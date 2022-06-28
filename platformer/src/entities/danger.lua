function spawn_danger()
    danger_zone = world:newRectangleCollider(-500, 800, 10000, 50, {
        collision_class = "Danger"
    })
    danger_zone:setType("static")
end
