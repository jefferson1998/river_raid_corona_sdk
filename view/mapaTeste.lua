local composer = require ("composer")
local botoes = require ("view.botao")
local estadoDoJogo = require ("model.estadoDoJogo")
local physics = require "physics"
physics.start()
physics.setGravity(0, 0 )
local passosX = 0
local tempo
local permitirAce = true
local result, resultResume
local composer = require ("composer")
local listaDeTiros = {}
local bancoDeDados = require ("bd.bancoDeDados")

local mapa = {

	planoDeFundo = {
		parteDireita = display.newRect(0,display.contentCenterY * 0.45, display.actualContentWidth *0.38, display.actualContentHeight),

		parteEsquerda = display.newRect(display.actualContentWidth ,display.contentCenterY * 0.45, display.actualContentWidth *0.38, display.actualContentHeight)},
	
	limiteDoMapa = display.newRect(display.contentCenterX, 
		display.contentCenterY * 0.45, 200, 570 ),
	
	painelDoPlayer = {
		tela = display.newRect(display.contentCenterX, display.contentCenterY * 2.05, display.actualContentWidth, 200 ),
		pontuacao = display.newText("Score: ", display.contentCenterX * 0.25, display.contentCenterY * 1.7, native.systemFontBold , 20 ),
		combustivel = display.newText("Fuel: " , display.contentCenterX * 1.5, display.contentCenterY * 1.7, native.systemFontBold , 20 )
	},
	
	barco = display.newImage( "resource/imagens/barco.png", display.contentCenterX *0.5, -10),

	aviaoInimigo = display.newImage( "resource/imagens/aviaoInimigo.png", display.contentCenterX *0.5, display.contentCenterY * 0.8),
	
	helicoptero = display.newImage( "resource/imagens/helicoptero.png", display.contentCenterX *1.5, 100),
	
	ponte = display.newImage( "resource/imagens/ponte.png", display.contentCenterX *1.01, display.contentCenterY * -0.9),
	
	objetosDoCenario = {
		obj1 = display.newImage( "resource/imagens/objetosDoCenario.png", display.contentCenterX * 1.8, display.contentCenterY ), 	
		obj2 = display.newImage( "resource/imagens/objetosDoCenario.png", display.contentCenterX * 0.2, display.contentCenterY *1.5 ),
 	},
	
	jato = 	display.newImage( "resource/imagens/jato.png", display.contentCenterX, display.contentCenterY *1.5 ),
	
	postosDeCombustivel = {
		p1 = display.newImage( "resource/imagens/postoDeCombustivel.png", display.contentCenterX *0.5, display.contentCenterY *0.2),
		p2 = display.newImage( "resource/imagens/postoDeCombustivel.png", display.contentCenterX *1.2, display.contentCenterY * - 1.4),
	},
	
	botaoTiro = display.newCircle(display.contentCenterX * 1.8, display.contentCenterY * 2, 26 ),

	botoes = botoes:novosBotoes(),
	textMenu,
	textRestart,
}
	
function mapa:start() 
	
	function mapa:configurandoImagens()
		mapa.ponte.width = 198
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
		mapa.planoDeFundo.parteDireita:setFillColor(0,0.8,0.2)
		mapa.planoDeFundo.parteEsquerda:setFillColor(0,0.8,0.2)
		mapa.planoDeFundo.parteEsquerda.id = "pe"
		mapa.planoDeFundo.parteDireita.id = "pd"
		mapa.limiteDoMapa:setFillColor(0,0.5,1)
		mapa.painelDoPlayer.tela:setFillColor(0.5,0.2,0.5 )
	end

	function mapa:adicionandoFisica()
		physics.addBody(mapa.planoDeFundo.parteDireita, "static")
		physics.addBody(mapa.planoDeFundo.parteEsquerda, "static")
		physics.addBody( mapa.ponte)
		physics.addBody( mapa.barco)
		physics.addBody( mapa.aviaoInimigo)
		physics.addBody( mapa.helicoptero)
		physics.addBody( mapa.jato, "dynamic")
		mapa.ponte.isFixedRotation = true
		mapa.barco.isFixedRotation = true
		mapa.helicoptero.isFixedRotation = true
		mapa.aviaoInimigo.isFixedRotation = true
		mapa.jato.isFixedRotation = true
		mapa.jato:toFront()
	end

	function mapa:reabastecerJato()
		if (math.floor(mapa.jato.y) == math.floor(mapa.postosDeCombustivel.p1.y))
			or 
		   (math.floor(mapa.jato.y) == math.floor(mapa.postosDeCombustivel.p2.y))then
			estadoDoJogo:reabastecerCombustivel()
		end
	end

	function mapa:atualizarPainelDoUsuario()
		mapa.painelDoPlayer.pontuacao.text = "    Score: " .. estadoDoJogo:getPontuacao()
		if estadoDoJogo:getJato().combustivel <= 200 then
			mapa.painelDoPlayer.combustivel.text = "  Fuel: NEED"
		else
			mapa.painelDoPlayer.combustivel.text = "  Fuel: OK"
		end

	end

	function mapa:resetarObjetosDestruidosMapa()
		if mapa.barco.y ~= nil then
			if mapa.jato.contentBounds.yMax < mapa.barco.y then
				display.remove(mapa.barco)
				mapa.barco = display.newImage( "resource/imagens/barco.png", display.contentCenterX *0.5, display.contentCenterY * -1.6)
			end
		else
			mapa.barco = display.newImage( "resource/imagens/barco.png", display.contentCenterX *0.5, display.contentCenterY * -1.6)
		end

		if mapa.aviaoInimigo.y ~= nil then
			if  mapa.jato.contentBounds.yMax < mapa.aviaoInimigo.y  then
				display.remove(mapa.aviaoInimigo)
				mapa.aviaoInimigo = display.newImage( "resource/imagens/aviaoInimigo.png", display.contentCenterX *0.5, display.contentCenterY *  -0.8)	

			end
		else
			mapa.aviaoInimigo = display.newImage( "resource/imagens/aviaoInimigo.png", display.contentCenterX *0.5, display.contentCenterY *  -0.8)	
		end
		
		if mapa.helicoptero.y ~= nil then
			if  mapa.jato.contentBounds.yMax < mapa.helicoptero.y  then
				display.remove(mapa.helicoptero)
				mapa.helicoptero = display.newImage( "resource/imagens/helicoptero.png", display.contentCenterX *1.5, display.contentCenterY * -1.2)

			end
		else
			mapa.helicoptero = display.newImage( "resource/imagens/helicoptero.png", display.contentCenterX *1.5, display.contentCenterY * -1.2)
		end

		if  mapa.jato.contentBounds.yMax < mapa.objetosDoCenario.obj1.y  then
			mapa.objetosDoCenario.obj1.x, mapa.objetosDoCenario.obj1.y =display.contentCenterX * 1.8 , -150
		end
		
		if  mapa.jato.contentBounds.yMax < mapa.objetosDoCenario.obj2.y  then
			mapa.objetosDoCenario.obj2.x, mapa.objetosDoCenario.obj2.y =display.contentCenterX * 0.2, -150
		end

		if  mapa.jato.contentBounds.yMax < mapa.postosDeCombustivel.p1.y  then
			mapa.postosDeCombustivel.p1.x, mapa.postosDeCombustivel.p1.y = display.contentCenterX *0.5, display.contentCenterY * - 1
		end
		
		if  mapa.jato.contentBounds.yMax < mapa.postosDeCombustivel.p2.y  then
			mapa.postosDeCombustivel.p2.x, mapa.postosDeCombustivel.p2.y = display.contentCenterX *1.4, display.contentCenterY * -1.5
		end

		if mapa.ponte.y == nil then
			mapa.ponte = display.newImage( "resource/imagens/ponte.png", display.contentCenterX, display.contentCenterY * -2.9)
		end
	
		if #listaDeTiros > 0  then	
			for i=1,#listaDeTiros do
				if listaDeTiros[i] ~= nil then
					if listaDeTiros[i].y ~= nil then
						if listaDeTiros[i].y < 0 then
							mapa:removerTiro(listaDeTiros[i])
						end	
					end
				end
			end
		end
		mapa:configurandoImagens() 
		mapa:adicionandoFisica()
	end

	function mapa:removerEventos()
		if result == nil then
			display.remove(mapa.botaoTiro)
			mapa.botaoTiro:removeEventListener("touch", atirar)
			permitirAce = false
			result = timer.pause(tempo)
			resultResume = nil
		end	
	end

	function mapa:accelerometer(event)
		if permitirAce == true then
			if(mapa.jato.x ~= nil) then
				if(display.contentCenterY * 0.45 ~= mapa.jato.x or  display.actualContentWidth ~= mapa.jato.x) then
						mapa.jato.x = mapa.jato.x + (event.xGravity * 30)
				end
			end
		end
	end

	function mapa:recriandoImagens()
		mapa.planoDeFundo.parteDireita = display.newRect(0,display.contentCenterY * 0.45, display.actualContentWidth *0.38, display.actualContentHeight)
		mapa.planoDeFundo.parteEsquerda = display.newRect(display.actualContentWidth ,display.contentCenterY * 0.45, display.actualContentWidth *0.38, display.actualContentHeight)
		mapa.limiteDoMapa = display.newRect(display.contentCenterX, display.contentCenterY * 0.45, 200, 570 )
		mapa.painelDoPlayer.tela = display.newRect(display.contentCenterX, display.contentCenterY * 2.05, display.actualContentWidth, 200 )
		mapa.painelDoPlayer.pontuacao = display.newText("Score: ", display.contentCenterX * 0.25, display.contentCenterY * 1.7, native.systemFontBold , 20 )
		mapa.painelDoPlayer.combustivel = display.newText("Fuel: " , display.contentCenterX * 1.5, display.contentCenterY * 1.7, native.systemFontBold , 20 )
		mapa.barco = display.newImage( "resource/imagens/barco.png", display.contentCenterX *0.5, -10)
		mapa.aviaoInimigo = display.newImage( "resource/imagens/aviaoInimigo.png", display.contentCenterX *0.5, display.contentCenterY * 0.8)
		mapa.helicoptero = display.newImage( "resource/imagens/helicoptero.png", display.contentCenterX *1.5, 100)
		mapa.ponte = display.newImage( "resource/imagens/ponte.png", display.contentCenterX *1.01, display.contentCenterY * -0.9)
		mapa.objetosDoCenario.obj1 = display.newImage( "resource/imagens/objetosDoCenario.png", display.contentCenterX * 1.8, display.contentCenterY )	
		mapa.objetosDoCenario.obj2 = display.newImage( "resource/imagens/objetosDoCenario.png", display.contentCenterX * 0.2, display.contentCenterY *1.5 )
		mapa.jato = display.newImage( "resource/imagens/jato.png", display.contentCenterX, display.contentCenterY *1.5)
		mapa.postosDeCombustivel.p1 = display.newImage( "resource/imagens/postoDeCombustivel.png", display.contentCenterX *0.5, display.contentCenterY *0.2)
		mapa.postosDeCombustivel.p2 = display.newImage( "resource/imagens/postoDeCombustivel.png", display.contentCenterX *1.2, display.contentCenterY * - 1.4)
		mapa.botaoTiro = display.newCircle(display.contentCenterX * 1.8, display.contentCenterY * 2, 26 )
		result = nil
		mapa:configurandoImagens()
		mapa:adicionandoFisica()
		mapa.botaoTiro:addEventListener( "touch", atirar )			
		mapa.botoes = botoes:novosBotoes()
		mapa:touchInBotoes()
		resultResume = timer.resume(tempo)
	end

	function mapa:removerTiro(tiro)
		for i=1,#listaDeTiros do
			if listaDeTiros[i] == tiro then
				display.remove(listaDeTiros[i])
				table.remove( listaDeTiros, i)
			end
		end		
	end

	function mapa:timer(event)
		mapa:atualizarPainelDoUsuario()
		mapa.jato:addEventListener("collision", fimDeJogo)		
		mapa:resetarObjetosDestruidosMapa()
		estadoDoJogo:dimunuirCombustivel()
		mapa:reabastecerJato()
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

		if mapa.postosDeCombustivel.p1.y ~= nil then
			mapa.postosDeCombustivel.p1.y = mapa.postosDeCombustivel.p1.y + 2
		end

		if mapa.postosDeCombustivel.p2.y ~= nil then
			mapa.postosDeCombustivel.p2.y = mapa.postosDeCombustivel.p2.y + 2
		end
	end

	function mapa:touch(e)
		if e.phase == "began" then
			if e.target.myName == "right" then
				passosX = 1.3
				
			elseif e.target.myName == "left" then
					passosX = -1.3
			end
		elseif (e.phase == "ended" or e.phase == "canceled") then
			passosX = 0
		end
	end

	function mapa:touchInBotoes()
		for i=1, #mapa.botoes do
			mapa.botoes[i]:addEventListener("touch", mapa )
		end
	end

	function mapa:limparMapa()
		display.remove(mapa.textRestart)
		display.remove(mapa.jato)
		display.remove(mapa.aviaoInimigo)
		display.remove(mapa.barco)
		display.remove(mapa.objetosDoCenario.obj1)
		display.remove(mapa.objetosDoCenario.obj2)
		display.remove(mapa.helicoptero)
		display.remove(mapa.planoDeFundo.parteDireita)
		display.remove(mapa.planoDeFundo.parteEsquerda)
		display.remove(mapa.limiteDoMapa)
		display.remove(mapa.painelDoPlayer.tela)
		display.remove(mapa.postosDeCombustivel.p1)
		display.remove(mapa.postosDeCombustivel.p2)
		display.remove(mapa.ponte)
		display.remove(mapa.painelDoPlayer.pontuacao)
		display.remove(mapa.painelDoPlayer.combustivel)
		for i=1,#mapa.botoes do
			display.remove(mapa.botoes[i])
		end
		
	end

	function mapa:enterFrame ()
		if mapa.jato.x ~= nil and estadoDoJogo:getVidaJogador() ~= 0 then
			mapa.jato.x = mapa.jato.x + passosX	
		end
	end

	function restartJogo(event)
		display.remove(event.target)
		if resultResume == nil then
			if event.phase == "began" then
				bancoDeDados:atualizarPontuacao(estadoDoJogo:getPontuacao())
				permitirAce = true
				if event.target.id == "restart" then
					mapa:limparMapa()
					mapa:recriandoImagens()
					estadoDoJogo:getNovoJogador()
				else
					mapa:limparMapa()
					composer.gotoScene("view.cenaMenu")
				end
			end
		end	
		
	end

	function newTiro(x,y)
		local novoTiro = display.newRect(x, y-25, 5, 3)
		physics.addBody(novoTiro)
		novoTiro:setLinearVelocity(0,-300)
		novoTiro:addEventListener("collision", destruirObj)
		return novoTiro
	end

	function destruirObj(event)
		mapa:removerTiro(event.target)
		display.remove(event.other)
		estadoDoJogo:enterFrame(event.other)
		mapa:atualizarPainelDoUsuario()
	end

	function atirar(e)
		if e.phase == "began" then
			local tiro = newTiro(mapa.jato.x, mapa.jato.y)
			table.insert(listaDeTiros, tiro)
		end	
	end

	function fimDeJogo(event)
		if event.other.id ~= "pe" and event.other.id ~= "pd" then
		 	estadoDoJogo:setMatarJogador()
		 	mapa:removerEventos()
		 	mapa.textMenu = display.newImage("resource/imagens/menu.png", display.contentCenterX ,display.contentCenterY * 1.1)
		 	mapa.textMenu.id = "menu"
		 	mapa.textMenu:addEventListener( "touch", restartJogo )
		 	mapa.textRestart = display.newImage("resource/imagens/botaoMenu.png",display.contentCenterX ,display.contentCenterY * 1.37 )
		 	mapa.textRestart.id = "restart"
		 	mapa.textRestart:addEventListener( "touch", restartJogo)
		end
	end

	mapa:touchInBotoes(	)
	Runtime:addEventListener("enterFrame", mapa)
	mapa.botaoTiro:addEventListener( "touch", atirar )
	Runtime:addEventListener("accelerometer", mapa)
	tempo = timer.performWithDelay( 15, mapa, 0 )

end

return mapa