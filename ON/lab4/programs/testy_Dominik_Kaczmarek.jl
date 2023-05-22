include("modul_Dominik_Kaczmarek.jl")
using .Funkcje
using Plots

x = Vector{Float64}([-1,0,1,2])      # węzły x_i
f = Vector{Float64}([-1,0,-1,2])     # f(x_i) 
fx = ilorazyRoznicowe(x,f)           # f[x_0,...,x_i]

x2 = Vector{Float64}([-1,0,1,2])
f2 = Vector{Float64}([12,10,0,12])     # f(x_i) 
fx2 = ilorazyRoznicowe(x2,f2)

t = Float64(0)                      # argument dla którego szukamy wartości zwracanej przez wielomian interpolacyjny

a = Float64(-1.0)                   # lewy kraniec przedziału
b = Float64(1.0)                    # prawy kraniec przedziału
n = Int(5)                          # stopień wielomianu (liczba węzłów) 

g(x) = x^3 + x - 4

println("Ilory różnicowe: $(fx)")
println("Wartość funkcji w punkcie $(t): $(warNewton(x,fx,t))")
println("Współczynniki wielomianu z tablicy: $(naturalna(x, fx))")
println("Współczynniki wielomianu: $(naturalna(x2, fx2))")

wykres = rysujNnfx(g,a,b,n)
savefig(wykres, "testowa_funkcja.png")




