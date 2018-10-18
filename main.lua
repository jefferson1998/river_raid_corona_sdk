-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local mapa = require "view.mapa"
mapa:startMapa()
function moverMapa()
	if mapa.barco.imagem ~= nil then
		mapa:destruirObjetos()
	end
end

timer.performWithDelay( 500, moverMapa, 0)