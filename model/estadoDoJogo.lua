local barco = require ("model.barco")
local jato = require ("model.jato")
local ponte = require ("model.ponte")
local helicoptero = require ("model.helicoptero")
local aviaoInimigo = require ("model.aviaoInimigo")
local postoDeCombustivel = require ("model.postoDeCombustivel")
local jogador = require ("model.jogador")

local estadoDoJogo = {}

function estadoDoJogo:enterFrame(argObjeto)
	if argObjeto.id == "p" then
		jogador:setPontuacao(ponte.pontuacao)
		ponte.destruida = true
		ponte:novaPonte()
	elseif argObjeto.id == "h" then
	 	jogador:setPontuacao(helicoptero.pontuacao)
		helicoptero.destruido = true
		helicoptero:novoHelicoptero()
	elseif argObjeto.id == "b" then
	 	jogador:setPontuacao(barco.pontuacao)
		barco.destruido = true
		barco:novoBarco()
	elseif argObjeto.id == "a" then
		jogador:setPontuacao(aviaoInimigo.pontuacao)
		aviaoInimigo.destruido = true
		aviaoInimigo:novoAviaoInimigo()
	end
end

function estadoDoJogo:dimunuirCombustivel()
	jato.combustivel = jato.combustivel - 0.1
end

function estadoDoJogo:getJogador()
	return jogador
end

function estadoDoJogo:getJato()
	return jato
end

function estadoDoJogo:getPontuacao()
	return jogador.pontuacao
end

function estadoDoJogo:setMatarJogador()
	return jogador:setMorrer()
end

function estadoDoJogo:getVidaJogador()
	return jogador:getVida()
end

function estadoDoJogo:getNovoJogador()
	return jogador:novoJogador()
end

function estadoDoJogo:reabastecerCombustivel()
	jato.combustivel = jato.combustivel  + postoDeCombustivel.combustivel
end

function estadoDoJogo:salvarJogador(jogador)

end

return estadoDoJogo