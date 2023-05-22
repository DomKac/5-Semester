function between_1_and_2()
    # Testy dla x z przedziału [1,2)
    delta = (Float64(2))^(-52)
    println("Delta = ", delta)
    # Pierwsze 32 liczb
    for k in 1:(2^5)
        x = one(Float64) + k*delta
        println("1 + ", k, "*δ = ", x, "\tBitowo x = ", bitstring(Float64(x)))
    end
    println("")
    # Ostatnie 32 liczb
    for k in (2^52 - 2^5):(2^52 - 1)
        x = one(Float64) + k*delta
        println("1 + ", k, "*δ = ", x, "\tBitowo x = ", bitstring(Float64(x)))
    end
end

function between_2_and_4()
    # Testy dla x z przedziału [2,4)
    delta = (Float64(2))^(-51)
    println("Delta = ", delta)
    # Pierwsze 32 liczb
    for k in 1:(2^5)
        x = Float64(2) + k*delta
        println("1 + ", k, "*δ = ", x, "\tBitowo x = ", bitstring(Float64(x)))
    end
    println("")
    # Ostatnie 32 liczb
    for k in (2^(52) - 2^5):(2^(52) - 1)
        x = Float64(2) + k*delta
        println("2 + ", k, "*δ = ", x, "\tBitowo x = ", bitstring(Float64(x)))
    end
end

function between_0_5_and_1()
    # Testy dla x z przedziału [1/2,1)
    delta = (Float64(2))^(-53)
    println("Delta = ", delta)
    # Pierwsze 32 liczb
    for k in 1:(2^5)
        x = Float64(1/2) + k*delta
        println("1 + ", k, "*δ = ", x, "\tBitowo x = ", bitstring(Float64(x)))
    end
    println("")
    # Ostatnie 32 liczb
    for k in (2^(52) - 2^5):(2^(52) - 1)
        x = Float64(1/2) + k*delta
        println("2 + ", k, "*δ = ", x, "\tBitowo x = ", bitstring(Float64(x)))
    end
end



between_1_and_2()
between_2_and_4()
between_0_5_and_1()
