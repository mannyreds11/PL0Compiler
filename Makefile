CC = gcc
CFLAGS = -O -w #-ggdb
LDFLAGS = 

# the parser generator
YACC = bison -y

YACCFLAGS = -v

#use next two lines for flex
LEX = flex
FLIBS = -lfl


OBJS = lex.yy.o y.tab.o

pl0 : $(OBJS)
	$(CC) -o pl0 $(CFLAGS) $(OBJS) $(LDFLAGS) $(LIBS) $(FLIBS)

lex.yy.o : lex.yy.c y.tab.h

lex.yy.c : pl0.l
	$(LEX) pl0.l

y.tab.c : pl0.y
	$(YACC) $(YACCFLAGS) pl0.y

y.tab.h:
	$(YACC) -d $(YACCFLAGS) pl0.y

clean:
	-rm lex.yy.c y.tab.c *.o y.tab.h pl0 y.output *~ core


test:
	./pl0 < pl0.src > pl0.c
	
indentc:
	 indent -i4 pl0.c
	 
