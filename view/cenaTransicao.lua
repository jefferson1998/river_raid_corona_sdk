local composer = require ("composer")
local cena = composer.newScene( )


function cena:touch()
    composer.removeScene("view.cenaJogo")
    composer.gotoScene("view.cenaMenu")
end


function cena:create( event )
    -- local planoDeFundo = display.newRect(display.contentCenterX ,display.contentCenterY, display.actualContentWidth,display.actualContentHeight)
    -- planoDeFundo:setFillColor(1,1,1)
end
 
 
-- show()
function cena:show( event )
 
    local cenaGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then

        -- Code here runs when the cena is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        print( "((show scene RestartDummy's view))" ) 
        composer.removeScene( "view.cenaJogo" ) 
        composer.gotoScene( "view.cenaJogo", "fade", 0 )  
        -- Code here runs when the cena is entirely on screen
 
    end
end
 
 
-- hide()
function cena:hide( event )
 
    local cenaGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the cena is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the cena goes entirely off screen
 
    end
end
 
 
-- destroy()
function cena:destroy( event )
 
    local cenaGroup = self.view
    -- cenaGroup:remove(mapa)
end
 
 
-- -----------------------------------------------------------------------------------
-- cena event function listeners
-- -----------------------------------------------------------------------------------
cena:addEventListener( "create", cena )
cena:addEventListener( "show", cena )
cena:addEventListener( "hide", cena )
cena:addEventListener( "destroy", cena )
-- -----------------------------------------------------------------------------------
 
return cena