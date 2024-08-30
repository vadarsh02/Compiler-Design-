#include "lexer.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();

extern int yylineno;
extern int column;
extern char* yytext;
extern FILE *yyin;


char *token_name[]={"BRACKET","IDENTIFIER","KEYWORD","MATH_OP","COMPARATOR","LOGICAL_OP",
"BITWISE_OP","PUNCTUATOR","ASSIGN_OP","ASSIGN_BIT","CONSTANT","FLOAT","BOOL","STRING","I/O", "CHARACTER"};

int main(int argc,char **argv){
	int tokenid;
	int i;
	FILE *fh;
	if(argc==2&&(fh=fopen(argv[1],"r")))
		yyin=fh;

printf("     Token            Lexeme          Line#         Column#\n");
printf("=============================================================\n");	
	
	
	
	if(yytext=='\n')
	    {
			yylineno++;
		} 
		
	while(tokenid=yylex()){
		
		if(tokenid>0)
		{
			if(yytext=='\n'){
				yylineno++;
			
			}
			
			
			
			printf("%12s",token_name[tokenid-1]);
			printf("%16s ",yytext);
			
			
			printf("%12d",yylineno);
			printf("%16d\n",column);
			column = column+strlen(yytext);
			
		
		}	
		
		else if(tokenid==-1)
		{
			printf("Line %d - Unknown stream of characters : %s\n", yylineno,yytext);
			return 0;
		}
	}
	
	
	return 0;
}
