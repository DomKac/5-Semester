
x_float64 = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y_float64 = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

x_float32 = Float32[2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y_float32 = Float32[1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

function sum_a(type, x, y)
    sum = zero(type)

    for i in 1:5
        sum += x[i]*y[i]
    end
    sum
end

println("a). Float32, Suma = ", sum_a(Float32, x_float32, y_float32))
println("a). Float64, Suma = ", sum_a(Float64, x_float64, y_float64))


function sum_b(type, x, y)
    sum = zero(type)
    
    for i in 5:-1:1
        sum += x[i] * y[i]
    end
    sum
end

println("b). Float32, Suma = ", sum_b(Float32, x_float32, y_float32))
println("b). Float64, Suma = ", sum_b(Float64, x_float64, y_float64))


function sum_c(type, x, y)

    part_sum = Vector{type}(undef, 5)
    for i in 1:5
        part_sum[i] = x[i] * y[i]
    end
    part_sum = sort(part_sum, rev=true) # sortujemy  sumy częściowe malejąco
    
    # W zadaniu mamy z góry narzucone tablice, stąd wiemy że po pomnożeniu otrzymamy 3 liczby dodatnie i 2 liczny ujemne.
    # Po pososrtowaniu 3 liczby dodatnie znajdują się na pierwszych trzech miejscach vectora
    # Polecenie: "dodaj dodatnie liczby w porządku od największego do najmniejszego"
    sum_positive = zero(type)
    for i in 1:3
        sum_positive += part_sum[i]
    end
    # "dodaj ujemne liczby w porządku od najmniejszego do największego"
    sum_negative = zero(type)
    for i in 5:-1:4
        sum_negative += part_sum[i]
    end

    # "następnie daj do siebie obliczone sumy częściowe"
    sum = zero(type)
    sum = sum_positive + sum_negative
end

println("c). Float32, Suma = ", sum_c(Float32, x_float32, y_float32))
println("c). Float64, Suma = ", sum_c(Float64, x_float64, y_float64))

function sum_d(type, x, y)

    part_sum = Vector{type}(undef, 5)
    for i in 1:5
        part_sum[i] = x[i] * y[i]
    end
    part_sum = sort(part_sum, rev=true) # sortujemy  sumy częściowe malejąco
    
    # W przeciwieństwie do metody c). liczby dodatnie zsumujemy od namniejszej do największej.
    sum_positive = zero(type)
    for i in 3:-1:1
        sum_positive += part_sum[i]
    end
    # a liczby ujemne od największej do najmniejszej 
    sum_negative = zero(type)
    for i in 4:5
        sum_negative += part_sum[i]
    end

    # "następnie daj do siebie obliczone sumy częściowe"
    sum = zero(type)
    sum = sum_positive + sum_negative
    sum
end

println("d). Float32, Suma = ", sum_d(Float32, x_float32, y_float32))
println("d). Float64, Suma = ", sum_d(Float64, x_float64, y_float64))
