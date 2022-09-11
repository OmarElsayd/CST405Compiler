all: Parser
parser.tab.c parser.tab.h:
	bison -t -v -d parser.y
	flex lexer2.l
	gcc -o parser parser.tab.c lex.yy.c
	./parser testProg.cmm

