include("functions.jl")
using .Funkcje_123

# zwracane (r,v,it,err) 

function f(x)
    return sin(x) - (x^2)/4
end

function f_prim(x)
    return cos(x) - x/2
end

x0 = Float64(1.5)
x1 = Float64(2.0)
delta = (1/2)*(10^(-5))
epsilon = delta


(r,v,it,err) = mbisekcji(f,x0,x1,delta,epsilon)
println("Metoda bisekcji:")
println("r = $r,\t v = $v,\t it = $it,\t err = $err")

(r,v,it,err) = mstycznych(f,f_prim,x0,delta,epsilon,16)
println("Metoda Newtona:")
println("r = $r,\t v = $v,\t it = $it,\t err = $err")

(r,v,it,err) = msiecznych(f,x0,x1,delta,epsilon,16)
println("Metoda siecznych:")
println("r = $r,\t v = $v,\t it = $it,\t err = $err")
