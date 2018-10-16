local postoDeCombustivel = {
	imagem = display.newRect(display.contentCenterX * 1, display.contentCenterY * 1, 40, 40 ),
	pontuacao = 10,
	destruido = false,
	combustivel = 100,
}

-- for k,v in pairs(postoDeCombustivel) do
-- 	print(k,v)
-- end

function postoDeCombustivel:novoPosto()
	
end

function postoDeCombustivel:movimentacao()

	postoDeCombustivel.imagem.x = postoDeCombustivel.imagem.x + 10
	print(postoDeCombustivel.imagem.contentBounds.xMax)
	if postoDeCombustivel.imagem.contentBounds.xMax >= display.actualContentWidth then
		postoDeCombustivel.imagem.x = (postoDeCombustivel.imagem.contentBounds.xMax 
			- postoDeCombustivel.imagem.contentBounds.xMin) / 2
	end
end

function postoDeCombustivel:destruido()
	postoDeCombustivel.destruido = true
end

function function_name( ... )
	-- body
end

return postoDeCombustivel