local botoes = require ("view.botao")
local estadoDoJogo = require ("model.estadoDoJogo")
local physics = require "physics"
physics.start()
physics.setGravity(0, 0 )

local passosX = 0

local mapa = {
	planoDeFundo = display.newRect(display.contentCenterX, 
		display.contentCenterY * 0.45, display.actualContentWidth, display.actualContentHeight),
	
	limiteDoMapa = display.newRect(display.contentCenterX, 
		display.contentCenterY * 0.45, 200, 570 ),
	
	painelDoPlayer = {tela = display.newRect(display.contentCenterX, 
		display.contentCenterY * 2.05, display.actualContentWidth, 200 ),
	pontuacao = display.newText("Score: ", display.contentCenterX * 0.25, 
		display.contentCenterY * 1.7, native.systemFontBold , 20 ) },
	
	barco = display.newImage( "resource/imagens/barco.png", display.contentCenterX *0.5, -10),

	aviaoInimigo = display.newImage( "resource/imagens/aviaoInimigo.png", display.contentCenterX *0.5, display.contentCenterY * 0.8),
	
	helicoptero = display.newImage( "resource/imagens/helicoptero.png", display.contentCenterX *1.5, 100),
	
	ponte = display.newImage( "resource/imagens/ponte.png", display.contentCenterX, display.contentCenterY * -0.9),
	
	objetosDoCenario = {obj1 = display.newImage( "resource/imagens/objetosDoCenario.png", display.contentCenterX * 1.8, 
		display.contentCenterY ), 	obj2 = display.newImage( "resource/imagens/objetosDoCenario.png", display.contentCenterX * 0.2, display.contentCenterY *1.5 ),
 	},
	
	jato = 	display.newImage( "resource/imagens/jato.png", display.contentCenterX, display.contentCenterY *1.5 ),
	
	-- postoDeCombustivel = display.newImage( "resource/imagens/postoDeCombustivel.png", display.contentCenterX *0.5, 100),
	
	botoes = botoes:novosBotoes(),
	
	botaoTiro = display.newCircle(display.contentCenterX * 1.8, display.contentCenterY * 2, 26 )
	
}

function mapa:configurandoImagens()
	mapa.ponte.width = 200
	mapa.ponte.height = 40
	mapa.ponte.id = "p"
	mapa.helicoptero.width = 25
	mapa.helicoptero.height = 25
	mapa.helicoptero.id = "h"
	mapa.aviaoInimigo.width = 25
	mapa.aviaoInimigo.height = 25
	mapa.aviaoInimigo.id = "a"
	mapa.jato.width = 32
	mapa.jato.height = 32
	mapa.jato.id = "j"
	mapa.barco.id = "b"
	mapa.planoDeFundo:setFillColor(0,0.8,0.2)
	mapa.limiteDoMapa:setFillColor(0,0.5,1)
	mapa.painelDoPlayer.tela:setFillColor(0.5,0.2,0.5 )
end


function mapa:adicionandoFisica()
	physics.addBody( mapa.ponte)
	physics.addBody( mapa.barco)
	physics.addBody( mapa.aviaoInimigo)
	physics.addBody( mapa.helicoptero)
	physics.addBody( mapa.jato, "dynamic")
	mapa.jato.isFixedRotation = true
end

function moverCenario()
	mapa:resetarMapa()
	-- movimentando helicoptero
	if  mapa.helicoptero.x ~= nil and mapa.helicoptero.y ~= nil then

		mapa.helicoptero.x = mapa.helicoptero.x - 0.4
		mapa.helicoptero.y = mapa.helicoptero.y + 2
	end
	
	-- movimentando objetos do "staticos" --
	mapa.objetosDoCenario.obj1.y = mapa.objetosDoCenario.obj1.y + 2
	mapa.objetosDoCenario.obj2.y = mapa.objetosDoCenario.obj2.y + 2

	-- movimentando ponte --
	if mapa.ponte.y ~= nil then
			mapa.ponte.y = mapa.ponte.y + 2

	end

	-- movimentando barco --
	if mapa.barco.x ~= nil and mapa.barco.y ~= nil then
		mapa.barco.x = mapa.barco.x + 0.4
		mapa.barco.y = mapa.barco.y + 2

	end

	-- movimentando o avião inimigo
	if mapa.aviaoInimigo.y ~= nil then
		mapa.aviaoInimigo.y = mapa.aviaoInimigo.y + 2
	end

end

function mapa:atualizaPainelDoUsuario(pontuacao)
	mapa.painelDoPlayer.pontuacao.text = "    Score: " .. pontuacao
end

function mapa:touch(e)

	if e.phase == "began" then
			print("maximo" .. mapa.limiteDoMapa.contentBounds.xMax)
			print("min" ..mapa.limiteDoMapa.contentBounds.xMin)
		if e.target.myName == "right" then
			passosX = 1.3
			
		elseif e.target.myName == "left" then
				passosX = -1.3
		end

	elseif (e.phase == "ended" or e.phase == "canceled") then
		passosX = 0
	end

end

function atirar(e)
	if e.phase == "began" then
		local tiro = display.newRect(mapa.jato.x, mapa.jato.y-25,5,3)
		physics.addBody(tiro)
		tiro:setLinearVelocity(0,-300)
		tiro:addEventListener("collision", destruirObj)

	end	
end


function destruirObj(event)
	
	display.remove(event.target)

	display.remove(event.other)
	mapa:atualizaPainelDoUsuario(estadoDoJogo:enterFrame(event.other.id))
	-- mapa:resetarObjetoDestruido()
end



function mapa:atualizaEstadoDoJogo()
	
end

function mapa:resetarObjetoDestruido()

		mapa.barco.y = nil
		
end

function mapa:resetarMapa()
	if mapa.barco.y ~= nil then
		if mapa.jato.contentBounds.yMax < mapa.barco.y then
				mapa.barco.x, mapa.barco.y = display.contentCenterX *0.5, -150
		end
	end
	if mapa.aviaoInimigo.y ~= nil then
		if  mapa.jato.contentBounds.yMax < mapa.aviaoInimigo.y  then
			mapa.aviaoInimigo.x, mapa.aviaoInimigo.y = display.contentCenterX *0.5, -300
		end
	end

	if mapa.helicoptero.y ~= nil then
		if  mapa.jato.contentBounds.yMax < mapa.helicoptero.y  then
			mapa.helicoptero.x, mapa.helicoptero.y =display.contentCenterX *1.5, -450
		end
	end

	if mapa.objetosDoCenario.obj1.y ~= nil then
		if  mapa.jato.contentBounds.yMax < mapa.objetosDoCenario.obj1.y  then
			mapa.objetosDoCenario.obj1.x, mapa.objetosDoCenario.obj1.y =display.contentCenterX * 1.8 , -150
		end
	end

	if mapa.objetosDoCenario.obj2.y ~= nil then
		if  mapa.jato.contentBounds.yMax < mapa.objetosDoCenario.obj2.y  then
			mapa.objetosDoCenario.obj2.x, mapa.objetosDoCenario.obj2.y =display.contentCenterX * 0.2, -150
		end
	end

end

local update = function ()

	mapa.jato.x = mapa.jato.x + passosX	

end


for i=1, #mapa.botoes do
	mapa.botoes[i]:addEventListener("touch", mapa )
end

mapa.botaoTiro:addEventListener( "touch", atirar )
Runtime:addEventListener("enterFrame", update)

timer.performWithDelay( 20, moverCenario, 0 )


return mapa