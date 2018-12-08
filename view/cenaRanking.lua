local composer = require ("composer")
local cena = composer.newScene( )
local widget= require ("widget")
local bancoDeDados = require ("bd.bancoDeDados")

function cena:touch()
    composer.removeScene("view.cenaRanking")
    composer.gotoScene( "view.cenaMenu" )
end
 
function cena:create( event )
    local objetosDaCena = self.view
    local planoDeFundo = display.newRect(display.contentCenterX ,display.contentCenterY, display.actualContentWidth,display.actualContentHeight)
    planoDeFundo:setFillColor(1,1,1)
    print(bancoDeDados:getPontuacao())
    local myText = display.newText( bancoDeDados:getPontuacao(),display.contentCenterX ,display.contentCenterY, "Segoe Script", 70 )
    myText:setFillColor( 1, 0, 0 )
    local score = display.newImage("resource/imagens/pontuacao.png", display.contentCenterX ,display.contentCenterY * 0.5)
    local button = display.newImage("resource/imagens/botaoVoltar.png", display.contentCenterX * 0.2 ,display.contentCenterY * 1.9)
    button:addEventListener( "touch", cena )
    objetosDaCena:insert(planoDeFundo)
    objetosDaCena:insert(myText)
    objetosDaCena:insert(score)
    objetosDaCena:insert(button)
    -- Code here runs when the cena is first created but has not yet appeared on screen
    
 
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