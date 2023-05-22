using Polynomials
# Wspolczynniki wielomianu z zadania 3
p_wspolczynniki = [1, -210.0, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]

p1 = Polynomial(reverse(p_wspolczynniki))   # postać naturalna wielomianu 
p2 = fromroots(1:20)          # postać iloczynowa

pierwiastki = roots(p1)

for k in 1:20
    println("$k & $(pierwiastki[k]) & $(abs(p1(pierwiastki[k]))) & $(abs(p2(pierwiastki[k]))) & $(abs(pierwiastki[k] - k))\\\\")
end

println("b). Podmieniony współczynnik -210 na -210-(2^-23)")

p_wspolczynniki_B = [1, -210.0-(2.0)^(-23), 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]

p1_B = Polynomial(reverse(p_wspolczynniki_B))   # postać naturalna wielomianu 
pierwiastki_B = roots(p1_B)

for k in 1:20
    println("$k & $(pierwiastki_B[k]) & $(abs(p1_B(pierwiastki_B[k]))) & $(abs(p2(pierwiastki_B[k]))) & $(abs(pierwiastki_B[k] - k))\\\\")
end
