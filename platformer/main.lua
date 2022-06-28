function love.load()
    require "src/require"
    require_all()

    if love.filesystem.getInfo("data.lua") then
        local data = love.filesystem.load("data.lua")
        data()
    end

    globals.sounds.bgm:play()
    load_map(globals.save_data.current_level)
    love.window.setMode(1000, 768)
end

function love.update(dt)
    update_(dt)
end

function love.draw()
    draw_()
end

