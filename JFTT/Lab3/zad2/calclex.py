import ply.lex as lex

 # List of token names.   This is always required
tokens = (
    'NUMBER',
    'PLUS',
    'MINUS',
    'TIMES',
    'DIVIDE',
    'LPAREN',
    'RPAREN',
    'POWER',
    'ENDLINE',
    'ERR'
)

# Regular expression rules for simple tokens
t_PLUS    = r'\+'
t_MINUS   = r'[-]'
t_TIMES   = r'\*'
t_DIVIDE  = r'[/]'
t_LPAREN  = r'\('
t_RPAREN  = r'\)'
t_POWER   = r'\^'

t_ignore  = ' \t'
t_ignore_COMMENT = r'^[#].*\n'
t_ignore_LINE_CONT = r'^[#].*\\\n.*'

t_ENDLINE = r'\n'
t_ERR = r'.'

# A regular expression rule with some action code
def t_NUMBER(t):
     r'\d+'
     t.value = int(t.value)    
     return t

def t_error(t):
    pass
