function draw_()
    camera:attach()
    game_map:drawLayer(game_map.layers["Tile Layer 1"])
    world:draw()
    draw_enemies()
    player:draw()
    camera:detach()
    love.graphics.draw(globals.sprites.flag, globals.flag_x, globals.flag_y)
end
