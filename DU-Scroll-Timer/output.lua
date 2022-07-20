local layer = createLayer()
local rx, ry = getResolution()
local time = getTime()

local speed = 0.5 -- 0 to 1
local font = loadFont("Montserrat", 128)

setDefaultFillColor(layer, Shape_Text, 0, 0, 0, 1)
setDefaultStrokeColor(layer, Shape_Text, 2, 2, 2, 1)
setDefaultStrokeWidth(layer, Shape_Text, 3)

setDefaultTextAlign(layer, AlignH_Center, AlignV_Middle)

local hours = string.format("%02d", math.floor(time/3600 % 24))
local minutes = string.format("%02d", math.floor(time/60 % 60))
local seconds = string.format("%02d", math.floor(time % 60))

function renderDigit(digit, maxDigit, timeScale, xPos)
    local offset = (math.max(timeScale-speed, time%timeScale)-(timeScale-speed))*(1/speed) -- 0 to 1
    local offsetY = offset*ry

    addText(layer, font, digit, xPos, ry/2+offsetY)
    addText(layer, font, (tonumber(digit)+1)%maxDigit, xPos, ry/2-ry+offsetY)
end

-- Hours
local hourLimit, hourTimeScale = 10, 36000
if hours:sub(1,1) == "2" then
    hourLimit = 4
    hourTimeScale = 14400
end
renderDigit(hours:sub(1,1), 3, hourTimeScale, rx/2-280)
renderDigit(hours:sub(2,2), hourLimit, 3600, rx/2-200)

addText(layer, font, ":", rx/2-120, ry/2)

-- Minutes
renderDigit(minutes:sub(2,2), 10, 60, rx/2+40)
renderDigit(minutes:sub(1,1), 06, 600, rx/2-40)

addText(layer, font, ":", rx/2+120, ry/2)

-- Seconds
renderDigit(seconds:sub(1,1), 06, 10, rx/2+200)
renderDigit(seconds:sub(2,2), 10, 1, rx/2+280)

requestAnimationFrame(1)
