
#include "main.h"
#define specials '+', '-', '*', '/', '(', ')', '[', ']', '{', '}', ',', ';', ':'
//symbolNames代表英文，symbol为一种变量数字表示（包括类型，符号，操作）
fstream infixFile, inputFile;
char* symbolNames[] = {
	"Ident",
	"Const",
	"Int", "Char",
	"Void",
	"IntCon", "CharCon", "StringCon",
	"Plus", "Minus", "Times", "Div",
	"Eql", "Neq", "Gtr", "Geq", "Lss", "Leq",
	"Becomes",
	"Lparent", "Rparent", "Lbrack", "Rbrack", "Lbrace", "Rbrace",
	"Comma", "Semicolon", "Colon",
	"If", "Else",
	"Switch", "Case", "Default",
	"For","While",
	"Scanf", "Printf",
	"Main",
	"Return"
};

void setup() {
	// File initialization
	
	inputFile.open("In.txt", ios::in);
	if (inputFile.is_open() == false)cout << "打开文本失败" << endl;
	else cout << "打开文本成功" << endl;
	// Table initialization
	idTable.reserve(10000);
	staticTable.reserve(10000);
	infixTable.reserve(10000);

	// Keyword strings 关键词（包括类型和操作）
	char* keywordList[] = {
		"const",
		"int",
		"char",
		"void",
		"if",
		"else",
		"switch",
		"case",
		"default",
		"for",
		"scanf",
		"printf",
		"main",
		"return",
		"while"
	};
	for (int i = 0; i < keywordCount; i++) {
		strcpy_s(keywords[i], keywordList[i]);//把后复制于前，返回前
	}

	// Keyword symbols
	symbol keySymbolList[] = {//类型和操作的数字表示
		constsy, intsy, charsy, voidsy, ifsy, elsesy, switchsy, casesy, defaultsy, forsy,
		scanfsy, printfsy, mainsy, returnsy, whilesy
	};
	for (int i = 0; i < keywordCount; i++) {
		keySymbols[i] = keySymbolList[i];
	}

	// Special symbols
	char specialSymbolsChar[] = {//符号的字符形式
		specials
	};
	symbol specialSymbolList[] = {//符号的数字形式
		plus, minus, times, idiv, lparent, rparent, lbrack, rbrack, lbrace, rbrace,
		comma, semicolon, colon
	};//'+', '-', '*', '/', '(', ')', '[', ']', '{', '}', ',', ';', ':'
	//define the map specialSymbols
	for (int i = 0; i < sizeof(specialSymbolList) / sizeof(specialSymbolList[0]); i++) {
		specialSymbols[specialSymbolsChar[i]] = specialSymbolList[i];
	}
}

