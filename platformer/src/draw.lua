function draw_()
    camera:attach()
    game_map:drawLayer(game_map.layers["Tile Layer 1"])
    world:draw()
    player:draw()
    camera:detach()
end
