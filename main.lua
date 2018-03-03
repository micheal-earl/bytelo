function love.load()
  image = love.graphics.newImage('resources/image.png')
end

function love.update(dt)

end

function love.draw()
  love.graphics.draw(image, 200, 150)
end