%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int number;
	char character;
	char* string;
}

%token <string> TYPE
%token <string> ID
%token <number> NUMBER
%token <char> SEMICOLON
%token <char> EQ
%token <char> ADD_OPR
%token <char> MULTI_OPR
%token <char> DIV_OPR
%token <char> SUB_OPR
%token <char> MOD_OPR
%token WRITE


%printer { fprintf(yyoutput, "%s", $$); } ID;

%start Program

%%

Program: DeclList  
;

DeclList:	Decl DeclList
	| Decl
;

Decl:	VarDecl
	| StmtList
;

VarDecl:	TYPE ID SEMICOLON	{ printf("\n RECOGNIZED RULE: Variable declaration %s\n", $2);
								  //printf("Items recognized: %s, %s, %c \n", $1, $2, $3);
								}
;


StmtList:	
	| Stmt StmtList
;

Stmt:	SEMICOLON
	| Expr1 SEMICOLON
	| Expr2 SEMICOLON
	| Expr3 SEMICOLON
	| Expr4 SEMICOLON
	| Expr5 SEMICOLON
	| Expr6 SEMICOLON
	| Expr7 SEMICOLON

;

Expr1 :ID SEMICOLON { printf("\n RECOGNIZED RULE: Simplest expression\n"); }
	| ID EQ ID SEMICOLON	{ printf("\n RECOGNIZED RULE: Assignment statement\n"); }
	| ID EQ NUMBER SEMICOLON	{ printf("\n RECOGNIZED RULE: Assignment statement\n"); }
Expr2: ID ADD_OPR ID SEMICOLON	{ printf("\n RECOGNIZED RULE: Addition\n"); }
	| ID EQ ID ADD_OPR ID SEMICOLON	{ printf("\n RECOGNIZED RULE: Addition\n"); }
Expr3: ID SUB_OPR ID SEMICOLON	{ printf("\n RECOGNIZED RULE: Subtraction\n"); }
	| ID EQ ID SUB_OPR ID SEMICOLON	{ printf("\n RECOGNIZED RULE: Subtraction\n"); }
Expr4: ID MULTI_OPR ID SEMICOLON	{ printf("\n RECOGNIZED RULE: Multiplication\n"); }
	| ID EQ ID MULTI_OPR ID SEMICOLON	{ printf("\n RECOGNIZED RULE: Multiplication\n"); }
Expr5: ID DIV_OPR ID SEMICOLON	{ printf("\n RECOGNIZED RULE: Division\n"); }
	| ID EQ ID DIV_OPR ID SEMICOLON	{ printf("\n RECOGNIZED RULE: Division\n"); }
Expr6: ID MOD_OPR ID SEMICOLON	{ printf("\n RECOGNIZED RULE: Modulus\n"); }
	| ID EQ ID MOD_OPR ID SEMICOLON	{ printf("\n RECOGNIZED RULE: Modulus\n"); }
Expr7: WRITE ID SEMICOLON	{ printf("\n RECOGNIZED RULE: WRITE statement\n"); }
%%

int main(int argc, char**argv)
{
/*
	#ifdef YYDEBUG
		yydebug = 1;
	#endif
*/
	printf("Compiler started. \n\n");
	
	if (argc > 1){
	  if(!(yyin = fopen(argv[1], "r")))
          {
		perror(argv[1]);
		return(1);
	  }
	}
	yyparse();
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
