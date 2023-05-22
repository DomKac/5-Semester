include("functions.jl")
using .Funkcje_123

# y = 3x
# y = e^x

# 3x = e^x
# 3x - e^x = 0
# f(x) = 3x - e^x

function f(x::Float64)
    return 3*x - ℯ^x
end

delta = Float64(10^(-4))
epsilon = delta

# Musimy jeszcze dobrać przedziały w taki sposób żeby w każdym z 
# nich znalazło się dokładnie jedno miejsce zerowe
# A_1 = [0,1] A_2 = [1,3]

println("x1 = $(mbisekcji(f,0.0,1.0,delta,epsilon))")
println("x2 = $(mbisekcji(f,1.0,3.0,delta,epsilon))")
