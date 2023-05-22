function f(x)
    sin(x) + cos(3*x)
end
#
function derivative_f(x)
    cos(x) - 3*sin(3*x)
end

function main()
    x_0 = one(Float64)
    dev_f = derivative_f(x_0)
    for n in 0:54
        h = (one(Float64)*2)^(-n)
        f_p = (f(x_0 + h)-f(x_0))/(h)
        println("h = 2^(-",n, ")\t(1+h) = ", 1+h,"\t\tf'(h) = ",f_p,"\t\t|f' - dev_f| = ", abs(f_p - dev_f) )
    end
end

main()
