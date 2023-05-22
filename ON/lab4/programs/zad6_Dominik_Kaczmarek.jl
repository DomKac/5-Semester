include("modul_Dominik_Kaczmarek.jl")
using .Funkcje
using Plots

f1(x) = abs(x)
f2(x) = 1/(1 + x^2)

for n in [5, 10, 15]
    plot1 = rysujNnfx(f1, -1.0, 1.0, n)
    savefig(plot1, "6_f1_$n.png")
    plot2 = rysujNnfx(f2, -5.0, 5.0, n)
    savefig(plot2, "6_f2_$n.png")
end
