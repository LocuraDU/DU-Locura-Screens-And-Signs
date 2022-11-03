-- Made by NQ-Deckard for Hadron ;-)
-- Start of configuration

local secondsBetweenImages = 5 -- Number of seconds between images
local backgroundImage = "assets.prod.novaquark.com/102348/3cf92ccf-e518-4456-9d90-f115b6324b0f.jpg" -- Set to false to disable // backgroundImage = false

if not init then
    init = true
    images = { -- Add all your images to this table, as strings seperated by comma's.
        "assets.prod.novaquark.com/130546/92f70041-2f4f-4bf7-a5b7-73d2031a5406.jpg", 
        "assets.prod.novaquark.com/130546/a151c00f-38f4-4ec1-b1eb-cec983646a44.jpg", 
        "assets.prod.novaquark.com/130546/a3459a69-cda2-4153-821b-5e9256516c4e.jpg",  
        }
end

-- DONT EDIT BELOW THIS LINE --

-- Information / Updates / Downloads: GitHub/LocuraDU 
-- Code: GitHub/LocuraDU & Discord/NQ-Deckard
-- Design: Discord/NQ-Deckard
-- Info: LocuraDU is a mod hub for many games by GitHub/CredenceHamby

local imgs = images
local background, foreground = createLayer(), createLayer()
local rx, ry = getResolution()
local imageCount = #imgs
local adjustedTime = getTime() / secondsBetweenImages
local flooredTime = adjustedTime - (adjustedTime % 1)
local displayedImage = loadImage(imgs[(flooredTime % imageCount) + 1])
local preloadImage = loadImage(imgs[((flooredTime + 1) % imageCount) + 1])
addImage(foreground, displayedImage, 0, 0, rx, ry)

if backgroundImage then
    setNextFillColor(background, 1, 1, 1, 1)
    addImage(background, loadImage(backgroundImage), 0, 0, rx, ry)
end

requestAnimationFrame(5)  -- request screen refresh every 15 frames
