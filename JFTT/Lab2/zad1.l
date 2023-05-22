%{
    /* definicje */    
    int word_counter = 0;
    int line_counter = 0;
%}

/* rules */
%%

^[ \t]*(\n) {line_counter++;}
^[ \t]+
[ \t]+ {putchar(' ');}
[ \t]+$
[ \t]+<<EOF>>

[a-zA-Z]+ {ECHO; word_counter++;}
\n {ECHO; line_counter++;}

%%

yywrap() {}

int main(int argc, char** argv){
    /* printf("argc = %d\n", argc); */
    /* printf("argv[0] = %s\n", argv[0]); */
    /* printf("argv[1] = %s", argv[1]) */

    if(argc > 1) {
        yyin = fopen(argv[1], "r");
    }
    else {
        printf("Enter string: ");  
        yyin = stdin;
    }
    yylex();
    printf("\n------EOF------\nilosc linijek w pliku: %d\nilosc slow w pliku: %d", line_counter, word_counter);
    return 0;
}
