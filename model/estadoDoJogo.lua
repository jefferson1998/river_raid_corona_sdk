local barco = require ("model.barco")
local jato = require ("model.jato")
local ponte = require ("model.ponte")
local helicoptero = require ("model.helicoptero")
local aviaoInimigo = require ("model.aviaoInimigo")
local postoDeCombustivel = require ("model.postoDeCombustivel")
local jogador = require ("model.jogador")

local estadoDoJogo = {}

function estadoDoJogo:enterFrame(argObjeto)
	if argObjeto == "p" then
		jogador:setPontuacao(ponte.pontuacao)
		ponte.destruida = true
	elseif argObjeto == "h" then
	 	jogador:setPontuacao(helicoptero.pontuacao)
		helicoptero.destruida = true
	elseif argObjeto == "b" then
	 	jogador:setPontuacao(barco.pontuacao)
		barco.destruido = true
	elseif argObjeto == "a" then
		jogador:setPontuacao(aviaoInimigo.pontuacao)
		aviaoInimigo.destruido = true
	end
	return jogador.pontuacao
end

Runtime:addEventListener("enterFrame", estadoDoJogo)

return estadoDoJogo