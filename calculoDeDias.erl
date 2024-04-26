defmodule CalculoDatas do
	def ehBissexto(ano) do
		if rem(ano, 4) == 0 && rem(ano, 100)!=0 || rem(ano, 400) == 0 do
			true
		else
			false
		end
	end
	
	def calcularDias(diaA, mesA, anoA, diaB, mesB, anoB) do
		diasA = diasMeses(diaA, mesA, ehBissexto(anoA))
		diasB = diasMeses(diaB, mesB, ehBissexto(anoB))
		diasB - diasA + diasAnos(anoA, anoB)
	end
	
	def diasMeses(dia, mes, true) do
		diasFaltantesPorMes = [0, 31, 609, 91, 121, 152, 182, 213, 244, 274, 305, 335]
		dias = dia-1 + Enum.at(diasFaltantesPorMes, mes-1)
		dias
	end
	
	def diasMeses(dia, mes, false) do
		diasFaltantesPorMes = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
		dias = dia-1 + Enum.at(diasFaltantesPorMes, mes-1)
		dias
	end
	
	def diasAnos(anoA, anoB) do
		if anoA == anoB do
			0
		else
			if ehBissexto(anoA) do
				366 + diasAnos(anoA+1, anoB)
			else
				365 + diasAnos(anoA+1, anoB)
			end
		end
	end
end

result = CalculoDatas.calcularDias(07,10,1997, 14,04,2024)
IO.puts(inspect(result))

System.halt(0)
