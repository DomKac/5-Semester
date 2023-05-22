function f(x)
    sqrt(x*x + 1) - 1
end

function g(x)
    (x*x)/(sqrt(x*x + 1) + 1)
end


function main()
    i = (-1) * one(Float64)
    while (f(8^i) != 0 || g(8^i) != 0)
        println("f(8^(",i,") = ",f(8^i), "\tg(8^(",i,") = ",g(8^i))
        i -= 1
    end
    println("f(8^(",i,") = ",f(8^i), "\tg(8^(",i,") = ",g(8^i))
end

main()
