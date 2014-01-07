-----------------------------------------------------------------------------------------
-- Memory Match Game: Vegetable
-- config.lua
-- BSDTech version 1.1 (amir.husaini@gmail.com)
-----------------------------------------------------------------------------------------

module(..., package.seeall)

new = function ( params )

	local widget = require( "widget" )
	local localGroup = display.newGroup()
	local _W = display.contentWidth;
	local _H = display.contentHeight;
	
	local totalButtons = 0
	local secondSelect = 0
	local checkForMatch = false

	local button = {}
	local buttonCover = {}
	local buttonImages = {1,1, 2,2, 3,3}
	local home
	
	local homey = function ( event )
		if event.phase == "ended" then
			director:changeScene( "menu", "crossfade" )
		end
	end
	
	home = widget.newButton{
		width = 36,
		height = 36,
		defaultFile = "home.png",
		overFile = "home.png",
		onEvent = homey
	}

	local background = display.newImageRect("Default.png", _W, _H)

	local lastButton = display.newImage("1.png");	

	local matchText = display.newText(" ", 0, 0, native.systemFont, 18)

	local x = -20

	local function playLoop(snd)
			local backgroundSound
	        audio.stop(backgroundSound)
	        audio.dispose( backgroundSound  )
	        backgroundSound = nil
			backgroundSound = audio.loadStream(snd)
			audio.setMaxVolume( 0.75, { channel=0 } )
			audio.setVolume( 0.7, { channel=0 } )
			audio.setMinVolume( 0.25, { channel=0 } )
			audio.play(backgroundSound, {channel=0, loops=0})
	end

--Set up game function
function game(object, event)
	if(event.phase == "began") then	
		
		if(checkForMatch == false and secondSelect == 0) then
			--Flip over first button
			buttonCover[object.number].isVisible = false;
			lastButton = object
			checkForMatch = true			
		elseif(checkForMatch == true) then
			if(secondSelect == 0 and lastButton ~= object) then
			--if(secondSelect == 0) then
				--Flip over second button
				buttonCover[object.number].isVisible = false;
				secondSelect = 1;
				--If buttons do not match, flip buttons over
				if(lastButton.myName ~= object.myName) then
					playLoop("sedih.mp3")
					matchText.text = " ";
					timer.performWithDelay(2250, function()						
						matchText.text = " ";
						checkForMatch = false;
						secondSelect = 0;
						buttonCover[lastButton.number].isVisible = true;
						buttonCover[object.number].isVisible = true;
					end, 1)					
				--If buttons DO match, remove buttons
				elseif(lastButton.myName == object.myName) then
					playLoop("clap.mp3")
					matchText.text = " ";
					timer.performWithDelay(2250, function()						
						matchText.text = " ";
						checkForMatch = false;
						secondSelect = 0;
						lastButton:removeSelf();
						object:removeSelf();
						buttonCover[lastButton.number]:removeSelf();
						buttonCover[object.number]:removeSelf();
					end, 1)	

				end				
			end			
		end
	end
end

local function init()
	for count = 1,3 do
		x = x + 90
		y = -20
	
		for insideCount = 1,2 do
			y = y + 80

			--Set a cover to hide the button image
			buttonCover[totalButtons] = display.newImage("cover.png");
			buttonCover[totalButtons].x = x; buttonCover[totalButtons].y = y;
		
			--Assign each image a random location on grid
			temp = math.random(1,#buttonImages)
			button[count] = display.newImage(buttonImages[temp] .. ".png");				
		
			--Position the button
			button[count].x = x;
			button[count].y = y;		
		
			--Give each a button a name
			button[count].myName = buttonImages[temp]
			button[count].number = totalButtons
		
			--Remove button from buttonImages table
			table.remove(buttonImages, temp)
				
			totalButtons = totalButtons + 1

			--Attach listener event to each button
			button[count].touch = game		
			button[count]:addEventListener( "touch", button[count] )
		end
	end
end

		local initVars = function ()
	
		localGroup:insert( background )
		localGroup:insert( home )
		localGroup:insert( lastButton )
		localGroup:insert( matchText )
		
		background.alpha = 0.5
		background.x = display.contentCenterX
		background.y = display.contentCenterY
	
		home.x = _W/2 + 140
		home.y = _H/2 - 240
	
		matchText:setFillColor(0, 0, 255)
		matchText.x = _W/2
		
		lastButton.alpha = 0
		lastButton.myName = 1;
	
		end
    
		initVars()
		init()
        return localGroup
        
end