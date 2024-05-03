defmodule CalculoBarras do
	def calcDV(lista) do
		rest = 11 - rem(calcPass(lista, 4), 11)
		cond do
			rest == 0 || rest == 10 || rest == 11 ->
				1
			true ->
				rest
		end
	end
	def calcPass([], _) do
		0
	end
	def calcPass(lista, 1) do
		hd(lista) * 9 + calcPass(tl(lista), 8)
	end
	def calcPass(lista, cont) do
		hd(lista) * cont + calcPass(tl(lista), cont-1)
	end
end

#result = CalculoBarras.calcDV([0, 0, 1, 9, 9, 6, 8, 6, 0, 0, 0, 0, 0, 0, 2, 0, 4, 0, 0, 0, 0, 0, 0, 0, 2, 7, 4, 8, 3, 9, 7, 0, 0, 0, 0, 3, 3, 2, 5, 6, 7, 1, 7])#Moura
result = CalculoBarras.calcDV([0,0,1,9,9,6,9,4,0,0,0,0,0,3,2,1,0,2,0,0,0,0,0,0,2,7,4,8,3,9,7,0,0,0,0,3,2,8,3,8,9,1,7]) #Angela
IO.puts(inspect(result))

System.halt(0)
