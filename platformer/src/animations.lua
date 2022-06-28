globals = require("src/globals")

local player_grid_width = globals.player.grid_width
local player_grid_height = globals.player.grid_height
local player_img_width = globals.sprites.player_sheet:getWidth()
local player_img_height = globals.sprites.player_sheet:getHeight()

local enemy_grid_width = globals.enemy.grid_width
local enemy_grid_height = globals.enemy.grid_height
local enemy_img_width = globals.sprites.enemy_sheet:getWidth()
local enemy_img_height = globals.sprites.enemy_sheet:getHeight()

local player_grid = anim8.newGrid(player_grid_width, player_grid_height, player_img_width, player_img_height)
local enemy_grid = anim8.newGrid(enemy_grid_width, enemy_grid_height, enemy_img_width, enemy_img_height)

animations = {
    player = {
        idle = anim8.newAnimation(player_grid("1-15", 1), 0.05),
        jump = anim8.newAnimation(player_grid("1-7", 2), 0.05),
        run = anim8.newAnimation(player_grid("1-15", 3), 0.05)
    },
    enemy = anim8.newAnimation(enemy_grid("1-2", 1), 0.03)
}
