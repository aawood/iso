function love.conf(t)
    t.title = "iso Test"
    t.author = "Adrian Wood"
    t.url = aawood.co.uk
    t.identity = isotest
    t.version = "0.8.0"
    t.screen.width = 1200
    t.screen.height = 600
    t.screen.fullscreen = false
    t.screen.vsync = true
    t.screen.fsaa = 0
    t.modules.joystick = false
    t.modules.audio = true
    t.modules.keyboard = true
    t.modules.event = true
    t.modules.image = true
    t.modules.graphics = true
    t.modules.timer = true
    t.modules.mouse = true
    t.modules.sound = true
    t.modules.physics = false
end