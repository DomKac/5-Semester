p0_32 = Float32(0.01)
p0_64 = Float64(0.01)
r_32 = Float32(3)
r_64 = Float64(3)

prev_32 = p0_32
prev_64 = p0_64

pn_32 = p0_32
pn_64 = p0_64

println("2.) Wyniki n | Float32 | Float64")

for n in 2:41
    global pn_32 = prev_32 + r_32*prev_32*(1-prev_32)
    global pn_64 = prev_64 + r_64*prev_64*(1-prev_64)
    println("$(n-1) & $(pn_32) & $(pn_64) \\\\")
    global prev_32 = pn_32
    global prev_64 = pn_64
end

prev_32 = p0_32

println("1.) Wyniki n | Float32 | Float32 but cuted after 10th iteration")

for n in 2:11
    global pn_32 = prev_32 + r_32*prev_32*(1-prev_32)
    println("$(n-1) & $(pn_32) & $(pn_32) \\\\")
    global prev_32 = pn_32
end

prev_32_cuted = Float32(0.722)

for n in 12:41
    global pn_32 = prev_32 + r_32*prev_32*(1-prev_32)
    pn_32_cuted = prev_32_cuted + r_32*prev_32_cuted*(1-prev_32_cuted)
    println("$(n-1) & $(pn_32) & $(pn_32_cuted) \\\\")
    global prev_32_cuted = pn_32_cuted
    global prev_32 = pn_32
end


