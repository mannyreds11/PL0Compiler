// PL/O Compiler
// Author: Manuel Rojas

%token
ASSIGN PERIOD SEMICOLON CONST COMMA VAR PROCEDURE EQUAL CALL BEGN END IF THEN WHILE DO ODD PRINTINT PRINTLN PRINTSTRING LT GT LE GE NE PLUS MINUS TIMES DIVIDE LPAREN RPAREN IDENTIFIER NUMBER TRUE FALSE BCOMMENT ECOMMENT

%start START
%{
  #include <stdio.h>
  #define YYERROR_VERBOSE 1
  //#define TRUE  1
  //#define FALSE 0
  extern char *yytext;
%}

%%
// Prints the libraries into C file
// Program consists of a block and period

START: {printf("#include <stdio.h>\n");}
       {printf("#include <stdlib.h>\n\n");} 
       block  PERIOD
       ;

empty: ;


block:  empty
        | consec varsec prosec statement 
        ;
	

consec: empty
        | CONST {printf("int ");} constdef constdeflist SEMICOLON {printf(";\n");}
        ;

	
constdef: IDENTIFIER {printf(yytext);} EQUAL {printf(" = ");} NUMBER {printf(yytext);}
          ;

// Used recursion in case of multiple constant declarations
	  
constdeflist: empty
              |COMMA {printf(", ");} constdef constdeflist
              ;

	      	  
varsec : VAR {printf ("int ");} IDENTIFIER {printf(yytext);} vardeflist SEMICOLON {printf(";\n");}
	 ;
	 
// Used recursion in case of multiple variables used
	 
vardeflist : empty
             |COMMA {printf(", ");} IDENTIFIER {printf(yytext);} vardeflist
             ;
	
// Can be a regualr procedure (subprogram) or a main procedure (main program)

prosec : empty
         | proc procmain
	 ;

// Calls prosec (recursion) in case of multiple procedures 
// Uses its own block, named problock. Apart from regular block above

proc: PROCEDURE {printf("void ");} IDENTIFIER {printf(yytext);} {printf("(){\n");} SEMICOLON problock SEMICOLON {printf("}");} prosec
	 ;

	 	 
problock: consec varsec prosec statement {printf(";");}
          ;
	 
// Main procedure starts with a BEGN with no "procedure" keyword above

procmain: empty
	 | BEGN {printf("int main(){");} statement statementlist  END {printf("}");}
         ;
	 
	 

statement: identsec callsec beginsec ifsec whilesec
           ;

// Used recursion to declare multiple statements 

statementlist: empty
               | SEMICOLON {printf(";");} statement statementlist
	       ;
	   
identsec: empty
          | IDENTIFIER {printf(yytext);} ASSIGN {printf(" = ");} expression 
          ;
	  
	  
callsec : empty
          | CALL IDENTIFIER {printf(yytext);} {printf("()");}
	  ;
	  
	  
beginsec: empty
          | BEGN {printf("{\n");} statement beginlist {printf("; ");}END {printf("\n}\n");}
          ;
       

beginlist : empty 
            | SEMICOLON {printf(";\n");} statement beginlist 
            ;
	       
	  

ifsec: empty
       | IF {printf("if");} {printf("(");} condition {printf(")");}  THEN statement {printf(";");} 
       ;
       


whilesec: empty
          |WHILE {printf("while");} {printf("(");} condition {printf(")");} DO statement 
	  ;
	     

// ODD Checks for odd numbers by returning the remainder and comparing it to 1
	
condition: ODD expression {printf("% 2 == 1");}
           | expression symbol expression
	   ;
	   
symbol: EQUAL{printf("==");}
        | NE {printf("!=");}
	| LT {printf("<");}
	| GT {printf(">");}
	| LE {printf("<=");}
	| GE {printf(">=");}
	;
	     
expression:  sign term termlist 
	     ;
	     
// Used for negative numbers

sign: empty
      | PLUS
      | MINUS
      ;

term: factor factorlist
      ;     	     

termlist: empty
          |PLUS {printf(" + ");} term termlist
	  |MINUS {printf(" - ");} term termlist
	  ;    	     



      
factor: IDENTIFIER {printf(yytext);}
        | NUMBER {printf(yytext);} 
        | boolean
	| LPAREN {printf(" ( ");} expression RPAREN {printf(" ) ");} 	   
	;  
	
factorlist: empty
            | TIMES {printf(" * ");} factor factorlist
            | DIVIDE {printf(" / ");} factor factorlist
            ;
      
boolean: TRUE {printf("TRUE");}
         | FALSE {printf("FALSE");}
         ;
	  

%%
int main(){
yyparse();
}
