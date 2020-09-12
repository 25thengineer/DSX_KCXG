#pragma once
#ifndef C0_COMPILER_MAIN_H
#define C0_COMPILER_MAIN_H


#include <fstream>
#include <map>
#include <vector>
#include <set>
#include <cstring>
#include <cstdlib>
#include <algorithm>
#include <ctype.h>
#include <iomanip>//格式化输出
#include "tool.h"

//using namespace std;
using std::cin;
using std::cout;
using std::endl;
using std::string;
using std::ios;
using std::fstream;
using std::map;
using std::stringstream;

// Restricts
const int maxIdentLength = 100;
const int maxLineLength = 100;
const int keywordCount = 15;//14+1
const int maxDigit = 15;
const int maxInt = 100000000;

//type
typedef char alpha[maxIdentLength + 1]; // Alphabet letter should be restricted to maxIdentLength
typedef enum {
	identi, // 0
	constsy, // 1
	intsy, charsy, // 2, 3
	voidsy, // 4
	intcon, charcon, stringcon, // 5, 6, 7
	plus, minus, times, idiv, // 8, 9, 10, 11
	eql, neq, gtr, geq, lss, leq, // 12, 13, 14, 15, 16, 17
	becomes, // 18
	lparent, rparent, lbrack, rbrack, lbrace, rbrace, // 19, 20, 21, 22, 23, 24
	comma, semicolon, colon, // 25, 26, 27
	ifsy, elsesy, // 28, 29
	switchsy, casesy, defaultsy, // 30, 31, 32
	forsy, // 33
	scanfsy, printfsy, // 34, 35
	mainsy, // 36
	returnsy, // 37
	whilesy//38
} symbol; // All C0 reserved words
typedef enum {
	consts,
	vars,
	params,
	funcs
} kind; // All C0 kinds
typedef enum {
	ints, chars, voids
} type; // All C0 types
typedef struct {
	char name[maxIdentLength]; // Identifier
	kind cls; // Const or variable or parameter or function
	type typ; // Int or char or void
	int addr;
	int length;
	int level; // Block level where elements lies
} tabElement; // Symbol table element
typedef struct {
	string ioperator;
	string operand1;
	string operand2;
	string operand3;
} infixNotation;//putout format
typedef enum {
	LeadingZero, NumRangeExceed, ExclamationMark,
	EmptyChar, IllegalChar, QuotMarkLost,
	IllegalStr, StrRangeExceed, UnknownWord,
	SignedZero, NumErr, NotVarFunc,
	IdRepeat, CharConErr, ConDefTypeErr,
	ArrIndexErr, DefHeadErr, IdNotDefine,
	IllegalFact, IdKindNotMatch, StepLenZero,
	CaseNotCon, ParamCountExceed, IllegalType,
	PrintfSyLost, ScanfSyLost, ReturnSyLost,
	DefaultSyLost, ColonLost, CaseSyLost,
	SwitchSyLost, PlusLost, ForSyLost,
	IfSyLost, BecomesSyLost, VoidSyLost,
	LeftBraceLost, RightBraceLost, LeftParentLost,
	RightParentLost, RightBrackLost, IdLost,
	SemicolonLost, AssignSyLost, TypeDefLost,
	StepLenLost, StateErr, IllegalSyntax
} errorType;
		// Static elements
extern alpha keywords[];
extern symbol keySymbols[];
extern map<char, symbol> specialSymbols;

// Global Variables changing all the way
extern char line[]; // One source code line
extern char ch; // Currently reading character
extern alpha token;
extern symbol sy;
extern int inum;
extern char str[];
extern int level;
extern fstream inputFile;
extern fstream infixFile;
// Lengths for global variables
extern int lineLength; // Currently reading line length
extern int stringLength;

// Pointers(Indices) for global variables
extern int charPtr;
extern int linePtr;
extern std::vector<int> funcPtrs;
extern int idTablePtr;
// Tables
extern std::vector<tabElement> idTable;
extern std::vector<tabElement> staticTable;
extern std::vector<infixNotation> infixTable;
// Flags
extern bool errorFlag;
extern bool skipFlag;//用于判断句子完整性，如果为0，说明不完整

// Lexical functions
void nextch(); // Store one source code line into line[] and store one char into ch
void insymbol(); // Read one symbol, sy stores symbol type, inum stores contents
//symbol functions
void setup();
// erro functions
void error(int errorNum); // Output error position & error number
void skipUntil(symbol nexts[],int length);
void setup(); // Set up reserved words

// id_Table functions
void insertTable(kind cls, type typ, const char name[], int length, int level, int addr);
void insertStatic(string function, kind cls, type typ, const char name[], int length, int level);
void popElement();
void popLocals();
int lookUp(const char *name); // Return index of identifier in table
int lookUpStatic(const char *functionName); // For function
int lookUpStatic(const char *functionName, const char *identifier); // For local variable or parameter
bool isDefinable(char name[]);
int findCurrentFunc();
void printTable();

//infixNotation function
void insertInfix(string ioperator, string operand1, string operand2, string operand3);
void outputInfixes();
string createTempVar();
//
// praser actions

void program();
void constState();
void constDef();
void globalVarState();
void varState();
void varDef();
void funcWithRetDef();
void funcWithoutRetDef();
void defHead(type* returnType, char identifier[]);
void parameter();
void parameterTable();
void complexState();
void mainDef();
type factor(string &infixString);
type term(string &infixString);
type expression(string &infixString);
void assignState();
void ifState();
void judgement(string &infixString); // Judgement inside if statement
void loopState();
void whileState();
void conditionState();
void conditionTable(type firstType, string switchElement, string endSwitchLabel);
void conditionBranch(type firstType, string switchElement, string endSwitchLabel);
void conditionDefault();
void funcWithRetCall(string &infixString);
void funcWithoutRetCall();
void valueParamTable(int idIndex);
void returnState();
void scanfState();
void printfState();
void stateList();
void statement();
void integer(string &infixString);

// Infixes optimization
void optimizeInfixes();

// Target code generations
void mipsProgram(string mipsFileName);
#endif //C0_COMPILER_MAIN_H