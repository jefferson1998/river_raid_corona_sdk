local barcoModel = require "model.barco"
local jogadorModel = require "model.jogador"

local physics = require "physics"
physics.start( )

local mapa = {}


function mapa:desenhoDoMapa()
	

	
end

function mapa:startMapa()
	mapa.montanhas = display.newRect(display.contentCenterX, 
		display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
	mapa.montanhas:setFillColor(0,0.8,0.2)

	mapa.limiteDoMapa = display.newRect(display.contentCenterX, 
		display.contentCenterY * 1, 200, 570 ):setFillColor(0,0,1)

	mapa.barco = barcoModel:novoBarco()
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