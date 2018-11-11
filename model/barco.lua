
local barco = {
	pontuacao = 20,
	destruido = false
}

function barco:novoBarco()
	barco.pontuacao = 20
	barco.destruido = false
end
return barco