local globals = require("src/globals")
local grid_width = globals.enemy.grid_width
local grid_height = globals.enemy.grid_height
local enemy_width = globals.enemy.width
local enemy_height = globals.enemy.height
local enemy_sheet = globals.sprites.enemy_sheet
local enemy_speed = globals.enemy.speed

function spawn_enemy(x, y)
    local enemy = world:newRectangleCollider(x, y, enemy_width, enemy_height, {
        collision_class = "Enemy"
    })
    enemy.direction = 1
    enemy.speed = enemy_speed
    enemy.animation = animations.enemy
    enemy:setFixedRotation(true)

    table.insert(enemies, enemy)
end

function update_enemies(dt)
    for i, e in ipairs(enemies) do
        local ex, ey = e:getPosition()
        if not enemy_collide(e, {"Platform"}) then
            e.direction = -e.direction
        end
        e:setX(ex + e.speed * dt * e.direction)
        e.animation:update(dt)
    end
end

function draw_enemies()
    for i, e in ipairs(enemies) do
        local ex, ey = e:getPosition()
        e.animation:draw(enemy_sheet, ex, ey, nil, 0.9 * e.direction, 1, enemy_width / 2, enemy_height / 2 + 10)
    end
end
