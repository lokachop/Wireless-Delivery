local nextMaps = {
	["test"] = "credits",
	["level1"] = "level2",
	["level2"] = "level3",
	["level3"] = "level4",
	["level4"] = "level5",
	["level5"] = "level6",
	["level6"] = "level7",
	["level7"] = "level8",
	["level8"] = "credits"
}

local success_sounds = {
	"snd/vo/success/success1.wav",
	"snd/vo/success/success2.wav",
	"snd/vo/success/success3.wav",
	"snd/vo/success/success4.wav",
	"snd/vo/success/success5.wav",
	"snd/vo/success/success6.wav",
	"snd/vo/success/success7.wav",
	"snd/vo/success/success8.wav",
}

local death_sounds = {
	"snd/vo/fail/fail_5g1.wav",
	"snd/vo/fail/fail_5g2.wav"
}


local timedeath_sounds = {
	"snd/vo/time_fail/time_fail1.wav",
	"snd/vo/time_fail/time_fail2.wav",
	"snd/vo/time_fail/time_fail3.wav",
	"snd/vo/time_fail/time_fail4.wav",
	"snd/vo/time_fail/time_fail5.wav",
	"snd/vo/time_fail/time_fail6.wav",
}

local font_large = love.graphics.newFont(32)
local function lsglil_makeNiceButtonSkin()
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

		currCol[4] = .3
		love.graphics.setColor(currCol)
		love.graphics.rectangle("fill", edata["x"], edata["y"], edata["w"], edata["h"])

		currCol[4] = 1
		love.graphics.setColor(currCol)
		love.graphics.printf(edata["text"], font_large, edata["x"], edata["y"], edata["w"], "center")
	end
end


love.audio.setEffect("robot_modulate", {
	type = "ringmodulator",
	waveform = "sine",
	frequency = 8800,
	highcut = 0,
})

-- handles level completion
function ConnJam.CompleteLevel()
	local nextMap = nextMaps[ConnJam.CurrMap]
	if not nextMap then
		error("No next map!")
	end


	-- play a delivered sound
	local snd_toplay = success_sounds[math.random(1, #success_sounds)]
	Sounds[snd_toplay]:setEffect("robot_modulate")
	Sounds[snd_toplay]:setFilter({
		type = "highpass",
		volume = .6,
		lowgain = .05,
	})
	Sounds[snd_toplay]:play()



	ConnJam.StopTimer()
	GAME_STATE = STATE_LEVELEND

	-- make ui
	lsglil_makeNiceButtonSkin()

	local w, h = love.graphics.getDimensions()

	local b_w1 = 256
	lsglil2.NewObject("ButtonNext", "button")
	lsglil2.SetObjectPosition("ButtonNext", (w / 2) - (b_w1 * .5), h * .5)
	lsglil2.SetObjectScale("ButtonNext", b_w1, 32 + 4)
	lsglil2.SetObjectData("ButtonNext", "text", nextMap == "credits" and "Credits" or "Next level")
	lsglil2.SetObjectData("ButtonNext", "col", {153 / 255, 229 / 255, 80 / 255})
	lsglil2.SetObjectData("ButtonNext", "onPress", function(GUITime)
		if nextMap == "credits" then
			ConnJam.StopMapSong()
			ConnJam.BeginCredits()
		else
			GAME_STATE = STATE_PLAY
			ConnJam.LoadMap(nextMap)
		end

		lsglil2.DeleteObject("ButtonNext")
		lsglil2.DeleteObject("ButtonMenu")
	end)

	local b_w2 = 256
	lsglil2.NewObject("ButtonMenu", "button")
	lsglil2.SetObjectPosition("ButtonMenu", (w / 2) - (b_w2 * .5), h * .7)
	lsglil2.SetObjectScale("ButtonMenu", b_w2, 32 + 4)
	lsglil2.SetObjectData("ButtonMenu", "text", "Back to menu")
	lsglil2.SetObjectData("ButtonMenu", "col", {80 / 255, 153 / 255, 229 / 255})
	lsglil2.SetObjectData("ButtonMenu", "onPress", function(GUITime)
		GAME_STATE = STATE_MENU
		ConnJam.StopMapSong()
		ConnJam.InitMainMenu()

		lsglil2.DeleteObject("ButtonNext")
		lsglil2.DeleteObject("ButtonMenu")
	end)
end





function ConnJam.FailLevel(reason, time_death)
	ConnJam.FailReason = reason
	-- play a delivered sound
	local snd_toplay = time_death and timedeath_sounds[math.random(1, #timedeath_sounds)] or death_sounds[math.random(1, #death_sounds)]
	Sounds[snd_toplay]:setEffect("robot_modulate")
	Sounds[snd_toplay]:setFilter({
		type = "highpass",
		volume = .6,
		lowgain = .05,
	})
	Sounds[snd_toplay]:play()

	GAME_STATE = STATE_FAIL

	lsglil_makeNiceButtonSkin()
	local w, h = love.graphics.getDimensions()
	local b_w1 = 256
	lsglil2.NewObject("ButtonRetry", "button")
	lsglil2.SetObjectPosition("ButtonRetry", (w / 2) - (b_w1 * .5), h * .5)
	lsglil2.SetObjectScale("ButtonRetry", b_w1, 32 + 4)
	lsglil2.SetObjectData("ButtonRetry", "text", "Retry")
	lsglil2.SetObjectData("ButtonRetry", "col", {153 / 255, 229 / 255, 80 / 255})
	lsglil2.SetObjectData("ButtonRetry", "onPress", function(GUITime)
		GAME_STATE = STATE_PLAY
		ConnJam.RespawnPlayerCheckpoint()

		lsglil2.DeleteObject("ButtonRetry")
		lsglil2.DeleteObject("ButtonMenu")
	end)

	local b_w2 = 256
	lsglil2.NewObject("ButtonMenu", "button")
	lsglil2.SetObjectPosition("ButtonMenu", (w / 2) - (b_w2 * .5), h * .7)
	lsglil2.SetObjectScale("ButtonMenu", b_w2, 32 + 4)
	lsglil2.SetObjectData("ButtonMenu", "text", "Back to menu")
	lsglil2.SetObjectData("ButtonMenu", "col", {80 / 255, 153 / 255, 229 / 255})
	lsglil2.SetObjectData("ButtonMenu", "onPress", function(GUITime)
		GAME_STATE = STATE_MENU
		ConnJam.StopMapSong()
		ConnJam.InitMainMenu()

		lsglil2.DeleteObject("ButtonRetry")
		lsglil2.DeleteObject("ButtonMenu")
	end)

end




local level_fancynames = {
	["level1"] = "The First Delivery",
	["level2"] = "Where's the signal?",
	["level3"] = "Rooftop adventure",
	["level4"] = "Pretty from up here",
	["level5"] = "Who lives up there?",
	["level6"] = "Persistence",
	["level7"] = "Vertical Signal",
	["level8"] = "The last delivery",
	["test"] = "the test LEVEL!!"
}


local font_large_levelbeaten = love.graphics.newFont(48)
local font_s_large_levelbeaten = love.graphics.newFont(32)
local font_med_levelbeaten = love.graphics.newFont(24)
function ConnJam.RenderLevelEnd()
	love.graphics.setColor(1, 1, 1, 1)
	local w = love.graphics.getDimensions()
	love.graphics.printf("Delivery Successful", font_large_levelbeaten, 0, 0, w, "center")


	love.graphics.setColor(.85, .85, .85, 1)
	local f_name = level_fancynames[ConnJam.CurrMap] or ("level_fancynames[\"" .. ConnJam.CurrMap .. "\"] is nil, FIXXX")
	love.graphics.printf("\"" .. f_name .. "\"", font_med_levelbeaten, 0, 48, w, "center")
	love.graphics.printf(ConnJam.GetFormattedTimeTaken(), font_med_levelbeaten, 0, 48 + 24, w, "center")


end
ConnJam.FailReason = "No reason?"
function ConnJam.RenderLevelFail()
	love.graphics.setColor(1, 1, 1, 1)
	local w = love.graphics.getDimensions()
	love.graphics.printf("Delivery Failed", font_large_levelbeaten, 0, 0, w, "center")
	love.graphics.setColor(.925, .925, .925, 1)
	love.graphics.printf(ConnJam.FailReason, font_s_large_levelbeaten, 0, 48, w, "center")

	love.graphics.setColor(.85, .85, .85, 1)
	local f_name = level_fancynames[ConnJam.CurrMap] or ("level_fancynames[\"" .. ConnJam.CurrMap .. "\"] is nil, FIXXX")
	love.graphics.printf("\"" .. f_name .. "\"", font_med_levelbeaten, 0, 48 + 32, w, "center")


	--love.graphics.printf(ConnJam.GetFormattedTimeTaken(), font_med_levelbeaten, 0, 48 + 24, w, "center")


end




local checkpoint_last = {x = 0, y = 0} -- tile coords
function ConnJam.MarkCheckpoint(x, y)
	checkpoint_last.x = x or 0
	checkpoint_last.y = y or 0
end

function ConnJam.GetCheckpointCoords()
	return checkpoint_last.x, checkpoint_last.y
end

function ConnJam.RespawnPlayerCheckpoint()
	-- tp back to checkpoint
	ConnJam.SetPlayerVel(0, 0)
	ConnJam.SetPlayerPos(checkpoint_last.x * TILE_SIZE, (checkpoint_last.y * TILE_SIZE) - (PLAYER_SIZE_Y / 2))
	ConnJam.SetPlayerConnectivity(CONNECTION_RANGE)
	-- if we dont do this it doesnt work for some reason
	ConnJam.InitPlayer()
	ConnJam.BeginTimer()

	-- tp camera too cuz its nice
	ConnJam.SetCamPos(checkpoint_last.x * TILE_SIZE, checkpoint_last.y * TILE_SIZE)
end

-- takes u back to last checkpoint
function ConnJam.DieQuick(time_death)
	local snd_toplay = time_death and timedeath_sounds[math.random(1, #timedeath_sounds)] or death_sounds[math.random(1, #death_sounds)]
	Sounds[snd_toplay]:setEffect("robot_modulate")
	Sounds[snd_toplay]:setFilter({
		type = "highpass",
		volume = .6,
		lowgain = .05,
	})

	Sounds[snd_toplay]:play()

	ConnJam.RespawnPlayerCheckpoint()
end