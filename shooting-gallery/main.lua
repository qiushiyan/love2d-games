function hit(target, x, y)
    local d = distance(target.x, target.y, x, y)
    if d <= target.radius then
        return true
    else
        return false
    end
end

function distance(x1, y1, x2, y2)
    return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
end

function love.load()
    local radius = 30
    target = {
        x = math.random(radius, love.graphics.getWidth() - radius),
        y = math.random(radius, love.graphics.getHeight() - radius),
        radius = 50
    }
    sounds = {
        blip = love.audio.newSource("assets/sounds/blip.wav", "static")
    }
    game_state = 1
    score = 0
    timer = 0
    gameFont = love.graphics.newFont("assets/fonts/font.ttf", 30)
    sprites = {
        target = love.graphics.newImage("assets/sprites/target.png"),
        crosshairs = love.graphics.newImage("assets/sprites/crosshairs.png"),
        sky = love.graphics.newImage("assets/sprites/sky.png")
    }

    love.mouse.setVisible(false)
end

function love.update(dt)
    if game_state == 2 then
        if timer - dt > 0 then
            timer = timer - dt
        else
            timer = 0
            score = 0
            game_state = 1
        end
    end
end

function love.draw()
    love.graphics.draw(sprites.sky, 0, 0)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: " .. score, 0, 0)
    love.graphics.print("Timer: " .. math.ceil(timer), 300, 0)

    if game_state == 1 then
        love.graphics.printf("Click to begin", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    end

    if game_state == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
        love.graphics.draw(sprites.crosshairs, love.mouse.getX() - 20, love.mouse.getY() - 20)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        if game_state == 2 then
            if hit(target, x, y) then
                score = score + 1
                sounds.blip:play()
                local upper_x = love.graphics.getWidth() - target.radius
                local upper_y = love.graphics.getHeight() - target.radius
                target.x = math.random(target.radius, upper_x)
                target.y = math.random(target.radius, upper_y)
            else
                score = score - 1
            end
        else
            if game_state == 1 then
                game_state = 2
                timer = 20
            end
        end
    end
end
