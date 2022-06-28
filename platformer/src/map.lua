function load_map(name)
    globals.save_data.current_level = name

    -- save proprogress
    love.filesystem.write("data.lua", table.show(globals.save_data, "globals.save_data"))
    destroy()
    game_map = sti("maps/" .. name .. ".lua")

    for i, obj in pairs(game_map.layers["Platforms"].objects) do
        spawn_platform(obj.x, obj.y, obj.width, obj.height)
    end
    for i, obj in pairs(game_map.layers["Enemies"].objects) do
        spawn_enemy(obj.x, obj.y)
    end
    for i, obj in pairs(game_map.layers["Flag"].objects) do
        globals.flag_x = obj.x
        globals.flag_y = obj.y
    end

    for i, obj in pairs(game_map.layers["Start"].objects) do
        globals.start_position.x = obj.x
        globals.start_position.y = obj.y

        player:setX(globals.start_position.x)
        player:setY(globals.start_position.y)
    end

    spawn_danger()
end
