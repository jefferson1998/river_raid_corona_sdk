-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local jogador = require "model.jogador"
local postoDeCombustivel = require "model.postoDeCombustivel"

function mover()
	 postoDeCombustivel:movimentacao()

end

timer.performWithDelay( 500, mover, 0 )