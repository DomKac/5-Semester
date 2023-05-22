
from gettext import find
import sys

def create_pi(pattern):
    my_pi = [0 for x in range(len(pattern))]
    p_len = len(pattern)
    longest_match = ""
    for q in range(2,p_len+1):
        for k in range(1,q):
            if(pattern[0:k] == pattern[q-k:q]):
                longest_match = pattern[0:k]
        my_pi[q-1] = len(longest_match)
        longest_match = ""
    return my_pi


def find_pattern(pattern, text):
    text_len = len(text)
    p_len = len(pattern)
    my_pi = create_pi(pattern)
    matching_indexes = []
    q = 0
    for i in range(text_len):
        while q > 0 and pattern[q] != text[i]:
            q = my_pi[q-1]
        if pattern[q] == text[i]:
            q += 1
        if q == p_len:
            matching_indexes.append(i-p_len+1)
            q = my_pi[q-1]
    return matching_indexes


if __name__ == "__main__":
    
    pattern = sys.argv[1]
    with open(sys.argv[2]) as f:
        text = f.read()
    indeksy = find_pattern(pattern, text)
    print(f"Wzorzec {pattern} rozpoczyna się w tekście na indeksach:\n{indeksy}")
