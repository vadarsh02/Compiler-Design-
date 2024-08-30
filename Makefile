src/lex.yy.c : src/lexer.l
	flex -o src/lex.yy.c src/lexer.l

all : src/lexer.c src/lex.yy.c
	bash init.sh
	gcc src/lex.yy.c src/lexer.c -lfl -o bin/lexer

clean :
	rm -rf src/lex.yy.c bin
