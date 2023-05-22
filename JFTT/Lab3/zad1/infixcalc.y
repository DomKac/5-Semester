/* Reverse Polish Notation calculator. */

%{
    #include <stdio.h>  
    #include <math.h>
    #include <ctype.h>
    #include <stdlib.h>
    #include <string.h>
    #include <stdbool.h>

    #include "operationsGF.h"
    #include "lex.yy.c"
    
    #define YYSTYPE int
    #define P 1234577

    extern int yylex();
    int yyparse();
    void yyerror (char const *);

    bool neg_flag = false;
    char err_msg[50]        ;   /* wypisanie odpowiednich błędów */
    char number[1000] = ""  ;    /* int -> string */
    char str[100000] = ""   ;   /* zmienna gdzie będzie zapisywna odwrotna notacja polska */
%}


%token NUM
%token ERR

%left '-' '+'
%left '*' '/'
%precedence NEG /* negation (unary minus) */
%right '^'      /* exponentiation */


%% /* Grammar rules and actions follow. */

input:
    %empty
| input line
;

line:
    '\n'
| exp '\n' { printf ("ONP: %s\n", str);
             printf ("Wynik: %d\n", $1);
             str[0] = '\0';
             number[0] = '\0';
            }
| error '\n' {  str[0] = '\0';
                number[0] = '\0'; 
                yyerrok; 
             }
;

num: 
  NUM               { $$ = $1 % P; }
| '-' NUM %prec NEG { $$ = negP($2, P); }


pownum: 
  NUM               { $$ = $1 % (P-1); }
| '-' NUM %prec NEG { $$ = negP($2, P-1); }

exp:
  num               { $$ = $1; number[0] = '/0'; sprintf(number, "%d", ($1 % P)); strcat(number, " "); strcat(str, number); }
| exp '+' exp       { $$ = addP($1, $3, P); strcat(str, "+ ");}
| exp '-' exp       { $$ = subP($1, $3, P); strcat(str, "- ");}
| exp '*' exp       { $$ = mulP($1, $3, P); strcat(str, "* ");}
| exp '/' exp       {   
                        {int x = divP($1, $3, P); 
                        if(x == -1) {
                            err_msg[0] = '\0';
                            sprintf(err_msg, "%d", $3);
                            yyerror(strcat(err_msg, " nie jest odwracalne modulo 1234577"));
                            YYERROR;
                        }
                        else {
                            $$ = x;
                            strcat(str, "/ ");
                        }};
                    }

| exp '^' powexp    { $$ = powP($1, $3, P); strcat(str, "^ "); }
| '(' exp ')'       { $$ = $2; }
| '-' '(' exp ')' %prec NEG { $$ = negP($3,P); strcat(str, "- ");}
| '-' '-' exp       { $$ = $3; }
;

powexp:
  pownum            { $$ = ($1);  number[0] = '/0'; sprintf(number, "%d", ($1 % (P-1))); strcat(number, " "); strcat(str, number); }
| powexp '+' powexp { $$ = addP($1, $3, (P-1)); strcat(str, "+ ");}
| powexp '-' powexp { $$ = subP($1, $3, (P-1)); strcat(str, "- ");}
| powexp '*' powexp { $$ = mulP($1, $3, (P-1)); strcat(str, "* ");}
| powexp '/' powexp {
                        int x = divP($1, $3, (P-1)); 
                        if(x == -1) {
                            err_msg[0] = '\0';
                            sprintf(err_msg, "%d", $3);
                            yyerror(strcat(err_msg, " nie jest odwracalne modulo 1234576"));
                            YYERROR;
                        }
                        else {
                            $$ = x;
                            strcat(str, "/ ");
                        }
                    }
| '(' powexp ')'    { $$ = $2; }
| '-' '(' powexp ')' %prec NEG { $$ = negP($3,P-1); strcat(str, "- ");}
| '-' '-' powexp    { $$ = $3; }

;

%%

/* Called by yyparse on error. */
void yyerror (char const *s) {
    fprintf(stderr, "%s\n", s);
}

int main (void) {
    return yyparse();
}
