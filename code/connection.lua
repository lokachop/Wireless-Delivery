local function printTable(tblpointer)
	print("---------")
	for k, v in pairs(tblpointer) do
		print(k, v)
	end
end

local function sqrdist(x1, y1, x2, y2)
	return ((x2 - x1) ^ 2) + ((y2 - y1) ^ 2)
end

local function dist(x1, y1, x2, y2)
	return math.sqrt(((x2 - x1) ^ 2) + ((y2 - y1) ^ 2))
end

local function map2vis(x, y)
	return (x * TILE_SIZE) + TILE_SIZE / 2, (y * TILE_SIZE) + TILE_SIZE / 2
end



function ConnJam.GetPowerfulTower(x, y)
	local la_low = math.huge
	local low_id = nil
	for k, v in ipairs(ConnJam.MapEmitters) do
		local sq_dist = sqrdist(x, y, map2vis(v.x, v.y)) * (v.emitmult or 1)
		if sq_dist < la_low then
			low_id = k
			la_low = sq_dist
		end
	end

	return low_id, la_low
end


function ConnJam.GetConnectivityAtPoint(x, y)
	local highest_conn = 0
	local target_tower = 0

	for k, v in ipairs(ConnJam.MapEmitters) do
		local visx, visy = map2vis(v.x, v.y)

		local towerdist = (sqrdist(x, y, visx, visy) / (v.emitmult or 1)) / TILE_SIZE
		local d_strength = math.max(CONNECTION_RANGE - towerdist, 0)


		local items, len = ConnJam.MapBumpWorld:querySegment(x, y, visx, visy)
		for i = 1, len do
			local itm = items[i]
			if itm.notrace then
				goto _continue
			end

			d_strength = d_strength - (CONNECTION_RANGE * (itm.occlusion / 2))
			::_continue::
		end

		if d_strength > highest_conn then
			highest_conn = d_strength
			target_tower = k
		end
	end

	if highest_conn <= 0 then
		target_tower = 0
	end

	return highest_conn, target_tower
end


function ConnJam.DebugDrawTraces()
	love.graphics.setColor(.25, 1, .25)
	love.graphics.setLineWidth(8)

	local _, tower = ConnJam.GetConnectivityAtPoint(ConnJam.Player.x + (PLAYER_SIZE_X / 2), ConnJam.Player.y)


	for k, v in ipairs(ConnJam.MapEmitters) do
		if k == tower then
			love.graphics.setColor(.25, 1, .25)
		else
			love.graphics.setColor(1, .25, .25)
		end

		local visx, visy = map2vis(v.x, v.y)

		love.graphics.line(ConnJam.Player.x + (PLAYER_SIZE_X / 2), ConnJam.Player.y, visx, visy)
	end
end




