%{
    /* definicje */    

%}

%x comment

%x string
%x string1
%x string2

/* rules */
%%

#       {BEGIN(comment);}
\"      {ECHO; BEGIN(string);}
\'      {ECHO; BEGIN(string1);}
\"\"\"  {ECHO; BEGIN(string2);}

<comment>{
    \n  {ECHO; BEGIN(INITIAL);}
    . 
}

<string>{
    \"  {ECHO; BEGIN(INITIAL);}
    .   {ECHO;}
}

<string1>{
    \'  {ECHO; BEGIN(INITIAL);}
    .   {ECHO;}
}

<string2>{
    \"\"\" {ECHO; BEGIN(INITIAL);}
    .      {ECHO;}
}


%%

yywrap() {}

int main(int argc, char** argv){

    if(argc > 1) {
        yyin = fopen(argv[1], "r");
    }
    else {
        printf("Enter string: ");  
        yyin = stdin;
    }
    yylex();
    return 0;
}
