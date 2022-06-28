local globals = require "src/globals"
local grid_width = globals.player.grid_width
local grid_height = globals.player.grid_height
local img_width = globals.sprites.player_sheet:getWidth()
local img_height = globals.sprites.player_sheet:getHeight()
local start_position = globals.player.start_position
local player_width = globals.player.width
local player_height = globals.player.height
local player_sheet = globals.sprites.player_sheet
local grid = anim8.newGrid(grid_width, grid_height, img_width, img_height)

player = world:newRectangleCollider(start_position.x, start_position.y, player_width, player_height, {
    collision_class = "Player"
})
player:setFixedRotation(true)

player.speed = 240
player.width = player_width
player.height = player_height
player.animations = {
    idle = anim8.newAnimation(grid("1-15", 1), 0.05),
    jump = anim8.newAnimation(grid("1-7", 2), 0.05),
    run = anim8.newAnimation(grid("1-15", 3), 0.05)
}
player.animation = player.animations.idle
player.state = "idle"
player.direction = 1 -- player facing direction, 1 = right, -1 = left
player.grounded = true -- is player on ground?

function player:draw()
    local px, py = self:getPosition()

    player.animation:draw(player_sheet, px, py, nil, 0.25 * player.direction, 0.25, grid_width / 4 - 30,
        grid_height / 2 + 20)
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
            player.animation = player.animations.run
        elseif player.state == "idle" then
            player.animation = player.animations.idle
        elseif player.state == "jump" then
            player.animation = player.animations.jump
        end
        player.animation:update(dt)
    end
end
