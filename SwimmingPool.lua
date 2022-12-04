-- ↓ START EDITABLE OPTIONS ↓ --
local bg_image = loadImage("assets.prod.novaquark.com/89757/d60a6bc1-bbc7-4ddf-937e-019a2edc2d42.jpg")
-- ↑ END EDITABLE OPTIONS ↑ --

-- DONT EDIT BELOW THIS LINE --

-- DU-Locura-Screens-And-Signs
-- Visit GitHub/LocuraDU For Information / Updates / Downloads 
-- Script Credits: Discord/Kurock
-- Love With Your Heart, Use Your Head For Everything Else - Captain Disillusion

local rows = 14
local cols = 10
-------------------------------------
local rx, ry = getResolution()
local bg = createLayer()

local t = math.floor(getTime()*cols)
local bg_rx, bg_ry = getImageSize(bg_image)
local bgp_rx = bg_rx/cols
local bgp_ry = bg_ry/rows
subx = bgp_rx *(t%(cols-1))
suby = bgp_ry *(math.floor(t/(cols-1))%(rows-1))

addImageSub(bg, bg_image, 0, 0,rx,ry,subx,suby,bgp_rx,bgp_ry)
requestAnimationFrame(1)
