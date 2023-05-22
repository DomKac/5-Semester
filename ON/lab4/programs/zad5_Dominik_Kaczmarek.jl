include("modul_Dominik_Kaczmarek.jl")
using .Funkcje
using Plots

f1(x) = ℯ^x
f2(x) = (x^2)*sin(x)

for n in [5, 10, 15]
    plot1 = rysujNnfx(f1, 0.0, 1.0, n)
    savefig(plot1, "5_f1_$n.png")
    plot2 = rysujNnfx(f2, -1.0, 1.0, n)
    savefig(plot2, "5_f2_$n.png")
end
