# IO.inspect(DV.digito_verificador([0, 6, 8, 0, 9, 3, 5, 0, 3, 1]))
defmodule Menu do
  def menuPrincipal() do
    IO.puts("Digite 'Codificador | c' para usar o codificador")
    IO.puts("Digite 'Decodificador | d' para usar o decodificador")
    choice = IO.gets("") |> String.trim()
    escolha(choice)
  end

  def escolha(choice) do
    cond do
      choice == "Codificador" || choice == "c" ->
        menuCodificador()

      choice == "d" || choice == "Decodificador" ->
        menuDecodificador()

      true ->
        IO.puts("Verifique a entrada e tente novamente")
        menuPrincipal()
    end
  end

  def menuCodificador() do
    IO.puts("Digite o código do banco:")
    codBan = IO.gets("") |> String.trim()

    IO.puts("Digite o código da moeda:")
    codCoi = IO.gets("") |> String.trim()

    IO.puts("Digite a data de vencimento: 'dd/mm/ano'")
    codTim = IO.gets("") |> String.trim()
    data = Codificador.padronizarData(codTim)

    codTim =
      Integer.to_string(
        CalculoDatas.calcularDias(
          07,
          10,
          1997,
          String.to_integer(data |> Enum.at(0)),
          String.to_integer(data |> Enum.at(1)),
          String.to_integer(data |> Enum.at(2))
        )
      )

    IO.puts("Digite o valor:")
    codPri = IO.gets("") |> String.trim()
    codPri = String.replace(codPri, ",", "")
    codPri = Codificador.completarZeros(codPri, 10)

    IO.puts("Digite o tipo de convenio:")
    codCon = IO.gets("") |> String.trim()
    codCon = Codificador.padronizarConvenio(codCon)

    IO.puts("Digite os dados especificos:")
    codDat = IO.gets("") |> String.trim()

    cod_barras = codBan <> codCoi <> codTim <> codPri <> codCon <> codDat
    cod_barras = String.replace(cod_barras, ".", "")
    cod_barras_int = Enum.map(String.graphemes(cod_barras), &String.to_integer/1)
    IO.puts(inspect(cod_barras))
    dv_cod_barras = CalculoBarras.calcDV(cod_barras_int)

    cod_barras_final =
      codBan <>
        "." <>
        codCoi <>
        "." <>
        Integer.to_string(dv_cod_barras) <>
        "." <> codTim <> "." <> codPri <> "." <> codCon <> "." <> codDat

    IO.puts("O código de barras gerado é: \n" <> cod_barras_final)

    Barlix.ITF.encode!(String.replace(cod_barras_final, ".", ""))
    |> Barlix.PNG.print(file: "barcode.png")
  end

  def menuDecodificador() do
    IO.puts("Digite a lista de sequencias")
    codBan = IO.gets("") |> String.trim()
    # decodificador()
    1
  end
end

IO.puts(Menu.menuPrincipal())

System.halt(0)
