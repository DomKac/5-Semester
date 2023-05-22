
function KahanMacheps(type)
    x = one(type)
    return (3*x*((4*x)/(3*x) - x) - x)
end

println("Macheps Kahana dla Float16 =\t", KahanMacheps(Float16))
println("Macheps Kahana dla Float32 =\t", KahanMacheps(Float32))
println("Macheps Kahana dla Float64 =\t", KahanMacheps(Float64))

