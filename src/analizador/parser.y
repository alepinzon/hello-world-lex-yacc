%{
    #include<stdio.h>
    int yylex(void);
    void yyerror(char *s);
%}

%token NUMBER EVALUAR

%left '+' '-'
%left '*' '/'
%left NEG

%%

Init
    : Lista {
        return 0;
    }
;

Lista
    : Lista EVALUAR '(' Expr ')' ';'
    {
        printf("\nResult=%d\n", $4);
    }
    |   EVALUAR '(' Expr ')' ';'
    {
        printf("\nResult=%d\n", $3);
    }
;

Expr
    : Expr '+' Expr
    {
        $$ = $1 + $3;
    }
    | Expr '-' Expr
    {
        $$ = $1 - $3;
    }
    | Expr '*' Expr
    {
        $$ = $1 * $3;
    }
    | Expr '/' Expr
    {
        $$ = $1 / $3;
    }
    | '-' Expr %prec NEG 
    {
        $$ = -$2;
    }
    | '(' Expr ')'
    {
        $$ = $2;
    }
    | NUMBER
    {
        $$ = $1;
    }
;

%%

// Driver Code
int main(void) {
    yyparse();
    return 0;
}

void yyerror(char *s) {
    printf("\n%s\n", s);
}
