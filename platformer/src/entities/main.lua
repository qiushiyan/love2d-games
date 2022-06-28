require("src/entities/player")
require("src/entities/enemy")
require("src/entities/danger")
require("src/entities/platform")

enemies = {}
platforms = {}

function destroy()
    destroy_enemies()
    destroy_platform()
end
