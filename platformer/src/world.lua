world = wf.newWorld(0, 1000, false)

world:setQueryDebugDrawing(true)

world:addCollisionClass("Platform")
world:addCollisionClass("Player")
world:addCollisionClass("Danger")
world:addCollisionClass("Enemy")
