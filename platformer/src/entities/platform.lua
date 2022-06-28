function spawn_platform(x, y, width, height)
    if width > 0 and height > 0 then
        local platform = world:newRectangleCollider(x, y, width, height, {
            collision_class = "Platform"
        })
        platform:setType("static")

        table.insert(platforms, platform)
    end
end

function destroy_platform()
    for i = #platforms, 1, -1 do
        if platforms[i] ~= nil then
            platforms[i]:destroy()
        end
        table.remove(platforms, i)
    end
end
