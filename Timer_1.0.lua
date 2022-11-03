local version = '1.0'
local rx,ry = getResolution()
local back=createLayer()
local front=createLayer()
local time = getTime()
local small=loadFont('Play',14)
local smallBold=loadFont('Play-Bold',18)
local storageBar = createLayer()
local colorLayer = createLayer()
local layer = createLayer()

-- DU-Locura-Timer
-- Code: GitHub/LocuraDU & Discord/Davemane42
-- Design: GitHub/LocuraDU & GitHub/Jericho1060

setBackgroundColor( 15/255,24/255,29/255)
setDefaultStrokeColor( back,Shape_Line,0,0,0,0.5)
setDefaultShadow( back,Shape_Line,6,0,0,0,0.5)
setDefaultFillColor( front,Shape_Box,0.075,0.125,0.156,1)
setDefaultFillColor( front,Shape_Text,0.710,0.878,0.941,1)

function renderHeader(title)
    local h_factor = 12
    local h = 35
    addLine( back,0,h+12,rx,h+12)
    addBox(front,0,12,rx,h)
    addText(front,small,"" ..version.. "",rx-50,35)
    addText(front,smallBold,title,44,35)
end

renderHeader('Locura Timer')

local speed = 0.5 -- 0 to 1
local font = loadFont("Montserrat", 120)

setDefaultFillColor(layer, Shape_Text, 0.075,0.125,0.156,1)
setDefaultStrokeColor(layer, Shape_Text, 0.710,0.878,0.941,1)
setDefaultStrokeWidth(layer, Shape_Text, 2)

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
