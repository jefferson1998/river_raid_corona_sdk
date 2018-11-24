local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )
local bancoDeDados = {}

function bancoDeDados:criarTabelaJogador()
	local tableSetup = [[CREATE TABLE IF NOT EXISTS jogador ( UserID INTEGER PRIMARY KEY autoincrement, Nome, Pontuacao );]]
	db:exec( tableSetup )
end

function bancoDeDados:inserirJogador(jogador)
	local nome = "'" .. jogador.nome .. "'"
	local pontuacao =  jogador.pontuacao
	if bancoDeDados:recuperarJogadorPeloNome(jogador) ~= nil then
		local insertQuery = [[INSERT INTO jogador VALUES ( NULL, ]] .. nome ..[[, ]].. pontuacao.. [[);]]
		db:exec( insertQuery )
	end	
end

function bancoDeDados:recuperarJogadorPeloNome(jogador)

	local jogadorSaida = {}
	for row in db:nrows( "SELECT * FROM jogador WHERE nome =" .. jogador.nome) do
	    print( "Row:", row.UserID ) 
	    -- Create sub-table at next available index of "people" table
	    jogadorSaida[#jogadorSaida+1] =
	    {
	        Nome = row.Nome,
	        
	        Pontuacao = row.Pontuacao

	    }

	    for i=1,#jogadorSaida do
	    	print(jogadorSaida[i].Nome)
	    end
		if jogadorSaida.nome ~= nil then
			return jogadorSaida
		end
	end

	return nil

end

function bancoDeDados:recuperarJogadores()
	local jogadores = {}

	for row in db:nrows( "SELECT * FROM jogador" ) do
	    print( "Row:", row.UserID ) 
	    -- Create sub-table at next available index of "people" table
	    jogadores[#jogadores+1] =
	    {
	        Nome = row.Nome,
	        
	        Pontuacao = row.Pontuacao

	    }
	    for i=1,#jogadores do
	    	print(jogadores[i].Nome)
	    end
	end
end

function bancoDeDados:fecharBanco()
	if ( db and db:isopen() ) then
    	db:close()
	end
end

function bancoDeDados:deletarTodosJogadores()	
	local jogadores = {}
	for row in db:nrows( "SELECT * FROM jogador" ) do
	    print( "Row:", row.UserID ) 
	    jogadores[#jogadores+1] =
	    {
	        Nome = row.Nome,
	        
	        Pontuacao = row.Pontuacao

	    }
	    local q = [[DELETE FROM jogador WHERE UserID=]] .. row.UserID .. [[;]]
		db:exec( q )
	end
end
return bancoDeDados

