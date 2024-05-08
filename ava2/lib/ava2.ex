# IO.inspect(DV.digito_verificador([0, 6, 8, 0, 9, 3, 5, 0, 3, 1]))
defmodule Menu do
  def menuPrincipal() do
    IO.puts("Digite 'Codificador | c' para usar o codificador")
    IO.puts("Digite 'Decodificador | d' para usar o decodificador")
    choice = IO.gets("") |> String.trim()
    escolha(choice)
  end

  def at(list, index) do
  	at(list, index, 1)
  end
  
  def at(list, index, cont) do
  	if cont == index do
  		Integer.to_string(hd(list))
  	else
  		at(tl(list), index, cont+1)
  	end
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

    IO.puts("Digite o tipo de convenio:(Nosso número)")
    codCon = IO.gets("") |> String.trim()
    codCon = Codificador.padronizarConvenio(codCon)

    IO.puts("Digite os dados especificos:(Carteira)")
    codDat = IO.gets("") |> String.trim()

    cod_barras = codBan <> codCoi <> codTim <> codPri <> codCon <> codDat
    cod_barras = String.replace(cod_barras, ".", "")
    cod_barras_int = Enum.map(String.graphemes(cod_barras), &String.to_integer/1)
    dv_cod_barras = CalculoBarras.calcDV(cod_barras_int)

    cod_barras_final =
      codBan <>
        "." <>
        codCoi <>
        "." <>
        Integer.to_string(dv_cod_barras) <>
        "." <> codTim <> "." <> codPri <> "." <> codCon <> "." <> codDat
    #001.9.4.9686.0000002040.0000.0027483.9700.00332567.17
    #001.9.0000.0.9.0274839700.3.0033256717.1.4.9686.0000002040
    
    cb = String.replace(cod_barras_final, ".", "")
    codigo_barras = String.to_charlist(cb)
    IO.puts(cb)
    IO.puts(inspect(codigo_barras))
    linha_digitavel =
        codBan <>
        "." <>
        codCoi <>
        "." <>
        at(codigo_barras, 20) <>
        "." <>
        at(codigo_barras, 21) <>
        at(codigo_barras, 22) <>
        at(codigo_barras, 23) <>
        at(codigo_barras, 24) <>
        "0" <>
        " " <>
        at(codigo_barras, 25) <>
        at(codigo_barras, 26) <>
        at(codigo_barras, 27) <>
        at(codigo_barras, 28) <>
        at(codigo_barras, 29) <>
        "." <>
        at(codigo_barras, 30) <>
        at(codigo_barras, 31) <>
        at(codigo_barras, 32) <>
        at(codigo_barras, 33) <>
        at(codigo_barras, 34) <>
        "3" <>
        at(codigo_barras, 35) <>
        at(codigo_barras, 36) <>
        at(codigo_barras, 37) <>
        at(codigo_barras, 38) <>
        at(codigo_barras, 39) <>
        "." <>
        at(codigo_barras, 40) <>
        at(codigo_barras, 41) <>
        at(codigo_barras, 42) <>
        at(codigo_barras, 43) <>
        at(codigo_barras, 44) <>
        "1" <>
        " " <>
        Integer.to_string(dv_cod_barras) <>
        "." <>
        codTim <>
        "." <>
        codPri
    
    IO.puts(inspect(linha_digitavel))
    
    Barlix.ITF.encode!(String.replace(cod_barras_final, ".", ""))
    |> Barlix.PNG.print(file: "barcode.png")
    IO.puts("O código de barras gerado foi gerado e salvo em: /ava2/barcode.png \n")
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
