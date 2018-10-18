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


function postoDeCombustivel:destruido()
	postoDeCombustivel.destruido = true
end

function function_name( ... )
	-- body
end

return postoDeCombustivel