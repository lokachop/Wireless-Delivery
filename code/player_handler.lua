-- my code is sub-par

local ply_animscl = 48
local ply_animTextures = {
	["idle"] = {
		tex = "robit_sheet.png",
		len = 1,
		rate = 0,
	},
	["move"] = {
		tex = "robit_sheet.png",
		len = 4,
		rate = 12,
	},
	["jump"] = {
		tex = "robit_jump_sheet.png",
		len = 3,
		rate = 24,
		persist = true
	},
}

local ply_quads = {}
for k, v in pairs(ply_animTextures) do
	if not ply_quads[v.tex] then
		print(v.tex)
		ply_quads[v.tex] = love.graphics.newQuad(0, 0, ply_animscl, ply_animscl, Textures[v.tex].img)
	end
end


ConnJam.Player = {
	x = 0,
	y = 0,
	velx = 0,
	vely = 0,
	anim_frame = 0,
	anim_state = "idle",
	anim_time = 0,
	anim_flip = false,
	grounded = true,
	curr_connectivity = CONNECTION_RANGE,
}
ConnJam.PlayerPhys = {name = "player", notrace = true, no_playercoll = true}

function ConnJam.SetPlayerPos(x, y)
	ConnJam.Player.x = x or 0
	ConnJam.Player.y = y or 0
end

function ConnJam.SetPlayerPosHalt(x, y)
	ConnJam.Player.velx = 0
	ConnJam.Player.vely = 0

	ConnJam.Player.x = x or 0
	ConnJam.Player.y = y or 0
end

function ConnJam.SetPlayerVel(vx, vy)
	ConnJam.Player.velx = vx or 0
	ConnJam.Player.vely = vy or 0
end


function ConnJam.SetPlayerConnectivity(val)
	ConnJam.Player.curr_connectivity = val
end

function ConnJam.InitPlayer()
	if ConnJam.MapBumpWorld:hasItem(ConnJam.PlayerPhys) then
		ConnJam.MapBumpWorld:remove(ConnJam.PlayerPhys)
	end

	ConnJam.MapBumpWorld:add(ConnJam.PlayerPhys, ConnJam.Player.x, ConnJam.Player.y, PLAYER_SIZE_X, PLAYER_SIZE_Y)
end

local function clamp(x, m, M)
	return math.max(math.min(x, M), m)
end


local last_connected = Curtime
function ConnJam.UpdateConnectivity(dt)
	local connectivity = ConnJam.GetConnectivityAtPoint(ConnJam.Player.x + (PLAYER_SIZE_X / 2), ConnJam.Player.y)
	local delta_dir = connectivity > ConnJam.Player.curr_connectivity and 1024 or -1024

	--local conn_delta = (connectivity - ConnJam.Player.curr_connectivity) + delta_dir

	ConnJam.Player.curr_connectivity = math.max(ConnJam.Player.curr_connectivity + (delta_dir * (dt * 16)), 0)

	local p_con = ConnJam.Player.curr_connectivity

	if p_con > 0 then
		last_connected = Curtime
	end

	if p_con <= 0 and (Curtime - last_connected) > 2 then
		print("we are dead")
		ConnJam.FailLevel("Lost Connection")
	end


	--if p_con > 0 then
	local gr_val = math.max(math.min(1 - math.max((p_con / 2) - 1024, 0) / (CONNECTION_RANGE / 4), 1), 0)
		Shaders["noise.frag"]:send("graymult", gr_val)
		--local nsmul = 1 - math.min(math.max((p_con / 2) - 512, 0) / 2048, 1)
		--local ns_val = math.max(math.min(nsmul, .6), 0)


		Shaders["noise.frag"]:send("noisemult", math.max(math.min(gr_val, .6), 0))
	--else
	--	Shaders["noise.frag"]:send("graymult", 1)
	--	Shaders["noise.frag"]:send("noisemult", 1)
	--end
end


function ConnJam.MovePlayer(dt)
	local connectivity = ConnJam.Player.curr_connectivity --ConnJam.GetConnectivityAtPoint(ConnJam.Player.x + (PLAYER_SIZE_X / 2), ConnJam.Player.y)


	if connectivity <= 0 then
		return
	end

	local v_mul = math.min(ConnJam.Player.curr_connectivity / (CONNECTION_RANGE * .75), 1)
	local v_mul_jmp = math.min(ConnJam.Player.curr_connectivity / (CONNECTION_RANGE * .35), 1)

	if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		ConnJam.Player.velx = clamp(ConnJam.Player.velx - (64 * v_mul), -PLAYER_SPEEDCAP, PLAYER_SPEEDCAP)
		ConnJam.Player.anim_flip = true
	end
	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		ConnJam.Player.velx = clamp(ConnJam.Player.velx + (64 * v_mul), -PLAYER_SPEEDCAP, PLAYER_SPEEDCAP)
		ConnJam.Player.anim_flip = false
	end

	if ConnJam.Player.grounded and (love.keyboard.isDown("space") or love.keyboard.isDown("w") or love.keyboard.isDown("up")) then
		ConnJam.Player.vely = (-512 - 128 - 128) * v_mul_jmp
		ConnJam.Player.grounded = false
		ConnJam.Player.anim_state = "jump"
		ConnJam.Player.anim_time = 0

		Sounds["snd/sfx/jump.wav"]:setVolume(.25)
		Sounds["snd/sfx/jump.wav"]:play()
	end
end

local function printTable(tblpointer)
	print("-------")
	for k, v in pairs(tblpointer) do
		print("[" .. k .. "]: " .. tostring(v))
	end
end


function ConnJam.UpdatePlayer(dt)
	local _, len_f = ConnJam.MapBumpWorld:queryRect(ConnJam.Player.x, ConnJam.Player.y + PLAYER_SIZE_Y, PLAYER_SIZE_X, 4 + math.max(ConnJam.Player.vely / (TILE_SIZE * .85), 0), function(item)
		if item.col_onlytop and (ConnJam.Player.vely < 0) then
			return false
		end

		if item.no_playercoll then
			return false
		end

		return true
	end)
	local grounded = len_f > 0

	if (not ConnJam.Player.grounded) and grounded and (ConnJam.Player.vely > 0) then
		Sounds["snd/sfx/hit_ground.wav"]:setVolume(.25)
		Sounds["snd/sfx/hit_ground.wav"]:play()
	end
	ConnJam.Player.grounded = grounded



	local n_x = ConnJam.Player.x + (ConnJam.Player.velx * dt)
	local n_y = ConnJam.Player.y + (ConnJam.Player.vely * dt)

	local actualX, actualY, cols, len = ConnJam.MapBumpWorld:move(ConnJam.PlayerPhys, n_x, n_y, function(item, other)
		if other.col_onlytop and not ConnJam.Player.grounded then
			return false
		end

		if other.no_playercoll then
			return false
		end

		return "slide"
	end)
	for i = 1, len do
		local col = cols[i]
		if col.normal.y == -1 then
			ConnJam.Player.vely = 0
		end

		if col.normal.y == 1 then
			ConnJam.Player.vely = 0
		end

		if col.normal.x ~= 0 then
			ConnJam.Player.velx = 0
		end
	end



	if grounded then
		ConnJam.Player.velx = ConnJam.Player.velx / math.max(82.45 * dt, 1)
		if math.abs(ConnJam.Player.velx) > 8 then
			ConnJam.Player.anim_state = "move"
		else
			ConnJam.Player.anim_state = "idle"
		end
	else
		ConnJam.Player.velx = ConnJam.Player.velx / math.max(72.45 * dt, 1)
		ConnJam.Player.vely = ConnJam.Player.vely + (2048 * dt)
	end

	ConnJam.Player.x = actualX
	ConnJam.Player.y = actualY
end

function ConnJam.HandlePlayerTileTouch()
	local ply_wx = math.floor((ConnJam.Player.x + (PLAYER_SIZE_X / 2)) / TILE_SIZE)
	local ply_wy = math.floor((ConnJam.Player.y + (PLAYER_SIZE_Y / 2)) / TILE_SIZE)

	local tile = ConnJam.GetMapTile(ply_wx, ply_wy)
	if tile == 0 then
		return
	end

	local tile_nfo = ConnJam.Tiles[tile]
	if not tile_nfo then
		return
	end

	if tile_nfo.touch_call then
		tile_nfo.touch_call(ply_wx, ply_wy)
	end
end


function ConnJam.RenderPlayer()
	local curr_anim_nfo = ply_animTextures[ConnJam.Player.anim_state]
	local curr_quad = ply_quads[curr_anim_nfo.tex]

	if curr_anim_nfo.persist then
		ConnJam.Player.anim_frame = math.min(math.floor(ConnJam.Player.anim_time * curr_anim_nfo.rate), curr_anim_nfo.len - 1)
	else
		ConnJam.Player.anim_frame = math.floor((ConnJam.Player.anim_time * curr_anim_nfo.rate) % curr_anim_nfo.len)
	end
	curr_quad:setViewport(ConnJam.Player.anim_frame * ply_animscl, 0, ply_animscl, ply_animscl)


	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(
		Textures[curr_anim_nfo.tex].img,
		curr_quad,
		ConnJam.Player.x + (ConnJam.Player.anim_flip and ply_animscl or 0),
		ConnJam.Player.y,
		0,
		(PLAYER_SIZE_X / ply_animscl) * (ConnJam.Player.anim_flip and -1 or 1),
		PLAYER_SIZE_Y / ply_animscl
	)


	--[[
	love.graphics.setColor(1, 0, 0, .5)
	love.graphics.rectangle("fill", ConnJam.Player.x, ConnJam.Player.y, PLAYER_SIZE_X, PLAYER_SIZE_Y)

	love.graphics.setColor(1, 0, 0, 1)
	love.graphics.setLineWidth(2)
	love.graphics.rectangle("line", ConnJam.Player.x, ConnJam.Player.y, PLAYER_SIZE_X, PLAYER_SIZE_Y)


	love.graphics.setColor(0, 1, 0, .5)
	love.graphics.rectangle("fill", ConnJam.Player.x, ConnJam.Player.y + PLAYER_SIZE_Y, PLAYER_SIZE_X, 4 + math.max(ConnJam.Player.vely / (TILE_SIZE * .85), 0))

	love.graphics.setColor(0, 1, 0, 1)
	love.graphics.setLineWidth(2)
	love.graphics.rectangle("line", ConnJam.Player.x, ConnJam.Player.y + PLAYER_SIZE_Y, PLAYER_SIZE_X, 4 + math.max(ConnJam.Player.vely / (TILE_SIZE * .85), 0))

	local ply_wx = math.floor((ConnJam.Player.x + (PLAYER_SIZE_X / 2)) / TILE_SIZE)
	local ply_wy = math.floor((ConnJam.Player.y + (PLAYER_SIZE_Y / 2)) / TILE_SIZE)


	love.graphics.setColor(1, 1, 0, .25)
	love.graphics.rectangle("fill", ply_wx * TILE_SIZE, ply_wy * TILE_SIZE, TILE_SIZE, TILE_SIZE)
	]]--
end