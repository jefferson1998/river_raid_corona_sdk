local jato = {
	
}


function jato:newJato()
	jato.imagem = display.newRect(display.contentCenterX * 1, display.contentCenterY * 2.09, 40, 40 )
	jato.combustivel = 0

	function jato:reabastecendoCombustivel()
	
	end

	return jato
end

return jato

