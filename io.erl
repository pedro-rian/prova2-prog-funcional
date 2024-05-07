defmodule Menu do
	def menuPrincipal() do
		IO.puts("Digite 'Codificador | C' para usar o codificador")
		IO.puts("Digite 'Decodificador | D' para usar o decodificador")
		choice = IO.gets("") |> String.trim()
		escolha(choice)
	end
	
	def escolha(choice) do
		cond do
			choice == "Codificador" || choice == "C" ->
				menuCodificador()
			choice == "D" || choice == "Decodificador" ->
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
		IO.puts("Digite o valor:")
		codPri = IO.gets("") |> String.trim()
		IO.puts("Digite o tipo de convenio:")
		codCon = IO.gets("") |> String.trim()
		IO.puts("Digite os dados especificos:")
		codDat = IO.gets("") |> String.trim()
		#codificador()
		IO.puts(inspect(codBan))
		IO.puts(inspect(codCoi))
		IO.puts(inspect(codTim))
		IO.puts(inspect(codPri))
		IO.puts(inspect(codCon))
		IO.puts(inspect(codDat))
		0
	end
	
	def menuDecodificador() do
		IO.puts("Digite a lista de sequencias")
		codBan = IO.gets("") |> String.trim()
		#decodificador()
		1
	end
end

			
		
IO.puts(Menu.menuPrincipal())


System.halt(0)
