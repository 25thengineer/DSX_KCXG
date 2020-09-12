#include "erro_and_warn.cpp"
#include "id_table.cpp"
#include "infixNotation.cpp"
#include "infixOpt.cpp"
#include "lexical.cpp"
#include "main.h"
#include "paser.cpp"
#include "symbol.cpp"
#include "tool.cpp"
#include "tool.h"

int main() {
	setup();
	//insymbol();
	program();
	outputInfixes();
	optimizeInfixes();
	//system("pause");
	return 0;
}