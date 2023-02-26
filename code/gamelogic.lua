-- hanldes generic game logic
ConnJam = ConnJam or {}


local level_times = { -- beat my times! if you do, tweet @Lokachop or contact at Lokachop#5862
    ["level1"] = 80, -- took me 7.49s
    ["level2"] = 80, -- took me 6.29s
    ["level3"] = 60, -- took me 19.62s
    ["level4"] = 40, -- took me 7.07s
    ["level5"] = 70, -- took me 5.81s
    ["level6"] = 70, -- took me 17.13s
    ["level7"] = 70, -- took me 11.71s
    ["level8"] = 120, -- took me 27.01s
    ["test"] = 40, -- took me 0.65s (hint, go left)
}

local timer_len = 64
ConnJam.TimerTime = 0
ConnJam.TimeTaken = 0
ConnJam.TimerActive = false
ConnJam.GameActive = false


function ConnJam.BeginTimerTaken()
    ConnJam.TimeTaken = 0
end

function ConnJam.BeginTimer()
    if level_times[ConnJam.CurrMap] then
        ConnJam.TimerTime = level_times[ConnJam.CurrMap]
    else
        ConnJam.TimerTime = timer_len
    end

    ConnJam.TimerActive = true
    ConnJam.GameActive = true
end

function ConnJam.StopTimer()
    ConnJam.TimerActive = false
end

local last_song = nil

-- i appear to have what is called a "lack of a proper soundtrack"
-- no kevin macleod to save me either
local map_songs = {
    ["level1"] = "snd/streamed_mus/horrid.mp3",
    ["level2"] = "snd/streamed_mus/horrid.mp3",
    ["level3"] = "snd/streamed_mus/trash.mp3",
    ["level4"] = "snd/streamed_mus/horrid.mp3",
    ["level5"] = "snd/streamed_mus/horrid.mp3",
    ["level6"] = "snd/streamed_mus/trash.mp3",
    ["level7"] = "snd/streamed_mus/horrid.mp3",
    ["level8"] = "snd/streamed_mus/trash.mp3",
    ["test"] = "snd/streamed_mus/abhorrent.mp3",
}
function ConnJam.PlayMapSong()
    if GAME_STATE ~= STATE_PLAY then
        return
    end

    Sounds["snd/noise.mp3"]:stop()

    Sounds["snd/noise.mp3"]:play()
    Sounds["snd/noise.mp3"]:setLooping(true)

    if last_song ~= nil then
        Sounds[last_song]:stop()
    end

    if map_songs[ConnJam.CurrMap] then
        Sounds[map_songs[ConnJam.CurrMap]]:play()
        Sounds[map_songs[ConnJam.CurrMap]]:setVolume(.5)
        Sounds[map_songs[ConnJam.CurrMap]]:setLooping(true)

        last_song = map_songs[ConnJam.CurrMap]
    else
        print("no MAPSONG \"" .. ConnJam.CurrMap .. "\"")
    end
end

function ConnJam.StopMapSong()
    if last_song ~= nil then
        Sounds[last_song]:stop()
    end
    Sounds["snd/noise.mp3"]:stop()
end

function ConnJam.DistortSongThink()
    if GAME_STATE ~= STATE_PLAY then
        return
    end

    local player_signalstrength = math.min(ConnJam.Player.curr_connectivity / (CONNECTION_RANGE * .65), 1)
    local player_signalstrength_inv = math.abs(1 - player_signalstrength)

    if map_songs[ConnJam.CurrMap] then
        Sounds[map_songs[ConnJam.CurrMap]]:setPitch(1 + (math.sin(Curtime * 64) * (.1 * player_signalstrength_inv)))
        Sounds[map_songs[ConnJam.CurrMap]]:setVolume(.5 * player_signalstrength)
    end

    Sounds["snd/noise.mp3"]:setVolume(.5 * player_signalstrength_inv)
end



function ConnJam.UpdateTimer(dt)
    if ConnJam.TimerActive then
        ConnJam.TimerTime = ConnJam.TimerTime - dt
        ConnJam.TimeTaken = ConnJam.TimeTaken + dt
    end

    if ConnJam.TimerTime <= 0 then
        ConnJam.FailLevel("Ran out of time", true)
    end
end


local function fancy_time(secs_o)
    local hours = math.floor(secs_o / 3600)
    local mins = math.floor((secs_o / 60) % 60)
    local secs = secs_o % 60

    return hours, mins, secs
end

function ConnJam.GetFormattedTimeTaken()
    local _, f_m, f_s = fancy_time(ConnJam.TimeTaken)

   return string.format("%02d:%05.2f", f_m, f_s)
end


local timer_font_large = love.graphics.newFont(32)
local timer_font_small = love.graphics.newFont(12)
function ConnJam.RenderTimer()
    local w = love.graphics.getDimensions()
    love.graphics.setColor(1, 1, 1, 1)



    local _, l_m, l_s = fancy_time(ConnJam.TimerTime)

    local timer_str = string.format("%02d:%05.2f", l_m, l_s)
    love.graphics.printf(timer_str, timer_font_large, 0, 0, w, "center")


    local _, f_m, f_s = fancy_time(ConnJam.TimeTaken)

    local timer_str_taken = string.format("%02d:%05.2f", f_m, f_s)
    love.graphics.printf(timer_str_taken, timer_font_small, 0, 0, w, "right")
end


local parallax_mat = Textures["parallax.png"].img
parallax_mat:setWrap("repeat", "repeat")
local parallax_quad = love.graphics.newQuad(0, 0, 480, 224, parallax_mat)
local parallax_tall = parallax_mat:getHeight() - 32

local parallax_mat_far = Textures["parallax2.png"].img
parallax_mat_far:setWrap("repeat", "repeat")
local parallax_quad_far = love.graphics.newQuad(0, 0, 256, 128, parallax_mat_far)
local parallax_far_tall = parallax_mat_far:getHeight() / 2

local floor_planes = {
    ["level1"] = 12,
    ["level2"] = 11,
    ["level3"] = 12,
    ["level4"] = 16,
    ["level5"] = 23,
    ["level6"] = 19,
    ["level7"] = 33,
    ["level8"] = 25,
    ["test"] = 10,
    ["mainmenu"] = 17,
}
function ConnJam.RenderParallaxBackground()

    local curr_floor = floor_planes[ConnJam.CurrMap]
    if not curr_floor then
        return
    end
    local w, _ = love.graphics.getDimensions()

    local ycsub = (TILE_SIZE * curr_floor)

    local cam_delta_to_plane = ConnJam.Camera.y - ycsub


    -- far parallax
    love.graphics.setColor(.4, .4, .8, 1)
    parallax_quad_far:setViewport(ConnJam.Camera.x * .2, 0, w, 192)
    love.graphics.draw(parallax_mat_far, parallax_quad_far, ConnJam.Camera.x - (w / 2), (ycsub + cam_delta_to_plane * .6) - (parallax_far_tall * 1.05), 0, 1.05, 1.05)

    love.graphics.setColor(.35, .35, .6, 1)
    parallax_quad_far:setViewport(ConnJam.Camera.x * .3, 0, w, 192)
    love.graphics.draw(parallax_mat_far, parallax_quad_far, ConnJam.Camera.x - (w / 2), (ycsub + cam_delta_to_plane * .5) - (parallax_far_tall * 1.1), 0, 1.1, 1.1)

    love.graphics.setColor(.35, .15, .2, 1)
    parallax_quad_far:setViewport(ConnJam.Camera.x * .4, 0, w, 192)
    love.graphics.draw(parallax_mat_far, parallax_quad_far, ConnJam.Camera.x - (w / 2), (ycsub + cam_delta_to_plane * .4) - (parallax_far_tall * 1.4), 0, 1.4, 1.4)


    love.graphics.setColor(.55, .55, .75, 1)
    -- near parallax
    parallax_quad:setViewport(ConnJam.Camera.x * .6, 0, w, 224)
    love.graphics.draw(parallax_mat, parallax_quad, ConnJam.Camera.x - (w / 2), (ycsub + cam_delta_to_plane * .1) - (parallax_tall * 1.4), 0, 1.4, 1.4)
end