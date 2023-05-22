using LinearAlgebra

function hilb(n::Int)
    # Function generates the Hilbert matrix  A of size n,
    #  A (i, j) = 1 / (i + j - 1)
    # Inputs:
    #	n: size of matrix A, n>=1
    #
    #
    # Usage: hilb(10)
    #
    # Pawel Zielinski
    if n < 1
        error("size n should be >= 1")
    end

    return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end


function matcond(n::Int, c::Float64)
    # Function generates a random square matrix A of size n with
    # a given condition number c.
    # Inputs:
    #	n: size of matrix A, n>1
    #	c: condition of matrix A, c>= 1.0
    #
    # Usage: matcond(10, 100.0)
    #
    # Pawel Zielinski
    if n < 2
        error("size n should be > 1")
    end
    if c< 1.0
        error("condition number  c of a matrix  should be >= 1.0")
    end
    (U,S,V)=svd(rand(n,n))
    return U*diagm(0 =>[LinRange(1.0,c,n);])*V'
end


function hilb_test(n::Int)
    x = ones(n)
    m = hilb(n)
    b = m*x

    gauss_x = m\b
    inv_x = inv(m)*b

    println(n, " & ", rank(m), " & ",cond(m), " & ", norm(x - gauss_x)/norm(x)," & ",norm(x - inv_x)/norm(x), " \\\\") 
end


function rand_test(n, c)
    x = ones(n)
    m = matcond(n,Float64(c))
    b = m*x

    gauss_x = m\b
    inv_x = inv(m)*b

    println(n, " & 10^{", log10(c), "} & ", rank(m), " & ",cond(m), " & ", norm(x - gauss_x)/norm(x)," & ",norm(x - inv_x)/norm(x), " \\\\") 
end

println("Hilbert matrixes")
for n in 2:2:36
    hilb_test(n)
end
println()

ns = [5,10,20]
cs = [1,10,1000,10^7,10^12,10^16]

println("Random matrixes")
for n in ns
    for c in cs
        rand_test(n,c)
    end
end
