%{
    /* definicje */    
    int doc_flag = 0;
%}

%x comment1
%x comment2

%x doc_comment1
%x doc_comment2

%x string

/* rules */
%%

\/\*\*|\/\*\!  {{if(doc_flag == 0){ ECHO;} else{ ; }}; BEGIN(doc_comment1);}
\/\/\/|\/\/\!  {{if(doc_flag == 0){ ECHO;} else{ ; }}; BEGIN(doc_comment2);}

\/\/    {BEGIN(comment1);}
\/\*    {BEGIN(comment2);}

\"      {ECHO; BEGIN(string);} 


<doc_comment1>{

    \*\/    {
            if(doc_flag > 0){ BEGIN(INITIAL);}
            else{ ECHO; BEGIN(INITIAL);}
            }

    .       {
            if(doc_flag == 0){ ECHO; }
            else{ ; }
            }

    \\\n    {
            if(doc_flag == 0){ ECHO; }
            else{ ; }
            }

    \n      {
            if(doc_flag == 0){ ECHO; }
            else{ ; }
            }
}

<doc_comment2>{

    \\\n    {
            if(doc_flag == 0){ ECHO; }
            else{ ; }
            }

    \n      {
            if(doc_flag > 0){ BEGIN(INITIAL);}
            else{ ECHO; BEGIN(INITIAL);}
            }

    .       {
            if(doc_flag == 0){ ECHO; }
            else{ ; }
            }
}


<comment1>{
    \\\n    
    \n   {ECHO; BEGIN(INITIAL);}
    . 
}
<comment2>{
    \\\n    
    \*\/ {BEGIN(INITIAL);}
    .
    \n
}

<string>{
    \"  {ECHO; BEGIN(INITIAL);}
    .   {ECHO;}
}




%%

yywrap() {}

int main(int argc, char** argv){

    doc_flag = atoi(argv[1]);


    if(argc > 2) {
        yyin = fopen(argv[2], "r");
    }
    else {
        printf("Enter string: ");  
        yyin = stdin;
    }
    yylex();
    return 0;
}
