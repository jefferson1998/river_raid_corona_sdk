local botoes = require ("view.botao")
local physics = require "physics"
physics.start()
physics.setGravity(0, 0 )

local passosX = 0

local mapa = {
	planoDeFundo = display.newRect(display.contentCenterX, 
		display.contentCenterY, display.actualContentWidth, display.actualContentHeight),
	limiteDoMapa = display.newRect(display.contentCenterX, 
		display.contentCenterY * 1, 200, 570 ),
	barco = display.newImage( "resource/imagens/barco.png", display.contentCenterX *0.5, -10),
	aviaoInimigo = display.newImage( "resource/imagens/aviaoInimigo.png", display.contentCenterX *0.5, display.contentCenterY),
	-- helicoptero = display.newImage( "resource/imagens/helicoptero.png", display.contentCenterX *1.5, 100),
	ponte = display.newImage( "resource/imagens/ponte.png", display.contentCenterX, display.contentCenterY * -0.9),
	objetosDoCenario = {obj1 = display.newImage( "resource/imagens/objetosDoCenario.png", display.contentCenterX * 1.8, 
		display.contentCenterY ), 	obj2 = display.newImage( "resource/imagens/objetosDoCenario.png", display.contentCenterX * 0.2, display.contentCenterY *1.5 ),
 	},
	jato = 	display.newImage( "resource/imagens/jato.png", display.contentCenterX, display.contentCenterY *1.5 ),
	-- postoDeCombustivel = display.newImage( "resource/imagens/postoDeCombustivel.png", display.contentCenterX *0.5, 100),
	botoes = botoes:novosBotoes(),
	botaoTiro = display.newCircle(display.contentCenterX * 1.8, display.contentCenterY * 2, 20 )
	
}

function mapa:configurandoImagens()
	mapa.ponte.width = 200
	mapa.ponte.height = 40
	-- mapa.helicoptero.width = 25
	-- mapa.helicoptero.height = 25
	mapa.aviaoInimigo.width = 25
	mapa.aviaoInimigo.height = 25
	mapa.jato.width = 32
	mapa.jato.height = 32
	mapa.planoDeFundo:setFillColor(0,0.8,0.2)
	mapa.limiteDoMapa:setFillColor(0,0.5,1)
end


function mapa:adicionandoFisica()
	physics.addBody( mapa.ponte)
	physics.addBody( mapa.barco)
	physics.addBody( mapa.aviaoInimigo)
	physics.addBody( mapa.jato, "dynamic")
	mapa.jato.isFixedRotation = true
end

function moverCenario()
	-- movimentando helicoptero
	-- mapa.helicoptero.x = mapa.helicoptero.x - 0.4
	-- mapa.helicoptero.y = mapa.helicoptero.y + 2

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

function mapa:touch(e)

	if e.phase == "began" or e.phase == "moved" then
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
	mapa:resetarObjetoDestruido()
end

function colisaoComObj(e)
	
end

function mapa:terminaLimiteDoJato()
	-- body
end

function mapa:resetarObjetoDestruido()
	ponte = display.newImage( "resource/imagens/ponte.png", display.contentCenterX, display.contentCenterY * -1.9)
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