local globals = {
    enemy = {
        width = 70,
        height = 90,
        speed = 200,
        grid_width = 100,
        grid_height = 79
    },
    player = {
        width = 40,
        height = 100,
        speed = 300,
        start_position = {
            x = 360,
            y = 100
        },
        grid_width = 614,
        grid_height = 564
    },
    sprites = {
        player_sheet = love.graphics.newImage("sprites/player_sheet.png"),
        enemy_sheet = love.graphics.newImage("sprites/enemy_sheet.png")
    }
}

return globals
