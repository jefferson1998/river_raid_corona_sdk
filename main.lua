-- -----------------------------------------------------------------------------------------
-- --
-- -- main.lua
-- --
-- -----------------------------------------------------------------------------------------

-- -- Your code here
-- local physics = require "physics"
-- physics.start( )

-- physics.setGravity(0, 0)
-- local mapa = require "view.mapa"

-- mapa:startMapa()

-- physics.addBody( mapa.jogador.jato.imagem, "dynamic" )

-- -- physics.addBody(mapa.montanhas, "static")


-- function moverMapa()
-- 	if mapa.barco.imagem ~= nil then
-- 		mapa:destruirObjetos()
-- 	end
-- end

-- timer.performWithDelay( 500, moverMapa, 0)
local composer = require( "composer" )
composer.gotoScene( "view.cenaMenu" )
