from pydoc import doc
from array import *
import sys

def create_automat(pattern):
    p_len = len(pattern) 
    alphabet_p = list(set(pattern)) # tworzymy listę symboli tworzących wzorzec
    alphabet_p.sort()
    delta = {(q, s): 0 for q in range(p_len + 1) for s in alphabet_p} # funkcja delta ('numer stanu', 'litera z alfabetu')

    for q in range(p_len+1):
        print (f"q = {q}") 
        for s in alphabet_p:
            print (f"\ts = {s}")
            k = min(p_len, q+1)
            print(f"\t\tk = min({p_len}, {q+1}) = {k}")
            print(f"\t\tP(q)||s = {pattern[:q]+s}\t P(k) = {pattern[:k]}")
            while not((pattern[:q]+s).endswith(pattern[:k])) and k > 0: # dopóki P(k) nie jest sufiksem P(q)||s i k>0            
                k = k-1
                print(f"\t\tk = {k}")
                print(f"\t\tP(q)||s = {pattern[:q]+s}\t P(k) = {pattern[:k]}")
            delta[q, s] = k
            print(f"\t\tdelta[{q}, {s}] = {k}")
    return delta

def find_pattern(pattern, text):
    
    delta = create_automat(pattern)
    p_len = len(pattern)
    text_len = len(text)
    q = 0
    index = []
    
    for i in range(text_len):
        if text[i] in pattern:
            q = delta[q, text[i]]
        else:
            q = 0
        if q == p_len:
            # print(f"Wzorzec wystepuje z przesuniecie {i-m+1}")
            # print(text[(i-m+1):i+1])
            index.append(i-p_len+1) 

    return index            


if __name__ == "__main__":
    
    pattern = sys.argv[1]
    with open(sys.argv[2]) as f:
        text = f.read()
    indeksy = find_pattern(pattern, text)
    print(f"Wzorzec {pattern} rozpoczyna się w tekście na indeksach:\n{indeksy}")
