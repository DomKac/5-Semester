import ply.yacc as yacc
from calclex import tokens

P = 1234577

err = ""
onp = ""

def addP(a, b, P):
     return (a + b) % P

def mulP(a, b, P):
     return (a * b) % P

def negP(a, P):
     return P-a

def invP(a,P):
     for i in range(1,P):
          if mulP(a,i,P) == 1:
               return i
     return -1

def subP(a, b, P):
     return addP(a, negP(b, P), P)

def divP(a, b, P):
     inv_b = invP(b, P)
     if inv_b == -1:
          return -1
     
     return mulP(a, inv_b, P)

def powP(a, b, P):
     if b == 0:
          return 1
     p = 1
     for i in range(b):
          p = mulP(p,a,P)

     return p


# kolejność wykonywania działań
precedence = (
    ('left', 'PLUS', 'MINUS'),
    ('left', 'TIMES', 'DIVIDE'),
    ('right', 'NEG'),
    ('right', 'POWER')
)

def p_line(p):
     'line : exp ENDLINE'
     global onp
     print("ONP: ", onp)
     print(f"Wynik: {p[1]}\n")    
     onp = ""

def p_line_error(p):
    'line : error ENDLINE'
    global err, onp
    print(err)
    onp = ""

def p_exp_num(p):
     'exp : num'
     p[0] = p[1]
     global onp
     onp += f"{p[1]} "

def p_num_plus(p):
     'num : NUMBER'
     p[0] = p[1] % P

def p_num_minus(p):
     'num : MINUS NUMBER %prec NEG'
     p[0] = negP(p[2],P)


def p_exp_add(p):
     'exp : exp PLUS exp'
     p[0] = addP(p[1], p[3], P)
     global onp
     onp += "+ "

def p_exp_sub(p):
     'exp : exp MINUS exp'
     p[0] = subP(p[1], p[3], P)
     global onp
     onp += "- "
 
def p_exp_mul(p):
     'exp : exp TIMES exp'
     p[0] = mulP(p[1], p[3], P)
     global onp
     onp += "* "
 
def p_exp_div(p):
     'exp : exp DIVIDE exp'

     x = divP(p[1], p[3], P)
     if x == -1:
          global err
          err = f"{p[3]} nie jest odwracalne modulo {P}"
          raise SyntaxError
     else:
          p[0] = x
          global onp
          onp += "/ "
 
def p_exp_paren_plus(p):
     'exp : LPAREN exp RPAREN'
     p[0] = p[2]

def p_exp_paren_minus(p):
     'exp : MINUS LPAREN exp RPAREN %prec NEG'
     p[0] = negP(p[3], P)
     global onp
     onp += "- "

def p_exp_pow(p):
     'exp : exp POWER powexp'
     p[0] = powP(p[1],p[3],P)
     global onp
     onp += "^ "

def p_exp_double_minus(p):
     'exp : MINUS MINUS exp'
     p[0] = p[3]

# ------ Liczy w potędze (modulo P-1)

def p_powexp_num(p):
     'powexp : pownum'
     p[0] = p[1]
     global onp
     onp += f"{p[1]} "     

def p_pownum_plus(p):
     'pownum : NUMBER'
     p[0] = p[1] % (P-1)

def p_pownum_minus(p):
     'pownum : MINUS NUMBER %prec NEG'
     p[0] = negP(p[2],(P-1))

# ------ Działania modulo P-1 w potędze 

def p_powexp_add(p):
     'powexp : powexp PLUS powexp'
     p[0] = addP(p[1], p[3], P-1)
     global onp
     onp += "+ "
 
def p_powexp_sub(p):
     'powexp : powexp MINUS powexp'
     p[0] = subP(p[1], p[3], P-1)
     global onp
     onp += "- "

def p_powexp_mul(p):
     'powexp : powexp TIMES powexp'
     p[0] = mulP(p[1], p[3], P-1)
     global onp
     onp += "* "
 
def p_powexp_div(p):
     'powexp : powexp DIVIDE powexp'
     
     x = divP(p[1], p[3], P-1)
     if x == -1:
          global err
          err = f"{p[3]} nie jest odwracalne modulo {P-1}"
          raise SyntaxError
     else:
          p[0] = x
          global onp
          onp += "/ "
 
def p_powexp_paren_plus(p):
     'powexp : LPAREN powexp RPAREN'
     p[0] = p[2]

def p_powexp_paren_minus(p):
     'powexp : MINUS LPAREN powexp RPAREN %prec NEG'
     p[0] = negP(p[3], P-1)
     global onp
     onp += "- "


def p_powexp_double_minus(p):
     'powexp : MINUS MINUS powexp'
     p[0] = p[3]

# --------

def p_error(p):
     if p != None:
          print("Blad skladni!")
     pass
