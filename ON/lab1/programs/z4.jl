function odp_a()
    x = one(Float64)
    while nextfloat(x)*(one(Float64)/nextfloat(x)) == one(Float64) && x < 2
        x = nextfloat(x)
    end
    x = nextfloat(x)
    println("1). znaleziona liczba:\tx = ",x)    
    println("Wynik działania x*(1/x) dla znalezionego x: ", x*(1/x))

end

function odp_b()
    x = zero(Float64)
    while nextfloat(x)*(one(Float64)/nextfloat(x)) == one(Float64)
        x = nextfloat(x)
    end
    x = nextfloat(x)
    println("2).Najmniejsza znaleziona liczba:\tx = ",x)    
    println("Wynik działania x*(1/x) dla znalezionego x: ", x*(1/x))

end

odp_a()
odp_b()
