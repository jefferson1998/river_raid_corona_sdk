local jogador = {pontuacao = 0, vida = 1}

function jogador:setPontuacao(argPonto)
	jogador.pontuacao = jogador.pontuacao + argPonto
end

return jogador