-----------------------------------------------------------------------------------------
-- Memory Match Game: Vegetable
-- main.lua
-- BSDTech version 1.1 (amir.husaini@gmail.com)
-----------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "background", 255, 255, 255 )
local director = require("director")

local mainGroup = display.newGroup()

local main = function ()
	mainGroup:insert(director.directorView)
	director:changeScene("menu")
	return true
end

main()