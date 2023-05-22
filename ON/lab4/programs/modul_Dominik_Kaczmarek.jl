module Funkcje
export ilorazyRoznicowe, warNewton, naturalna, rysujNnfx, rysujNnfx2
using Plots


"""
# Dane:
-'x::Vector{Float64}': wektor długości n + 1 zawierający węzły x0, . . . , xn
        x[1]=x0,..., x[n+1]=xn
-'f::Vector{Float64}': wektor długości n + 1 zawierający wartości interpolowanej
        funkcji w węzłach f (x0), . . . , f (xn)

# Wyniki:
- fx: wektor długości n + 1 zawierający obliczone ilorazy różnicowe
    fx[1]=f [x0],
    fx[2]=f [x0, x1],..., fx[n]=f [x0, . . . , xn−1], fx[n+1]=f [x0, . . . , xn].
"""

function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    n = length(x) # liczba punktów
    fx = zeros(n) # tworzymy tablice fx i uzupełniamy ją zerami
    
    # Do obliczenia ilorazów korzystamy z twierdzenia 3, oraz
    # tabeli trójkątnej jak pokazano na wykładzie nr 6.
    for i in 1:n
        fx[i] = f[i]
    end

    for i in 2:n
        for j in n:(-1):i
            fx[j] = (fx[j] - fx[j-1])/(x[j] - x[j-i+1])
        end
    end

    return fx
end

"""
Dane:
-'x::Vector{Float64}': wektor długości n + 1 zawierający węzły x0, . . . , xn
        x[1]=x0,..., x[n+1]=xn
-'fx::Vector{Float64}': wektor długości n + 1 zawierający ilorazy różnicowe
        fx[1]=f [x0],
        fx[2]=f [x0, x1],..., fx[n]=f [x0, . . . , xn−1], fx[n+1]=f [x0, . . . , xn]
-'t::Float64': punkt, w którym należy obliczyć wartość wielomianu

# Wyniki:
- nt: wartość wielomianu w punkcie t.
"""
# O(n)
function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
    n = length(x)
    nt = fx[n]
    for i in (n-1):(-1):1
        nt = fx[i] + (t - x[i])*nt
    end

    return nt
end

"""
# Dane:
-'x::Vector{Float64}': wektor długości n + 1 zawierający węzły x0, . . . , xn
        x[1]=x0,..., x[n+1]=xn
-'fx::Vector{Float64}': wektor długości n + 1 zawierający ilorazy różnicowe
        fx[1]=f [x0],
        fx[2]=f [x0, x1],..., fx[n]=f [x0, . . . , xn−1], fx[n+1]=f [x0, . . . , xn]

# Wyniki:
- a: wektor długości n + 1 zawierający obliczone współczynniki postaci naturalnej
        a[1]=a0,
        a[2]=a1,..., a[n]=an−1, a[n+1]=an.
"""
# O(n^2)
function naturalna(x::Vector{Float64}, fx::Vector{Float64})
    n = length(x)
    a = zeros(n)
    a[n] = fx[n] # a_n = f[x0,x1,...,x_n]

    for i in (n-1):(-1):1
        a[i] = fx[i] - x[i] * a[i+1]
        for j in (i+1):(n-1)
            a[j] += -x[i] * a[j+1]
        end
    end

    return a
end

"""
# Dane:
-'f::Function': funkcja f (x) zadana jako anonimowa funkcja,
-'a::Float64': lewy kraniec przedziału interpolacji
-'b::Float64': prawy kraniec przedziału interpolacji
-'n::Int': stopień wielomianu interpolacyjnego

# Wyniki:
- funkcja rysuje wielomian interpolacyjny i interpolowaną
funkcję w przedziale [a, b].
"""

function rysujNnfx(f::Function,a::Float64,b::Float64,n::Int)
    h = (b-a)/n # odległosc między sąsiednimi węzłami
    x = zeros(n+1)
    p = zeros(n+1)

    # wyznaczenie węzłów
    for k in 1:(n+1)
        x[k] = a + (k-1)*h
        p[k] = f(x[k])
    end

    fx = ilorazyRoznicowe(x,p)
    
    # -- Liczba punktów z których utworzymy wykres --
    prec = 200
    # numOfPoints = n*prec # alternatywnie
    numOfPoints = Int(ceil(b-a)*prec)
    # -----------------------------------------------
    poly = zeros(numOfPoints+1)
    func = zeros(numOfPoints+1)
    points = zeros(numOfPoints+1)
    h2 = 1.0/prec
    for k in 1:(numOfPoints+1)
        points[k] = a + (k-1)*h2
        poly[k] = warNewton(x,fx,points[k])
        func[k] = f(points[k])  
    end

    wykres = plot(points, [poly func], label=["wielomian" "funkcja"], title="n = $n")
    display(wykres)
    return wykres

end


end
