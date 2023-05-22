function example123()
    c = Float64(-2)
    x0_1 = Float64(1)
    x0_2 = Float64(2)
    x0_3 = Float64(1.99999999999999)
    for n in 2:41
        xn_1 = x0_1^2 + c
        xn_2 = x0_2^2 + c
        xn_3 = x0_3^2 + c
        x0_1 = xn_1
        x0_2 = xn_2
        x0_3 = xn_3
        println("$(n-1) & $(xn_1) & $(xn_2) & $(xn_3) \\\\")
    end
end

function example4567()
    c = Float64(-1)
    x0_4 = Float64(1)
    x0_5 = Float64(-1)
    x0_6 = Float64(0.75)
    x0_7 = Float64(0.25)
    for n in 2:41
        xn_4 = x0_4^2 + c
        xn_5 = x0_5^2 + c
        xn_6 = x0_6^2 + c
        xn_7 = x0_7^2 + c
        x0_4 = xn_4
        x0_5 = xn_5
        x0_6 = xn_6
        x0_7 = xn_7
        println("$(n-1) & $(xn_4) & $(xn_5) & $(xn_6) & $(xn_7) \\\\")
    end
end

example123()
println()
example4567()

