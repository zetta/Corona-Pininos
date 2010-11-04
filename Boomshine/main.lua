

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


local bg = display.newImage("Aurora.png")

-- iniciamos las pelotitas 




for i = 0,BALLS do
    circle = display.newCircle( math.random(WIDTH-5), math.random(HEIGHT-5), 9 )
    circle:setFillColor(math.random(255),math.random(255),math.random(255), 180)
    circle:setStrokeColor(100,100,100)
    circle.speed = math.random(2,6)
    circle.direction = math.random(0,1) < 1 and -1 or 1
    circle.speed = circle.speed*circle.direction
    circle.speedOnX, circle.speedOnY = circle.speed, circle.speed -- multiple asignation ¬¬ esta re chafa, multiple asignation deberia ser cortito!!
    -- physics.addBody( circle, { density = 1.0, friction = 0.3, bounce = 0.2, radius = 7 } )
    balls[i] = circle
end 



Runtime:addEventListener( "enterFrame",
    function()
        for index,ball in pairs(balls) do 

            -- vamos a checar la colision
            for i,otherBall in pairs(balls) do
                if  otherBall.speed == 0 then
                    -- print('otherBall')
                    i = otherBall.x-ball.x
                    j = otherBall.y-ball.y
                    magnitude = math.sqrt( (i*i)+(j*j) )
                    -- print('----------------')                    
                    -- print(magnitude)
                    -- print(otherBall.xScale*7)
                    if ( magnitude < 40) then
                        ball.speed, ball.speedOnX, ball.speedOnY = 0,0,0
                        -- print('colission')
                    end
                end
            end

            ball.x = ball.x + ball.speedOnX
            ball.y = ball.y + ball.speedOnY

            if ball.speed == 0 then
                if ball.xScale < 6 then
                    ball:scale(1.1,1.1)
                end
            else
                if ball.x >= WIDTH or ball.x <= 0 then
                    ball.speedOnX = ball.speedOnX*-1
                end
                if ball.y >= HEIGHT or ball.y <= 0 then
                    ball.speedOnY = ball.speedOnY*-1
                end
            end
        end
    end
)




Runtime:addEventListener("touch",
    function(event)
        circle = display.newCircle( event.x, event.y, 9 )
        circle:setFillColor(255,221,0,180)
        circle:setStrokeColor(100,100,100)
        circle.direction = 1
        circle.speed, circle.speedOnX, circle.speedOnY = 0,0,0
        table.insert(balls, circle)
    end
)








