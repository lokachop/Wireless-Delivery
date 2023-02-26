ConnJam = ConnJam or {}


local level_selector = false
local levelButtonIds = {}
local function rm_buttons()
	lsglil2.DeleteObject("ButtonStart")
	lsglil2.DeleteObject("ButtonLoadLevel")
	lsglil2.DeleteObject("ButtonCredits")

	if level_selector then
		print("selekctor")
		lsglil2.DeleteObject("ButtonBack")

		for k, v in pairs(levelButtonIds) do
			lsglil2.DeleteObject(v)
		end
	end
end

local function rm_menumusic()
	Sounds["snd/streamed_mus/test1_drums_low.wav"]:stop()
	Sounds["snd/streamed_mus/test1_main_hi.wav"]:stop()
end


local level_order = {
	["level1"] = 0,
	["level2"] = 1,
	["level3"] = 2,
	["level4"] = 3,
	["level5"] = 4,
	["level6"] = 5,
	["level7"] = 6,
	["level8"] = 7,
	["test"] = 8,
	["mainmenu"] = 9,
}

local blacklisted_levels = {
	["test"] = true,
	["mainmenu"] = true
}

local lsglil_sucks = Curtime or 0
local function mk_menubuttons()
	local w, h = love.graphics.getDimensions()
	local div_add = (w / 800)

	lsglil2.NewObject("ButtonStart", "button")
	lsglil2.SetObjectPosition("ButtonStart", 0, h * .3)
	lsglil2.SetObjectScale("ButtonStart", (w / 6.5) / div_add, 32 + 4)
	lsglil2.SetObjectData("ButtonStart", "text", "Start!")
	lsglil2.SetObjectData("ButtonStart", "col", {153 / 255, 229 / 255, 80 / 255})
	lsglil2.SetObjectData("ButtonStart", "onPress", function(GUITime)
		print("Play")
		rm_buttons()
		rm_menumusic()

		GAME_STATE = STATE_PLAY
		ConnJam.LoadMap("level1")
	end)


	lsglil2.NewObject("ButtonLoadLevel", "button")
	lsglil2.SetObjectPosition("ButtonLoadLevel", 0, h * .5)
	lsglil2.SetObjectScale("ButtonLoadLevel", (w / 3.5) / div_add, 32 + 4)
	lsglil2.SetObjectData("ButtonLoadLevel", "text", "Load Level...")
	lsglil2.SetObjectData("ButtonLoadLevel", "col", {80 / 255, 153 / 255, 229 / 255})
	lsglil2.SetObjectData("ButtonLoadLevel", "onPress", function()
		lsglil_sucks = Curtime + 1

		rm_buttons()

		lsglil2.NewObject("ButtonBack", "button")
		lsglil2.SetObjectPosition("ButtonBack", 0, h * .2)
		lsglil2.SetObjectScale("ButtonBack", (w / 6.5) / div_add, 32 + 4)
		lsglil2.SetObjectData("ButtonBack", "text", "Back...")
		lsglil2.SetObjectData("ButtonBack", "col", {229 / 255, 153 / 255, 80 / 255})
		lsglil2.SetObjectData("ButtonBack", "onPress", function()
			if lsglil_sucks > Curtime then
				return
			end

			mk_menubuttons()

			for k, v in pairs(levelButtonIds) do
				lsglil2.DeleteObject(v)
			end

			lsglil2.DeleteObject("ButtonBack")
			level_selector = false
		end)

		local levels = ConnJam.Maps
		for k, v in pairs(levels) do
			if blacklisted_levels[k] then
				goto _continue
			end

			local order = level_order[k]
			if not order then
				error("no level order for \"" .. k .. "\"")
			end


			local level_id = "Button_lvl" .. k

			lsglil2.NewObject(level_id, "button")

			local ord_calc = (order % 7) / 10

			lsglil2.SetObjectPosition(level_id, ((w / 4) / div_add) * math.floor(order / 7), h * (.3 + ord_calc))
			lsglil2.SetObjectScale(level_id, (w / 4) / div_add, 32 + 4)
			lsglil2.SetObjectData(level_id, "text", k)
			lsglil2.SetObjectData(level_id, "col", {80 / 255, 153 / 255, 229 / 255})
			lsglil2.SetObjectData(level_id, "onPress", function()
				if lsglil_sucks < Curtime then
					rm_buttons()
					rm_menumusic()

					for k2, v2 in pairs(levelButtonIds) do
						lsglil2.DeleteObject(v2)
					end

					GAME_STATE = STATE_PLAY
					ConnJam.LoadMap(k)
				end
			end)

			levelButtonIds[#levelButtonIds + 1] = level_id

			::_continue::
		end

		level_selector = true
	end)


	lsglil2.NewObject("ButtonCredits", "button")
	lsglil2.SetObjectPosition("ButtonCredits", 0, h * .7)
	lsglil2.SetObjectScale("ButtonCredits", (w / 4.75) / div_add, 32 + 4)
	lsglil2.SetObjectData("ButtonCredits", "text", "Credits...")
	lsglil2.SetObjectData("ButtonCredits", "col", {153 / 255, 80 / 255, 229 / 255})
	lsglil2.SetObjectData("ButtonCredits", "onPress", function(GUITime)
		print("Credits")
		rm_buttons()
		rm_menumusic()

		ConnJam.BeginCredits()
	end)
end


local font_large = love.graphics.newFont(32)
function ConnJam.InitMainMenu()
	ConnJam.LoadMap("mainmenu")

	print("Load main menu")

	Sounds["snd/streamed_mus/test1_drums_low.wav"]:setLooping(true)
	Sounds["snd/streamed_mus/test1_drums_low.wav"]:setFilter({
		type = "lowpass",
		volume = .6,
		highgain = 0.0,
	})
	Sounds["snd/streamed_mus/test1_drums_low.wav"]:play()



	Sounds["snd/streamed_mus/test1_main_hi.wav"]:setLooping(true)
	Sounds["snd/streamed_mus/test1_main_hi.wav"]:setFilter({
		type = "lowpass",
		volume = .6,
		highgain = 0.0,
	})
	Sounds["snd/streamed_mus/test1_main_hi.wav"]:play()
	Sounds["snd/streamed_mus/test1_main_hi.wav"]:setVolume(0)



	-- lets override paints to make it look GOOD
	lsglil2.Elements["button"].Paint = function(time, edata, touching)
		local currCol = {0, 0, 0}
		if touching then
			if love.mouse.isDown(1) then
				currCol = {edata["col"][1] + 0.4, edata["col"][2] + 0.4, edata["col"][3] + 0.4}
			else
				currCol = {edata["col"][1] + 0.2, edata["col"][2] + 0.2, edata["col"][3] + 0.2}
			end
		else
			currCol = edata["col"]
		end

		love.graphics.setColor(currCol)
		love.graphics.rectangle("fill", edata["x"], edata["y"] + edata["h"] - 4, edata["w"], 4)

		love.graphics.printf(edata["text"], font_large, edata["x"], edata["y"], edata["w"])
	end

	mk_menubuttons()
end


local i_gamelogo = Textures["logo.png"].img
local i_gamelogo_box = Textures["logo_box.png"].img
function ConnJam.RenderMainMenuIcon()
	--local w_add = w * .025
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(i_gamelogo_box, 0, 0, 0, 4, 4)
	--love.graphics.draw(i_gamelogo, w_add + (32 * 2), w_add + 16, 0, 4, 4)
	love.graphics.draw(i_gamelogo, 32 * 4, 18, 0, 6, 6)
end

local MENU_SONG_TIME = math.pi * 2.4
function ConnJam.MenuThink(dt)
	MENU_SONG_TIME = MENU_SONG_TIME + dt


	--Sounds["snd/streamed_mus/test1_main_hi.wav"]:setLooping(true)
	Sounds["snd/streamed_mus/test1_main_hi.wav"]:setVolume(math.max(((math.sin(MENU_SONG_TIME * .5) + 1) / 2) - .25, 0))

end

local cam_time = 0
function ConnJam.UpdateCameraMainMenu(dt)
	cam_time = cam_time + dt
	ConnJam.SetCamPos((13 + math.sin(cam_time * .75)) * TILE_SIZE, (15 + (math.cos(cam_time * .75) / 4)) * TILE_SIZE)
end