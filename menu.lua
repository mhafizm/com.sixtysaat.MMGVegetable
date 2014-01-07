-----------------------------------------------------------------------------------------
-- Memory Match Game: Vegetable
-- menu.lua
-- BSDTech version 1.1 (amir.husaini@gmail.com)
-----------------------------------------------------------------------------------------

module(..., package.seeall)

new = function ( params )
	
	local widget = require( "widget" )
	local rateit = require( "rateit" )
	rateit.setAndroidURL("com.sixtysaat.MMGVegetable")
	
	local ads = require "ads"

	local function adListener( event )
	    if event.isError then
	    end
	end
	
	local localGroup = display.newGroup()
	local _W = display.contentWidth
	local _H = display.contentHeight
	
	local checklang =  system.getPreference("locale", "country")
	local language
	if "MY" == checklang then
	        language = "Padan Gambar Sayuran"
	elseif "ID" == checklang then
			language = "Padan Gambar Sayuran"
	else
	        language = "Memory Match Vegetable"
	end
	
	local title      = display.newText( language, 0, 0, native.systemFontBold, 22 )

	local bt01, bt02, bt03, bt04, bt05, bt06
				
	local function onSystemEvent( event )
	        if  "applicationExit" == event.type then
	                native.requestExit();
	        end 
	end
	
	local function onKeyEvent( event )

	   local phase = event.phase
	   local keyName = event.keyName

	   if ( "back" == keyName and phase == "up" ) then
	                local function onComplete( event )
	                        if "clicked" == event.action then
	                                local i = event.index
	                                if 1 == i then
	                                        native.cancelAlert( alert )
	                                elseif 2 == i then
	                                        native.requestExit()
	                                end
	                        end
	                end
	                local alert = native.showAlert( language, "Are you sure you want to exit?", { "No", "Yes" }, onComplete )
					localGroup:insert( alert )
	                return true
	   end
	   return true
	end
	
	local function playLoop(snd)
			local backgroundSound
	        audio.stop()
	        audio.dispose( backgroundSound  )
	        backgroundSound = nil
			backgroundSound = audio.loadStream(snd)
			audio.setMaxVolume( 0.7, { channel=1 } )
			audio.setVolume( 0.5, { channel=1 } )
			audio.setMinVolume( 0.25, { channel=1 } )
			audio.play(backgroundSound, {channel=1, loops=-1})
	end
	
	local bt01t = function ( event )
		if event.phase == "ended" then
			ads.hide()
			director:changeScene( "easy", "crossfade" )
		end
	end
	
	local bt02t = function ( event )
		if event.phase == "ended" then
			bt02.isVisible = false
			bt03.isVisible = true
			audio.stop()
		end
    end
    
    local bt03t = function ( event )
		if event.phase == "ended" then
			bt02.isVisible = true
			bt03.isVisible = false
			playLoop("lagu.mp3")
		end
    end
				
	local bt04t = function ( event )
		if event.phase == "ended" then
			rateit.openURL()
		end
	end
	
	local bt05t = function ( event )
		if event.phase == "ended" then
			ads.hide()
			director:changeScene( "normal", "crossfade" )
		end
	end
	
	local bt06t = function ( event )
		if event.phase == "ended" then
			ads.hide()
			director:changeScene( "hard", "crossfade" )
		end
	end
	
	bt01 = widget.newButton{
					width = 154,
					height = 40,
					label="Easy",
					fontSize='24',
					labelColor = { default={0}, over={128} },
					defaultFile = "button.png",
					overFile = "button-over.png",
					onEvent = bt01t
	}
	
	bt02 = widget.newButton{
					width = 32,
					height = 32,
					labelColor = { default={0}, over={128} },
					defaultFile = "music-icon.png",
					overFile = "music-icon.png",
					onEvent = bt02t
    }

	bt03 = widget.newButton{
					width = 32,
					height = 32,
					labelColor = { default={0}, over={128} },
					defaultFile = "music-iconx.png",
					overFile = "music-iconx.png",
					onEvent = bt03t
    }
    		
	bt04 = widget.newButton{
					label="Rate Us",
					fontSize='24',
					labelColor = { default={0}, over={128} },
					defaultFile = "button.png",
					overFile = "button-over.png",
					onEvent = bt04t
	}
	
	bt05 = widget.newButton{
					label="Normal",
					fontSize='24',
					labelColor = { default={0}, over={128} },
					defaultFile = "button.png",
					overFile = "button-over.png",
					onEvent = bt05t
	}
	
	bt06 = widget.newButton{
					label="Hard",
					fontSize='24',
					labelColor = { default={0}, over={128} },
					defaultFile = "button.png",
					overFile = "button-over.png",
					onEvent = bt06t
	}
	
	local background = display.newImageRect("Default.png", _W, _H)
		
	local initVars = function ()
		
		ads.init( "admob", "a152c74d5ddb0e0", adListener )
		ads.show( "banner", { x=0, y=0 } )
		
		localGroup:insert( background )
		localGroup:insert( title )
		localGroup:insert( bt01 )
		localGroup:insert( bt02 )
		localGroup:insert( bt03 )
		localGroup:insert( bt04 )
		localGroup:insert( bt05 )
		localGroup:insert( bt06 )
		
		background.alpha = 0.5
		background.x = display.contentCenterX
	    background.y = display.contentCenterY
	
		title.x = _W/2
		title.y = _H/2 - 150
		
		bt01.x = _W/2
		bt01.y = _H/2 - 50
		
		bt02.x = _W/2 + 140
        bt02.y = _H/2 + 235
        
        bt03.x = _W/2 + 140
        bt03.y = _H/2 + 235

		bt04.x = _W/2
		bt04.y = _H/2 + 160
		
		bt05.x = _W/2
		bt05.y = _H/2
		
		bt06.x = _W/2
		bt06.y = _H/2 + 50
		
		playLoop("lagu.mp3")
		bt02.isVisible = true
        bt03.isVisible = false
		
		title:setFillColor( 0,0,0 )
		
		Runtime:addEventListener( "key", onKeyEvent )
		
	end
	
	initVars()
	
	return localGroup
	
end