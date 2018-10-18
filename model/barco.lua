local barco = {
	
}

function barco:novoBarco()

	barco.imagem = display.newRect(display.contentCenterX * 1, display.contentCenterY * 1, 40, 40 )
	barco.pontuacao = 10
	barco.destruido = false
	barco.orientacao = "direita"

	function barco:movimentacao()
		print(barco.imagem.contentBounds.xMax)
		if barco.imagem.contentBounds.xMax < display.actualContentWidth and  barco.orientacao == "direita" then
			barco.imagem.x = barco.imagem.x + 7
			barco.imagem.y = barco.imagem.y + 20
		else
			barco.orientacao = "esquerda"
			barco.imagem.x = barco.imagem.x - 7
			if barco.imagem.contentBounds.xMin == 0 then
					barco.orientacao = "direita"
			end
		end
	end

	function barco:destruido()
		barco.imagem = nil
		barco.destruido = true
		display.remove( barco.imagem )
	end

	function barco:resetBarco()
		-- body
	end

	return barco
end

return barco