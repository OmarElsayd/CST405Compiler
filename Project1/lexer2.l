%option noyywrap

%{
#include <stdio.h>
#include <string.h>

#define YY_DECL int yylex()
#include "parser.tab.h"

int words = 0;
int chars = 0;
int lines = 0;

%}

/* This part will define the names that are leglle in our lanagauge 
For exaple I want to be able to include underscore in my IDs 
so I added semples [_] with a condithion that we can not start with "_" at
the beginning of any ID */

letter      [a-zA-Z]
Semple		[_]
digit       [0-9]
ID          {letter}({letter}|{digit}|{Semple})*
delim       [ \t\n]
NUMBER      {digit}+(\.{digit}+)?(E[+\-]?(digit)+)?
ws          {delim}+

%%
"/*"    				{
							int c;
							while((c = input()) != 0) {
								if(c == '*') {
									if((c = input()) == '/')
										break;
									else
										unput(c);
								}
							}
						}
						
"int"	{words++; chars += strlen(yytext);
			printf("%s : TYPE\n", yytext);
			yylval.string = strdup(yytext); 
			return TYPE;
		}

"write"	{words++; chars += strlen(yytext);
			printf("%s : KEYWORD\n", yytext);
			yylval.string = strdup(yytext); 
			return WRITE;
		}

{ID}	{words++; chars += strlen(yytext);
			  printf("%s : IDENTIFIER\n",yytext);
			  yylval.string = strdup(yytext); 
			  return ID;
			}
			
{NUMBER}		{words++; chars += strlen(yytext);
			  printf("%s : NUMBER\n",yytext);
			  yylval.string = strdup(yytext); 
			  return NUMBER;
			}
			
";"		{chars++;
		  printf("%s : SEMICOLON\n", yytext);
		  yylval.string = strdup(yytext); 
		  return SEMICOLON;
		}
		
"="		{chars++;
		  printf("%s : EQ\n", yytext);
		  yylval.string = strdup(yytext); 
		  return EQ;
		}
"+"		{chars++;
		  printf("%s : ADD_OPR\n", yytext);
		  yylval.string = strdup(yytext); 
		  return ADD_OPR;
		}
"-"		{chars++;
		  printf("%s : SUB_OPR\n", yytext);
		  yylval.string = strdup(yytext); 
		  return SUB_OPR;
		}		
"*"		{chars++;
		  printf("%s : MULTI_OPR\n", yytext);
		  yylval.string = strdup(yytext); 
		  return MULTI_OPR;
		}
"/"		{chars++;
		  printf("%s : DIV_OPR\n", yytext);
		  yylval.string = strdup(yytext); 
		  return DIV_OPR;
		}
"%"		{chars++;
			printf("%s : MOD_OPR\n", yytext);
			yylval.string = strdup(yytext); 
			return MOD_OPR;
		}


[\n]	{lines++; chars=0;}
[ \t]	{chars++;}
.		{chars++;
         printf("%s : Unrecognized symbol at line %d char %d\n", yytext,lines,chars);
		}
		

%%