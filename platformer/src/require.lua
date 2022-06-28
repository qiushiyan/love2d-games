function require_all()
    anim8 = require "libs/anim8/anim8"
    wf = require "libs/windfield/windfield"
    sti = require "libs/Simple-Tiled-Implementation/sti"
    require "libs/show/show"
    Camera = require "libs/hump/camera"
    camera = Camera()
    require "src/world"
    require "src/animations"
    require "src/map"
    require "src/entities/main"
    require "src/utils"
    require "src/draw"
    require "src/update"
end
