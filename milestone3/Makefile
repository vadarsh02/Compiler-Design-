all:
	bison -d parser.y
	flex lexer.l 
	gcc lex.yy.c parser.tab.c -lfl -o parser
	
clean:
	rm lex.yy.c parser.tab.h parser.tab.c 	
	
