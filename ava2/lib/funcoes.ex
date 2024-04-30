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
    [h1 | t1] ++ [dv]
  end
end
