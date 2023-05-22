module Funkcje_123
export mbisekcji, mstycznych, msiecznych

"""
# Arguments
-`f::Function`: funkcja f(x) zadana jako anonimowa funkcja (ang. anonymous function).
-`a::Float64`: lewy koniec przedziału początkowego.
-`b::Float64`: prawy koniec przedziału początkowego.
-`delta::Float64`: dokładność obliczeń f(r).
-`epsilon::Float64`: dokładność obliczeń r.

# Wyniki:
(r,v,it,err) – czwórka, gdzie
    r – przybliżenie pierwiastka równania f (x) = 0,
    v – wartość f (r),
    it – liczba wykonanych iteracji,
    err – sygnalizacja błędu
        0 - brak błędu
        1 - funkcja nie zmienia znaku w przedziale [a,b]
"""

function mbisekcji(f::Function, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    it = 0
    f_a = f(a)
    f_b = f(b)
    e = b-a         # długość przedziału początkowego
    r = a + e/2;    

    # sprawdzamy czy w zadanym przedziale istnieje miejsce zerowe,
    # poprzez sprawdzenie czy f dla krańców przedziału zwraca jedną 
    # wartość ujemną i jedną wartość dodatnią.
    if sign(f_a) == sign(f_b)
        return (Float64(0), Float64(0), it, 1)
    end

    while true
        it = it + 1
        e = e/2     # z każdą iteracją spradzamy obszar dwukrotnie mniejszy
        r = a + e   # srodek przedziału
        v = f(r)

        # Końćzymy kiedy otrzymamy wynik spełniąjący zadaną dokładność
        if abs(e) < delta || abs(v) < epsilon 
            return (r, v, it, 0)
        end
        
        # Mając przedział [a_it, b_it] i r = (b_it - a_it)/2
        # patrzymy czy f(a_it) i f(r) róznią się znakiem.
        # Jeśli tak to wiemy że miejsca zero. należy szukać w przedziale [a_it, r]
        # Jeśli nie to w przedziale [r, b_it].
        if sign(v) != sign(f_a)
            b = r
            f_b = v
        else
            a = r;
            f_a = v;
        end
    end
end

"""
# Arguments
-`f::Function`: funkcja anonimowa f(x).
-`pf::Function`: pochodna funkcji f(x).
-`x0::Float64`: przybliżenie początkowe.
-`delta::Float64`: dokładność obliczeń f(r).
-`epsilon::Float64`: dokładność obliczeń r.
-`maxit::Int`: maksymalna dopuszczalna liczba iteracji.

# Wyniki
(r,v,it,err) – czwórka, gdzie
    r – przybliżenie pierwiastka równania f(x) = 0,
    v – wartość f (r),
    it – liczba wykonanych iteracji,
    err – sygnalizacja błędu
        0 - metoda zbieżna
        1 - nie osiągnięto wymaganej dokładności w maxit iteracji,
        2 - pochodna bliska zeru
"""

function mstycznych(f::Function,pf::Function,x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    v = f(x0)

    if abs(v) < epsilon
        return (x0, v, 0, 0)
    end
    
    for it in 1:maxit
        dx0 = pf(x0)
        if abs(dx0) < epsilon
            return (x0, v, it, 2)
        end            

        x1 = x0 - (v/dx0)
        v = f(x1)
        
        if abs(x1-x0) < delta || abs(v) < epsilon
            return (x1, v, it, 0)
        end

        x0 = x1
    end

    return (x0, v, maxit, 1)

end


"""
# Arguments
-`f::Function`: funkcja f(x) zadana jako anonimowa funkcja.
-`x0::Float64`: przybliżenie początkowe x0.
-`x1::Float64`: przybliżenie początkowe x1.
-`delta::Float64`: dokładność obliczeń f(r).
-`epsilon::Float64`: dokładność obliczeń r.
-`maxit::Int` – maksymalna dopuszczalna liczba iteracji.

# Wyniki:
(r,v,it,err) – czwórka, gdzie
    r – przybliżenie pierwiastka równania f (x) = 0,
    v – wartość f (r),
    it – liczba wykonanych iteracji,
    err – sygnalizacja błędu
        0 - metoda zbieżna
        1 - nie osiągnięto wymaganej dokładności w maxit iteracji
"""

function msiecznych(f::Function, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    fa = f(x0)
    fb = f(x1)

    for it in 1:maxit
        if abs(fa) > abs(fb)
            x0,x1 = x1,x0
            fa,fb = fb,fa
        end

        s = (x1-x0)/(fb-fa)
        x1 = x0
        fb = fa
        x0 = x0 - (fa*s)
        fa = f(x0)
        
        if abs(x1-x0) < delta || abs(fa) < epsilon
            return (x0, fa, it, 0)
        end
    end
    
    return(x0,fa,maxit,1)
    
end


end
