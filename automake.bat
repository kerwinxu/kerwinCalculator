del calc.tab.c
del calc.tab.h
del lex.yy.c
bison -d calc.y 
flex calc.l
gcc -o bc *.c -lm
