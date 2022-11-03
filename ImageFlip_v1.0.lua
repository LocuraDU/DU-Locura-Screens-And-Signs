-- Made by NQ-Deckard for Hadron ;-)
-- Start of configuration

local secondsBetweenImages = 5 -- Number of seconds between images
local backgroundImage = "assets.prod.novaquark.com/102348/3cf92ccf-e518-4456-9d90-f115b6324b0f.jpg" -- Set to false to disable // backgroundImage = false

if not init then
    init = true
    images = { -- Add all your images to this table, as strings seperated by comma's.
        "assets.prod.novaquark.com/102348/046f500a-e4eb-4188-ab19-6ef1a92ad7c4.jpg",  --red
        "assets.prod.novaquark.com/102348/8a89711b-98dc-4d27-b79a-786164fdb658.jpg", -- blue
        "assets.prod.novaquark.com/102348/d8ce629a-e940-4b20-a576-5cd289c42b9b.jpg", -- green 
        }
end

-- End of configuration - Do not alter below this line

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

requestAnimationFrame(15)  -- request screen refresh every 15 frames
