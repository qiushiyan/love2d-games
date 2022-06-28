function spawn_danger()
    danger_zone = world:newRectangleCollider(0, 550, 800, 50, {
        collision_class = "Danger"
    })
    danger_zone:setType("static")
end
