#include "tool.h"
int strToInt(string str) {
	stringstream ss(str);
	int integer;
	ss >> integer;
	return integer;
}

char strToChar(string str) {
	stringstream ss(str);
	char character;
	ss >> character;
	return character;
}

string intToString(int num)
{
	stringstream ss;
	ss << num;
	return ss.str();
}
string charToString(char c)
{
	string str;
	stringstream stream;
	stream << c;
	str = stream.str();
	return str;
}
