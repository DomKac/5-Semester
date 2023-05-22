from ply import lex, yacc

import calclex
import calcyacc

def main():
    lexer = lex.lex(module=calclex)
    parser = yacc.yacc(module=calcyacc)
    while True:
        str = ""
        while True:
            try:
                str += input()
            except EOFError:
                return
            str += '\n'
            if not str.endswith('\\\n'):
                break
        parser.parse(str, lexer=lexer)

if __name__ == "__main__":
    main()
