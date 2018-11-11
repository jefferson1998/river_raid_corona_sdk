
local botoes = {}

function botoes:novosBotoes()

	local imagemBotao = "resource/imagens/botao_movimentar.png"
	local w = display.contentWidth
	local h = display.contentHeight
		-- BOTAO CIMA
	botoes[1] = display.newImage(imagemBotao)
	botoes[1].anchorX = 0.5
	botoes[1].anchorY = 0.0
	botoes[1]:rotate ( 180 )
	botoes[1].x = w * 0.10
	botoes[1].y = h * 1
	botoes[1].width = 29
	botoes[1].height = 32
	botoes[1].myName = "up"


	--BOTAO BAIXO
	botoes[2] = display.newImage(imagemBotao)
	botoes[2].anchorX = 0.5
	botoes[2].anchorY = 0.0
	botoes[2].x = botoes[1].x
	botoes[2].y = botoes[1].y
	botoes[2].width = 29
	botoes[2].height = 32
	botoes[2].myName = "down"

	--BOTAO ESQUERDA
	botoes[3] = display.newImage(imagemBotao)
	botoes[3].anchorX = 0.5
	botoes[3].anchorY = 0.0
	botoes[3]:rotate ( 90 )
	botoes[3].x = botoes[1].x
	botoes[3].y = botoes[1].y
	botoes[3].width = 29
	botoes[3].height = 32
	botoes[3].myName = "left"

	--BOTAO DIREITA
	botoes[4] = display.newImage(imagemBotao)
	botoes[4].anchorX = 0.5
	botoes[4].anchorY = 0.0
	botoes[4]:rotate ( 270 )
	botoes[4].x = botoes[1].x
	botoes[4].y = botoes[1].y
	botoes[4].width = 29
	botoes[4].height = 32
	botoes[4].myName = "right"

	return botoes
end

return botoes