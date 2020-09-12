#include "main.h"
#include <iomanip>

const int startIndex = 0;

std::vector<tabElement> idTable;//could be changed
std::vector<tabElement> staticTable;//never change
int addressIndex = startIndex;//下一个元素的起始坐标(address)
//
void insertTable(kind cls, type typ, const char name[], int length, int level, int addr) {
	tabElement element;
	//全局的level=0
	//idTable和static table都插入元素，常量由传入的addr决定，变量由addressIndex + length决定，函数则全部归0
	if (level == 0) { // Globals
		if (cls == consts) { // Addr for constant stands for its value
			element.addr = addr;
		}
		else if (cls == vars) {
			element.addr = addressIndex;
			if (length != 0) { // Array
				addressIndex = addressIndex + length;
			}
			else {
				addressIndex++;
			}
		}
		else { // Function or main
			element.addr = 0;
			addressIndex = startIndex;
		}
		strcpy_s(element.name, name);
		element.cls = cls;
		element.typ = typ;
		element.length = length;
		element.level = level;
		idTable.push_back(element);
		staticTable.push_back(element);
	}

	//局部的量的地址一类的，地址除了无function其他一样
	else { // Locals
		//变量还是常量 addressIndex不一样
		if (cls == consts) { // Addr for constant stands for its value
			element.addr = addr;
		}
		else if (cls == vars || cls == params) {
			element.addr = addressIndex;
			if (length != 0) { // Array
				addressIndex = addressIndex + length;
			}
			else {
				addressIndex++;
			}
		}
		strcpy_s(element.name, name);
		element.cls = cls;
		element.typ = typ;
		element.length = length;
		element.level = level;
		idTable.push_back(element);
		staticTable.push_back(element);
	}
}

// Only available for local variables, address can be get according to last element
//插入到对应函数的对应地址下，作为一个新的元素 StaticTable
void insertStatic(string function, kind cls, type typ, const char name[], int length, int level) {
	tabElement element;
	int insertIndex;

	// Set insertIndex to tail of function block
	insertIndex = lookUpStatic(function.c_str());//从static table中找出func
	if (insertIndex != staticTable.size() - 1) {
		insertIndex++;
	}
	for (; insertIndex < staticTable.size() && staticTable[insertIndex].cls != funcs ;
		++insertIndex);
	insertIndex--;
	// Get address according to last element ，the last element of one function.c_str()
	tabElement lastElement = staticTable[insertIndex];
	if (lastElement.cls == funcs) { // Last one is function
		element.addr = 0;
	}
	else if (lastElement.cls != vars || lastElement.length == 0) { // Last one is not array
		element.addr = lastElement.addr + 1;
	}
	else { // Last one is array
		element.addr = lastElement.addr + lastElement.length;
	}
	//插入
	strcpy_s(element.name, name);
	element.cls = cls;
	element.typ = typ;
	element.length = length;
	element.level = level;
	staticTable.insert(staticTable.begin() + insertIndex, element);
}
//id_table pop
void popElement() {
	idTable.pop_back();
}
//Pop local variables from id table
void popLocals() {
	for (int i = idTable.size() - 1; i >= 0; --i) { // Pop local variables from id table
		if (idTable[i].level != 0) {
			popElement();
		}
		else { // All local variables popped from id table
			break;
		}
	}
}

// Return 函数在id_table中的下标
int lookUp(const char *name) {
	if (idTable.size() == 0) {
		return -1;
	}
	for (int i = idTable.size() - 1; i >= 0; i--) {
		if (strcmp(idTable[i].name, name) == 0) {
			return i;
		}
	}
	return -1;
}

// Return index of certain function in staticTable, -1 means not found
int lookUpStatic(const char *functionName) {
	if (staticTable.size() == 0) {
		return -1;
	}
	for (int i = 0; i < staticTable.size(); i++) {
		if (strcmp(staticTable[i].name, functionName) == 0 && staticTable[i].cls == funcs) {
			return i;
		}
	}
	return -1;
}

// Return index of certain constant/variable/parameter inside certain function in staticTable, -1 means not found
int lookUpStatic(const char *functionName, const char *identifier) {
	int funcIndex = lookUpStatic(functionName);
	if (staticTable.size() == 0 || funcIndex == -1) {
		return -1;
	}
	//search the index of identifier
	for (int i = funcIndex + 1; i < staticTable.size() &&
		(staticTable[i].cls != funcs); ++i) { // Look up in local
		if (strcmp(staticTable[i].name, identifier) == 0) {
			return i;
		}
	}
	for (int j = 0; j < staticTable.size() &&
		(staticTable[j].cls != funcs); ++j) { // Look up in global
		if (strcmp(staticTable[j].name, identifier) == 0) {
			return j;
		}
	}
	return -1;
}

bool isDefinable(char name[]) {
	if (lookUp(name) == -1) { // Identifier with this name never exists
		return true;
	}
	else if (idTable[lookUp(name)].level < level) { // Identifier with this name's level is shallower
		return true;
	}
	return false;
}
//find the index of the current function in the id_table
int findCurrentFunc() {
	if (idTable.size() == 0) {
		return -1;
	}
	for (int i = idTable.size() - 1; i >= 0; --i) {
		if (idTable[i].cls == funcs) {
			return i;
		}
	}
	return -1; // No function occurred before
}
//print id_table and static_table
void printTable() {
	cout << endl;
	cout << "----------------------------------Identifier Table---------------------------------" << endl;
	cout << "Name           "
		<< "Kind           "
		<< "Type           "
		<< "Address        "
		<< "Length         "
		<< "Level          "
		<< endl;
	for (int i = 0; i < idTable.size(); ++i) {
		printf("%-*s", 15, idTable[i].name);
		printf("%-*d", 15, idTable[i].cls);
		printf("%-*d", 15, idTable[i].typ);
		printf("%-*d", 15, idTable[i].addr);
		printf("%-*d", 15, idTable[i].length);
		printf("%-*d", 15, idTable[i].level);
		printf("\n");
	}
	cout << "------------------------------------Static Table-----------------------------------" << endl;
	cout << "Name           "
		<< "Kind           "
		<< "Type           "
		<< "Address        "
		<< "Length         "
		<< "Level          "
		<< endl;
	for (int i = 0; i < staticTable.size(); ++i) {
		printf("%-*s", 15, staticTable[i].name);
		printf("%-*d", 15, staticTable[i].cls);
		printf("%-*d", 15, staticTable[i].typ);
		printf("%-*d", 15, staticTable[i].addr);
		printf("%-*d", 15, staticTable[i].length);
		printf("%-*d", 15, staticTable[i].level);
		printf("\n");
	}
}