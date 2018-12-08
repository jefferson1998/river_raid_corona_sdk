local composer = require ("composer")
local cena = composer.newScene( )
local widget= require ("widget")

function cena:touch(event)
    if event.phase == "began" then
        if event.target.id == "start" then
            composer.gotoScene( "view.cenaJogo" )
        elseif event.target.id == "exit" then
            native.requestExit()
        elseif event.target.id == "ranking" then
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
    
end
 

-- destroy()
function cena:destroy( event )
 
    local cenaGroup = self.view
    display.remove(cenaGroup) 
end
 
cena:addEventListener( "create", cena )
cena:addEventListener( "destroy", cena )
 
return cena