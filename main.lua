--[[
	Wireless Delivery


	The most bland gamejam entry ever!
	Coded by Lokachop, 2023

	powered by a lack of social interaction and that one paracetamol i took while making the map editor


	the codebase for this is horrendous, sorry in advance

	mystery global variables, magic global funcs, weird casing, etc...



	hello again
	it is 23 hr till i have to submit game and i only have 5 maps :c

	ok my goal is to ship with 8 maps, i quickly threw together another one so i only need to make 2 maps
	am running out of ideas for creative uses of the connection concept though
	and i still need to make the trailer and the promoart
	and the final cleanup....


	ok so map ideas

	map7; yet another vertical map but you go up to turn on signal below "Vertical Signal"
	map8; the final one so itwill be complex; you have to do first a map4 type of thing of going to the left to turn on signal, then u go up to turn on other signal
		and then u go to right to win and beat game

	alr time to CODEE

	

	hiii

	20 hr till submit time

	i got the 8 maps fully done and everything looks ready to go so ill quickly throw together a shit song for the credits and ill start cleaning up

	good news 19 hr left till submit and i wrote a song :D
	(test3.wav) i think ill call it trash.mp3

	its in the game


	i wish i could fix the laggy buttons but no time

	gonna make clean up and upload
]]


ConnJam = ConnJam or {}
TILE_SIZE = 64
PLAYER_SIZE_X = 48
PLAYER_SIZE_Y = 48
PLAYER_SPEEDCAP = 400
CONNECTION_RANGE = 1024 * 24
CANVAS_MAIN = nil



STATE_MENU = 0
STATE_MAPEDIT = 1
STATE_PLAY = 2
STATE_CREDITS = 3
STATE_LEVELEND = 4
STATE_FAIL = 5
GAME_STATE = STATE_MENU


function love.load() -- called on start
	love.filesystem.load("/initlua.lua")()

	Curtime = 0
	love.keyboard.setKeyRepeat(true)

	CANVAS_MAIN = love.graphics.newCanvas(love.graphics.getDimensions())
	CANVAS_BLUR = love.graphics.newCanvas(love.graphics.getDimensions())

	if GAME_STATE == STATE_MENU then
		ConnJam.InitMainMenu()
	end

	--ConnJam.LoadMap("level8")
	--atlas_img = love.graphics.newImage(ConnJam.TexAtlas)
end

function love.update(dt)
	Curtime = Curtime + dt
	ConnJam.Player.anim_time = ConnJam.Player.anim_time + dt
	RealFPS = 1 / dt

	if GAME_STATE == STATE_PLAY then
		ConnJam.HandlePlayerTileTouch()

		ConnJam.MovePlayer(dt)
		ConnJam.UpdatePlayer(dt)
		ConnJam.CameraSeekPlayer(dt)
		ConnJam.UpdateConnectivity(dt)
		ConnJam.UpdateTimer(dt)
		ConnJam.DistortSongThink()
	end

	if GAME_STATE == STATE_LEVELEND then
		ConnJam.CameraSeekPlayer(dt)
	end

	if GAME_STATE == STATE_FAIL then
		ConnJam.CameraSeekPlayer(dt)
	end

	if GAME_STATE == STATE_MAPEDIT then
		MapEdit.MoveMapEditor(dt)
	end

	if GAME_STATE == STATE_MENU then
		ConnJam.UpdateCameraMainMenu(dt)
		ConnJam.MenuThink(dt)
	end

	if GAME_STATE == STATE_CREDITS then
		ConnJam.CreditsThink(dt)
	end

	lsglil2.Update(dt)
end

function love.textinput(t)
	local cancel = lsglil2.UpdateTextEntry(t)
	if cancel then
		return
	end

end

function love.keypressed(key, scancode, isrepeat)
	local cancel lsglil2.UpdateTextEntryKeyPress(key)
	if cancel then
		return
	end

	if GAME_STATE == STATE_MAPEDIT then
		MapEdit.EditorKeybinds(key, scancode, isrepeat)
	end
end

function love.mousepressed(x, y, button, istouch, presses)
	if GAME_STATE == STATE_MAPEDIT then
		MapEdit.EditorMouse(x, y, button, istouch, presses)
	end
end

function love.draw() -- draw
	local w, h = love.graphics.getDimensions()

	love.graphics.setCanvas(CANVAS_MAIN)
		love.graphics.setBlendMode("alpha")

		if GAME_STATE == STATE_PLAY then
			love.graphics.clear(.5, .5, 1, 1)
			love.graphics.push()
				ConnJam.TranslateScaleCamera()
				ConnJam.RenderParallaxBackground()

				ConnJam.RenderMapBackground()
				ConnJam.RenderPlayer()
				--ConnJam.DebugDrawTraces()
				ConnJam.RenderMap()

				ConnJam.RenderMapEx()
			love.graphics.pop()
		end

		if GAME_STATE == STATE_LEVELEND then
			love.graphics.clear(.5, .5, 1, 1)
			love.graphics.push()
				ConnJam.TranslateScaleCamera()
				ConnJam.RenderParallaxBackground()

				ConnJam.RenderMapBackground()
				ConnJam.RenderPlayer()
				ConnJam.RenderMap()

				ConnJam.RenderMapEx()
			love.graphics.pop()
		end

		if GAME_STATE == STATE_FAIL then
			love.graphics.clear(.5, .5, 1, 1)
			love.graphics.push()
				ConnJam.TranslateScaleCamera()
				ConnJam.RenderParallaxBackground()

				ConnJam.RenderMapBackground()
				ConnJam.RenderPlayer()
				ConnJam.RenderMap()

				ConnJam.RenderMapEx()
			love.graphics.pop()
		end


		if GAME_STATE == STATE_MAPEDIT then
			love.graphics.clear(.5, .5, 1, 1)
			love.graphics.push()
				ConnJam.TranslateScaleCamera()
				ConnJam.RenderParallaxBackground()

				love.graphics.setColor(1, 1, 1, 1)
				MapEdit.RenderMapUnefficient()

				MapEdit.RenderCursor()
				ConnJam.RenderMapEx()
			love.graphics.pop()
		end

		if GAME_STATE == STATE_MENU then
			love.graphics.clear(.5, .5, 1, 1)
			love.graphics.push()
				ConnJam.TranslateScaleCamera()
				ConnJam.RenderParallaxBackground()

				ConnJam.RenderMapBackground()
				ConnJam.RenderMap()
			love.graphics.pop()
		end
	love.graphics.setCanvas()



	if GAME_STATE == STATE_PLAY then
		Shaders["noise.frag"]:send("randseed", math.random())

		love.graphics.setShader(Shaders["noise.frag"])
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.setBlendMode("alpha", "premultiplied")
			love.graphics.draw(CANVAS_MAIN, 0, 0)
			love.graphics.setBlendMode("alpha")
		love.graphics.setShader()

		ConnJam.RenderTimer()
	end


	if GAME_STATE == STATE_LEVELEND then
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.setBlendMode("alpha", "premultiplied")
		love.graphics.draw(CANVAS_MAIN, 0, 0)
		love.graphics.setBlendMode("alpha")

		love.graphics.setColor(0, 0, 0, .55)
		love.graphics.rectangle("fill", 0, 0, w, h)

		ConnJam.RenderLevelEnd()
	end

	if GAME_STATE == STATE_FAIL then
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.setBlendMode("alpha", "premultiplied")
		love.graphics.draw(CANVAS_MAIN, 0, 0)
		love.graphics.setBlendMode("alpha")

		love.graphics.setColor(0, 0, 0, .55)
		love.graphics.rectangle("fill", 0, 0, w, h)

		ConnJam.RenderLevelFail()
	end



	if GAME_STATE == STATE_MENU then
		love.graphics.setShader(Shaders["blur.frag"])
		love.graphics.setBlendMode("alpha")
		love.graphics.setColor(1, 1, 1, 1)
			for i = 1, 6 do
				Shaders["blur.frag"]:send("add", i / 512)
				local rot = (i % 2) == 0
				love.graphics.setCanvas(rot and CANVAS_MAIN or CANVAS_BLUR)
					love.graphics.draw(rot and CANVAS_BLUR or CANVAS_MAIN, 0, 0)
				love.graphics.setCanvas()
			end


			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.setBlendMode("alpha", "premultiplied")

			local w_mul = (w + 64) / w
			local h_mul = (h + 64) / h

			love.graphics.draw(CANVAS_MAIN, -32, -32, 0, w_mul, h_mul)
			love.graphics.setBlendMode("alpha")
		love.graphics.setShader()
	end

	if GAME_STATE == STATE_MAPEDIT then
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.setBlendMode("alpha", "premultiplied")
		love.graphics.draw(CANVAS_MAIN, 0, 0)
		love.graphics.setBlendMode("alpha")

		MapEdit.RenderInfo()
		MapEdit.DrawTilePalette()
	end

	if GAME_STATE == STATE_MENU then
		love.graphics.setColor(0, 0, 0, .6)
		love.graphics.rectangle("fill", 0, 0, w, h)



		love.graphics.setColor(1, 1, 1, 1)
		ConnJam.RenderMainMenuIcon()
	end

	if GAME_STATE == STATE_CREDITS then
		ConnJam.RenderCredits()
	end


	lsglil2.DrawElements()
end