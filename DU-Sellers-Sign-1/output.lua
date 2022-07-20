local logo ="assets.prod.novaquark.com/63518/3cc7d62b-5dd1-47eb-89ee-f6edc5ea125b.png"
local shipImage ="assets.prod.novaquark.com/63518/2df209da-9169-4b5e-8b73-7083ecff0807.png"

-- Animated BG on or off --
local bgAnim = true

-- https://github.com/EricHamby/DU-LUA-Scripts
-- DU-Sellers-Sign-1
-- v1.0

local title = "GSL Plutus"
local price ="BP: 1,500,000  Token: N/A"

local mainFont = "Play-Bold"
local secondaryFont = "Play-Bold"

local ship_desc={
        "Name: GSL Plutus",
        "Role: Astoird Hunter",
        "Type: Space Only",
        " ",
        "--- Equipment ---",
        " ",
        "DSAT: No",
        "Shield: Medium",
        "Weapons: No",
        "Cargo: 2 M Cans",
       
        
    }

local ship_stats ={
       "Core Size: S",
	   "Dry Mass: 401T",
		"Max Space Thrust: 18.2g",
        "Max Space Brake: 17.1g",
        "Low Space Lift: 3.43g",  
        "Max Atmo Thrust: N/A",
        "Max Atmo Brake:  N/A",
        "Low Atmo Lift:   N/A",
        "High Atmo Lift:  N/A",
        "Max Speed:       N/A",
        "Max Weight:      N/A",
            
    }

------ Colors ------

-- Static Bacground color
local bgColor = { 0.0,0.1,0.1,0.8 }

-- Border Color --
local border = {0.37,0.0,0.37,1}

-- Box Fill Color --
local fill = {0.2,0.2,0.2,0.6}

-- Main Font Color --
local mainFontC = {1.0,1.0,1.0,1.0}

-- Secondary Font Color --
local secondaryFontC = {1.0,1.0,1.0,1.0}


-- Background moving circles --
local ballCount = 4000
local speed = 20
local ballR = 0.4
local ballG = 0.1
local ballB = 0.4

-- Thanks NQ Deckard for this little helper fucntion, that made me face palm wondering why i didnt think of that
local function rgba(t)
    return t[1], t[2], t[3], t[4]
end

---- DO NOT EDIT BELOW THIS POINT UNLESS YOU KNOW WHAT YOU ARE DOING ----
--Thanks to NQ-Node for the cool ball simulation code
if bgAnim == true then
local rx, ry = getResolution()

--[[ init ]]--------------------------------------------------------------------

if not init then
    init = true

    function randF (a, b)
        return a + (b - a) * math.random()
    end
        
    function randExp ()
        return -math.log(1.0 - math.random())
    end

    balls = {}
    for i = 1, ballCount do
        local e = {}
        e.x = randF(0, rx)
        e.y = randF(0, ry)
        e.r = 1 + 1.0 * math.log(1.0 - math.random()) ^ 2.0
        e.vx = randF(-1, 1) * randExp()
        e.vy = randF(-1, 1) * randExp()
        e.cx = ballR * math.random() ---
        e.cy = ballG * math.random()
        e.cz = ballB * math.random()
        e.ca = math.random()
        table.insert(balls, e)
    end
end

--[[ simulation ]]--------------------------------------------------------------

local dt = speed * getDeltaTime()

for _, v in ipairs(balls) do
    v.x = v.x + dt * v.vx
    v.y = v.y + dt * v.vy
    if v.x < 0 or v.x > rx then
        v.x = v.x - dt * v.vx
        v.vx = -v.vx
    end
    if v.y < 0 or v.y > ry then
        v.y = v.y - dt * v.vy
        v.vy = -v.vy
    end
end

--[[ rendering ]]---------------------------------------------------------------

local l = createLayer()

-- render balls
for _, e in ipairs(balls) do
    setNextFillColor(l, e.cx, e.cy, e.cz, e.ca)
    addCircle(l, e.x, e.y, e.r)
end



requestAnimationFrame(1)
    
else
    
end

--------------------------------------------------------------------------------


--- Background

local layer = createLayer()
local rx, ry = getResolution()
setNextFillColor(layer, rgba(bgColor))
setDefaultStrokeColor(layer, Shape_Box, rgba(border)) 
setDefaultStrokeWidth(layer, Shape_Box, 4) 
addBox(layer, rx, ry, rx-1, ry-1)


-- Header

local layer5 = createLayer() 
--local rx, ry = getResolution()
setDefaultStrokeColor(layer, Shape_BoxRounded, rgba(border)) 
setDefaultStrokeWidth(layer, Shape_BoxRounded, 2) 
setNextFillColor(layer,rgba(fill))  
addBoxRounded(layer, 14, 12, 700, 96, 10)
local logoimg = loadImage(logo)
addImage(layer5, logoimg, 20 ,20 ,80, 80)



-- Price box

local layerP = createLayer()
setDefaultStrokeColor(layer, Shape_BoxRounded, rgba(border)) 
setDefaultStrokeWidth(layer, Shape_BoxRounded, 2) 
setNextFillColor(layer, rgba(fill))  
addBoxRounded(layer, 14, 120, 700, 60, 10)
local font = loadFont(mainFont,40)
setNextFillColor(layer,rgba(mainFontC))
addText(layer, font, price, 20, 160)


-- Ship Image
local layerS = createLayer()
local SImage =loadImage(shipImage)
addImage(layer, SImage, 725,15,284,160)
setDefaultStrokeColor(layer, Shape_BoxRounded, rgba(border)) 
setDefaultStrokeWidth(layer, Shape_BoxRounded, 2)
setNextFillColor(layer,rgba(fill))
addBoxRounded(layer,725,15,285,161,20)


-- Left Panel
 
local layer1 = createLayer()
setDefaultStrokeColor(layer, Shape_BoxRounded, rgba(border)) 
setDefaultStrokeWidth(layer, Shape_BoxRounded, 2) 
setNextFillColor(layer, rgba(fill))  
addBoxRounded(layer, 15, 190, 488, 370, 20 )



--- Right Panel
local layer3 = createLayer()
setDefaultStrokeColor(layer, Shape_BoxRounded, rgba(border)) 
setDefaultStrokeWidth(layer, Shape_BoxRounded, 2) 
setNextFillColor(layer, rgba(fill))
local rx, ry = getResolution() 
addBoxRounded(layer, 513, 190, 496, 370, 20)



local layer6 = createLayer()
setNextTextAlign(layer, AlignH_Right, AlignV_Middle)
local rx, ry = getResolution()
local font = loadFont(mainFont,60)
setNextFillColor(layer,rgba(mainFontC))
addText(layer, font, title, rx/2, ry/10)

---- Left Panel Description ---
local lines = ship_desc
local fontSize = 25
local font = loadFont(secondaryFont, fontSize)
local layer = createLayer()
local y = fontSize + 16

for i, line in ipairs(lines) do
    setNextFillColor(layer,rgba(secondaryFontC))
    addText(layer, font, line, 36, 200+y)
    y = y + fontSize + 2
end

---- RIght Panel Stats ----
local lines = ship_stats
local fontSize = 25
local font = loadFont(secondaryFont, fontSize)
local layer = createLayer()
local y = fontSize + 16

for i, line in ipairs(lines) do
    setNextFillColor(layer,rgba(secondaryFontC))
    addText(layer, font, line, 538, 200+y)
    y = y + fontSize + 2
end
