function love.load()
    require "src/require"
    require_all()

    if love.filesystem.getInfo("data.lua") then
        local data = love.filesystem.load("data.lua")
        data()
    end

    load_map(globals.save_data.current_level)
    love.window.setMode(1000, 768)
end

function love.update(dt)
    update_(dt)
end

function love.draw()
    draw_()
end

function love.keypressed(key)
    if key == "up" or key == "space" then
        if player_collide({"Platform", "Enemy"}) then
            player.state = "jump"
            player:applyLinearImpulse(0, -5000)
        end
    end
end
