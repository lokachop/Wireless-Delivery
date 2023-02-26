local bump = require("bump")
ConnJam.Maps = {}
ConnJam.MapBackgrounds = {}
ConnJam.MapExRenders = {}


local math = math
local math_floor = math.floor

function ConnJam.DeclareMap(name, data)
	ConnJam.Maps[name] = data
end

function ConnJam.DeclareMapBackground(name, data)
	ConnJam.MapBackgrounds[name] = data
end

function ConnJam.DeclareMapExtraRender(name, func)
	ConnJam.MapExRenders[name] = func
end

function ConnJam.RenderMapEx()
	if ConnJam.MapExRenders[ConnJam.CurrMap] then
		ConnJam.MapExRenders[ConnJam.CurrMap]()
	end
end



-- tile 99 = player start
ConnJam.DeclareMap("test", {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{ 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0},
	{ 0, 0, 0, 0, 0, 0, 0,18, 0, 0, 0, 0, 0, 0, 0, 0, 0,18, 0, 0, 0},
	{ 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0},
	{ 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 2, 2, 2, 2, 0, 3, 0, 0, 0},
	{ 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0},
	{ 0,99, 0, 0, 0, 0,47, 3, 0, 1, 9, 0, 0, 0, 0, 0,97, 3, 0,98, 0},
	{25,25,25,19,21,23,25,25,25,25,25,23,25,25,25,27,25,23,25,29,25},
	{26,26,26,20,22,26,26,26,28,26,26,26,26,26,24,26,26,26,26,26,26},
	{46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46},
})
ConnJam.DeclareMapBackground("test", {
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0,44,43,43,43,45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0,34,33,33,33,35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0,37,33,36,33,38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0,34,33,33,33,35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0,37,33,36,33,38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0,34,33,33,33,35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0,31,30,42,30,32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
})

-- tiles are 24 x 24
ConnJam.MapBumpWorld = bump.newWorld(24 * 4)
ConnJam.MapBumpTiles = {}
ConnJam.MapEmitters = {}


function ConnJam.ClearMapCollision()
	for i = 1, #ConnJam.MapBumpTiles do
		local v = ConnJam.MapBumpTiles[i]
		ConnJam.MapBumpWorld:remove(v)
		ConnJam.MapBumpTiles[i] = nil
	end
end


ConnJam.CurrMap = "none"
ConnJam.ActiveMap = {}

--ConnJam.ActiveMap
function ConnJam.GetMapTile(x, y)
	return ConnJam.ActiveMap[math_floor(x) + (math_floor(y - 1) * ConnJam.MapW)] or 0
end

function ConnJam.RemoveMapTile(x, y)
	local tid = math_floor(x) + (math_floor(y - 1) * ConnJam.MapW)

	local tile = ConnJam.ActiveMap[tid]
	if not tile then
		return
	end

	local tile_props = ConnJam.Tiles[tile]
	if not tile_props then
		return
	end


	if tile_props.solid then
		for k, v in ipairs(ConnJam.MapBumpTiles) do
			if v.x == x and v.y == y then
				ConnJam.MapBumpWorld:remove(v)
				table.remove(ConnJam.MapBumpTiles, k)
				break
			end
		end
	end

	ConnJam.ActiveMap[tid] = 0

	if tile_props.emitter then
		for k, v in ipairs(ConnJam.MapEmitters) do
			if v.x == x and v.y == y then
				table.remove(ConnJam.MapEmitters, k)
				break
			end
		end
	end
end

function ConnJam.SetMapTile(x, y, to)
	local tid = math_floor(x) + (math_floor(y - 1) * ConnJam.MapW)

	local tile = ConnJam.ActiveMap[tid]
	if not tile then
		return
	end

	if tile == to then
		return
	end

	ConnJam.RemoveMapTile(x, y)


	local tile_props = ConnJam.Tiles[to]
	if not tile_props then
		return
	end

	if tile_props.solid then
		local hx = x * TILE_SIZE
		local hy = y * TILE_SIZE
		local hw = TILE_SIZE
		local hh = TILE_SIZE
		if tile_props.custom_hull then
			hx = hx + tile_props.custom_hull.ox
			hy = hy + tile_props.custom_hull.oy
			hw = tile_props.custom_hull.w
			hh = tile_props.custom_hull.h
		end


		ConnJam.MapBumpTiles[#ConnJam.MapBumpTiles + 1] = {occlusion = tile_props.occludefactor or 0, x = x, y = y}
		ConnJam.MapBumpWorld:add(ConnJam.MapBumpTiles[#ConnJam.MapBumpTiles], hx, hy, hw, hh)
	end


	if tile_props.emitter then
		ConnJam.MapEmitters[#ConnJam.MapEmitters + 1] = {x = x, y = y, mult = tile_props.emitmult}
	end


	ConnJam.ActiveMap[tid] = to

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setCanvas(ConnJam.MapCanvas)
		love.graphics.setScissor(x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE)
		love.graphics.clear(0, 0, 0, 0)
		love.graphics.setScissor()

		local quad = love.graphics.newQuad(tile_props.canvas_x, tile_props.canvas_y, TILE_SIZE, TILE_SIZE, ConnJam.TexAtlasImg)
		love.graphics.draw(ConnJam.TexAtlasImg, quad, x * TILE_SIZE, y * TILE_SIZE)
	love.graphics.setCanvas()

	ConnJam.MapCanvasImg = love.graphics.newImage(ConnJam.MapCanvas:newImageData())
	ConnJam.MapCanvasImg:setFilter("nearest", "nearest")
end



ConnJam.MapCanvas = nil
ConnJam.MapCanvasImg = nil

ConnJam.MapCanvasBg = nil
ConnJam.MapCanvasBgImg = nil

function ConnJam.LoadMap(name)
	if not ConnJam.Maps[name] then
		error("Map \"" .. name .. "\" doesnt exist!")
	end
	ConnJam.CurrMap = name
	print("Loading map \"" .. name .. "\"")

	-- friendly reminder to self to make sure map is actually even
	ConnJam.MapW = #ConnJam.Maps[name][#ConnJam.Maps[name]]
	ConnJam.MapH = #ConnJam.Maps[name]


	love.graphics.setColor(1, 1, 1, 1)
	ConnJam.MapCanvas = love.graphics.newCanvas((ConnJam.MapW + 1) * TILE_SIZE, (ConnJam.MapH + 1) * TILE_SIZE)
	ConnJam.MapCanvas:setFilter("nearest", "nearest")
	ConnJam.MapCanvasBg = love.graphics.newCanvas((ConnJam.MapW + 1) * TILE_SIZE, (ConnJam.MapH + 1) * TILE_SIZE)
	ConnJam.MapCanvasBg:setFilter("nearest", "nearest")


	ConnJam.MapEmitters = {}
	ConnJam.ActiveMap = {}

	-- do bg first
	if ConnJam.MapBackgrounds[name] then
		print("Background Exists!")
		--local bg_mapw = #ConnJam.MapBackgrounds[name][#ConnJam.MapBackgrounds[name]]
		--local bg_maph = #ConnJam.MapBackgrounds[name]

		love.graphics.setCanvas(ConnJam.MapCanvasBg)
		for k, v in ipairs(ConnJam.MapBackgrounds[name]) do
			for k2, v2 in ipairs(v) do
				if v2 == 0 then -- void, do nothing
					goto _continue3
				end


				local tile_props = ConnJam.Tiles[v2]
				if not tile_props then
					error("MAPINIT ERROR! (no t_prop for [" .. v2 .. "] on map \"" .. name .. "\" BACKGROUND)")
				end

				local xc = k2 * TILE_SIZE
				local yc = k * TILE_SIZE

				local quad = love.graphics.newQuad(tile_props.canvas_x, tile_props.canvas_y, TILE_SIZE, TILE_SIZE, ConnJam.TexAtlasImg)
				love.graphics.draw(ConnJam.TexAtlasImg, quad, xc, yc)
				::_continue3::
			end
		end
		love.graphics.setCanvas()
	end


	ConnJam.ClearMapCollision()


	for k, v in ipairs(ConnJam.Maps[name]) do
		for k2, v2 in ipairs(v) do
			ConnJam.ActiveMap[#ConnJam.ActiveMap + 1] = v2

			if v2 == 0 then -- void, do nothing
				goto _continue
			end

			local tile_props = ConnJam.Tiles[v2]
			if not tile_props then
				error("MAPINIT ERROR! (no t_prop for [" .. v2 .. "] on map \"" .. name .. "\")")
			end

			if tile_props.init_call then
				local fine, err = pcall(tile_props.init_call, k2, k)
				if not fine then
					error("MAPINIT ERROR!\n" .. err)
				end
			end

			if tile_props.emitter then
				ConnJam.MapEmitters[#ConnJam.MapEmitters + 1] = {x = k2, y = k, mult = tile_props.emitmult}
			end


			if tile_props.solid then
				local hx = k2 * TILE_SIZE
				local hy = k * TILE_SIZE
				local hw = TILE_SIZE
				local hh = TILE_SIZE
				if tile_props.custom_hull then
					hx = hx + tile_props.custom_hull.ox
					hy = hy + tile_props.custom_hull.oy
					hw = tile_props.custom_hull.w
					hh = tile_props.custom_hull.h
				end

				ConnJam.MapBumpTiles[#ConnJam.MapBumpTiles + 1] = {
					occlusion = tile_props.occludefactor or 0,
					x = k2,
					y = k,
					no_playercoll = tile_props.no_playercoll or false,
					col_onlytop = tile_props.col_onlytop or false
				}
				ConnJam.MapBumpWorld:add(ConnJam.MapBumpTiles[#ConnJam.MapBumpTiles], hx, hy, hw, hh)
			end

			::_continue::
		end
	end

	-- build the vis map
	love.graphics.setCanvas(ConnJam.MapCanvas)
	for k, v in ipairs(ConnJam.ActiveMap) do
		if v == 0 then -- void, do nothing
			goto _continue2
		end

		local t_prop = ConnJam.Tiles[v]
		if not t_prop then
			error("MAPINIT ERROR! (no t_prop vis_build [" .. v .. "] on map \"" .. name .. "\")")
		end

		local xc = ((k - 1) % ConnJam.MapW) + 1
		local yc = math_floor((k - 1) / ConnJam.MapW) + 1

		if t_prop.visible then
			local quad = love.graphics.newQuad(t_prop.canvas_x, t_prop.canvas_y, TILE_SIZE, TILE_SIZE, ConnJam.TexAtlasImg)
			love.graphics.draw(ConnJam.TexAtlasImg, quad, xc * TILE_SIZE, yc * TILE_SIZE)
		end

		::_continue2::
	end
	love.graphics.setCanvas()

	ConnJam.MapCanvasImg = love.graphics.newImage(ConnJam.MapCanvas:newImageData())
	ConnJam.MapCanvasImg:setFilter("nearest", "nearest")

	ConnJam.MapCanvasBgImg = love.graphics.newImage(ConnJam.MapCanvasBg:newImageData())
	ConnJam.MapCanvasBgImg:setFilter("nearest", "nearest")


	print("map is " .. ConnJam.MapW .. "x" .. ConnJam.MapH)
	print(#ConnJam.MapEmitters .. (#ConnJam.MapEmitters == 1 and " emitter.." or " emitters.."))


	--begin the timer
	ConnJam.BeginTimer()
	ConnJam.BeginTimerTaken()


	ConnJam.PlayMapSong()
	ConnJam.SetPlayerConnectivity(CONNECTION_RANGE)
end


function ConnJam.RenderMap()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(ConnJam.MapCanvasImg)


	--[[
	for k, v in ipairs(ConnJam.Dev_PhysObj) do
		love.graphics.setColor(0, 0, 1, .25)
		love.graphics.rectangle("fill", v.x, v.y, v.w, v.h)

		love.graphics.setColor(0, 0, 1, 1)
		love.graphics.setLineWidth(2)
		love.graphics.rectangle("line", v.x, v.y, v.w, v.h)
	end
	]]--
end

function ConnJam.RenderMapBackground()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(ConnJam.MapCanvasBgImg)
end