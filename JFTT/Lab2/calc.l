%{
    #include <math.h>
    /* definicje */    
    int x;
    int y;
    int wynik;
%}

DIGIT   [0-9]
DZIALANIE   [+*-/]

/* rules */
%%

{DIGIT}+" "{DIGIT}+" "{DZIALANIE} {printf("dzialanie\n");}
[abc]

\n {return 0;}

%%

yywrap() {}

int main(void){

    printf("Enter string: ");
    yylex();
    return 0;

}
