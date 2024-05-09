defmodule Funcoes do
  # Soma de todos os elementos da lista:
  def soma([]), do: 0
  def soma([head | tail]), do: head + soma(tail)

  # Conversão de um número de dois dígitos em um único dígito:
  def soma_digitos(n) when n <= 9 do
    n
  end

  def soma_digitos(n) when n > 9 do
    s = String.graphemes(Integer.to_string(n))
    digitos = Enum.map(s, &String.to_integer/1)
    soma_digitos(soma(digitos))
  end

  # Multiplicação da lista de dígitos do código pela lista de multiplicadores:
  def multiplicadores([h1 | t1], [h2 | t2]), do: [h1 * h2] ++ multiplicadores(t1, t2)
  def multiplicadores([], _), do: []

  # Lista gerada pelos multiplicadores passando pela soma_digitos:
  def lista_digito_unico([head | tail]), do: [soma_digitos(head)] ++ lista_digito_unico(tail)
  def lista_digito_unico([]), do: []

  # Dezena imediata ao número:
  def dezena_imediata(n) when n <= 10 do
    10
  end

  def dezena_imediata(n) when n > 10 do
    10 + dezena_imediata(n - 10)
  end
end

defmodule DV do
  def digito_verificador([h1 | t1]) do
    lista_gerada =
      Funcoes.lista_digito_unico(
        Funcoes.multiplicadores([h1 | t1], [1, 2, 1, 2, 1, 2, 1, 2, 1, 2])
      )

    soma = Funcoes.soma(lista_gerada)
    dv = Funcoes.dezena_imediata(soma) - soma
    dv
    #[h1 | t1] ++ [dv]
  end
end

defmodule CalculoDatas do
  def ehBissexto(ano) do
    if (rem(ano, 4) == 0 && rem(ano, 100) != 0) || rem(ano, 400) == 0 do
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
    dias = dia - 1 + Enum.at(diasFaltantesPorMes, mes - 1)
    dias
  end

  def diasMeses(dia, mes, false) do
    diasFaltantesPorMes = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
    dias = dia - 1 + Enum.at(diasFaltantesPorMes, mes - 1)
    dias
  end

  def diasAnos(anoA, anoB) do
    if anoA == anoB do
      0
    else
      if ehBissexto(anoA) do
        366 + diasAnos(anoA + 1, anoB)
      else
        365 + diasAnos(anoA + 1, anoB)
      end
    end
  end
end

defmodule Codificador do
  def padronizarData(dataString) do
    data_sem_barras = String.replace(dataString, "/", "")
    algs = String.graphemes(data_sem_barras)

    {dia, resto} = Enum.split(algs, 2)
    {mes, ano} = Enum.split(resto, 2)

    dia_str = Enum.join(dia)
    mes_str = Enum.join(mes)
    ano_str = Enum.join(ano)

    [dia_str, mes_str, ano_str]
  end

  def completarZeros(codigo, n) do
    qtd_zeros = n - String.length(codigo)
    codigo_str = String.duplicate("0", qtd_zeros) <> codigo
    codigo_str
  end

  def padronizarValor(valor) do
    qtd_zeros = 10 - String.length(valor)
    valor_str = String.duplicate("0", qtd_zeros) <> valor
    valor_str
  end

  def padronizarConvenio(convenio) do
    # 27483970000332567 =  0027483, 9700, 0000, 00332567
    convenio_chars = String.graphemes(convenio)
    {parte2, resto1} = Enum.split(convenio_chars, 5)
    {parte3, resto2} = Enum.split(resto1, 4)
    {parte1, parte4} = Enum.split(resto2, 2)

    parte1 = completarZeros(Enum.join(parte1), 4)
    parte2 = completarZeros(Enum.join(parte2), 7)
    parte3 = completarZeros(Enum.join(parte3), 4)
    parte4 = completarZeros(Enum.join(parte4), 8)
    parte1 <> "." <> parte2 <> "." <> parte3 <> "." <> parte4
  end
end

defmodule Decodificador do
  def decoder(list) do
  	dv1(list) <>
  	dv2(list) <>
  	dv3(list) <>
  	Utils.at(list, 5) <>
  	Utils.range(list, 6, 9) <>
  	Utils.range(list, 10, 19)
  end
  def dv1(list) do
  	campo = Utils.range(list, 1, 4) <> Utils.range(list, 20, 24)
  	calcCampo = "0" <> campo
  	campoList = String.codepoints(calcCampo)
  	list_integers = Enum.map(campoList, &String.to_integer/1)
  	dv = DV.digito_verificador(list_integers)
  	campo <> Integer.to_string(dv)
  end
  def dv2(list) do
  	campo = Utils.range(list, 25, 34)
  	campoList = String.codepoints(campo)
  	list_integers = Enum.map(campoList, &String.to_integer/1)
  	dv = DV.digito_verificador(list_integers)
  	campo <> Integer.to_string(dv)
  end
  def dv3(list) do
  	campo = Utils.range(list, 35, 44)
  	campoList = String.codepoints(campo)
  	list_integers = Enum.map(campoList, &String.to_integer/1)
  	dv = DV.digito_verificador(list_integers)
  	campo <> Integer.to_string(dv)
  end
  def decodificador(list) do
  	IO.puts(Utils.range(list, 1, 3))
  	IO.puts(Utils.at(list, 4))
  	#
  	IO.puts(Utils.range(list, 10, 19))
  	IO.puts(Utils.range(list, 26, 42))
  	IO.puts(Utils.range(list, 43, 44))
  end
end

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
    hd(lista) * cont + calcPass(tl(lista), cont - 1)
  end
end

defmodule Utils do
	def at(list, index) do
		at(list, index, 1)
	end
  
	def at(list, index, cont) do
		if cont == index do
			hd(list)
		else
			at(tl(list), index, cont+1)
		end
	end
	def range(list, indexInit, indexFinal) do
		range(list, indexInit, indexFinal, indexInit)
	end
	def range(list, indexInit, indexFinal, actual) when actual < indexFinal do
		at(list, actual) <> range(list, indexInit, indexFinal, actual+1)
	end
	def range(list, _, indexFinal, actual) when actual == indexFinal do
		at(list, actual)
	end
end

# result = CalculoDatas.calcularDias(07,10,1997, 14,04,2024)
# IO.puts(inspect(result))

# System.halt(0)

#00194968600000020400000002748397000033256717
