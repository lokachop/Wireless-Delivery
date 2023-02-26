ConnJam = ConnJam or {}

local c_timer = 0
function ConnJam.BeginCredits()
	GAME_STATE = STATE_CREDITS
	Sounds["snd/streamed_mus/trash.mp3"]:play()
	Sounds["snd/streamed_mus/trash.mp3"]:setLooping(false)
end


function ConnJam.CreditsThink(dt)
	local _, h = love.graphics.getDimensions()

	local h_mul = h / 600

	c_timer = c_timer + (dt * 1.15)

	if c_timer > 62 * h_mul then
		Sounds["snd/streamed_mus/trash.mp3"]:stop()
		GAME_STATE = STATE_MENU
		ConnJam.InitMainMenu()
		c_timer = 0
	end
end


-- horriddd
local i_gamelogo = Textures["logo.png"].img
local i_gamelogo_box = Textures["logo_box.png"].img

local font_medium = love.graphics.newFont(24)
local font_large = love.graphics.newFont(42)
local font_xtra_large = love.graphics.newFont(64)
function ConnJam.RenderCredits()
	local w, h = love.graphics.getDimensions()

	local h_mul = h / 600

	local off_add = 0
	love.graphics.push()
		love.graphics.translate(0, -c_timer * 64)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(i_gamelogo_box, (w / 2) - (32 * 6), h, 0, 12, 12)
		off_add = off_add + ((196 * 2) * h_mul)

		love.graphics.draw(i_gamelogo, (w / 2) - (64 * 4), h + off_add, 0, 8, 8)
		off_add = off_add + (128 + 32) * h_mul

		love.graphics.printf("A game by Lokachop", font_medium, 0, h + off_add, w, "center")
		off_add = off_add + (256 + 64) * h_mul

		love.graphics.printf("Contributors", font_xtra_large, 0, h + off_add, w, "center")
		off_add = off_add + 72 * h_mul
		love.graphics.rectangle("fill", 0, h + off_add, w, 4)
		off_add = off_add + 6 * h_mul

		love.graphics.printf("opiper", font_large, 0, h + off_add, w, "center")
		off_add = off_add + 48 * h_mul
		love.graphics.printf("Textures, Playtesting", font_medium, 0, h + off_add, w, "center")

		off_add = off_add + 64 * h_mul
		love.graphics.printf("MISTER BONES", font_large, 0, h + off_add, w, "center")
		off_add = off_add + 48 * h_mul
		love.graphics.printf("Textures", font_medium, 0, h + off_add, w, "center")

		off_add = off_add + 64 * h_mul
		love.graphics.printf("Lefton", font_large, 0, h + off_add, w, "center")
		off_add = off_add + 48 * h_mul
		love.graphics.printf("Robot voice, Playtesting", font_medium, 0, h + off_add, w, "center")

		off_add = off_add + 64 * h_mul
		love.graphics.printf("Lord_Arcness", font_large, 0, h + off_add, w, "center")
		off_add = off_add + 48 * h_mul
		love.graphics.printf("Feedback", font_medium, 0, h + off_add, w, "center")

		off_add = off_add + 64 * h_mul
		love.graphics.printf("NorskeTorsk", font_large, 0, h + off_add, w, "center")
		off_add = off_add + 48 * h_mul
		love.graphics.printf("Robot redesign for artwork", font_medium, 0, h + off_add, w, "center")

		off_add = off_add + 128 * h_mul
		love.graphics.printf("Tools Used", font_xtra_large, 0, h + off_add, w, "center")
		off_add = off_add + 72 * h_mul
		love.graphics.rectangle("fill", 0, h + off_add, w, 4)
		off_add = off_add + 6 * h_mul

		off_add = off_add + 64 * h_mul
		love.graphics.printf("LibreSprite", font_large, 0, h + off_add, w, "center")
		off_add = off_add + 48 * h_mul
		love.graphics.printf("https://libresprite.github.io/", font_medium, 0, h + off_add, w, "center")

		off_add = off_add + 64 * h_mul
		love.graphics.printf("Bosca Ceoil", font_large, 0, h + off_add, w, "center")
		off_add = off_add + 48 * h_mul
		love.graphics.printf("https://boscaceoil.net/", font_medium, 0, h + off_add, w, "center")

		off_add = off_add + 64 * h_mul
		love.graphics.printf("Audacity", font_large, 0, h + off_add, w, "center")
		off_add = off_add + 48 * h_mul
		love.graphics.printf("https://www.audacityteam.org/", font_medium, 0, h + off_add, w, "center")

		off_add = off_add + 64 * h_mul
		love.graphics.printf("sfxr", font_large, 0, h + off_add, w, "center")
		off_add = off_add + 48 * h_mul
		love.graphics.printf("https://www.drpetter.se/project_sfxr.html", font_medium, 0, h + off_add, w, "center")

		off_add = off_add + 128 * h_mul
		love.graphics.printf("Libraries Used", font_xtra_large, 0, h + off_add, w, "center")
		off_add = off_add + 72 * h_mul
		love.graphics.rectangle("fill", 0, h + off_add, w, 4)
		off_add = off_add + 6 * h_mul

		off_add = off_add + 64 * h_mul
		love.graphics.printf("bump.lua", font_large, 0, h + off_add, w, "center")
		off_add = off_add + 48 * h_mul
		love.graphics.printf("https://github.com/kikito/bump.lua", font_medium, 0, h + off_add, w, "center")


		off_add = off_add + 128 * h_mul
		love.graphics.printf("Powered By", font_xtra_large, 0, h + off_add, w, "center")
		off_add = off_add + 72 * h_mul
		love.graphics.rectangle("fill", 0, h + off_add, w, 4)
		off_add = off_add + 6 * h_mul

		off_add = off_add + 64 * h_mul
		love.graphics.printf("LÖVE2D", font_large, 0, h + off_add, w, "center")
		off_add = off_add + 48 * h_mul
		love.graphics.printf("https://love2d.org/", font_medium, 0, h + off_add, w, "center")


		off_add = off_add + 256 * h_mul
		love.graphics.push()
			local tval = math.max(c_timer - 52 * h_mul, 0)
			love.graphics.translate(0, tval * 64)
			love.graphics.printf("Thanks for playing!", font_xtra_large, 0, h + off_add, w, "center")
		love.graphics.pop()
	love.graphics.pop()
end