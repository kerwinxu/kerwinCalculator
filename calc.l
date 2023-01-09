%{
    #include <stdlib.h>
    #include <string.h>
    void calcerror(char *);
    #include "calc_yacc.h"
%}

%%
[0-9]+|[0-9]+"."[0-9]* {calclval.floatval =atof(calctext); return NUM;}
"+" {return OP_ADD;}
"-" {return OP_SUB;}
"**" {return OP_POW;}
"*" {return OP_MUL;}
"/" {return OP_DIV;}
"(" {return LEFT_BRACKET;}
")" {return RIGHT_BRACKET;}

"PI" {calclval.floatval =3.141592653589793; return NUM;}
"E"  {calclval.floatval =2.718281828459045; return NUM;}

[a-zA-Z][a-zA-Z0-9]* {calclval.id=strdup(calctext);return OP_FUN;}


"\n" {return END;} /* 回车*/

[\t ] ;
 
. calcerror("无效字符");

%%

int calcwrap(void){
    return 1;
}
