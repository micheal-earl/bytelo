
-- Generate a random ID with hopefull no overlaps
function UUID()
    local fn = function(x)
        local r = love.math.random(16) - 1
        r = (x == "x") and (r + 1) or (r % 4) + 9
        return ("0123456789abcdef"):sub(r, r)
    end
    return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
end

-- Generate a random number between two values that
-- includes all non-integer values
function random(min, max)
    if not max then
        return love.math.random()*min
    else
        return love.math.random()*(max - min) + min
    end
end

-- Compute the difference between two points on a coordinate grid
function distance(x1, y1, x2, y2)
    return math.sqrt((x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2))
end

function slow(amount, duration)
    game_speed = amount
    timer:tween('slow', duration, _G, {game_speed = 1}, 'in-out-cubic')
end

function pushRotate(x, y, r)
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(r or 0)
    love.graphics.translate(-x, -y)
end

function pushRotateScale(x, y, r, sx, sy)
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(r or 0)
    love.graphics.scale(sx or 1, sy or sx or 1)
    love.graphics.translate(-x, -y)
end