local composer = require ("composer")
local cena = composer.newScene( )
local mapa = require ("view.mapaTeste")     


function cena:create( event )
    mapa:start()
end
 
 
-- show()
function cena:show( event )
 
    local cenaGroup = self.view
    if ( phase == "will" ) then
        mapa:start()
    end
end
 
-- destroy()
function cena:destroy( event )
 
    local cenaGroup = self.view
    mapa = nil
end
 
cena:addEventListener( "create", cena )
cena:addEventListener( "show", cena )
 
return cena