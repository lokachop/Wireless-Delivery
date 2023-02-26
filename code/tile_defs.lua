ConnJam.Tiles = {}


function ConnJam.DeclareTile(id, props)
	ConnJam.Tiles[id] = props
end

ConnJam.DeclareTile(1, {
	mat_nm = "brick8.png",
	c_name = "brick",
	occludefactor = .25,
	solid = true,
	visible = true
})


ConnJam.DeclareTile(2, {
	mat_nm = "brick8.png",
	c_name = "building_wall",
	occludefactor = .1,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(3, {
	mat_nm = "steel_pole.png",
	c_name = "steel_pole",
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(4, {
	mat_nm = "antenna_off.png",
	c_name = "antennae_off",
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(5, {
	mat_nm = "antenna_on.png",
	c_name = "antennae_on",
	occludefactor = 0,
	solid = false,
	visible = true,
	emitter = true,
	emitmult = 1
})

ConnJam.DeclareTile(6, {
	mat_nm = "dirt.png",
	c_name = "dirt",
	occludefactor = .1,
	solid = true,
	visible = true,
	emitter = false,
})

ConnJam.DeclareTile(7, {
	mat_nm = "dirt.png",
	c_name = "dirt_nocoll",
	occludefactor = 0,
	solid = false,
	visible = true,
	emitter = false,
})

ConnJam.DeclareTile(8, {
	mat_nm = "concrete_floor.png",
	c_name = "concreet",
	occludefactor = .5,
	solid = true,
	visible = true,
	emitter = false,
})

ConnJam.DeclareTile(9, {
	mat_nm = "concrete_floor.png",
	c_name = "custom_hull",
	occludefactor = 0,
	solid = true,
	visible = true,
	emitter = false,
	custom_hull = {
		ox = 0,
		oy = TILE_SIZE / 2,
		w = TILE_SIZE,
		h = TILE_SIZE / 2
	},
})

ConnJam.DeclareTile(10, {
	mat_nm = "building_1.png",
	c_name = "building_1",
	occludefactor = 0,
	solid = true,
	visible = true,
	emitter = false,
})

ConnJam.DeclareTile(11, {
	mat_nm = "building_2.png",
	c_name = "building_2",
	occludefactor = 0,
	solid = true,
	visible = true,
	emitter = false,
})

ConnJam.DeclareTile(12, {
	mat_nm = "building_3.png",
	c_name = "building_3",
	occludefactor = 0,
	solid = true,
	visible = true,
	emitter = false,
})

ConnJam.DeclareTile(13, {
	mat_nm = "building_4.png",
	c_name = "building_4",
	occludefactor = 0,
	solid = true,
	visible = true,
	emitter = false,
})

ConnJam.DeclareTile(14, {
	mat_nm = "building_5.png",
	c_name = "building_5",
	occludefactor = 0,
	solid = true,
	visible = true,
	emitter = false,
})

ConnJam.DeclareTile(15, {
	mat_nm = "building_6.png",
	c_name = "building_6",
	occludefactor = 0,
	solid = true,
	visible = true,
	emitter = false,
})

ConnJam.DeclareTile(16, {
	mat_nm = "building_7.png",
	c_name = "building_7",
	occludefactor = 0,
	solid = true,
	visible = true,
	emitter = false,
})

ConnJam.DeclareTile(17, {
	mat_nm = "concrete_floor2.png",
	c_name = "concreeewat",
	occludefactor = .5,
	solid = false,
	visible = true,
	emitter = false,
})

ConnJam.DeclareTile(18, {
	mat_nm = "5g_pole.png",
	c_name = "5g_pole",
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(19, {
	mat_nm = "road_walk_path_left.png",
	c_name = "road_cross_left",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(20, {
	mat_nm = "road_walk_path_left.png",
	c_name = "road_cross_left_f",
	mat_flip = true,
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(21, {
	mat_nm = "road_walk_path_right.png",
	c_name = "road_cross_right",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(22, {
	mat_nm = "road_walk_path_right.png",
	c_name = "road_cross_right_f",
	mat_flip = true,
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(23, {
	mat_nm = "road_normal.png",
	c_name = "road_normal",
	occludefactor = 0,
	solid = true,
	visible = true,
})


ConnJam.DeclareTile(24, {
	mat_nm = "road_normal.png",
	c_name = "road_normal_fip",
	mat_flip = true,
	occludefactor = 0,
	solid = false,
	visible = true,
})


ConnJam.DeclareTile(25, {
	mat_nm = "road_normal2.png",
	c_name = "road_normal2",
	occludefactor = 0,
	solid = true,
	visible = true,
})


ConnJam.DeclareTile(26, {
	mat_nm = "road_normal2.png",
	c_name = "road_normal2_flip",
	mat_flip = true,
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(27, {
	mat_nm = "road_scar.png",
	c_name = "road_scar",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(28, {
	mat_nm = "road_scar.png",
	c_name = "road_scar_flip",
	mat_flip = true,
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(29, {
	mat_nm = "road_sandvich.png",
	c_name = "road_sandwich",
	occludefactor = 0,
	solid = true,
	visible = true,
})



ConnJam.DeclareTile(30, {
	mat_nm = "Brick_001.png",
	c_name = "brick1",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(31, {
	mat_nm = "Brick_001Left.png",
	c_name = "brick1l",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(32, {
	mat_nm = "Brick_001Right.png",
	c_name = "brick1r",
	occludefactor = 0,
	solid = true,
	visible = true,
})


ConnJam.DeclareTile(33, {
	mat_nm = "Brick_002.png",
	c_name = "brick2",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(34, {
	mat_nm = "Brick_002Left.png",
	c_name = "brick2l",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(35, {
	mat_nm = "Brick_002Right.png",
	c_name = "brick2r",
	occludefactor = 0,
	solid = true,
	visible = true,
})



ConnJam.DeclareTile(36, {
	mat_nm = "Brick_003C.png",
	c_name = "brick3c",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(37, {
	mat_nm = "Brick_003CLeft.png",
	c_name = "brick3cl",
	occludefactor = 0,
	solid = true,
	visible = true,
})


ConnJam.DeclareTile(38, {
	mat_nm = "Brick_003CRight.png",
	c_name = "brick3cr",
	occludefactor = 0,
	solid = true,
	visible = true,
})


ConnJam.DeclareTile(39, {
	mat_nm = "Brick_003.png",
	c_name = "brick3",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(40, {
	mat_nm = "Brick_003Left.png",
	c_name = "brick3l",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(41, {
	mat_nm = "Brick_003Right.png",
	c_name = "brick3r",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(42, {
	mat_nm = "Brick_004.png",
	c_name = "brick4",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(43, {
	mat_nm = "Brick_005.png",
	c_name = "brick5",
	occludefactor = .25,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(44, {
	mat_nm = "Brick_005Left.png",
	c_name = "brick5l",
	occludefactor = .25,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(45, {
	mat_nm = "Brick_005Right.png",
	c_name = "brick5r",
	occludefactor = .25,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(46, {
	mat_nm = "street_tile.png",
	c_name = "street_tile",
	occludefactor = 0,
	solid = false,
	visible = true,
})


ConnJam.DeclareTile(47, {
	mat_nm = "button_off.png",
	c_name = "buttontest",
	occludefactor = 0,
	solid = true,
	visible = true,
	touch_call = function(x, y)
		ConnJam.SetMapTile(3, 10, 5)
		ConnJam.SetMapTile(x, y, 48)
	end,
	custom_hull = {
		ox = 0,
		oy = TILE_SIZE * .725,
		w = TILE_SIZE,
		h = TILE_SIZE - (TILE_SIZE * .725)
	},
})

ConnJam.DeclareTile(48, {
	mat_nm = "button_on.png",
	c_name = "button_on",
	occludefactor = 0,
	solid = true,
	visible = true,
	custom_hull = {
		ox = 0,
		oy = TILE_SIZE * .825,
		w = TILE_SIZE,
		h = TILE_SIZE - (TILE_SIZE * .825)
	},
})


ConnJam.DeclareTile(49, {
	mat_nm = "fence_left_bottom.png",
	c_name = "fence_left_b",
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(50, {
	mat_nm = "fence_right_bottom.png",
	c_name = "fence_right_b",
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(51, {
	mat_nm = "fence_center_bottom.png",
	c_name = "fence_center_b",
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(52, {
	mat_nm = "trash.png",
	c_name = "trash_bucket",
	occludefactor = 0,
	solid = true,
	visible = true,
	custom_hull = {
		ox = TILE_SIZE * .2,
		oy = TILE_SIZE * .2,
		w = TILE_SIZE * .575,
		h = TILE_SIZE * .8
	},
})

ConnJam.DeclareTile(53, {
	mat_nm = "dumpster.png",
	c_name = "dumpster",
	occludefactor = 0,
	solid = true,
	visible = true,
	custom_hull = {
		ox = TILE_SIZE * .125,
		oy = TILE_SIZE * .45,
		w = TILE_SIZE * .75,
		h = TILE_SIZE * .55
	},
})


ConnJam.DeclareTile(54, {
	mat_nm = "concrete_pillar_wall.png",
	c_name = "concrete_pillar_wall",
	occludefactor = 0,
	solid = true,
	visible = true,
	custom_hull = {
		ox = TILE_SIZE * .25,
		oy = 0,
		w = TILE_SIZE * .5,
		h = TILE_SIZE
	},
})


ConnJam.DeclareTile(55, {
	mat_nm = "concrete_pillar_wall_mid.png",
	c_name = "concrete_pillar_wall_mid",
	occludefactor = 0,
	solid = true,
	visible = true,
	custom_hull = {
		ox = TILE_SIZE * .25,
		oy = 0,
		w = TILE_SIZE * .5,
		h = TILE_SIZE
	},
})

ConnJam.DeclareTile(56, {
	mat_nm = "concrete_pillar_wall_top.png",
	c_name = "concrete_pillar_wall_top",
	occludefactor = 0,
	solid = true,
	visible = true,
	custom_hull = {
		ox = TILE_SIZE * .25,
		oy = 0,
		w = TILE_SIZE * .5,
		h = TILE_SIZE
	},
})


ConnJam.DeclareTile(57, {
	mat_nm = "Brick_004_customer.png",
	c_name = "brick4_customer",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(58, {
	mat_nm = "Brick_006.png",
	c_name = "brick6_shopdoor",
	occludefactor = 0,
	solid = true,
	visible = true,
})

ConnJam.DeclareTile(59, {
	mat_nm = "Brick_007.png",
	c_name = "brick7_signl",
	occludefactor = 0,
	solid = true,
	visible = true,
})


ConnJam.DeclareTile(60, {
	mat_nm = "Brick_0072.png",
	c_name = "brick7_signr",
	occludefactor = 0,
	solid = true,
	visible = true,
})


ConnJam.DeclareTile(61, {
	mat_nm = "button_off.png",
	c_name = "button_lvl2",
	occludefactor = 0,
	solid = true,
	visible = true,
	touch_call = function(x, y)
		ConnJam.SetMapTile(30, 7, 5)
		ConnJam.SetMapTile(x, y, 48)

		Sounds["snd/sfx/button.wav"]:setVolume(.5)
		Sounds["snd/sfx/button.wav"]:play()
	end,
	custom_hull = {
		ox = 0,
		oy = TILE_SIZE * .725,
		w = TILE_SIZE,
		h = TILE_SIZE - (TILE_SIZE * .725)
	},
})


ConnJam.DeclareTile(62, {
	mat_nm = "fence_both_bottom.png",
	c_name = "fence_both_b",
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(63, {
	mat_nm = "fence_left_top.png",
	c_name = "fence_left_t",
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(64, {
	mat_nm = "fence_right_top.png",
	c_name = "fence_right_t",
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(65, {
	mat_nm = "fence_both_top.png",
	c_name = "fence_both_t",
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(66, {
	mat_nm = "fence_center_top.png",
	c_name = "fence_center_t",
	occludefactor = 0,
	solid = false,
	visible = true,
})


ConnJam.DeclareTile(67, {
	mat_nm = "Brick_005_p.png",
	c_name = "brick5_per",
	occludefactor = .25,
	solid = true,
	visible = true,
	col_onlytop = true,
	custom_hull = {
		ox = 0,
		oy = 0,
		w = TILE_SIZE,
		h = TILE_SIZE * .025
	},
})

ConnJam.DeclareTile(68, {
	mat_nm = "Brick_005Left_p.png",
	c_name = "brick5l_per",
	occludefactor = .25,
	solid = true,
	visible = true,
	col_onlytop = true,
	custom_hull = {
		ox = 0,
		oy = 0,
		w = TILE_SIZE,
		h = TILE_SIZE * .025
	},
})

ConnJam.DeclareTile(69, {
	mat_nm = "Brick_005Right_p.png",
	c_name = "brick5r_per",
	occludefactor = .25,
	solid = true,
	visible = true,
	col_onlytop = true,
	custom_hull = {
		ox = 0,
		oy = 0,
		w = TILE_SIZE,
		h = TILE_SIZE * .025
	},
})


ConnJam.DeclareTile(70, {
	mat_nm = "recharge_station.png",
	c_name = "chargestation",
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(71, {
	mat_nm = "button_off.png",
	c_name = "button_lvl3_1",
	occludefactor = 0,
	solid = true,
	visible = true,
	touch_call = function(x, y)
		ConnJam.SetMapTile(27, 4, 5)
		ConnJam.SetMapTile(x, y, 48)

		Sounds["snd/sfx/button.wav"]:setVolume(.5)
		Sounds["snd/sfx/button.wav"]:play()
	end,
	custom_hull = {
		ox = 0,
		oy = TILE_SIZE * .725,
		w = TILE_SIZE,
		h = TILE_SIZE - (TILE_SIZE * .725)
	},
})

ConnJam.DeclareTile(72, {
	mat_nm = "button_off.png",
	c_name = "button_lvl3_2",
	occludefactor = 0,
	solid = true,
	visible = true,
	touch_call = function(x, y)
		ConnJam.SetMapTile(62, 8, 5)
		ConnJam.SetMapTile(x, y, 48)

		Sounds["snd/sfx/button.wav"]:setVolume(.5)
		Sounds["snd/sfx/button.wav"]:play()
	end,
	custom_hull = {
		ox = 0,
		oy = TILE_SIZE * .725,
		w = TILE_SIZE,
		h = TILE_SIZE - (TILE_SIZE * .725)
	},
})

ConnJam.DeclareTile(73, {
	mat_nm = "Policetape_001.png",
	c_name = "tape_left",
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(74, {
	mat_nm = "Policetape_002.png",
	c_name = "tape_mid",
	occludefactor = 0,
	solid = false,
	visible = true,
})

ConnJam.DeclareTile(75, {
	mat_nm = "Policetape_003.png",
	c_name = "tape_right",
	occludefactor = 0,
	solid = false,
	visible = true,
})


ConnJam.DeclareTile(76, {
	mat_nm = "button_off.png",
	c_name = "button_lvl6_1",
	occludefactor = 0,
	solid = true,
	visible = true,
	touch_call = function(x, y)
		ConnJam.SetMapTile(52, 8, 5)
		ConnJam.SetMapTile(x, y, 48)

		Sounds["snd/sfx/button.wav"]:setVolume(.5)
		Sounds["snd/sfx/button.wav"]:play()
	end,
	custom_hull = {
		ox = 0,
		oy = TILE_SIZE * .725,
		w = TILE_SIZE,
		h = TILE_SIZE - (TILE_SIZE * .725)
	},
})

ConnJam.DeclareTile(77, {
	mat_nm = "button_off.png",
	c_name = "button_lvl7_1",
	occludefactor = 0,
	solid = true,
	visible = true,
	touch_call = function(x, y)
		ConnJam.SetMapTile(38, 28, 5)
		ConnJam.SetMapTile(x, y, 48)

		Sounds["snd/sfx/button.wav"]:setVolume(.5)
		Sounds["snd/sfx/button.wav"]:play()
	end,
	custom_hull = {
		ox = 0,
		oy = TILE_SIZE * .725,
		w = TILE_SIZE,
		h = TILE_SIZE - (TILE_SIZE * .725)
	},
})

ConnJam.DeclareTile(78, {
	mat_nm = "button_off.png",
	c_name = "button_lvl8_1",
	occludefactor = 0,
	solid = true,
	visible = true,
	touch_call = function(x, y)
		ConnJam.SetMapTile(47, 11, 5)
		ConnJam.SetMapTile(x, y, 48)

		Sounds["snd/sfx/button.wav"]:setVolume(.5)
		Sounds["snd/sfx/button.wav"]:play()
	end,
	custom_hull = {
		ox = 0,
		oy = TILE_SIZE * .725,
		w = TILE_SIZE,
		h = TILE_SIZE - (TILE_SIZE * .725)
	},
})


ConnJam.DeclareTile(79, {
	mat_nm = "button_off.png",
	c_name = "button_lvl8_2",
	occludefactor = 0,
	solid = true,
	visible = true,
	touch_call = function(x, y)
		ConnJam.SetMapTile(69, 20, 5)
		ConnJam.SetMapTile(85, 18, 5)
		ConnJam.SetMapTile(x, y, 48)

		Sounds["snd/sfx/button.wav"]:setVolume(.5)
		Sounds["snd/sfx/button.wav"]:play()
	end,
	custom_hull = {
		ox = 0,
		oy = TILE_SIZE * .725,
		w = TILE_SIZE,
		h = TILE_SIZE - (TILE_SIZE * .725)
	},
})

ConnJam.DeclareTile(97, {
	mat_nm = "checkpoint.png",
	c_name = "checkpoint",
	occludefactor = 0,
	solid = false,
	visible = false,
	touch_call = function(x, y)
		local cx, cy = ConnJam.GetCheckpointCoords()
		if cx ~= x or cy ~= y then
			Sounds["snd/sfx/charge.wav"]:play()
		end
		ConnJam.MarkCheckpoint(x, y)
	end
})


ConnJam.DeclareTile(98, {
	mat_nm = "flag-dev.png",
	c_name = "level_end",
	occludefactor = 0,
	solid = false,
	visible = false,
	touch_call = function()
		ConnJam.CompleteLevel()
	end
})

ConnJam.DeclareTile(99, {
	mat_nm = "spawn.png",
	c_name = "player_spawn",
	occludefactor = 0,
	solid = false,
	visible = false,

	init_call = function(x, y)
		print("Spawn is at " .. x .. "," .. y)
		ConnJam.SetPlayerPosHalt(x * TILE_SIZE, y  * TILE_SIZE - (PLAYER_SIZE_Y / 2))
		ConnJam.SetCamPos(x * TILE_SIZE, y * TILE_SIZE)
		ConnJam.MarkCheckpoint(x, y)
		ConnJam.InitPlayer()
	end
})


ConnJam.DeclareTile(999, {
	mat_nm = "block.png",
	c_name = "solid_block",
	occludefactor = 0,
	solid = true,
	visible = false,
})

ConnJam.DeclareTile(998, {
	mat_nm = "block_signal.png",
	c_name = "signal_block_25",
	occludefactor = .65,
	solid = true,
	visible = false,
	no_playercoll = true
})




-- build the atlas
-- theyre all 24x24
local atlas_countx = 12 -- 12 tiles wide atlas
local t_count = 0

-- texcture count
for k, v in pairs(ConnJam.Tiles) do
	t_count = t_count + 1
end

-- build atlas
local atlas_sx = math.min(t_count, atlas_countx) * TILE_SIZE
local atlas_sy = (1 + math.floor(t_count / atlas_countx)) * TILE_SIZE

print("atlas is " .. atlas_sx .. "x" .. atlas_sy)
local tex_canvas = love.graphics.newCanvas(atlas_sx, atlas_sy)
tex_canvas:setFilter("nearest", "nearest")
love.graphics.setCanvas(tex_canvas)
	love.graphics.clear(0, 0, 0, 0)
love.graphics.setCanvas()


local c_tex = 0
for k, v in pairs(ConnJam.Tiles) do
	local xc = (c_tex % atlas_countx) * TILE_SIZE
	local yc = math.floor(c_tex / atlas_countx) * TILE_SIZE

	love.graphics.setCanvas(tex_canvas)
		love.graphics.setColor(1, 1, 1, 1)

		local tex_nfo = Textures[v.mat_nm]

		love.graphics.draw(tex_nfo.img, xc, yc + (v.mat_flip and TILE_SIZE or 0), 0, TILE_SIZE / tex_nfo.w, (TILE_SIZE / tex_nfo.h) * (v.mat_flip and -1 or 1))
	love.graphics.setCanvas()


	--local u_calc = xc / atlas_sx
	--local v_calc = yc / atlas_sx

	ConnJam.Tiles[k].canvas_x = xc
	ConnJam.Tiles[k].canvas_y = yc

	c_tex = c_tex + 1
end

ConnJam.TexAtlas = tex_canvas:newImageData()
ConnJam.AtlasDeltaX = TILE_SIZE / atlas_sx
ConnJam.AtlasDeltaY = TILE_SIZE / atlas_sy

ConnJam.TexAtlasImg = love.graphics.newImage(ConnJam.TexAtlas)
ConnJam.TexAtlasImg:setFilter("nearest", "nearest")