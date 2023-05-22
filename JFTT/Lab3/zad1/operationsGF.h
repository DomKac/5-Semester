#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int negP(int a, int P);
int invP(int a, int P);
int addP(int a, int b, int P);
int mulP(int a, int b, int P);
int subP(int a, int b, int P);
int divP(int a, int b, int P);
int powP(int a, int b, int P);

/* element przeciwny */
int negP(int a, int P){
    /* z flexa dostajemy |a| < P  */
    //return (a < 0) ? (P + a) : a; 
    return P-a;
}
int invP(int a, int P){
    for (size_t i = 1; i < P; i++) {
        if(mulP(a,i,P) == 1)
            return i;
    }
    return -1; /* w ciele nie ma elementu odwrotnego do a */
}

int addP(int a, int b, int P){
    return (a + b) % P;
}

int mulP(int a, int b, int P){
    return (int)(((unsigned long long)a * (unsigned long long)b) % P);
}

int subP(int a, int b, int P){
    return addP(a, negP(b,P), P);
}

int divP(int a, int b, int P){
    int inv_b = invP(b, P);
    /* b nie ma el. odwrotengo w GF(P) */
    if (inv_b == -1)
        return -1;

    return mulP(a, inv_b, P);
}

int powP(int a, int b, int P){
    if(b == 0)
        return 1;
    int p = 1;
    for (size_t i = 0; i < b; i++){
        p = mulP(p,a,P);
    }
    return p;
}
