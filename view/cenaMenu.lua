local composer = require ("composer")
local cena = composer.newScene( )
local widget= require ("widget")

function cena:touch(event)
    if event.phase == "began" then
        if event.target.id == "start" then
            composer.setVariable( "jogo", nil )
            composer.gotoScene( "view.cenaJogo" )
        end
        if event.target.id == "exit" then
            native.requestExit()
        end
        if event.target.id == "ranking" then
            composer.gotoScene( "view.cenaRanking" )
        end
    end
end
 
function cena:create( event )
    
    local objetosDaCena = self.view
    local planoDeFundo = display.newRect(display.contentCenterX ,display.contentCenterY, display.actualContentWidth,display.actualContentHeight)
    planoDeFundo:setFillColor(1,1,1)
    local river = display.newImage("resource/imagens/imagemMenu.png", display.contentCenterX ,display.contentCenterY * 0.5)
    local botao = display.newImage("resource/imagens/botaoMenu.png",display.contentCenterX ,display.contentCenterY * 1.37 )
    local texto = display.newImage("resource/imagens/textoRai.png",display.contentCenterX ,display.contentCenterY *1.1 )
    local botaoRanking = display.newImage("resource/imagens/botaoRanking.png",display.contentCenterX ,display.contentCenterY * 1.59)
    local botaoSair = display.newImage("resource/imagens/botaoSair.png",display.contentCenterX ,display.contentCenterY * 1.8 )
    botao.id = "start"
    botaoRanking.id = "ranking"
    botaoSair.id = "exit"
    objetosDaCena:insert(planoDeFundo)
    objetosDaCena:insert(river)
    objetosDaCena:insert(botao)
    objetosDaCena:insert(texto)
    objetosDaCena:insert(botaoSair)
    objetosDaCena:insert(botaoRanking)


    botao:addEventListener("touch", cena)
    botaoRanking:addEventListener("touch", cena)
    botaoSair:addEventListener("touch", cena)
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