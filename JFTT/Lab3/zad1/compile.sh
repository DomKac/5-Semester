flex zad1.l
bison -d infixcalc.y
gcc infixcalc.tab.c -o calc
