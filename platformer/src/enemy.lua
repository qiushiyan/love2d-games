local globals = require("src/globals")
local grid_width = globals.enemy.grid_width
local grid_height = globals.enemy.grid_height
local enemy_sheet = globals.sprites.enemy_sheet

enemies = {}

-- Enemy = {
--     direction = 1,
--     speed = enemy_speed
-- }

-- function Enemy:new(x, y)
--     local enemy = world:newRectangleCollider(x, y, enemy_width, enemy_height, {
--         collision_class = "Enemy"
--     })
--     setmetatable(enemy, self)
--     self.__index = self

--     table.insert(enemies, enemy)
--     return enemy
-- end

-- function update(dt)
--     local ex, ey = self:getPosition()
--     if not enemy_collide(self, {"Platform"}) then
--         self.direction = -self.direction
--     end
--     self:setX(ex + self.speed * dt * self.direction)
-- end

local grid = anim8.newGrid(grid_width, grid_height, enemy_sheet:getWidth(), enemy_sheet:getHeight())
