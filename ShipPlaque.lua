-- ↓ START EDITABLE OPTIONS ↓ --
local mainTitle='LOCURA INDUSTRIES' -- Main Center Title
local subTop='LONG HAUL TRANSPORT' -- Top Sub Text
local subBottom='JUNE 14 2022 // SN : 47493765' -- Bottom Sub Text
-- ↑ END EDITABLE OPTIONS ↑ --

-- DONT EDIT BELOW THIS LINE --

-- DU-Locura-Screens-And-Signs
-- Visit GitHub/LocuraDU For Information / Updates / Downloads 
-- Code: GitHub/CredenceHamby & GitHub/Jericho1060
-- Design: GitHub/CredenceHamby
-- Built using the wonderful tools at https://du-lua.dev/
-- Love With Your Heart, Use Your Head For Everything Else - Captain Disillusion

local layer=createLayer()  
local rx,ry=getResolution()
local title=loadFont('Play',100)
local subtext=loadFont('Play',15)
local font=loadFont('Play',30)

function getWideStr(str)
    local widestr=""
    for i = 1, #str do
        widestr = widestr .. str:sub(i,i) .. " "
    end
    return widestr
end

local widestrt=getWideStr(subTop)
local widestrb=getWideStr(subBottom)
setBackgroundColor(15/255,24/255,29/255)
setNextFillColor(layer,0,0,0,1)                
setDefaultStrokeColor(layer,Shape_Line,1,1,1,0.5)
setDefaultTextAlign(layer,AlignH_Center,AlignV_Middle)  
setDefaultStrokeWidth(layer,Shape_Line,0.001) 

function drawDoubleLine(layer,x,y,rx,space)
    addLine(layer,x,y,rx-x,y)
    addLine(layer,x,y+space,rx-x,y+space) 
end

local x,borderSpacing=10,4
drawDoubleLine(layer,x,150,rx,borderSpacing)
addText(layer,font,widestrt,rx/2,185)
addText(layer,title,mainTitle,rx/2,ry/2)  
addText(layer,font,widestrb,rx/2,425)
drawDoubleLine(layer,x,460,rx,borderSpacing)
setNextFillColor(layer,0.24,0.25,0.25,1) 
addText(layer,subtext,'GITHUB/LOCURADU',rx/2,475) 
