window_width = 1366
window_height = 768

function love.conf(t)
  --t.version = "0.11.0"
  t.console = true

  t.window.title = "Bytelo"
  t.window.icon = "resources/ico.png"
  t.window.width = window_width
  t.window.height = window_height
  t.window.fullscreen = false
  t.window.fullscreentype = "exclusive"
end