%{
	#include <math.h>
	#include<string.h>
	#include<stdlib.h>
	#include<stdio.h>
	#include <stdarg.h>
	#define YYDEBUG 1
	
	extern void yyerror(char *c);
	extern int yylineno;
        extern FILE *yyin;
        extern char* yytext;
	int yylex(void);  
	
%}
%union{
	int iVal;
	char* sVal;
	float fVal;
	char cVal;	
};


%token  CLASS CHAR CONST CASE CONTINUE DEFAULT DO DOUBLE INHERITANCE_OP
%token  ELSE ENUM EXTERN FALSE NEW FLOAT FOR IF  INT LONG
%token  PRIVATE PROTECTED PUBLIC REGISTER  RETURN SHORT SIGNED STATIC STRUCT SWITCH TYPEDEF THIS  TRUE UNION VOLATILE
%token  UNSIGNED VOID WHILE  BOOL 
%token  AUTO BREAK GOTO IDENTIFIER 

%token   ARROW CONSTANT FLOAT_CONSTANT HEX_CONSTANT OCT_CONSTANT STRING LOR LAND EQ NEQ LE GE LSHIFT RSHIFT INC DEC SIZEOF APLUS AMINUS AMULT ADIV AMOD AAND AOR AXOR LSHIFTEQ RSHIFTEQ
%start prog.start   
%%
prog.start: translation_unit     
			;


primary_expression : identifier
			| constant
			| FLOAT_CONSTANT
			| STRING
			| '(' expression ')'
			;


identifier:IDENTIFIER;


constant: CONSTANT
	| HEX_CONSTANT
	|OCT_CONSTANT 
	  ;
		

postfix_expression
	: primary_expression	
	| postfix_expression '[' expression ']'	

	| postfix_expression '(' ')'	
	| postfix_expression '(' argument_expression_list ')'	

	| postfix_expression '.' IDENTIFIER	
	| postfix_expression ARROW identifier
	| postfix_expression INC
	| postfix_expression DEC
	;	

argument_expression_list
	: argument_expression_list ',' assignment_expression	
	| assignment_expression					
	;	

unary_expression: postfix_expression			
	| INC unary_expression		
	| DEC unary_expression		
	| unary_operator cast_expression	
	| SIZEOF unary_expression		
	| SIZEOF '(' type_name ')'		
	;

unary_operator: '&'
			| '*'
			| '+'
			| '-'
			| '~'
			| '!'
			;

cast_expression
	: unary_expression			
	| '(' type_name ')' cast_expression	
	;

multiplicative_expression
	: cast_expression				
	| multiplicative_expression '*' cast_expression	
	| multiplicative_expression '/' cast_expression	
	| multiplicative_expression '%' cast_expression	
	;	

additive_expression
	: multiplicative_expression				
	| additive_expression '+' multiplicative_expression	
	| additive_expression '-' multiplicative_expression	
	;

shift_expression
	: additive_expression				
	| shift_expression LSHIFT additive_expression	
	| shift_expression RSHIFT additive_expression	
	;	
relational_expression
	: shift_expression				
	| relational_expression '<' shift_expression	
	| relational_expression '>' shift_expression	
	| relational_expression LE shift_expression	
	| relational_expression GE shift_expression	
	;

equality_expression
	: relational_expression					
	| equality_expression EQ relational_expression	
	| equality_expression NEQ relational_expression	
	;		
and_expression
	: equality_expression				
	| and_expression '&' equality_expression	
	;

exclusive_or_expression
	: and_expression				
	| exclusive_or_expression '^' and_expression	
	;	
inclusive_or_expression: exclusive_or_expression				
	| inclusive_or_expression '|' exclusive_or_expression	
    ;
logical_and_expression: inclusive_or_expression 
| logical_and_expression LAND inclusive_or_expression 
;

logical_or_expression: logical_and_expression 
| logical_or_expression LOR logical_and_expression
;

conditional_expression : logical_or_expression 
			 | logical_or_expression '?' expression ':' conditional_expression
					   ;

assignment_expression : conditional_expression
			 | unary_expression assignment_operator assignment_expression
					  ;


assignment_operator
	: '='		 
	| AMULT	 
	| APLUS	 
	| AMINUS	 
	| ADIV	 
	| AAND	 
	| AOR	 
	| AXOR	 
	| AMOD	 
	| RSHIFTEQ	 
	| LSHIFTEQ 
	;	

expression  : assignment_expression
			| expression ',' assignment_expression
			;

constant_expression: conditional_expression
                   ;

declaration
	: declaration_specifiers ';'		 
	| declaration_specifiers init_declarator_list ';'
		;

declaration_specifiers
	: storage_class_specifier				
	| storage_class_specifier declaration_specifiers	 
	| type_specifier					
	//| type_specifier declaration_specifiers			
	| type_qualifier				
	| type_qualifier declaration_specifiers			
	;

init_declarator_list
	: init_declarator				
	| init_declarator_list ',' init_declarator	 		
	;

init_declarator
	: declarator			
	| declarator '='  assignment_expression	
	;

storage_class_specifier
	:  TYPEDEF	 
	|  EXTERN	
	|  STATIC	
	|  AUTO	 	
	|  REGISTER	
	;	

type_specifier
	:  VOID				
	|  CHAR 				
	|  SHORT			
	|  INT				
	|  LONG
	| FLOAT			
	|  DOUBLE			
	|  SIGNED			
	|  UNSIGNED	
	| BOOL		
	|  struct_or_union_specifier  	
	|  enum_specifier					
	;

inheritance_specifier : access_specifier identifier
                      ;

inheritance_specifier_list : inheritance_specifier
    | inheritance_specifier_list ',' inheritance_specifier

access_specifier : PRIVATE
    | PUBLIC
    | PROTECTED

;

class : CLASS ;

class_definition_head : class
    | class INHERITANCE_OP inheritance_specifier_list
    | class IDENTIFIER
    | class IDENTIFIER  INHERITANCE_OP inheritance_specifier_list
;

class_definition : class_definition_head '{' class_internal_definition_list '}'
    | class_definition_head
	;

class_internal_definition_list : class_internal_definition
    | class_internal_definition_list class_internal_definition
	;

class_internal_definition : access_specifier '{' class_member_list '}' ';'
;

class_member_list : class_member
    | class_member_list class_member
	;

class_member : function_definition
    | declaration
	;


struct_or_union_specifier : struct_or_union IDENTIFIER '{' struct_declaration_list '}'
    | struct_or_union '{' struct_declaration_list '}'
    | struct_or_union IDENTIFIER

struct_or_union : STRUCT
    | UNION
    ;




struct_declaration_list
	:  struct_declaration	 			
	|  struct_declaration_list struct_declaration	
	;
struct_declaration
	:  specifier_qualifier_list struct_declarator_list ';'
	|specifier_qualifier_list ';'	 
	;

specifier_qualifier_list
	:  type_specifier specifier_qualifier_list	
	|  type_specifier	 			
	|  type_qualifier specifier_qualifier_list	
	|  type_qualifier	 		
	;

struct_declarator_list
	:  struct_declarator	 			
	|  struct_declarator_list ',' declarator	 
	;

struct_declarator: declarator
				 | ':' constant_expression	
				 | declarator ':' constant_expression 
				 ;


enum_specifier
	:  ENUM '{' enumerator_list '}'	 		
	|  ENUM identifier '{' enumerator_list '}'
	|  ENUM identifier	 			
	;

enumerator_list
	:  enumerator	 			 
	|  enumerator_list ',' enumerator	 
	;

enumerator
	:  identifier	 			
	|  identifier '=' constant_expression	 
	;

	
type_qualifier
	: CONST
	| VOLATILE
	;

declarator
	:  pointer direct_declarator	 
	|  direct_declarator	 	
	;




direct_declarator
	:  identifier	
	| '(' declarator ')' 					 
	|  direct_declarator '[' constant_expression ']'	 		 
	|  direct_declarator '[' ']'	    
	|  direct_declarator '(' parameter_type_list ')'	
	|  direct_declarator '(' ')'	
	| direct_declarator '(' identifier_list ')'		
	;

pointer
	:  '*'	 				
	|  '*' type_qualifier_list	 	
	|  '*' pointer	 			
	|  '*' type_qualifier_list pointer
	;

type_qualifier_list
	:  type_qualifier	 					
	|  type_qualifier_list type_qualifier	
	;	

parameter_type_list
	:  parameter_list	 	 		
	;

parameter_list
	:  parameter_declaration	 		
	|  parameter_list ',' parameter_declaration	
	;

parameter_declaration
	:  declaration_specifiers declarator	 		
	|  declaration_specifiers abstract_declarator	
	|  declaration_specifiers	 					 
	;
	
identifier_list: identifier
				| identifier_list ',' identifier

			;

type_name
	:  specifier_qualifier_list	 		
	|  specifier_qualifier_list abstract_declarator	
	;	


abstract_declarator
	:  pointer	 			
	|  direct_abstract_declarator	 	
	|  pointer direct_abstract_declarator	
	;

direct_abstract_declarator
	: '(' abstract_declarator ')' 
	| '[' ']'							
	|  '[' constant_expression ']'	 				
	|  direct_abstract_declarator '[' ']'				 
	|  direct_abstract_declarator '[' constant']'
	| '(' ')'
	| '(' parameter_type_list ')'
	| direct_abstract_declarator '(' ')' 
	| direct_abstract_declarator '(' parameter_type_list ')'
	;	

statement
	:  labeled_statement	
	|  compound_statement	 
	|  expression_statement	 
	|  selection_statement	 
	|  iteration_statement	 
	|  jump_statement	 
	;

labeled_statement
	:  identifier ':'  statement	 		
	|  CASE constant_expression':'  statement		
	|  DEFAULT ':'  statement	 		
	;


compound_statement
	:  '{' '}'	 			               
	|  '{' statement_list '}'	 		       
	|  '{' declaration_list '}'	 	        
	|  '{' declaration_list statement_list '}'		
	;

declaration_list
	:  declaration	 		 		 
	|  declaration_list declaration	 
	;

statement_list
	:  statement			 	 			 
	|  statement_list statement // causes shift reduce conflicts.
	;

expression_statement :
        | ';'			 	
	|  expression ';' 
	;

selection_statement
	:  IF '(' expression  ')'  statement	ELSE  statement		
	|  IF '(' expression  ')'  statement  	
	|  SWITCH '(' expression  ')' statement 			 
	;	

iteration_statement
	:  WHILE '('  expression')'  statement	 
	|  DO  statement WHILE '('  expression  ')' ';'	
	|  FOR '(' expression ';' expression ';'expression  ')'  statement	
	|  FOR '(' expression ';'  expression ';' ')'  statement	  
	;

jump_statement
	:  GOTO identifier ';'	 
	|  CONTINUE ';'	 		
	|  BREAK ';'	 		
	|  RETURN ';'	 		 
	|  RETURN expression ';' 
	;	


translation_unit: external_declaration
| translation_unit external_declaration
;

external_declaration
	:  function_definition	 
	|  declaration	 
	| class_definition 
	;




function_declaration
	: declaration_specifiers declarator 
	;

function_definition
	:  function_declaration compound_statement	 
	| declaration_specifiers declarator declaration_list compound_statement
	| declarator declaration_list compound_statement
    | declarator compound_statement
	;


%%	

extern FILE *yyin;

extern void yyerror(char *c){
		printf("%s\n", c);
	} 


int main(int argc, char* argv[]){
	FILE *file;
	if (argc==2 &&(file=fopen(argv[1],"r"))) {
		yyin = file;
		
		
		}
	else if (argc!=2){
		printf("Please give the file \n");
		return 0;
	}
	
yyparse();
	
	
	
	return 0;
}
