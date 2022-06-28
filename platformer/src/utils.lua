local globals = require "src/globals"
local enemy_width = globals.enemy.width
local enemy_height = globals.enemy.height
local enemy_speed = globals.enemy.speed

function collide(x, y, width, height, collision_classes)
    local colliders = world:queryRectangleArea(x, y, width, height, collision_classes)
    return #colliders > 0
end

function player_collide(collision_classes)
    return collide(player:getX() - player.width / 2, player:getY() + player.height / 2, player.width, 5,
        collision_classes)
end

function enemy_collide(enemy, collision_classes)
    local x, y = enemy:getPosition()
    return collide(x + globals.enemy.width / 2 * enemy.direction, y + globals.enemy.height / 2, 10, 10,
        collision_classes)
end

function spawn_platform(x, y, width, height)
    if width > 0 and height > 0 then
        local platform = world:newRectangleCollider(x, y, width, height, {
            collision_class = "Platform"
        })
        platform:setType("static")

        table.insert(platforms, platform)
    end
end

