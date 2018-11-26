local composer = require ("composer")
local cena = composer.newScene( )
local widget= require ("widget")
local estadoDoJogo = require ("model.estadoDoJogo")

function cena:touch()
    print("foi")
    composer.gotoScene( "view.cenaMenu" )
end
 
function cena:create( event )
    print("vezes")
    local objetosDaCena = self.view
    local planoDeFundo = display.newRect(display.contentCenterX ,display.contentCenterY, display.actualContentWidth,display.actualContentHeight)
    planoDeFundo:setFillColor(1,1,1)
    local myText = display.newText( estadoDoJogo:getJogador().pontuacao, 200, 200, native.systemFont, 50 )
    myText:setFillColor( 1, 0, 0 )
     local score = display.newImage("resource/imagens/pontuacao.png", display.contentCenterX ,display.contentCenterY * 0.5)
    -- local botaoVoltar = display.newImage("resource/imagens/botaoVoltar.png", display.contentCenterX ,display.contentCenterY * 2)
    -- botaoVoltar:addEventListener( "touch", cena )
    -- objetosDaCena:insert( planoDeFundo)
    -- objetosDaCena:insert(myText)
    -- objetosDaCena:insert(botaoVoltar)
    -- Code here runs when the cena is first created but has not yet appeared on screen
    
 
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
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the cena goes entirely off screen
 
    end
end
 
 
-- destroy()
function cena:destroy( event )
 
    local cenaGroup = self.view
    -- Code here runs prior to the removal of cena's view

    display.remove(cenaGroup)

 
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