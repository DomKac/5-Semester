include("functions.jl")
using .Funkcje_123

# Dane:
# 1. przedział początkowy
a = Float64(-2000000000)
x0 = Float64(a)
b = Float64(1000000)
x1 = Float64(b) 
# 2. funkcja f oraz jej pochodna 
function f(x::Float64)
    return 2*(x^2) + x - 4
end

function pf(x::Float64)
    return 4*x + 1
end

# 3. dokładności obliczeń
delta = Float64(10^(-5))
epsilon = Float64(10^(-5))

# maksymalna liczba iteracji
maxit = typemax(Int)

println("Wyniki metodą bisekcji:")
println(mbisekcji(f,a,b,delta,epsilon))
println("Wyniki metodą Newtona:")
println(mstycznych(f,pf,x0,delta,epsilon,maxit))
println("Wyniki metodą siecznych:")
println(msiecznych(f,x0,x1,delta,epsilon,maxit))


