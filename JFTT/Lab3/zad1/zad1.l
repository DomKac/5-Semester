%option noyywrap

%{
    /* definicje */
    #include <stdio.h>
    #include <stdlib.h>
    #include "infixcalc.tab.h"

    extern int yylex();
%}

%x comment

%%

^\# {BEGIN(comment);}  
<comment>{
    \\\n
    \n {BEGIN(INITIAL);} 
    .   
       
}

[ \t]+      ;
[0-9]+      {yylval = atoi(yytext); return NUM;}

"("         {return '(';}
")"         {return ')';}
"+"         {return '+';}
"-"         {return '-';}
"*"         {return '*';}
"/"         {return '/';}
"^"         {return '^';}
\n          {return '\n';}
.           {return ERR;}

%%
