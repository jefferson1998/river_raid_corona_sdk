local barcoModel = require "model.barco"
local jogadorModel = require "model.jogador"
local mapa = {}


function mapa:desenhoDoMapa()
	mapa.montanhas = {planoDeFundo = display.newRect(display.contentCenterX, 
		display.contentCenterY, display.actualContentWidth, display.actualContentHeight ):setFillColor(0,0.8,0.2)}

	mapa.limiteDoMapa = {limiteMapa = display.newRect(display.contentCenterX, 
		display.contentCenterY * 1, 200, 570 ):setFillColor(0,0,1)}
	
end

function mapa:startMapa()
	mapa:desenhoDoMapa()
	mapa.barco = barcoModel:novoBarco()
	print(tostring(mapa.barco.pontuacao))
	mapa.jogador = jogadorModel:novoJogador()
end



function moverBarco()
	if mapa.barco.imagem ~= nil then

	 mapa.barco:movimentacao()
	end
end


function mapa:destruirObjetos()
	if mapa.jogador.jato.imagem.contentBounds.yMax < mapa.barco.imagem.contentBounds.yMin then
		mapa.barco:destruido()
		print(tostring(mapa.barco.destruido))
	end
end


timer.performWithDelay( 500, moverBarco, 0 )

return mapa