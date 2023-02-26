-- map editor
MapEdit = {}
MapEdit.TileToPlace = 2
MapEdit.TargetBackground = false
MapEdit.HasTilePaletteOpen = false


local function printTable(tblpointer)
	print("---------")
	for k, v in pairs(tblpointer) do
		print(k, v)
	end
end



function MapEdit.ToggleTilePalette()
	MapEdit.HasTilePaletteOpen = not MapEdit.HasTilePaletteOpen
end

-- yummy yummy paracetamol keeps the problems away

local tile_quads = {}


function MapEdit.DrawTile(id, xc, yc)
	local tile_props = ConnJam.Tiles[id]
	if not tile_props then
		return
	end

	if not tile_quads[id] then
		tile_quads[id] = love.graphics.newQuad(tile_props.canvas_x, tile_props.canvas_y, TILE_SIZE, TILE_SIZE, ConnJam.TexAtlasImg)
	end

	love.graphics.draw(ConnJam.TexAtlasImg, tile_quads[id], xc, yc)
end


function MapEdit.SetTile(xc, yc, id)
	id = id or 0
	local c_map = ConnJam.CurrMap

	if MapEdit.TargetBackground then
		if not ConnJam.MapBackgrounds[c_map] then
			ConnJam.MapBackgrounds[c_map] = {}
		end

		if not ConnJam.MapBackgrounds[c_map][yc] then
			ConnJam.MapBackgrounds[c_map][yc] = {}
		end

		ConnJam.MapBackgrounds[c_map][yc][xc] = id
	else
		if not ConnJam.Maps[c_map] then
			ConnJam.Maps[c_map] = {}
		end

		if not ConnJam.Maps[c_map][yc] then
			ConnJam.Maps[c_map][yc] = {}
		end

		ConnJam.Maps[c_map][yc][xc] = id
	end
end

function MapEdit.DrawTilePalette()
	if not MapEdit.HasTilePaletteOpen then
		return
	end

	local w, h = love.graphics.getDimensions()
	local w_sub = w - (TILE_SIZE / 2)

	love.graphics.setColor(.25, .25, .25, 1)
	local t_count = 0
	for k, v in pairs(ConnJam.Tiles) do
		t_count = t_count + 1
	end

	love.graphics.rectangle("fill", 0, 0, w, (((t_count * TILE_SIZE) / w_sub) + 1) * TILE_SIZE)


	local c_tile = 0
	local tiles_per_row = w_sub / TILE_SIZE
	for k, v in pairs(ConnJam.Tiles) do
		local tile_props = v

		local xc = (c_tile % tiles_per_row) * TILE_SIZE
		local yc = (math.floor(c_tile / tiles_per_row)) * TILE_SIZE

		love.graphics.setColor(1, 1, 1, 1)
		MapEdit.DrawTile(k, xc, yc)


		love.graphics.setColor(0, xc / w, yc / h, 1)
		love.graphics.setLineWidth(4)
		love.graphics.rectangle("line", xc, yc, TILE_SIZE, TILE_SIZE)


		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.print(k, xc, yc)
		love.graphics.printf("[" .. tile_props.c_name .. "]", xc, yc + 14, TILE_SIZE)

		c_tile = c_tile + 1
	end

	local mx, my = love.mouse.getPosition()


	love.graphics.setColor(1, 1, 1, .25)

	local xc = math.floor(mx / TILE_SIZE)
	local yc = math.floor(my / TILE_SIZE)

	love.graphics.rectangle("fill", xc * TILE_SIZE, yc * TILE_SIZE, TILE_SIZE, TILE_SIZE)
end

function MapEdit.GetTileAtPosition(x, y)
	local w, _ = love.graphics.getDimensions()
	local w_sub = w - (TILE_SIZE / 2)
	local c_tile = 0
	local tiles_per_row = w_sub / TILE_SIZE
	for k, v in pairs(ConnJam.Tiles) do
		local xc = (c_tile % tiles_per_row)
		local yc = (math.floor(c_tile / tiles_per_row))

		if x == xc and y == yc then
			return k
		end


		c_tile = c_tile + 1
	end
end


function MapEdit.SelectTilePalette(mx, my)
	local xc = math.floor(mx / TILE_SIZE)
	local yc = math.floor(my / TILE_SIZE)

	local tile = MapEdit.GetTileAtPosition(xc, yc)
	if not tile then
		return
	end

	print("Selected; " .. tile)
	MapEdit.TileToPlace = tile
end



function MapEdit.SelectTile()
	print("----ENTER A TILE----")
	local tile = io.read()
	local num = tonumber(tile)
	if not num then
		return
	end

	local tile_nfo = ConnJam.Tiles[num]
	if not tile_nfo then
		return
	end

	MapEdit.TileToPlace = tile
	print("Selected tile " .. tile)
	print("aka. " .. tile_nfo.c_name)
end

function MapEdit.GetCursorPos()
	local w, h = love.graphics.getDimensions()
	local cx, cy = love.mouse.getPosition()


	w = w / ConnJam.Camera.scl
	h = h / ConnJam.Camera.scl
	cx = cx / ConnJam.Camera.scl
	cy = cy / ConnJam.Camera.scl

	cx = cx + ConnJam.Camera.x - (w / 2)
	cy = cy + ConnJam.Camera.y - (h / 2)

	-- now to map
	local mapx = math.floor(cx / TILE_SIZE)
	local mapy = math.floor(cy / TILE_SIZE)

	return mapx, mapy
end


function MapEdit.MoveMapEditor(dt)
	if love.keyboard.isDown("a") then
		ConnJam.Camera.x = ConnJam.Camera.x - (dt * 512)
	end

	if love.keyboard.isDown("d") then
		ConnJam.Camera.x = ConnJam.Camera.x + (dt * 512)
	end

	if love.keyboard.isDown("w") then
		ConnJam.Camera.y = ConnJam.Camera.y - (dt * 512)
	end

	if love.keyboard.isDown("s") then
		ConnJam.Camera.y = ConnJam.Camera.y + (dt * 512)
	end

	if love.keyboard.isDown("kp8") then
		ConnJam.Camera.scl = math.max(ConnJam.Camera.scl - (dt * ConnJam.Camera.scl), .25)
	end

	if love.keyboard.isDown("kp5") then
		ConnJam.Camera.scl = math.min(ConnJam.Camera.scl + (dt * ConnJam.Camera.scl), 4)
	end
end

function MapEdit.EditorKeybinds(key, scancode, isrepeat)
	if scancode == "n" then
		MapEdit.ExportMap()
	end

	--if scancode == "b" then
	--	MapEdit.SelectTile()
	--end

	if scancode == "tab" then
		print("Toggling tile palette")
		MapEdit.ToggleTilePalette()
	end

	if scancode == "r" then
		MapEdit.TargetBackground = not MapEdit.TargetBackground
	end
end

function MapEdit.EditorMouse(x, y, button, istouch, presses)
	if MapEdit.HasTilePaletteOpen then
		if button == 1 then
			MapEdit.SelectTilePalette(x, y)
		end
	else
		local cx, cy = MapEdit.GetCursorPos()
		if button == 1 then
			MapEdit.SetTile(cx, cy, MapEdit.TileToPlace)
		elseif button == 2 then
			MapEdit.SetTile(cx, cy, 0)
		end
	end
end





function MapEdit.RenderCursor()
	local mapx, mapy = MapEdit.GetCursorPos()


	local xc, yc = mapx * TILE_SIZE, mapy * TILE_SIZE
	-- draw the selected tile

	love.graphics.setColor(1, 1, 1, .35)
	MapEdit.DrawTile(MapEdit.TileToPlace, xc, yc)


	if MapEdit.TargetBackground then
		love.graphics.setColor(1, 1, 0, .25)
	else
		love.graphics.setColor(0, 1, 0, .25)
	end
	love.graphics.rectangle("fill", xc, yc, TILE_SIZE, TILE_SIZE)

	love.graphics.setLineWidth(2)
	love.graphics.rectangle("line", xc, yc, TILE_SIZE, TILE_SIZE)

end



local function recursive_tbl_copy(tblpointer)
	local new = {}
	for k, v in pairs(tblpointer) do
		if type(v) ~= "table" then
			new[k] = v
		else
			new[k] = recursive_tbl_copy(v)
		end
	end
	return new
end

local function getTileMapStr(callstr, tblpointer, wide_shift)
	-- make sure negatives get inserted
	local lowest_var = 1
	for k, v in pairs(tblpointer) do
		if k < lowest_var then
			lowest_var = k
		end
	end

	-- out-of-bounds
	if lowest_var ~= 1 then
		local delta_to_shift = (-lowest_var) + 1
		print("have to shift...; " .. delta_to_shift)
		local tbl_shift = {}
		-- shift table
		for k, v in pairs(tblpointer) do
			tbl_shift[k + delta_to_shift] = v
		end


		tblpointer = tbl_shift
	end

	-- analyze and find dimensions
	local greatest_w = -999999
	for k, v in pairs(tblpointer) do

		for k2, v2 in pairs(v) do
			if k2 > greatest_w then
				greatest_w = k2
			end
		end
	end

	print(greatest_w .. " WIDE")



	local tbl_concat = {}
	local last_k = 0
	for k, v in pairs(tblpointer) do
		if (k - last_k) ~= 1 then
			local delta_missing = k - last_k
			print("MISSING " .. delta_missing .. " TALL!")
			for i = 1, delta_missing do
				local subtbl_concat = {}
				for j = 1, greatest_w do
					subtbl_concat[#subtbl_concat + 1] = "  0"
				end
				tbl_concat[#tbl_concat + 1] = "{" .. table.concat(subtbl_concat, ",") .. "}"
			end
		end


		local subtbl_concat = {}
		for i = 1, greatest_w do
			subtbl_concat[i] = "  0"
		end

		for i = 1, wide_shift do
			subtbl_concat[i] = "  0"
		end

		for k2, v2 in pairs(v) do
			subtbl_concat[k2 + wide_shift] = string.rep(" ", v2 < 10 and 2 or (v2 < 100 and 1 or 0)) .. tostring(v2)
		end
		--[[
		if #subtbl_concat < greatest_w then
			local delta_missing = greatest_w - #subtbl_concat
			print("MISSING " .. delta_missing .. " WIDE!")
			for i = 1, delta_missing do
				subtbl_concat[#subtbl_concat + 1] = "  0"
			end
		end
		]]--

		local sub_cnt = 0
		for _, _ in pairs(subtbl_concat) do
			sub_cnt = sub_cnt + 1
		end

		if #subtbl_concat ~= sub_cnt then
			print("count neq")

			print(#subtbl_concat - sub_cnt)
		end




		tbl_concat[#tbl_concat + 1] = "{" .. table.concat(subtbl_concat, ",") .. "}"
		last_k = k
	end

	return callstr .. "(\"" .. ConnJam.CurrMap .. "\", {\n\t" .. table.concat(tbl_concat, ",\n\t") .. "\n})"

end

function MapEdit.ExportMap()
	-- make sure negatives get inserted
	local lowest_var = 1
	for k, v in pairs(ConnJam.Maps[ConnJam.CurrMap]) do
		if k < lowest_var then
			lowest_var = k
		end
	end

	if ConnJam.MapBackgrounds[ConnJam.CurrMap] then
		for k, v in pairs(ConnJam.MapBackgrounds[ConnJam.CurrMap]) do
			if k < lowest_var then
				lowest_var = k
			end
		end
	end

	-- out-of-bounds
	if lowest_var ~= 1 then
		local delta_to_shift = (-lowest_var) + 1
		print("have to shift...; " .. delta_to_shift)
		local tbl_shift = {}
		-- shift table
		for k, v in pairs(ConnJam.Maps[ConnJam.CurrMap]) do
			tbl_shift[k + delta_to_shift] = v
		end

		if ConnJam.MapBackgrounds[ConnJam.CurrMap] then
			local tbl_shift_bg = {}
			for k, v in pairs(ConnJam.MapBackgrounds[ConnJam.CurrMap]) do
				tbl_shift_bg[k + delta_to_shift] = v
			end
			ConnJam.MapBackgrounds[ConnJam.CurrMap] = tbl_shift_bg
		end

		ConnJam.Maps[ConnJam.CurrMap] = tbl_shift
	end


	local wide_shift_map = 0
	for k, v in pairs(ConnJam.Maps[ConnJam.CurrMap]) do
		for k2, v2 in pairs(v) do
			if v2 ~= 0 and k2 < 1 then
				local v_calc = math.abs(k2) + 1
				if v_calc > wide_shift_map then
					wide_shift_map = v_calc
				end
			end
		end
	end

	local wide_shift_final = wide_shift_map

	if ConnJam.MapBackgrounds[ConnJam.CurrMap] then
		local wide_shift_background = 0
		for k, v in pairs(ConnJam.MapBackgrounds[ConnJam.CurrMap]) do
			for k2, v2 in pairs(v) do
				if v2 ~= 0 and k2 < 1 then
					local v_calc = math.abs(k2) + 1
					if v_calc > wide_shift_background then
						wide_shift_background = v_calc
					end
				end
			end
		end

		if wide_shift_background > wide_shift_final then
			wide_shift_final = wide_shift_background
		end
	end


	local f_concat = {}
	f_concat[1] = getTileMapStr("ConnJam.DeclareMap", ConnJam.Maps[ConnJam.CurrMap], wide_shift_final)

	if ConnJam.MapBackgrounds[ConnJam.CurrMap] then
		f_concat[2] = getTileMapStr("ConnJam.DeclareMapBackground", ConnJam.MapBackgrounds[ConnJam.CurrMap], wide_shift_final)
	end

	local f_str = table.concat(f_concat, "\n\n----helloooooo----\n\n")

	love.filesystem.write("wireless_delivery_map_" .. ConnJam.CurrMap .. ".txt", f_str)
	print("Exported \"" .. ConnJam.CurrMap .. "\" successfully!")
end



function MapEdit.RenderInfo()
	local w = love.graphics.getDimensions()
	love.graphics.setColor(1, 1, 1, 1)

	love.graphics.print("MAP EDITOR!!", 0, 0)
	love.graphics.print("Seams and lag will be gone on compile", 0, 14)
	love.graphics.print("mapname; " .. ConnJam.CurrMap .. "", 0, 28)

	local cx, cy = MapEdit.GetCursorPos()
	love.graphics.print("cursorpos; " .. cx .. ", " .. cy, 0, 42)

	local selec_nfo = ConnJam.Tiles[MapEdit.TileToPlace]
	local selec_name = selec_nfo and selec_nfo.c_name or "none/empty"
	love.graphics.print("selected tile; " .. MapEdit.TileToPlace .. " [" .. selec_name .. "]", 0, 56)



	love.graphics.print("targetting; " .. (MapEdit.TargetBackground and "Background" or "Foreground"), 0, 70)


	-- keybinds
	love.graphics.printf("keybinds", 0, 0, w, "center")
	love.graphics.printf("n = export map", 0, 14, w, "center")
	love.graphics.printf("tab = toggle tile palette", 0, 28, w, "center")
	love.graphics.printf("r = toggle target background", 0, 42, w, "center")
	love.graphics.printf("wasd = move", 0, 56, w, "center")
	love.graphics.printf("kp8 / kp5 = zoom", 0, 70, w, "center")




	MapEdit.DrawTile(MapEdit.TileToPlace, w - TILE_SIZE - 8, 8)
end

function MapEdit.RenderMapUnefficient()
	love.graphics.setColor(1, 1, 1, 1)

	if ConnJam.MapBackgrounds[ConnJam.CurrMap] then
		for k, v in pairs(ConnJam.MapBackgrounds[ConnJam.CurrMap]) do
			for k2, v2 in pairs(v) do
				if not v2 then
					goto _continue2
				end

				local tile_props = ConnJam.Tiles[v2]
				if not tile_props then
					goto _continue2
				end

				MapEdit.DrawTile(v2, k2 * TILE_SIZE, k * TILE_SIZE)
				::_continue2::
			end
		end
	end


	for k, v in pairs(ConnJam.Maps[ConnJam.CurrMap]) do
		for k2, v2 in pairs(v) do
			if not v2 then
				goto _continue
			end

			local tile_props = ConnJam.Tiles[v2]
			if not tile_props then
				goto _continue
			end

			local x, y = k2, k
			MapEdit.DrawTile(v2, x * TILE_SIZE, y * TILE_SIZE)

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

				love.graphics.setColor(0, 0, 1, .35)
				love.graphics.rectangle("fill", hx, hy, hw, hh)

				love.graphics.setLineWidth(2)
				love.graphics.rectangle("line", hx, hy, hw, hh)
				love.graphics.setColor(1, 1, 1, 1)
			end

			if tile_props.emitter then
				love.graphics.setColor(1, 0, 1, .35)
				love.graphics.rectangle("fill", x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE)

				love.graphics.setLineWidth(2)
				love.graphics.rectangle("line", x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE)


				if tile_props.emitmult then
					love.graphics.setColor(1, 0, 1, 1)
					love.graphics.print("E: x" .. tile_props.emitmult, x * TILE_SIZE, y * TILE_SIZE)
				end


				love.graphics.setColor(1, 1, 1, 1)
			end


			::_continue::
		end
	end
end