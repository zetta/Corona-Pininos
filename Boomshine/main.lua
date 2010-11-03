

-- Hide Status Bar. Just hate it
display.setStatusBar( display.HiddenStatusBar )


--[[
-- comenzamos con la fisica 
local physics = require("physics")
physics.start()
physics.setGravity( 0, 4 )

borderBodyElement = { friction=0.5, bounce=0.3 }

local borderTop = display.newRect( 0, 0, 320, 20 )
physics.addBody( borderTop, "static", borderBodyElement )

local borderBottom = display.newRect( 0, 460, 320, 20 )
physics.addBody( borderBottom, "static", borderBodyElement )

local borderLeft = display.newRect( 0, 20, 20, 460 )
physics.addBody( borderLeft, "static", borderBodyElement )

local borderRight = display.newRect( 300, 20, 20, 460 )
physics.addBody( borderRight, "static", borderBodyElement )

--]]
-- variables para iniciar
WIDTH = display.contentWidth
HEIGHT = display.contentHeight
BALLS = 15
balls = {}



-- iniciamos las pelotitas 




for i = 0,BALLS do
    circle = display.newCircle( math.random(WIDTH), math.random(HEIGHT), 7 )
    circle:setFillColor(math.random(255),math.random(255),math.random(255))
    circle.speed = math.random(2,6)
    circle.direction = math.random(0,1) < 1 and -1 or 1
    circle.speed = circle.speed*circle.direction
    circle.speedOnX, circle.speedOnY = circle.speed, circle.speed -- multiple asignation ¬¬ esta re chafa, multiple asignation deberia ser cortito!!


    -- physics.addBody( circle, { density = 1.0, friction = 0.3, bounce = 0.2, radius = 7 } )
    balls[i] = circle
end 


Runtime:addEventListener( "enterFrame", function()
    for index,ball in pairs(balls) do 
        ball.x = ball.x + ball.speedOnX
        ball.y = ball.y + ball.speedOnY

        if ball.x >= WIDTH or ball.x <= 0 then
            ball.speedOnX = ball.speedOnX*-1
        end

        if ball.y >= HEIGHT or ball.y <= 0 then
            ball.speedOnY = ball.speedOnY*-1
        end 
    end
end )





















