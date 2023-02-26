local w, h = love.graphics.getDimensions()
ConnJam.Camera = {
    x = 0,
    y = 0,
    scl = (w / 800) * 1.5,
    tilt = 0
}

function ConnJam.SetCamPos(x, y)
    ConnJam.Camera.x = x or 0
    ConnJam.Camera.y = y or 0
end

function ConnJam.SetCamScale(zm)
    ConnJam.Camera.scl = zm or 1
end

function ConnJam.SetCamTilt(tilt)
    ConnJam.Camera.tilt = math.rad(tilt) or 0
end

function ConnJam.TranslateScaleCamera()
    love.graphics.translate(w / 2, h / 2)
    love.graphics.rotate(ConnJam.Camera.tilt)
    love.graphics.scale(ConnJam.Camera.scl, ConnJam.Camera.scl)

    love.graphics.translate(-ConnJam.Camera.x, -ConnJam.Camera.y)
    --love.graphics.scale(ConnJam.Camera.scl, ConnJam.Camera.scl)
end


function ConnJam.CameraSeekPlayer(dt)
    local deltax = (ConnJam.Player.x + (PLAYER_SIZE_X / 2)) - ConnJam.Camera.x
    local deltay = (ConnJam.Player.y - (PLAYER_SIZE_Y / 2)) - ConnJam.Camera.y

    ConnJam.Camera.x = ConnJam.Camera.x + deltax * (dt * 16)
    ConnJam.Camera.y = ConnJam.Camera.y + deltay * (dt * 16)


    w, h = love.graphics.getDimensions()
    ConnJam.Camera.scl = (w / 800) * 1.5
end