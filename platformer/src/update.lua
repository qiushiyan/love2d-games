function update_(dt)
    player:update(dt)
    world:update(dt)
    game_map:update(dt)
    update_enimies(dt)

    local px, py = player:getPosition()
    camera:lookAt(px, love.graphics.getHeight() / 2)
end
