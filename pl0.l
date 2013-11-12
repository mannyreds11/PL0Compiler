%{
#include "y.tab.h"
#define NOTHING 


int linecount = 1;


%}

%%
"~"                             {NOTHING; return (BCOMMENT);}
"$"                             {NOTHING; return (ECOMMENT);}
"TRUE"                         	{NOTHING; return (TRUE);}
"FALSE"                        	{NOTHING; return (FALSE);}
":="                            {NOTHING; return (ASSIGN);}
"."                             {NOTHING; return (PERIOD);}
";"                             {NOTHING; return (SEMICOLON);}
"CONST"                         {NOTHING; return (CONST);}
","                             {NOTHING; return (COMMA);}
"VAR"                           {NOTHING; return (VAR);}
"PROCEDURE"                     {NOTHING; return (PROCEDURE);}
"="                             {NOTHING; return (EQUAL);}
"CALL"                          {NOTHING; return (CALL);}
"BEGIN"                         {NOTHING; return (BEGN);}
"END"                           {NOTHING; return (END);}
"IF"                            {NOTHING; return (IF);}
"THEN"                          {NOTHING; return (THEN);}
"WHILE"                         {NOTHING; return (WHILE);}
"DO"                            {NOTHING; return (DO);}
"ODD"                           {NOTHING; return (ODD);}
"PrintInt"                      {NOTHING; return (PRINTINT);}
"PrintLn"                       {NOTHING; return (PRINTLN);}
"PrintString"                   {NOTHING; return (PRINTSTRING);}
"<"                             {NOTHING; return (LT);}
">"                             {NOTHING; return (GT);}
"<="                            {NOTHING; return (LE);}
">="                            {NOTHING; return (GE);}
"<>"                            {NOTHING; return (NE);}
"+"                             {NOTHING; return (PLUS);}
"-"                             {NOTHING; return (MINUS);}
"*"                             {NOTHING; return (TIMES);}
"/"                             {NOTHING; return (DIVIDE);}
"("                             {NOTHING; return (LPAREN);}
")"                             {NOTHING; return (RPAREN);}
[a-zA-Z][a-zA-Z0-9]*            {NOTHING; return (IDENTIFIER);}
[0-9][0-9]*                     {NOTHING; return (NUMBER);}
\n                              {NOTHING; linecount++;}
%%

int yyerror (char *c){
printf ("line %d is %s", linecount,c);
}
