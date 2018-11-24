local composer = require ("composer")
local cena = composer.newScene( )
local mapa = require ("view.mapaTeste")
function cena:create( event )
    local tempo
    local objetosDaCena = self.view
    mapa:start()

    function update()
        if mapa:getRetornarMenu() == true then
            composer.gotoScene("view.cenaMenu")
        end
    end
    Runtime:addEventListener("enterFrame", update)

end
 
 
-- show()
function cena:show( event )
 
    local cenaGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then

        -- Code here runs when the cena is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the cena is entirely on screen
 
    end
end
 
 
-- hide()
function cena:hide( event )
 
    local cenaGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the cena is on screen (but is about to go off screen)
        table.remove(mapa)

    elseif ( phase == "did" ) then
            table.remove(mapa)

        -- Code here runs immediately after the cena goes entirely off screen
 
    end
end
 
 
-- destroy()
function cena:destroy( event )
 
    local cenaGroup = self.view
end
 
 
-- ----------------------   -------------------------------------------------------------
-- cena event function listeners
-- -----------------------------------------------------------------------------------
cena:addEventListener( "create", cena )
cena:addEventListener( "show", cena )
cena:addEventListener( "hide", cena )
cena:addEventListener( "destroy", cena )
-- -----------------------------------------------------------------------------------
 
return cena