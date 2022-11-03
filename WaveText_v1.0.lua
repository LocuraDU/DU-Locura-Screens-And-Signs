local layer = createLayer()
local rx, ry = getResolution()
local time = getTime()
-- https://github.com/EricHamby/DU-LUA-Scripts
-- DU-Wave-Text
-- v1.0
local font = loadFont("Montserrat", 100)

setDefaultTextAlign(layer, AlignH_Left, AlignV_Middle)

local str = "Locura Mining Co!"

local strArray = {}
for char in string.gmatch(str, ".") do
    table.insert(strArray, char)
end

local widthTotal = getTextBounds(font, str)

for k,v in pairs(strArray) do
    local diff = widthTotal - getTextBounds(font, string.sub(str, k, -1))
    local x = (rx/2-widthTotal/2) + diff
    
    local offset = k/#strArray --0 to 1 char number to string lenght
    local frequency = time+offset*10
    local amplitude = 20
    local y = (ry/2) + math.sin(frequency)*amplitude
    
    addText(layer, font, v, x, y)
end

requestAnimationFrame(1)
