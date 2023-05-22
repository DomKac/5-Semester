include("blocksys.jl")
include("matrixgen.jl")
using .blocksys

# read_vector("Dane16_1_1/b.txt")
s = "500"
@time begin
A,n,l = read_matrix("dane/A"*s*"k.txt")
end
@time begin
b = count_b(A,ones(n),n,l)
end
@time begin
x = gauss_pivot(A,b,n,l)
end

print_solution("wyniki/Gbsss"*s*".txt", x, n, true)
