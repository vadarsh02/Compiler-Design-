%{
	extern void yyerror(char*);
	#include <math.h>
	#include <string.h>
	#include<stdio.h>
	#include<stdlib.h>
	#include "parser.tab.h"
	
		
    extern int iVal;
    extern float fVal;
	extern char* sVal;
%}

%option yylineno



AUTO            "auto"
BREAK			"break"
BOOL                  "bool"
CASE			"case"

CHAR			"char"
CLASS			"class"
CONST			"const"
CONTINUE		"continue"
DEFAULT			"default"
DO				"do"
DOUBLE          "double" 
ENUM            "enum"
ELSE			"else"
FLOAT			"float"
FOR 			"for"
GOTO			"goto"
IF				"if"

INT				"int"
LONG			"long"
NEW				"new" 	
PRIVATE  	  	"private"
PROTECTED		"protected"
PUBLIC			"public"
REGISTER 		"register" 
RETURN			"return"
SHORT			"short"
SIGNED			"signed"
SIZEOF			"sizeof"
STATIC			"static"
STRUCT			"struct"
SWITCH			"switch"
THIS			"this"


TYPEDEF			"typedef"
UNION 			"union" 
UNSIGNED 		"unsigned" 
VOID 			"void"
VOLATILE 		"volatile"
WHILE 			"while"
TRUE			"true"
FALSE			"false" 


RBRACE			"}"
LBRACE			"{"
RBRACKET		"]"
LBRACKET		"["
LPARENTHESES	"("
RPARENTHESES	")"
QUOTE           '
DQUOTE          \"
COMMA			","
COLON			":"
ARROW           "->"
SEMICOLON		";"
PLUS			"+"
MINUS			"-"
MULT			"*"
DIVIDE			"/"
MODULO			"%"	
INCREMENT       "++"
DECREMENT       "--"
AND		        "&"
OR				"|"
XOR 			"^"
NEGATION		"!"
TILDE			"~"
ASSIGN          "="
LESS_THAN		"<"
GREATER_THAN	">"
LOGICAL_AND		"&&"
LOGICAL_OR		"||"
EQUALS		    "=="
NOT_EQUALS		"!="
LESS_EQUALS		"<="
GREATER_EQUALS	">="	
ASSIGN_PLUS		"+="
ASSIGN_MINUS	"-="
ASSIGN_MULT		"*="
ASSIGN_DIV		"/="
ASSIGN_MOD		"%="
ASSIGN_AND		"&="
ASSIGN_OR		"|="
ASSIGN_XOR	    "^="
LEFT_SHIFT		"<<"
LEFT_SHIFT_EQ	"<<="
RIGHT_SHIFT		">>"
RIGHT_SHIFT_EQ	">>="
OCT_CONSTANT   ("0O"|"0o")[0-7]+
HEX_CONSTANT   ("0X"|"0x")[a-fA-F0-9]+
CONSTANT        [0-9]+
FLOAT_CONSTANT  (([0-9]+)?"."[0-9]+)(("e"|"E")("+"|"-")[0-9]+)?|([0-9]+)("e"|"E")("+"|"-")[0-9]+|([0-9]+)("e"|"E")[0-9]+				
IDENTIFIER      [_a-zA-Z][_a-zA-Z0-9]*
STRING          [a-zA-Z]?\"(\\.|[^\\"])*\"
IGNORE          ("#")(.)*(\n)
COMMENT			[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]|("//")(.)+
WHITESPACE		[\t\v ]+
NEWLINE			\n
%%


{AUTO} { return AUTO;}
{BREAK} { return BREAK; }
{BOOL} {return BOOL;}
{CASE} { return CASE; }
{CHAR} { return CHAR; }
{CLASS} { return CLASS; }
{CONST} { return CONST; }
{CONTINUE}  { return CONTINUE; }
{DEFAULT} { return DEFAULT; }
{DO} { return DO; }
{DOUBLE} { return DOUBLE;}
{ELSE} { return ELSE; }
{ENUM} { return ENUM; }
{FALSE} { return FALSE; }
{FLOAT} {return FLOAT; }
{FOR} { return FOR; }
{GOTO} { return GOTO; }
{IF} { return IF; }
{INT} { return INT; }
{LONG} { return LONG; }
{NEW} { return NEW; }
{PRIVATE} { return PRIVATE; }
{PROTECTED} { return PROTECTED; }
{PUBLIC} { return PUBLIC; }
{SHORT} {return SHORT; }
{REGISTER} {return REGISTER;}
{RETURN} { return RETURN; }
{STRUCT} { return STRUCT; }
{SIGNED} {return STATIC;}
{STATIC} {return STATIC;}
{SWITCH} { return SWITCH; }
{SIZEOF}  { return SIZEOF; }
{THIS} { return THIS; }
{TRUE} { return TRUE; }
{TYPEDEF} { return TYPEDEF; }
{UNION} {return UNION;}
{UNSIGNED} { return UNSIGNED;}
{VOID} { return VOID; }
{VOLATILE} {return VOLATILE;}
{WHILE} { return WHILE; } 
{IDENTIFIER}  { yylval.sVal = strdup(yytext); return IDENTIFIER; }
{OCT_CONSTANT}  { yylval.iVal = atoi(yytext); return OCT_CONSTANT; }
{HEX_CONSTANT}  { yylval.iVal = atoi(yytext); return HEX_CONSTANT; }
{CONSTANT}  { yylval.iVal = atoi(yytext); return CONSTANT; }
{FLOAT_CONSTANT} { yylval.fVal = atof(yytext); return FLOAT_CONSTANT ;}
{STRING}  { yylval.sVal = strdup(yytext); return STRING; } 
{RBRACE} { return *yytext; }
{LBRACE} { return *yytext; }
{RBRACKET}  { return *yytext; }
{LBRACKET}  { return *yytext; }
{LPARENTHESES}  { return *yytext; }
{RPARENTHESES}  { return *yytext; }
{COMMA}  { return *yytext; }
{COLON}  { return *yytext; }
{SEMICOLON}  { return *yytext; }
{QUOTE}  { return *yytext; }
{DQUOTE}  { return *yytext; }
{PLUS}  { return *yytext; }
{MINUS}  { return *yytext; }
{MULT}  { return *yytext; }
{DIVIDE}  { return *yytext; }
{MODULO}  { return *yytext; }
{AND}  { return *yytext; }
{OR}  { return *yytext; }
{XOR}  { return *yytext; }
{NEGATION}  { return *yytext; }
{ASSIGN}  { return *yytext; }
{TILDE}  { return *yytext; }
{LESS_THAN}  { return *yytext; }
{GREATER_THAN}  { return *yytext; }
{INCREMENT}  { return INC; }
{DECREMENT}  { return DEC; }
{LOGICAL_AND} { return LAND; }
{LOGICAL_OR} { return LOR; }
{EQUALS}  { return EQ; }
{ARROW} {return ARROW;}
{NOT_EQUALS}  { return NEQ; }
{LESS_EQUALS}  { return LE; }
{GREATER_EQUALS}  { return GE; }
{ASSIGN_PLUS}  { return APLUS; }
{ASSIGN_MINUS}  { return AMINUS; }
{ASSIGN_MULT}  { return AMULT; }
{ASSIGN_DIV}  { return ADIV; }
{ASSIGN_MOD}  { return AMOD; }
{ASSIGN_AND}  { return AAND; }
{ASSIGN_OR}  { return AOR; }
{ASSIGN_XOR}  { return AXOR; }
{LEFT_SHIFT}  { return LSHIFT; }
{LEFT_SHIFT_EQ}  { return LSHIFTEQ; }
{RIGHT_SHIFT}  { return RSHIFT; }
{RIGHT_SHIFT_EQ}  { return RSHIFTEQ; }
{COMMENT} ;
{WHITESPACE}  ;
{NEWLINE} ;	
{IGNORE}  ;
.	{yyerror(NULL);}

%%

int yywrap(void){
	return 1;
}

