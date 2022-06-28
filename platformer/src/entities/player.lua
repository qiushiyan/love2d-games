local globals = require "src/globals"
local start_position = globals.player.start_position
local player_width = globals.player.width
local player_height = globals.player.height
local player_sheet = globals.sprites.player_sheet
local player_grid_width = globals.player.grid_width
local player_grid_height = globals.player.grid_height

player = world:newRectangleCollider(start_position.x, start_position.y, player_width, player_height, {
    collision_class = "Player"
})
player:setFixedRotation(true)

player.speed = 240
player.width = player_width
player.height = player_height
player.animation = animations.player.idle
player.state = "idle"
player.direction = 1 -- player facing direction, 1 = right, -1 = left
player.grounded = true -- is player on ground?

function player:draw()
    local px, py = self:getPosition()
    player.animation:draw(player_sheet, px, py, nil, 0.25 * player.direction, 0.25, player_grid_width / 4 - 30,
        player_grid_height / 2 + 20)
end

function player:update(dt)
    if player.body then
        if player_collide({"Platform", "Enemy"}) then
            player.state = "idle"
            player.grounded = true
        else
            player.state = "jump"
            player.grounded = false
        end

        local px, py = player:getPosition()
        if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
            player:setX(px + player.speed * dt)
            player.state = "run"
            player.direction = 1
        end

        if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
            player:setX(px - player.speed * dt)
            player.state = "run"
            player.direction = -1
        end

        if player:enter("Danger") then
            player:destroy()
        end

        if player.state == "run" and player.grounded then
            player.animation = animations.player.run
        elseif player.state == "idle" then
            player.animation = animations.player.idle
        elseif player.state == "jump" then
            player.animation = animations.player.jump
        end
        player.animation:update(dt)
    end
end
