local jogador = {nome = "Jefferson", pontuacao = 0, vida = 1}

function jogador:novoJogador()
	jogador.nome = "Jefferson" 
	jogador.pontuacao = 0 
	jogador.vida = 1
	return jogador
end

function jogador:setPontuacao(argPonto)
	jogador.pontuacao = jogador.pontuacao + argPonto
end

function jogador:setMorrer()
	jogador.vida = 0
end

function jogador:getVida()
	return jogador.vida
end

return jogador