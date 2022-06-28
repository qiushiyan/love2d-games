function require_all()
    anim8 = require "libs/anim8/anim8"
    wf = require "libs/windfield/windfield"
    sti = require "libs/Simple-Tiled-Implementation/sti"
    Camera = require "libs/hump/camera"
    camera = Camera()
    require "src/world"
    require "src/player"
    require "src/platform"
    require "src/update"
    require "src/draw"
    require "src/danger"
    require "src/map"
    require "src/utils"
    require "src/enemy"
end
