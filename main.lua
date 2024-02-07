function love.load()
    crosshair = love.graphics.newImage('sprites/crosshairs.png')
    target = love.graphics.newImage('sprites/target.png')
    sky = love.graphics.newImage('sprites/sky.png')

    endFont = love.graphics.newFont(20)
    menuFont = love.graphics.newFont(50)


    score = 0
    timer = 10

    circle = {}
    circle.x = 400
    circle.y = 400
    circle.radius = 50

    love.mouse.setVisible(false)

    gameState = 'menu'


end


function love.update(dt)

    if gameState == 'play' then 
        if timer > 0 then 
            timer = timer - dt
        end

        if timer < 0 then
            timer = 0
            gameState = 'end'
        end
    end
    

end


function love.draw()
    love.graphics.draw(sky, 0, 0)

    if gameState == 'menu' then
        love.graphics.setFont(menuFont)
        love.graphics.print('PRESS ANYWHERE TO BEGIN', 50, 100)

    end

    if gameState == 'play' then
        love.graphics.draw(target, circle.x-50, circle.y-50)
    
        love.graphics.print(score, 10, 10)

        love.graphics.print(math.ceil(timer), 500, 10)

    end

    if gameState == 'end' then
        love.graphics.setFont(menuFont)
        love.graphics.print('SCORE: ' ..score, 200, 50)
        
        love.graphics.print(math.ceil(timer), 500, 10)

        love.graphics.setFont(endFont)
        love.graphics.print('Press anywhere to play again and esc to quit', 10, 1000)

    end

    love.graphics.draw(crosshair, love.mouse.getX()-20, love.mouse.getY()-20)

end

function love.mousepressed(x, y, button)
    if gameState == 'play' then
        if button == 1 then
            distanceWithTarget = distanceBetween(x, y, circle.x, circle.y)
            if distanceWithTarget < circle.radius then
                score = score + 1
                circle.x = math.random(circle.radius, love.graphics.getWidth()- circle.radius)
                circle.y = math.random(circle.radius, love.graphics.getHeight()- circle.radius)
            end
        end

    end

    if gameState == 'menu' and button == 1 then
        gameState = 'play'
        score = 0
        timer = 10

    end
    if gameState == 'end' and button == 1 then
        gameState = 'play'
    end

end


function distanceBetween (x1, y1, x2, y2)

    return math.sqrt ( (x2 - x1) ^ 2 + (y2 - y1) ^ 2)



end