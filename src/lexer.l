%{
#include "lexer.h"
#include<stdio.h>
int column=1;

%}
%option yylineno

%%
"asm"                                 	    return KEYWORD;
"auto"										return KEYWORD;
"break"										return KEYWORD;
"case"										return KEYWORD;
"catch"	 									return KEYWORD;
"char"					        			return KEYWORD;
"class"										return KEYWORD;
"const"										return KEYWORD;
"continue"									return KEYWORD;
"default"									return KEYWORD;
"delete"									return KEYWORD;
"do"										return KEYWORD;
"double"									return KEYWORD;
"else"										return KEYWORD;
"enum"					               	    return KEYWORD;										
"extern"									return KEYWORD;
"float"										return KEYWORD;
"for"										return KEYWORD;
"friend"									return KEYWORD;
"goto"										return KEYWORD;
"if"										return KEYWORD;
"inline"									return KEYWORD;
"int"										return KEYWORD;
"long"										return KEYWORD;
"new"										return KEYWORD;
"operator"									return KEYWORD;
"private"									return KEYWORD;
"protected"									return KEYWORD;
"public"									return KEYWORD;
"register"									return KEYWORD;									
"return"									return KEYWORD;
"short"										return KEYWORD;
"signed"									return KEYWORD;
"sizeof"									return KEYWORD;
"static"									return KEYWORD;
"struct"									return KEYWORD;
"switch"									return KEYWORD;	
"template"									return KEYWORD;	
"this"										return KEYWORD;
"throw"										return KEYWORD;
"try"										return KEYWORD;
"typedef"									return KEYWORD;
"union"										return KEYWORD;
"unsigned"									return KEYWORD;
"virtual"									return KEYWORD;
"void"										return KEYWORD;
"volatile"							     	return KEYWORD;
"while"										return KEYWORD;
									

"=="										return COMPARATOR;
"!=" 										return COMPARATOR;
"<"											return COMPARATOR;
">"											return COMPARATOR;
"<="										return COMPARATOR;
">="										return COMPARATOR;

													
"&&"										return LOGICAL_OP;
"!"									    	return LOGICAL_OP;	
"||"										return LOGICAL_OP;
	
")"											return BRACKET;
"("											return BRACKET;
"{"											return BRACKET;
"}"											return BRACKET;
"["											return BRACKET;	
"]"											return BRACKET;


","											return PUNCTUATOR;
":"											return PUNCTUATOR;
";"											return PUNCTUATOR;	

[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]							;         //multi line line comment
("//")(.)+													;        //single line comment

"="											return ASSIGN_OP;	
"+="										return ASSIGN_OP;
"-="										return ASSIGN_OP;
"*="										return ASSIGN_OP;
"/="										return ASSIGN_OP;
"%="										return ASSIGN_OP;


"&="										return ASSIGN_BIT;
"|="										return ASSIGN_BIT;
"^="										return ASSIGN_BIT;
"<<="										return ASSIGN_BIT;
">>="										return ASSIGN_BIT;
														
"+"											return MATH_OP;	
"-"											return MATH_OP;
"*"											return MATH_OP;	
"/"											return MATH_OP;
"%"											return MATH_OP;
"--"										return MATH_OP;
"++"										return MATH_OP;

"&"											return BITWISE_OP;
"|"											return BITWISE_OP;
"~"											return BITWISE_OP;
"^"											return BITWISE_OP;
"<<"										return BITWISE_OP;
">>"										return BITWISE_OP;


("0O"|"0o")[0-7]+							return CONSTANT;	
("0X"|"0x")[a-fA-F0-9]+						return CONSTANT;
[0-9]+										return CONSTANT;

(([0-9]+)?"."[0-9]+)(("e"|"E")("+"|"-")[0-9]+)?		return FLOAT;
([0-9]+)("e"|"E")("+"|"-"|"")[0-9]+					return FLOAT;

"true"|"false"							return BOOL;
("cout")[ ]*("<<")							return InOut;
("cin")[ ]*(">>")							return InOut;



'[a-zA-Z]'                                 return CHARACTER;
[_a-zA-Z][_a-zA-Z0-9]*					return IDENTIFIER;

[a-zA-Z]?\"(\\.|[^\\"])*\"					return STRING;

[\n]										column=1;
[ ] 										column++;
[\t]										column+=4;
("#")(.)*(\n)										;
.											{printf("Unidentified token\n"); return -1;}



%%

int yywrap(void){
	return 1;
}
