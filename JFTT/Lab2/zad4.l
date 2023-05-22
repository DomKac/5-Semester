%{
    /* definicje */
    #include <math.h>

    #define STACK_SIZE 100
    int stack[STACK_SIZE]; 
    int ptr = 0;
    int wynik = 0;

    void clear(){
        ptr = 0;
        for(int i=0; i<STACK_SIZE, i++ ){
            stack[i] = 0;
        }
    }

    int add(){
        ptr--;
        printf("stack[%d] + stack[%d] = %d + %d\n", ptr-1, ptr, stack[ptr-1], stack[ptr]);
        wynik = stack[ptr-1] + stack[ptr];
        stack[ptr-1] = wynik;
        printf("wynik = %d\t, ptr = %d\n", wynik, ptr);
    }

    int sub(){
        ptr--;
        printf("stack[%d] - stack[%d] = %d - %d\n", ptr-1, ptr, stack[ptr-1], stack[ptr]);
        wynik = stack[ptr-1] - stack[ptr];
        stack[ptr-1] = wynik;
        printf("wynik = %d\t, ptr = %d\n", wynik, ptr);
    }

    int mul(){
        ptr--;
        printf("stack[%d] * stack[%d] = %d * %d\n", ptr-1, ptr, stack[ptr-1], stack[ptr]);
        wynik = stack[ptr-1] * stack[ptr];
        stack[ptr-1] = wynik;
        printf("wynik = %d\t, ptr = %d\n", wynik, ptr);
    }

    int divide(){
        ptr--;
        printf("stack[%d] / stack[%d] = %d / %d\n", ptr-1, ptr, stack[ptr-1], stack[ptr]);
        wynik = stack[ptr-1] / stack[ptr];
        stack[ptr-1] = wynik;
        printf("wynik = %d\t, ptr = %d\n", wynik, ptr);
    }

    int modulo(){
        ptr--;
        printf("stack[%d] mod stack[%d] = %d mod %d\n", ptr-1, ptr, stack[ptr-1], stack[ptr]);
        wynik = stack[ptr-1] % stack[ptr];
        stack[ptr-1] = wynik;
        printf("wynik = %d\t, ptr = %d\n", wynik, ptr);
    }

    int power(){
        ptr--;
        printf("stack[%d] ^ stack[%d] = %d ^ %d\n", ptr-1, ptr, stack[ptr-1], stack[ptr]);
        wynik = (int)pow((double)stack[ptr-1], (double)stack[ptr]);
        stack[ptr-1] = wynik;
        printf("wynik = %d\t, ptr = %d\n", wynik, ptr);
    }    


%}


/* rules */
%%

\-?[0-9]+   {printf("number: %d\n", atoi(yytext));
            stack[ptr] = atoi(yytext);
            ptr++;}

\+          {{if(ptr >= 2){add();}
              else{ puts("Blad: za mala liczba argumentow!\n"); return 0;}};}

\-          {{if(ptr >= 2){sub();}
              else{ puts("Blad: za mala liczba argumentow!\n"); return 0;}};}

\*          {{if(ptr >= 2){mul();}
              else{ puts("Blad: za mala liczba argumentow!\n"); return 0;}};}

\^         {{if(ptr >= 2){power();}
              else{ puts("Blad: za mala liczba argumentow!\n"); return 0;}};}

\/          {{if(ptr < 2){puts("Blad: za mala liczba argumentow!\n"); return 0;}
              else if (stack[ptr-1] == 0){ puts("Blad: dzielenie przez 0!\n"); return 0;}
              else{ divide();}};}

\%         {{if(ptr < 2){puts("Blad: za mala liczba argumentow!\n"); return 0;}
              else if (stack[ptr-1] == 0){ puts("Blad: dzielenie przez 0!\n"); return 0;}
              else{ modulo();}};}

" "         

.           {printf("Blad: zly symbol '"); ECHO; puts("'"); return 0;}

\n          {{if(ptr > 1){printf("Blad: za mala liczba operatorow!\n");} else{printf("\n= %d\n", stack[0]);}}; return 0;}

%%

yywrap() {}

int main(int argc, char** argv){

    
    printf("Enter string: ");  
    yyin = stdin;
    yylex();

    return 0;
}
