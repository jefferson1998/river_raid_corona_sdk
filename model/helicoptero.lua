local helicoptero = {
	imagem = display.newRect(display.contentCenterX * 1, display.contentCenterY * 1, 40, 40 ),
	pontuacao = 10,
	destruido = false
}

-- for k,v in pairs(helicoptero) do
-- 	print(k,v)
-- end

function helicoptero:novoHelicoptero()
	
end

function helicoptero:movimentacao()
	print(helicoptero.imagem.contentBounds.xMax)
	if helicoptero.imagem.contentBounds.xMax < display.actualContentWidth then
		helicoptero.imagem.x = helicoptero.imagem.x + 10
		-- helicoptero.imagem.x = (helicoptero.imagem.contentBounds.xMax 
		-- 	- helicoptero.imagem.contentBounds.xMin) / 2
	else
		helicoptero.imagem.x = helicoptero.imagem.x - 10

	end
end

function helicoptero:fluxoContrarioDaMovimentacao(argOrientacao)

end

function helicoptero:destruido()
	helicoptero.destruido = true
end

function function_name( ... )
	-- body
end

return helicoptero