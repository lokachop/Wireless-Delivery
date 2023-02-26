-- lokachops recursive loader v1
local function recursiveLoad(path)
	print("recusive code loading; path " .. path)
	for k, v in pairs(love.filesystem.getDirectoryItems(path)) do
		local nfo = love.filesystem.getInfo(path .. "/" .. v)

		if nfo.type == "directory" then
			recursiveLoad(path .. "/" .. v)
		else
			local codeload = love.filesystem.load(path .. "/" .. v)
			codeload()
		end
	end
end

Textures = {}
local function recursiveLoadImages(path)
	for k, v in pairs(love.filesystem.getDirectoryItems(path)) do
		local nfo = love.filesystem.getInfo(path .. "/" .. v)

		if nfo.type == "directory" then
			recursiveLoadImages(path .. "/" .. v)
		else
			local imga = love.graphics.newImage(path .. "/" .. v)
			imga:setFilter("nearest", "nearest")
			Textures[v] = {
				img = imga,
				w = imga:getWidth(),
				h = imga:getHeight()
			}
		end
	end
end

Sounds = {}
local function recursiveLoadSounds(path)
	for k, v in pairs(love.filesystem.getDirectoryItems(path)) do
		local nfo = love.filesystem.getInfo(path .. "/" .. v)

		if nfo.type == "directory" then
			recursiveLoadSounds(path .. "/" .. v)
		else
			Sounds[path .. "/" .. v] = love.audio.newSource(path .. "/" .. v, "static")
		end
	end
end


Shaders = {}
local function recursiveLoadShaders(path)
	for k, v in pairs(love.filesystem.getDirectoryItems(path)) do
		local nfo = love.filesystem.getInfo(path .. "/" .. v)

		if nfo.type == "directory" then
			recursiveLoadShaders(path .. "/" .. v)
		else
			Shaders[v] = love.graphics.newShader(path .. "/" .. v)
		end
	end
end

-- love.graphics.newShader(

recursiveLoadSounds("snd")
recursiveLoadImages("assets")
recursiveLoad("libs")
recursiveLoad("code")
recursiveLoadShaders("shader")


print("loading complete!")