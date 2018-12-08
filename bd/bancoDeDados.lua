local sqlite3 = require( "sqlite3" )
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )
local bancoDeDados = {}


local criarJogador = [[CREATE TABLE IF NOT EXISTS jogador (Pontuacao INTEGER);]]
db:exec( criarJogador )

local inserir = [[INSERT INTO jogador (Pontuacao) VALUES (0);]]
db:exec(inserir)


function bancoDeDados:atualizarPontuacao(novaPontuacao)

	local pontuacao =  self:getPontuacao() + 0
	if(pontuacao < novaPontuacao) then
		 local script = [[UPDATE jogador SET Pontuacao = ']]..novaPontuacao..[[';]]
   		 db:exec(script)
	end

end

function bancoDeDados:getPontuacao()
	for row in db:urows('SELECT Pontuacao from jogador') do
        return row
    end
    return 0
end 

function bancoDeDados:fecharBanco()
	if ( db and db:isopen() ) then
    	db:close()
	end
end

return bancoDeDados

