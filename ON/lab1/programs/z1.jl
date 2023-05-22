
function macheps(type)
    x = one(type)
    while one(type) + x/2 != one(type)
        x /= 2
    end
    return x
end

println("Moje wartości epsilona maszynowego")
println("Macheps dla Float16 wynosi: ", macheps(Float16))
println("Macheps dla Float32 wynosi: ", macheps(Float32))
println("Macheps dla Float64 wynosi: ", macheps(Float64))
println()
println("Oryginalne wartosci epsilona maszynowego")
println("Macheps dla Float16 wynosi: ", eps(Float16))
println("Macheps dla Float32 wynosi: ", eps(Float32))
println("Macheps dla Float64 wynosi: ", eps(Float64))
print("\n\n")

function eta(type)
    x = one(type)
    while x/2 != zero(type)
        x /= 2
    end
    x
end    

println("Moje wartości Ety")
println("Eta dla Float16 wynosi: ", eta(Float16))
println("Eta dla Float32 wynosi: ", eta(Float32))
println("Eta dla Float64 wynosi: ", eta(Float64))
println()
println("Oryginalne wartosci Ety")
println("Eta dla Float16 wynosi: ", nextfloat(Float16(0.0)))
println("Eta dla Float32 wynosi: ", nextfloat(Float32(0.0)))
println("Eta dla Float64 wynosi: ", nextfloat(Float64(0.0)))
println()
println("floatmin(Float32) = ",floatmin(Float32))
println("floatmin(Float64) = ",floatmin(Float64))

print("\n\n")




function maxF(type)
    x = one(type)
    while !(isinf(x*2))
        x *= 2
    end
    # x nie jest jeszcze maksymalny
    y = x
    while !(isinf(x + y/2))
        y /= 2
        x += y
    end
    x
end


println("Moje, wyliczone iteracyjnie maksymalne wartości")
println("MAX dla Float16 wynosi: ", maxF(Float16))
println("MAX dla Float32 wynosi: ", maxF(Float32))
println("MAX dla Float64 wynosi: ", maxF(Float64))
println()
println("Oryginalne maksymalne wartości")
println("MAX dla Float16 wynosi: ", floatmax(Float16))
println("MAX dla Float32 wynosi: ", floatmax(Float32))
println("MAX dla Float64 wynosi: ", floatmax(Float64))
print("\n\n")
