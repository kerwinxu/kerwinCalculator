%{
    #include <stdlib.h>
    #include <string.h>
    void yyerror(char *);
    #include "calc_yacc.h"
%}

%%
[0-9]+|[0-9]+"."[0-9]* {yylval.floatval =atof(yytext); return NUM;}
"+" {return OP_ADD;}
"-" {return OP_SUB;}
"**" {return OP_POW;}
"*" {return OP_MUL;}
"/" {return OP_DIV;}
"(" {return LEFT_BRACKET;}
")" {return RIGHT_BRACKET;}


[a-z]+ {yylval.id=strdup(yytext);return OP_FUN;}


"\n" {return END;} /* 回车*/

[\t ] ;
 
. yyerror("无效字符");

%%

int yywrap(void){
    return 1;
}
