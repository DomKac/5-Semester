include("functions.jl")
using .Funkcje_123


# f1(x) = ℯ^(1-x) - 1
# 0 = ℯ^(1-x) - 1 -> 1 = ℯ^(1-x)
# 0 = 1-x -> x = 1
# gdy x -> inf to f1(x) -> -1

function f1(x::Float64)
    return ℯ^(1-x) - 1    
end

function f1_prim(x::Float64)
    return -ℯ^(1-x)
end

# f2(x) = x*ℯ^(-x)
# 0 = x*ℯ^(-x) -> x = 0
# gdy x -> inf to f2(x) -> 0

function f2(x::Float64)
    x*ℯ^(-x)    
end

function f2_prim(x::Float64)
    return ℯ^(-x) * (1-x)
end

delta = Float64(10^(-5))
epsilon = delta

# przedział i przybliżenia początkowe
a = Float64(1) 
x0 = Float64(a)

b = Float64(100)
x1 = Float64(b)

println("Wyniki funkcji f1(x) dla każdej z metdod:")
(r,v,it,err) = mbisekcji(f1,a,b,delta,epsilon)
println("Metoda bisekcji:")
println("& $r & $v & $it & $err \\\\")

(r,v,it,err) = mstycznych(f1,f1_prim,x0,delta,epsilon,1000)
println("Metoda Newtona:")
println("& $r & $v & $it & $err \\\\")

(r,v,it,err) = msiecznych(f1,x0,x1,delta,epsilon,1000)
println("Metoda siecznych:")
println("& $r & $v & $it & $err \\\\")

println("---------------------------------------------------------")

println("Wyniki funkcji f2(x) dla każdej z metdod:")
(r,v,it,err) = mbisekcji(f2,a,b,delta,epsilon)
println("Metoda bisekcji:")
println("& $r & $v & $it & $err \\\\")

(r,v,it,err) = mstycznych(f2,f2_prim,x0,delta,epsilon,typemax(Int))
println("Metoda Newtona:")
println("& $r & $v & $it & $err \\\\")

(r,v,it,err) = msiecznych(f2,x0,x1,delta,epsilon,typemax(Int))
println("Metoda siecznych:")
println("& $r & $v & $it & $err \\\\")
