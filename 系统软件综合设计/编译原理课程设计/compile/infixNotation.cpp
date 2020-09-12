#include "main.h"

std::vector<infixNotation> infixTable; // Memory reserved in setup()
string outputBuff;
int tempVarIndex = 0;
////输出三元式以及函数、加减、跳转等
void insertInfix(string ioperator, string operand1, string operand2, string operand3) {
	infixNotation notation;
	notation.ioperator = ioperator;
	notation.operand1 = operand1;
	notation.operand2 = operand2;
	notation.operand3 = operand3;
	infixTable.push_back(notation);

	if (ioperator == "CONST") {
		outputBuff = outputBuff + "const " + operand2 + " " + operand3 + " = "
			+ operand1 + "\n";
	}
	else if (ioperator == "VAR") {
		if (operand1 != " ") { // Array
			outputBuff = outputBuff + operand2 + " " + operand3 + "[" + operand1 + "]" + "\n";
		}
		else { // General variable
			outputBuff = outputBuff + operand2 + " " + operand3 + "\n";
		}
	}
	else if (ioperator == "FUNC") {
		outputBuff = outputBuff + operand2 + " " + operand3 + "()" + "\n";
	}
	else if (ioperator == "PARAM") {
		outputBuff = outputBuff + "param " + operand2 + " " + operand3 + "\n";
	}
	else if (ioperator == "ADD") {
		outputBuff = outputBuff + operand3 + " = " + operand1 + " + " + operand2 + "\n";
	}
	else if (ioperator == "SUB") {
		outputBuff = outputBuff + operand3 + " = " + operand1 + " - " + operand2 + "\n";
	}
	else if (ioperator == "MUL") {
		outputBuff = outputBuff + operand3 + " = " + operand1 + " * " + operand2 + "\n";
	}
	else if (ioperator == "DIV") {
		outputBuff = outputBuff + operand3 + " = " + operand1 + " / " + operand2 + "\n";
	}
	else if (ioperator == "ASSIGN") {
		outputBuff = outputBuff + operand3 + " = " + operand2 + "\n";
	}
	else if (ioperator == "NEG") {
		outputBuff = outputBuff + operand3 + " = -" + operand2 + "\n";
	}
	else if (ioperator == "EQL") {
		outputBuff = outputBuff + operand3 + " = " + operand1 + " == " + operand2 + "\n";
	}
	else if (ioperator == "NEQ") {
		outputBuff = outputBuff + operand3 + " = " + operand1 + " != " + operand2 + "\n";
	}
	else if (ioperator == "LSS") {
		outputBuff = outputBuff + operand3 + " = " + operand1 + " < " + operand2 + "\n";
	}
	else if (ioperator == "LEQ") {
		outputBuff = outputBuff + operand3 + " = " + operand1 + " <= " + operand2 + "\n";
	}
	else if (ioperator == "GTR") {
		outputBuff = outputBuff + operand3 + " = " + operand1 + " > " + operand2 + "\n";
	}
	else if (ioperator == "GEQ") {
		outputBuff = outputBuff + operand3 + " = " + operand1 + " >= " + operand2 + "\n";
	}
	else if (ioperator == "PUSH") {
		outputBuff = outputBuff + "push " + operand3 + "\n";
	}
	else if (ioperator == "CALL") {
		outputBuff = outputBuff + "call " + operand3 + "\n";
	}
	else if (ioperator == "RETURN") {
		outputBuff = outputBuff + "return " + operand3 + "\n";
	}
	else if (ioperator == "SETARR") {
		outputBuff = outputBuff + operand3 + "[" + operand2 + "] = " + operand1 + "\n";
	}
	else if (ioperator == "GETARR") {
		outputBuff = outputBuff + operand3 + " = " + operand1 + "[" + operand2 + "]" + "\n";
	}
	else if (ioperator == "JMP") {
		outputBuff = outputBuff + "jmp " + operand3 + "\n";
	}
	else if (ioperator == "BEQ") {
		outputBuff = outputBuff + "goto " + operand3 + ", if " + operand1 + " == " +
			operand2 + "\n";
	}
	else if (ioperator == "BNE") {
		outputBuff = outputBuff + "goto " + operand3 + ", if " + operand1 + " != " +
			operand2 + "\n";
	}
	else if (ioperator == "SCANF") {
		outputBuff = outputBuff + "scan " + operand3 + "\n";
	}
	else if (ioperator == "PRINTF") {
		if (operand2 != " " && operand3 != " ") {
			outputBuff = outputBuff + "print " + operand2 + ", " + operand3 + "\n";
		}
		else if (operand2 != " " && operand3 == " ") {
			outputBuff = outputBuff + "print " + operand2 + "\n";
		}
		else if (operand2 == " " && operand3 != " ") {
			outputBuff = outputBuff + "print " + operand3 + "\n";
		}
		else {
			cout << "Can't print nothing!" << endl;
		} // Do nothing
	}
	else if (ioperator == "LABEL") {
		outputBuff = outputBuff + operand3 + "\n";
	}
}
//三元式输入到infixfile中
void outputInfixes() {
	cout << outputBuff;
	//infixFile.close();
}
////创造#t
string createTempVar() {
	string tempVar;
	tempVar = "#t" + intToString(tempVarIndex);
	tempVarIndex++;
	return tempVar;
}