local jatoJogador = require "model.jato"
local botoes = require "view.botao"
local passosX, passosY = 0,0

local jogador = {}

function jogador:novoJogador()
	jogador.pontuacao = 0
	jogador.jato = jatoJogador:newJato()
	jogador.vida = 1
	jogador.botoes = botoes:novosBotoes()

	function jogador:atirar()
		
	end

	function touch(e)

		if e.phase == "began" or e.phase == "moved" then
			
			if e.target.myName == "right" then
				passosX = 1.3
				passosY = 0
			elseif e.target.myName == "left" then
				passosX = -1.3
				passosY = 0
			end

		elseif (e.phase == "ended" or e.phase == "canceled") then
			passosX = 0
			passosY = 0
		end

	end

	local update = function ()
		if jogador.jato ~= nil then
			jogador.jato.imagem.x = jogador.jato.imagem.x + passosX
			jogador.jato.imagem.y = jogador.jato.imagem.y + passosY	
		end	

	end

	for i=1, #jogador.botoes do
		jogador.botoes[i]:addEventListener("touch", touch )
	end

	Runtime:addEventListener("enterFrame", update)

	return jogador

end

return jogador