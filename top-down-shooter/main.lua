function angle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end

function distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function move_player(dt)
    if love.keyboard.isDown("d") then
        player.x = math.min(player.x + player.speed * dt, screen_height - player.width / 2)
    end

    if love.keyboard.isDown("a") then
        player.x = math.max(player.x - player.speed * dt, player.width / 2)
    end

    if love.keyboard.isDown("w") then
        player.y = math.max(player.y - player.speed * dt, player.height / 2)
    end

    if love.keyboard.isDown("s") then
        player.y = math.min(player.y + player.speed * dt, screen_height - player.height / 2)
    end

end

function remove_if(x, fun)
    for i = #x, 1, -1 do
        if fun(x[i]) then
            table.remove(x, i)
        end
    end

    return x
end

function dead(x)
    return x.dead
end

function hit(x, y, tolerance)
    local tolerance = tolerance or x.width + y.width
    return distance(x.x, x.y, y.x, y.y) <= tolerance
end

function out_of_bounds(object)
    local width = screen_width
    local height = screen_height
    return (object.x > width + object.width / 2) or (object.y > height + object.height / 2) or
               (object.x < -object.width / 2) or (object.y < -object.height / 2)
end

function love.load()
    math.randomseed(os.time())
    game_state = 1; -- 1 = menu, 2 = game, 3 = game over
    max_time = 2.5; -- time span to spawn zombies
    timer = max_time -- countdown to spawn a zombie
    time = 0; -- when this reaches over 5, decrease max_time by 0.5
    font = love.graphics.newFont(30)
    score = 0

    sprites = {
        background = love.graphics.newImage("assets/sprites/background.png"),
        bullet = love.graphics.newImage("assets/sprites/bullet.png"),
        player = love.graphics.newImage("assets/sprites/player.png"),
        zombie = love.graphics.newImage("assets/sprites/zombie.png")
    }

    player = {
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() / 2,
        rotation = 0,
        speed = 160,
        width = sprites.player:getWidth(),
        height = sprites.player:getHeight(),
        health = 100
    }

    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()
    zombie_width = sprites.zombie:getWidth()
    zombie_height = sprites.zombie:getHeight()
    bullet_width = sprites.bullet:getWidth()
    bullet_height = sprites.bullet:getHeight()

    zombies = {}
    bullets = {}
end

function love.update(dt)
    player.rotation = angle(player.x, player.y, love.mouse.getX(), love.mouse.getY())

    if game_state == 2 then
        move_player(dt)

        time = time + dt

        for i, z in ipairs(zombies) do
            z.rotation = angle(z.x, z.y, player.x, player.y)
            local next_x = z.x + z.speed * dt * math.cos(z.rotation)
            local next_y = z.y + z.speed * dt * math.sin(z.rotation)
            z.x = next_x
            z.y = next_y
            if hit(player, z, 30) then
                player.health = player.health - z.damage
                player.speed = player.speed + 20
                z.dead = true
            end
        end

        for i, z in ipairs(bullets) do
            z.x = z.x + z.speed * dt * math.cos(z.rotation)
            z.y = z.y + z.speed * dt * math.sin(z.rotation)
        end

        bullets = remove_if(bullets, out_of_bounds)

        for i, v in ipairs(zombies) do
            for j, b in ipairs(bullets) do
                if hit(v, b, 50) then
                    v.dead = true
                    b.dead = true
                    score = score + 1
                end
            end
        end

        zombies = remove_if(zombies, dead)
        bullets = remove_if(bullets, dead)

        timer = math.max(0, timer - dt)
        if timer == 0 then
            spawn_zombie()
            timer = max_time
            -- every 5 seconds, speed zombie generation speed by 0.5s, min 1 second
            if time > 5 then
                max_time = math.max(0.5, max_time - 0.5)
                -- reset timer
                timer = max_time
                time = 0
            end
        end

        if player.health == 0 then
            game_state = 1
            player.health = 100
            zombies = {}
            player.x = screen_width / 2 - player.width / 2
            player.y = screen_height / 2 - player.height / 2
            score = 0
            max_time = 3
            timer = max_time
            time = 0
        end
    end
end

function love.draw()
    love.graphics.draw(sprites.background, 0, 0)

    love.graphics.draw(sprites.player, player.x, player.y, player.rotation, nil, nil, player.width / 2,
        player.height / 2)

    love.graphics.printf("Score: " .. score, 0, screen_height - 100, screen_width, "center")

    if game_state == 1 then
        love.graphics.setFont(font)
        love.graphics.printf("Click anywhere to begin!", 0, 100, screen_width, "center")
    end

    if game_state == 2 then
        -- health bar
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", 5, screen_height - 20, 100, 20)
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle("fill", 5, screen_height - 20, player.health, 20)
        love.graphics.setColor(1, 1, 1)

        for i, z in ipairs(zombies) do
            love.graphics.draw(sprites.zombie, z.x, z.y, z.rotation, nil, nil, z.width / 2, z.height / 2)
        end

        for i, z in ipairs(bullets) do
            love.graphics.draw(sprites.bullet, z.x, z.y, nil, 0.5, nil, z.width / 2, z.height / 2)
        end
    end
end

function love.mousepressed(x, y, button)
    if button == 1 and game_state == 2 then
        spawn_bullet()
    end

    if button == 1 and game_state == 1 then
        game_state = 2
        max_time = 3
        timer = max_time
        time = 0
        score = 0
    end
end

function spawn_bullet()
    local bullet = {
        x = player.x,
        y = player.y,
        rotation = player.rotation,
        speed = 500,
        dead = false,
        width = bullet_width,
        height = bullet_height
    }

    table.insert(bullets, bullet)
end

function spawn_zombie()
    local side = math.random(1, 4)
    local zombie = {
        speed = 130,
        dead = false,
        width = zombie_width,
        height = zombie_height,
        damage = 25
    }

    if side == 1 then
        zombie.x = -zombie.width / 2
        zombie.y = math.random(0, screen_height)
    elseif side == 2 then
        zombie.x = screen_width + zombie.width / 2
        zombie.y = math.random(0, screen_height)
    elseif side == 3 then
        zombie.x = math.random(0, screen_width)
        zombie.y = -zombie.height / 2
    elseif side == 4 then
        zombie.x = math.random(0, screen_width)
        zombie.y = screen_height + zombie.height / 2
    end

    zombie.rotation = angle(zombie.x, zombie.y, player.x, player.y)

    table.insert(zombies, zombie)
end
