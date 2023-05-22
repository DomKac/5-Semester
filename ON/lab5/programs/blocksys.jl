module blocksys

import SparseArrays
using LinearAlgebra

export read_matrix ,read_vector, count_b, count_x, count_x_pivot, gauss, gauss_pivot, print_solution

#   1   1  -1
#   6   2   2
#  -3   4   1

# czytanie macierzy z pliku i wpisanie do SparseMatrix
function read_matrix(file::String)
    data = readlines(file)  
    n, l = split(data[1], " ") # pobieramy pierwsze 2 wartości z pliku z pierwszej linii 
    n = parse(Int64, n)      
    l = parse(Int64, l)
    rows = Vector{Int64}()      
    columns = Vector{Int64}()  
    values = Vector{Float64}()
    
    for w in 1:n    # schodzimy po wierszach 
        for k in max(1,w-l):min(n,w+2*l)    # idziemy po kolumach
            push!(rows, w)
            push!(columns, k)
            push!(values, Float64(0))
        end
    end
    A = SparseArrays.sparse(rows, columns, values)
    
    for k in 2:size(data)[1]
        i, j, val = split(data[k], " ")   
        i = parse(Int64, i)
        j = parse(Int64, j)
        val = parse(Float64, val)
        A[i,j] = val;
    end
    return A, n, l
end


function read_vector(file::String)
    data = readlines(file)
    n = data[1]
    n = parse(Int64, n)
    b = zeros(n)
    for i in 1:n
        b[i] = parse(Float64, data[i+1])
    end
    return b
end

function count_b(A::SparseArrays.SparseMatrixCSC{Float64, Int64}, x::Vector{Float64}, n::Int64, l::Int64)
    b = zeros(n)
    for w in 1:n                          # schodzimy po wierszach 
        for k in max(1,w-l):min(n,w+l)    
            b[w] += A[w,k] * x[k]
        end
    end
    return b
end

function count_x(A::SparseArrays.SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
    x = zeros(n)
    x[n] = b[n] / A[n,n]
    for w in n-1:-1:1
        x[w] = b[w]                          # schodzimy po wierszach 
        for k in w+1:min(n,w+l)    
            x[w] -= A[w,k] * x[k]
        end
        x[w] = x[w] / A[w,w]
    end
    return x
end

function count_x_pivot(A::SparseArrays.SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
    x = zeros(n)
    x[n] = b[n] / A[n,n]
    for w in n-1:-1:1
        x[w] = b[w] 
        # w przeciwieństwie do normalnego gaussa, tu musimy
        # przejść po większej ilości elementów w wierszu,
        # ponieważ mogliśmy zamienić wiersze
        for k in w+1:min(n,w+2*l)  
            x[w] -= A[w,k] * x[k]
        end
        x[w] = x[w] / A[w,w]
    end
    return x
end

# Brak elementu głównego - testy
function gauss(A::SparseArrays.SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)

    # eliminacja gaussa dla naszych macierzy
    for i in 1:(n-1)        # idziemy po kolumanch
        d = A[i,i]
        for w in (i+1):min(n,i+l)    # schodzimy po wierszach 
            m = A[w,i]/d
            if m != 0
                for k in i:min(n,i+1+l)    # idziemy po kolumach
                    A[w,k] = A[w,k] - m *  A[i,k] 
                end
                b[w] = b[w] - m * b[i]
            end    
        end
    end
    x = count_x(A,b,n,l)
    return x
end

function gauss_pivot(A::SparseArrays.SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
    for i in 1:(n-1)
        max_val = -1
        max_id = -1
        for w in i:min(n,i+l)  # szukamy największego elementu w kolumnie
            pom = abs(A[w,i])
            if pom > max_val
                max_val = pom
                max_id = w
            end
        end
        # podmiana wierszy jeśli w kolumnie znaleźliśmy większy element niż na przekątnej
        if max_id != i
            for w in i:min(n,i+2*l+1)
                A[i, w], A[max_id,w] = A[max_id,w], A[i, w]
            end
            # podmiana w wektorze b
            b[i], b[max_id] = b[max_id], b[i]
        end

        d = A[i,i]
        for w in (i+1):min(n,i+l)    # schodzimy po wierszach 
            m = A[w,i]/d
            if m != 0
                for k in i:min(n,i+2*l)  # musimy zwiększyć zasięg, ze wględu na zmianę wierszy
                    A[w,k] = A[w,k] - m * A[i,k] 
                end
                b[w] = b[w] - m * b[i]
            end    
        end
    end
    x = count_x_pivot(A,b,n,l)
    return x
end


function print_solution(file::String, x::Vector{Float64}, n::Int64, count_err::Bool)
    open(file, "w") do f
        if count_err
            err = norm(x - ones(n)) / norm(x)
            write(f, string(err), "\n")
        end
        foreach(a->write(f, string(a), "\n"), x)
    end
end

end
