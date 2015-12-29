# A Makefile for simple lex and yacc examples

# Comment out the proper lines below according to the scanner and
# parser generators available in your system

LEX = lex
YACC = yacc -d
# LEX = flex 
# YACC = bison -d

# We assume that your C-compiler is called gcc

CC = gcc


# testParser is the final object that we will generate, it used to test that the static library was created correctly 

testParser: ./test/main.c momentLib
	$(CC) -o testParser.exe test/main.c libMoment.a

# momentLib: this is static library that is created from the y.tab.o lex.yy.o and TimeParser.o
momentLib: y.tab.o lex.yy.o TimeParser.o
	ar -cvq libMoment.a *.o	

#TimeParser.o 
TimeParser.o: TimeParser.c TimeParser.h
	$(CC) -c TimeParser.c

## This rule will use yacc to generate the files y.tab.c and y.tab.h
## from our file parseIt.y

y.tab.c y.tab.h: parseIt.y
	$(YACC) -v parseIt.y

y.tab.o: y.tab.c TimeParser.h
	$(CC) -c y.tab.c

# These dependency rules indicate that (1) lex.yy.o depends on
# lex.yy.c and y.tab.h and (2) lex.yy.o and y.tab.o depend on TimeParser.h.
# Make uses the dependencies to figure out what rules must be run when
# a file has changed.

lex.yy.o: y.tab.h lex.yy.c 
	$(CC) -c lex.yy.c TimeParser.h

## this is the make rule to use lex to generate the file lex.yy.c from
## our file tokeIt.l

lex.yy.c: tokeIt.l TimeParser.h
	$(LEX) tokeIt.l


## Make clean will delete all of the generated files so we can start
## from scratch

clean:
	-rm -f *.o lex.yy.c *.tab.*  *.output *.gch *.exe libMoment.a