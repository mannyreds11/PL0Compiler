PL/0 Compiler
Author: Manuel Rojas
The program will translate a PL/0 program into a C program

Instructions:

1. Compile: $ make

2. Run:     $ make test 
	    make test feeds the PL/0 source file (plo.src) into the ./pl0 executable and appends the results into the C source file (pl0.c)

3. Compile again: $ gcc pl0.c

4. Run:  $ ./a.out
