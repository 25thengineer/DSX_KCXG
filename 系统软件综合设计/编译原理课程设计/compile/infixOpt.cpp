#include "main.h"

struct DAGNode {
	int number;//节点的唯一标识，与lastNum有关
	string content;//操作
	std::set<DAGNode*> parents;//父节点塞入
	DAGNode* leftChild;
	DAGNode* rightChild;
};
int lastNum = 0;//记录节点数
std::vector<DAGNode*> allNodes;
map<string, int> varNodeTable; // Node table
map<string, int> varsWithInitial; // Vars serving as initial nodes
std::set<string> crossingVars;
string currentFunc2;
std::vector<infixNotation> newInfixTable;
fstream betterInfixFile;
string newOutputBuff;

// Only codes with operand of ADD, SUB, MUL, DIV, NEG, ASSIGN, GETARR are manageable
inline bool isManageable(string ioperater) {
	if (ioperater == "ADD" || ioperater == "SUB" || ioperater == "MUL" ||
		ioperater == "DIV" || ioperater == "NEG" || ioperater == "ASSIGN" ||
		ioperater == "GETARR") {
		return true;
	}
	return false;
}

inline bool isMidNode(DAGNode *dagNode) {
	if (dagNode->leftChild != NULL || dagNode->rightChild != NULL) {
		return true;
	}
	return false;
}

// Variable name can't begin with space or number
inline bool isVarName(string operand) {
	if (operand[0] != ' ' && (operand[0] < '0' || operand[0] > '9')) {
		return true;
	}
	return false;
}

inline bool isAlpha(string content) {
	if (content[0] == '_' || (content[0] > 'a' && content[0] < 'z') || (content[0] > 'A' && content[0] < 'Z')) {
		return true;
	}
	return false;
}

DAGNode* findNodeWithNumber(int number) {
	for (int i = 0; i < allNodes.size(); ++i) {
		if (allNodes[i]->number == number) {
			return allNodes[i];
		}
	}
}

void insertNewInfix(string ioperator, string operand1, string operand2, string operand3) {
	infixNotation notation;
	notation.ioperator = ioperator;
	notation.operand1 = operand1;
	notation.operand2 = operand2;
	notation.operand3 = operand3;
	newInfixTable.push_back(notation);

	if (ioperator == "CONST") {
		newOutputBuff = newOutputBuff + "const " + operand2 + " " + operand3 + " = "
			+ operand1 + "\n";
	}
	else if (ioperator == "VAR") {
		if (operand1 != " ") { // Array
			newOutputBuff = newOutputBuff + operand2 + " " + operand3 + "[" + operand1 + "]" + "\n";
		}
		else { // General variable
			newOutputBuff = newOutputBuff + operand2 + " " + operand3 + "\n";
		}
	}
	else if (ioperator == "FUNC") {
		newOutputBuff = newOutputBuff + operand2 + " " + operand3 + "()" + "\n";
	}
	else if (ioperator == "PARAM") {
		newOutputBuff = newOutputBuff + "param " + operand2 + " " + operand3 + "\n";
	}
	else if (ioperator == "ADD") {
		newOutputBuff = newOutputBuff + operand3 + " = " + operand1 + " + " + operand2 + "\n";
	}
	else if (ioperator == "SUB") {
		newOutputBuff = newOutputBuff + operand3 + " = " + operand1 + " - " + operand2 + "\n";
	}
	else if (ioperator == "MUL") {
		newOutputBuff = newOutputBuff + operand3 + " = " + operand1 + " * " + operand2 + "\n";
	}
	else if (ioperator == "DIV") {
		newOutputBuff = newOutputBuff + operand3 + " = " + operand1 + " / " + operand2 + "\n";
	}
	else if (ioperator == "ASSIGN") {
		newOutputBuff = newOutputBuff + operand3 + " = " + operand2 + "\n";
	}
	else if (ioperator == "NEG") {
		newOutputBuff = newOutputBuff + operand3 + " = -" + operand2 + "\n";
	}
	else if (ioperator == "EQL") {
		newOutputBuff = newOutputBuff + operand3 + " = " + operand1 + " == " + operand2 + "\n";
	}
	else if (ioperator == "NEQ") {
		newOutputBuff = newOutputBuff + operand3 + " = " + operand1 + " != " + operand2 + "\n";
	}
	else if (ioperator == "LSS") {
		newOutputBuff = newOutputBuff + operand3 + " = " + operand1 + " < " + operand2 + "\n";
	}
	else if (ioperator == "LEQ") {
		newOutputBuff = newOutputBuff + operand3 + " = " + operand1 + " <= " + operand2 + "\n";
	}
	else if (ioperator == "GTR") {
		newOutputBuff = newOutputBuff + operand3 + " = " + operand1 + " > " + operand2 + "\n";
	}
	else if (ioperator == "GEQ") {
		newOutputBuff = newOutputBuff + operand3 + " = " + operand1 + " >= " + operand2 + "\n";
	}
	else if (ioperator == "PUSH") {
		newOutputBuff = newOutputBuff + "push " + operand3 + "\n";
	}
	else if (ioperator == "CALL") {
		newOutputBuff = newOutputBuff + "call " + operand3 + "\n";
	}
	else if (ioperator == "RETURN") {
		newOutputBuff = newOutputBuff + "return " + operand3 + "\n";
	}
	else if (ioperator == "SETARR") {
		newOutputBuff = newOutputBuff + operand3 + "[" + operand2 + "] = " + operand1 + "\n";
	}
	else if (ioperator == "GETARR") {
		newOutputBuff = newOutputBuff + operand3 + " = " + operand1 + "[" + operand2 + "]" + "\n";
	}
	else if (ioperator == "JMP") {
		newOutputBuff = newOutputBuff + "jmp " + operand3 + "\n";
	}
	else if (ioperator == "BEQ") {
		newOutputBuff = newOutputBuff + "goto " + operand3 + ", if " + operand1 + " == " +
			operand2 + "\n";
	}
	else if (ioperator == "BNE") {
		newOutputBuff = newOutputBuff + "goto " + operand3 + ", if " + operand1 + " != " +
			operand2 + "\n";
	}
	else if (ioperator == "SCANF") {
		newOutputBuff = newOutputBuff + "scan " + operand3 + "\n";
	}
	else if (ioperator == "PRINTF") {
		if (operand2 != " " && operand3 != " ") {
			newOutputBuff = newOutputBuff + "print " + operand2 + ", " + operand3 + "\n";
		}
		else if (operand2 != " " && operand3 == " ") {
			newOutputBuff = newOutputBuff + "print " + operand2 + "\n";
		}
		else if (operand2 == " " && operand3 != " ") {
			newOutputBuff = newOutputBuff + "print " + operand3 + "\n";
		}
		else {
			cout << "Can't print nothing!" << endl;
		} // Do nothing
	}
	else if (ioperator == "LABEL") {
		newOutputBuff = newOutputBuff + operand3 + "\n";
	}
}

// Insert operands to varsInBlock
void insertOperands(std::set<string>& varsInBlock, infixNotation notation) {
	if (isVarName(notation.operand1) &&
		varsInBlock.count(notation.operand1) == 0) { // Var not stored, insert it
		varsInBlock.insert(notation.operand1);
	}
	if (isVarName(notation.operand2) &&
		varsInBlock.count(notation.operand2) == 0) { // Var not stored, insert it
		varsInBlock.insert(notation.operand2);
	}
	if (isVarName(notation.operand3) &&
		varsInBlock.count(notation.operand3) == 0) { // Var not stored, insert it
		varsInBlock.insert(notation.operand3);
	}
}

// Store elements from vars in block to varExistenceCount
//varExistenceCount <var,cout of existence in varsInBlock>
void checkVarExistenceCount(map<string, int>& varExistenceCount, std::set<string>& varsInBlock) {
	for (std::set<string>::iterator it = varsInBlock.begin();
		it != varsInBlock.end(); ++it) {
		map<string, int>::iterator varIt;
		varIt = varExistenceCount.find(*it);//传入的参数是要查找的key
		if (varIt != varExistenceCount.end()) { // Variable already exists
			varIt->second++;
		}
		else { // Variable not exists, insert one
			varExistenceCount.insert(std::pair<string, int>(*it, 1));
		}
	}
}

// Split basic blocks & get crossing variables
//分割基本块
void splitBlocks() {
	map<string, int> varExistenceCount;
	std::set<string> varsInBlock;
	bool isInBlock = false;
	// Check all infix notations, get existence count
	for (int i = 0; i < infixTable.size(); ++i) {
		if (isManageable(infixTable[i].ioperator)) { // Infix code is manageable
			if (!isInBlock) { // This line of code is following an other kind of basic block
				isInBlock = true;
				checkVarExistenceCount(varExistenceCount, varsInBlock);
				// Empty vars in block
				varsInBlock.clear();
			}
		}
		else { // Infix code is not manageable
			if (isInBlock) { // This line of code is following an other kind of basic block
				isInBlock = false;
				checkVarExistenceCount(varExistenceCount, varsInBlock);
				// Empty vars in block
				varsInBlock.clear();
			}
		}
		//insert infixtable node i into varsInBlock
		if (infixTable[i].ioperator != "CONST" && infixTable[i].ioperator != "VAR" &&
			infixTable[i].ioperator != "FUNC" && infixTable[i].ioperator != "PARAM") {
			// Declarations don't take in count
			insertOperands(varsInBlock, infixTable[i]);
		}
	}

	// Manage the rest codes   最后一个块没有判断
	checkVarExistenceCount(varExistenceCount, varsInBlock);

	// Store element with existence count over 1 to crossingVars
	for (map<string, int>::iterator it = varExistenceCount.begin(); it != varExistenceCount.end();
		++it) {
		if (it->second > 1) { // Var cross basic blocks
			crossingVars.insert(it->first);
		}
	}
}

// Find & set node table element, return operand number(lastNum+1)
//根据operand查找varNodeTable，将找到后返回operand Num
//未找到varNOdeTable中添加operand,*lastNum,并生成DAGNode添加到allNode中
int setUpOperand(string operand, int *lastNum) {
	int operandNum;
	map<string, int>::iterator tempIt;
	tempIt = varNodeTable.find(operand);
	if (tempIt != varNodeTable.end()) { // Operand already exists
		operandNum = tempIt->second;
	}
	else { // Not exists, insert new node
		operandNum = *lastNum;
		if (operand[0] >= '0' && operand[0] <= '9') { // Number
													  // Insert left operand as number
			varNodeTable.insert(std::pair<string, int>(operand, *lastNum));
			DAGNode* node;
			node = new DAGNode;
			node->content = operand;
			node->number = *lastNum;
			node->leftChild = NULL;
			node->rightChild = NULL;
			allNodes.push_back(node); // Insert DAG node
			*lastNum = *lastNum + 1;
		}
		else { // Identifier
			   // Insert operand as variable
			varsWithInitial.insert(std::pair<string, int>(operand, *lastNum)); // Record initial node index
			varNodeTable.insert(std::pair<string, int>(operand, *lastNum));
			DAGNode* node;
			node = new DAGNode;
			node->content = operand;
			node->number = *lastNum;
			node->leftChild = NULL;
			node->rightChild = NULL;
			allNodes.push_back(node); // Insert DAG node
			*lastNum = *lastNum + 1;
		}
	}
	return operandNum;
}

// Set up one DAG node & element in varNodeTable according to infix notation
void infixToDAGNode(infixNotation notation) {
	int leftOpNum = 0;
	int rightOpNum = 0;
	int resultNum = 0;
	string ioperator = notation.ioperator;
	string leftOperand = notation.operand1;
	string rightOperand = notation.operand2;
	string result = notation.operand3;


	if (ioperator != "ASSIGN") { // Infix notation isn't an assignment
								 // Set up two operand
		leftOpNum = setUpOperand(leftOperand, &lastNum);
		rightOpNum = setUpOperand(rightOperand, &lastNum);

		// Set up result
		int i;
		// Find parent node
		for (i = 0; i < allNodes.size(); ++i) {
			if (allNodes[i]->content == ioperator &&
				allNodes[i]->leftChild->number == leftOpNum &&
				allNodes[i]->rightChild->number == rightOpNum) { // Find node with certain left & right child
				resultNum = allNodes[i]->number;
				break;
			}
		}
		if (i == allNodes.size()) { // Node doesn't exist, create a new one
			resultNum = lastNum;
			++lastNum;
			DAGNode *leftNode = allNodes[leftOpNum];
			DAGNode *rightNode = allNodes[rightOpNum];

			// Parent node settings
			DAGNode* node;
			node = new DAGNode;
			node->number = resultNum;
			node->content = ioperator;
			node->parents.clear();
			node->leftChild = leftNode;
			node->rightChild = rightNode;
			allNodes.push_back(node); // Insert node

									  // Children node settings
			leftNode->parents.insert(node);
			rightNode->parents.insert(node);
		}
		else { // Node exists, result number is in resultNum
		}
	}
	else { // Infix notation is a assignment
		   // Set up assigner
		rightOpNum = setUpOperand(rightOperand, &lastNum);

		// Set up assignee
		if (isMidNode(allNodes[rightOpNum])) { // Just get result number if rightOperand is middle node
			resultNum = rightOpNum;
		}
		else { // Create a parent node if rightOperand is not middle node
			resultNum = lastNum;
			++lastNum;
			DAGNode *rightNode = allNodes[rightOpNum];

			// Parent node settings
			DAGNode* node;
			node = new DAGNode;
			node->number = resultNum;
			node->content = ioperator;
			node->parents.clear();
			node->leftChild = NULL;
			node->rightChild = rightNode;
			allNodes.push_back(node); // Insert node

									  // Children node settings
			rightNode->parents.insert(node);
		}
	}

	// Result table settings
	map<string, int>::iterator tempIt;
	tempIt = varNodeTable.find(result);
	if (tempIt != varNodeTable.end()) { // Variable exists
		tempIt->second = resultNum;
	}
	else { // Not exist, insert new one
		varNodeTable.insert(std::pair<string, int>(result, resultNum));
	}
}

// Insert a mid DAGnode to calculation queue & cut off its connection with its children
//节点node记录到calculationQueue，把Node从子节点中的parentNode中删去，并对左右子节点检测是否是root，进行相同操作
void setMidNode(DAGNode* node, std::vector<DAGNode*>& calculationQueue) {
	DAGNode* leftChild = node->leftChild;
	DAGNode* rightChild = node->rightChild;

	// Push node to queue
	calculationQueue.push_back(node);

	// Erase parent element in children's parents set
	std::set<DAGNode*>::iterator tempIt;
	if (leftChild != NULL) {
		tempIt = leftChild->parents.find(node);
		if (tempIt != leftChild->parents.end()) {
			leftChild->parents.erase(tempIt);
		}
	}
	if (rightChild != NULL) {
		tempIt = rightChild->parents.find(node);
		if (tempIt != rightChild->parents.end()) {
			rightChild->parents.erase(tempIt);
		}
	}

	// Set children middle nodes now without parents recursively
	if (leftChild != NULL) {
		if (isMidNode(leftChild) && leftChild->parents.size() == 0) {
			setMidNode(leftChild, calculationQueue);
		}
	}
	if (rightChild != NULL && leftChild != rightChild) {
		if (isMidNode(rightChild) && rightChild->parents.size() == 0) {
			setMidNode(rightChild, calculationQueue);
		}
	}
}

// Export optimized codes from DAG & varNodeTable
void exportCodesFromDAG() {
	std::vector<DAGNode*> rootNodes;
	std::vector<DAGNode*> calculationQueue;
	rootNodes.reserve(10000);
	calculationQueue.reserve(10000);

	// Find root nodes
	for (int i = 0; i < allNodes.size(); ++i) {
		if (allNodes[i]->parents.size() == 0) { // No parents, must be root node
			rootNodes.push_back(allNodes[i]);
		}
	}

	// Get calculation queue
	while (rootNodes.size() != 0) {
		setMidNode(rootNodes[0], calculationQueue);
		// Delete current root node from root node vector
		rootNodes.erase(rootNodes.begin());
	}

	// Output var with initials e.g. a0 = a
	map<string, int>::iterator initIt;
	for (initIt = varsWithInitial.begin(); initIt != varsWithInitial.end();
		++initIt) {
		map<string, int>::iterator currentIt = varNodeTable.find(initIt->first);
		if (currentIt->second != initIt->second) { // Variable has been changed
			string varName = initIt->first;
			string newVarName = initIt->first + "0";

			// Insert a0 to static table
			// Skip all parameters
			int originalIdIndex;
			int insertIndex;
			for (insertIndex = lookUpStatic(currentFunc2.c_str());
				staticTable[insertIndex].cls == params; ++insertIndex);
			// Element settings
			originalIdIndex = lookUpStatic(currentFunc2.c_str(), varName.c_str());
			if (originalIdIndex == -1) { // Global identifier
				originalIdIndex = lookUp(varName.c_str());
			}
			insertStatic(currentFunc2, vars, staticTable[originalIdIndex].typ, newVarName.c_str(), 0, 1); // Insert table
			
																										  // Output a0 = a
			insertNewInfix("ASSIGN", " ", varName, newVarName);

			// Change "a" node content
			for (int i = 0; i < allNodes.size(); ++i) {
				if (allNodes[i]->content == varName) {
					allNodes[i]->content = newVarName;
					break;
				}
			}
		}
	}

	// Output queue in reverse
	for (int j = calculationQueue.size() - 1; j >= 0; --j) {
		int nodeNumber = calculationQueue[j]->number;

		// Collect all suited pairs of <name, number> from node table
		map<string, int>::iterator tempIt;
		std::set<string> varNodes;//记录vartable中与calculation中值一致的变量名
		for (tempIt = varNodeTable.begin(); tempIt != varNodeTable.end(); ++tempIt) {
			if (nodeNumber == tempIt->second) {
				varNodes.insert(tempIt->first);
			}
		}

		// Pick up pairs crossing basic blocks(if none, pick the first one) & set one as new content of result node
		std::set<string> varsToStay;
		std::set<string> varsToLeave;
		std::set<string>::iterator tempIt2;
		DAGNode* node = findNodeWithNumber(nodeNumber);
		DAGNode* leftChild = node->leftChild;
		DAGNode* rightChild = node->rightChild;

		for (tempIt2 = varNodes.begin(); tempIt2 != varNodes.end(); ++tempIt2) {
			// Set crossing variable to stay & others to leave
			std::set<string>::iterator crossingVarIt;
			crossingVarIt = crossingVars.find(*tempIt2);
			if (crossingVarIt != crossingVars.end()) { // Variable is a crossing one
				varsToStay.insert(*tempIt2);
			}
			else { // Not a crossing one
				varsToLeave.insert(*tempIt2);
			}
		}
		if (varsToStay.size() == 0) { // No crossing blocks variables
			string varName;
			if (varsToLeave.size() != 0) { // There are still other choices, choose the first one to stay
				varName = *varNodes.begin();
				varsToStay.insert(varName);
				varsToLeave.erase(varsToLeave.find(varName));
			}
			else { // No variables corresponding with this node, create a new one & insert it to staticTable
				varName = createTempVar();
				varsToStay.insert(varName);
				insertStatic(currentFunc2, vars, ints, varName.c_str(), 0, 1); // Type is not important, int can be ok
			}

			// Insert new infix notation
			string operand1;
			string operand2;
			if (leftChild == NULL) {
				operand1 = " ";
			}
			else {
				operand1 = leftChild->content;
			}
			if (rightChild == NULL) {
				operand2 = " ";
			}
			else {
				operand2 = rightChild->content;
			}
			insertNewInfix(node->content, operand1, operand2, varName);
		}
		else { // Choose the first one as result of calculation & assign it to others
			infixNotation notation;
			string varName = *varsToStay.begin();

			// Insert notation of first variable as calculation
			string operand1;
			string operand2;
			if (leftChild == NULL) {
				operand1 = " ";
			}
			else {
				operand1 = leftChild->content;
			}
			if (rightChild == NULL) {
				operand2 = " ";
			}
			else {
				operand2 = rightChild->content;
			}
			insertNewInfix(node->content, operand1, operand2, varName);

			// Insert notation of other variables as assignments
			std::set<string>::iterator tempIt;
			tempIt = varsToStay.begin();
			++tempIt;
			for (; tempIt != varsToStay.end(); ++tempIt) {
				insertNewInfix("ASSIGN", " ", varName, *tempIt);
			}
		}

		// Set node content(first to-stay variable)
		node->content = *varsToStay.begin();

		// Delete other variables in static table
		std::set<string>::iterator tempIt3;
		for (tempIt3 = varsToLeave.begin(); tempIt3 != varsToLeave.end(); ++tempIt3) {
			string varName = *tempIt3;
			int staticIndex = lookUpStatic(currentFunc2.c_str(), varName.c_str());
			if (staticIndex != -1) { // Prevent repeat deletion
				staticTable.erase(staticTable.begin() + staticIndex);
			}
		}
	}
}

// Resettle address of elements in static table
void resettleTableAddr() {
	int staticIndex;
	for (staticIndex = 0; staticTable[staticIndex].cls != funcs; ++staticIndex); // Skip all globals

																				 // Following address should be resettled
	int currentAddr = 0;
	for (; staticIndex < staticTable.size(); ++staticIndex) {
		tabElement* element = &staticTable[staticIndex];

		if (element->cls == funcs) { // Skip functions
			continue;
		}
		if (staticTable[staticIndex - 1].cls == funcs) { // Last one is a function
			if (element->cls == consts) { // Const, reserve its addr
				currentAddr = 0;
			}
			else { // Parameter or variable
				element->addr = 0;
				if (element->cls == vars && element->length != 0) { // Array
					currentAddr = element->length;
				}
				else { // Parameter or general variable
					currentAddr = 1;
				}
			}
		}
		else { // Last one isn't function
			if (element->cls == consts) { // Const, do nothing
			}
			else if (element->cls == vars && element->length != 0) { // Array
				element->addr = currentAddr;
				currentAddr += element->length;
			}
			else {  // Parameter or general variable
				element->addr = currentAddr;
				++currentAddr;
			}
		}
	}
}

void optimizeInfixes() {
	// Get variables crossing basic blocks
	splitBlocks();

	// Draw DAG & operate optimization
	newInfixTable.reserve(infixTable.size());
	for (int i = 0; i < infixTable.size(); ++i) {
		if (isManageable(infixTable[i].ioperator)) { // Infix code is manageable
			infixToDAGNode(infixTable[i]);
		}
		else { // Infix code is not manageable
			if (infixTable[i].ioperator == "FUNC") { // Enter a new function
				currentFunc2 = infixTable[i].operand3;
			}
			if (allNodes.size() != 0) { // One basic block ends, operate optimization
				exportCodesFromDAG();
									 // Empty DAG & table
				varsWithInitial.clear();
				allNodes.clear();
				varNodeTable.clear();
				lastNum = 0;
			}
			//执行NOT manageable指令
			insertNewInfix(infixTable[i].ioperator, infixTable[i].operand1,
				infixTable[i].operand2, infixTable[i].operand3);

		}
	}

	if (allNodes.size() != 0) { // Still one block not managed
		exportCodesFromDAG();
		// Empty DAG & table
		varsWithInitial.clear();
		allNodes.clear();
		varNodeTable.clear();
	}

	// Resettle staticTable elements' address
	resettleTableAddr();

	// Replace elements in infix table with that in new one
	infixTable.clear();
	infixTable.resize(newInfixTable.size());
	for (int j = 0; j < newInfixTable.size(); ++j) {
		infixTable[j] = newInfixTable[j];
	}

	// Output to file
	betterInfixFile.open("betterInfixes.txt", ios::out);
	betterInfixFile << newOutputBuff;
	betterInfixFile.close();
}