%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include <string.h>
    #define PI 3.14159265
    int yylex(void);
    void yyerror(char *);

    /*** 如下的是可以设置成输入字符串的。  **/
    typedef struct yy_buffer_state * YY_BUFFER_STATE;
    extern int yyparse();
    extern YY_BUFFER_STATE yy_scan_string(char * str);
    extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

    double result; // 输出的结果。

%}

// 有如下的标识符
%token NUM OP_ADD OP_SUB OP_MUL OP_DIV END NEG OP_POW OP_FUN LEFT_BRACKET RIGHT_BRACKET
// 优先级和结核性如下。
%left OP_ADD OP_SUB 
%left OP_MUL OP_DIV 
%right OP_POW
%left OP_FUN
%left NEG

// 数据类型。有两种，一种是浮点数，而另一种是字符串（函数名）
%union{
    double floatval;
    char * id;
}

// 如下的是数据类型，大多数类型都是数字（浮点数），只有OP_FUN是字符串。
%type <floatval> expr term factor fun NUM 
%type <id> OP_FUN

%%

line:
    line expr END {
        //printf("%2f\n", $2);
        result = $2;
        }
    |;
;
expr:
    expr OP_ADD term {$$ = $1 + $3;}
    | expr OP_SUB term {$$ = $1 - $3;}
    | term {$$=$1;}
;
term:
    term OP_MUL factor {$$ = $1 * $3;}
    | term OP_DIV factor {$$ = $1 / $3;}
    | term OP_POW factor {$$ = pow($1,$3);}
    | factor {$$=$1;}
;
factor:
    NUM {$$=$1;}
    | LEFT_BRACKET expr RIGHT_BRACKET {$$=$2;}
    | OP_SUB NUM %prec NEG {$$=-$2;}
    | fun
fun:
    OP_FUN LEFT_BRACKET expr RIGHT_BRACKET {
        if (strcmp("sin", $1) == 0)
        {
            $$=sin($3* PI / 180);
        }else if (strcmp("cos", $1) == 0)
        {
            $$=cos($3* PI / 180);
        }
        else if (strcmp("tan", $1) == 0)
        {
            $$=tan($3* PI / 180);
        }else{
            yyerror($1);

        }
    } // end

;

%%

void yyerror(char * s){
    printf("yyerror : %s\n", s);
}

double get_result(){
    return result;
}

// int main(void ){
//     yy_scan_string("sin(30)\n");
//     yyparse();
//     printf("%f\n", result);
//     return 0;
// }

double parse_expr(char * expr){
    // 这个是供外部调用的。
    printf("expr: %s\n", expr);
    YY_BUFFER_STATE buf = yy_scan_string(expr);
    yyparse();
    double result = get_result();
    yy_delete_buffer(buf);
    return result;

}
