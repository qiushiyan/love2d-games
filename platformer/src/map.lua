function map:load()
    game_map = sti("maps/level1.lua")

    for i, obj in pairs(game_map.layers["Platforms"].objects) do
        spawn_platform(obj.x, obj.y, obj.width, obj.height)
    end

    for i, obj in pairs(game_map.layers["Enemies"].objects) do
        spawn_enemy(obj.x, obj.y)
    end
end
