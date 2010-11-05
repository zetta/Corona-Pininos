
display.setStatusBar( display.HiddenStatusBar )

local width = display.contentWidth
local height = display.contentHeight
--local totalballs = 15
smokes = {}
local xlastpos = {}
local ylastpos = {}
local distance = -2.9
local xinit = math.random(width-45) + 25
local yinit = math.random(height-45) + 25

fireBall = display.newImage( "fireball.png",-50,-50 ) --) + 15, math.random(HEIGHT-30) + 15 )
fireBall:scale(.3,.3)
fireBall.speed = 5 --math.random(2,6)
fireBall.speedOnX = 6
fireBall.speedOnY = 7
fireBall.direction = math.random(0,1) < 1 and -1 or 1
fireBall.speed = fireBall.speed*fireBall.direction


function createSmokeBall()
    local smoke = display.newImage( "smokeball.png",xinit,yinit)
    smoke:scale(.3,.3)
    smoke.x = fireBall.x
    smoke.y = fireBall.y
	table.insert(smokes,smoke)
end


Runtime:addEventListener( "enterFrame",
    function()
        if system.getTimer()%2 == 0 then
            createSmokeBall()
        end 
        
        for key,smoke in ipairs(smokes) do
            smoke:scale(.97,.97)
            smoke.alpha = smoke.alpha-.02
            if smoke.xScale < 0.09 then
                table.remove(smokes,key)
                smoke:removeSelf()
            end
        end

        fireBall.x = fireBall.x + fireBall.speedOnX
		fireBall.y = fireBall.y + fireBall.speedOnY
		if fireBall.x >= width or fireBall.x <= 0 then
			fireBall.speedOnX = fireBall.speedOnX*-1
		end
		if fireBall.y >= height or fireBall.y <= 0 then
			fireBall.speedOnY = fireBall.speedOnY*-1
		end
	end
)
