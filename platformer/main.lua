function love.load()
    require "src/require"
    require_all()
    load_map()
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
