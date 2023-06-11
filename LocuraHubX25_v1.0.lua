-- ↓ START EDITABLE OPTIONS ↓ --
title='Your Title' -- Header Title
-- Column 1
tl01='C1R1'
tl02='C1R2'
tl03='C1R3'
tl04='C1R4'
tl05='C1R5'
-- Column 2
tl06='C2R1'
tl07='C2R2'
tl08='C2R3'
tl09='C2R4'
tl10='C2R5'
-- Column 3
tl11='C3R1'
tl12='C3R2'
tl13='C3R3'
tl14='C3R4'
tl15='C3R5'
-- Column 4
tl16='C4R1'
tl17='C4R2'
tl18='C4R3'
tl19='C4R4'
tl20='C4R5'
-- Column 5
tl21='C5R1'
tl22='C5R2' 
tl23='C5R3'
tl24='C5R4'
tl25='C5R5'

-- ↑ END EDITABLE OPTIONS ↑ --

-- DONT EDIT BELOW THIS LINE --

-- Information / Updates / Downloads: GitHub/LocuraDU 
-- Custom Made For SeekerOfHonjo
-- Code: GitHub/LocuraDU & GitHub/Jericho1060 & GitHub/d6rks1lv3rz3r0
-- Design: GitHub/LocuraDU & GitHub/Jericho1060 & GitHub/d6rks1lv3rz3r0
-- Info: LocuraDU is a mod hub for many games by GitHub/CredenceHamby
-- Built using the wonderful tools at https://du-lua.dev/
-- Love With Your Heart, Use Your Head For Everything Else - Captain Disillusion

rx,ry=getResolution()
back=createLayer()
front=createLayer()
left=createLayer()
right=createLayer()

small=loadFont('Play',14)
smallBold=loadFont('Play-Bold',18)
smalltext=loadFont('Play',15)
subtext=loadFont('Play',8)

setDefaultStrokeColor(back,Shape_Line,0,0,0,0.5)
setDefaultShadow(back,Shape_Line,6,0,0,0,0.5)
setDefaultFillColor(front,Shape_BoxRounded,249/255,212/255,123/255,1)
setDefaultFillColor(front,Shape_Text,0,0,0,1)
setDefaultFillColor(front,Shape_Box,0.075,0.125,0.156,1)
setDefaultFillColor(front,Shape_Text,0.710,0.878,0.941,1)
setDefaultTextAlign(left,AlignH_Center,AlignV_Baseline)
setDefaultTextAlign(right,AlignH_Center,AlignV_Baseline)
setBackgroundColor(15/255,24/255,29/255)
t1=130 t2=322 t3=518 t4=705 t5=898
h1=127 h2=319 h3=512 h4=704 h5=896

-- Function from d6rks1lv3rz3r0, It does stuff.
function DrawHub(layer,hublayer,r,g,b,CX,CY,scale)
    local rx, ry = getResolution()
    local vw = rx/100
    local vh = ry/100
    local PX = {-0.1715,-0.1715,-0.1735,-0.1735,-0.1535,0,0.1535,0.1735,0.1735,0.1715,0.1715,
        0.1715,0.1735,0.1735,0.1535,0,-0.1535,-0.1735,-0.1735,-0.1715,-0.1715}
    local PY = {0,-0.055,-0.057,-0.08,-0.128,-0.128,-0.128,-0.08,-0.057,-0.055,0,
        0.055,0.057,0.08,0.128,0.128,0.128,0.08,0.057,0.055,0}
    local r = r or R[1]
    local g = g or G[1]
    local b = b or B[1]
    local CX = CX or 0.5*rx
    local CY = CY or 0.5*ry
    local scale = scale or 2
    setDefaultStrokeWidth(front,Shape_Line,scale*1*vh)
    setDefaultStrokeColor(front,Shape_Line,r,g,b, 1) 
    setDefaultFillColor(front,Shape_Polygon,r + 1,g + 1,b + 1, 1) 
    for ii = 1,#PX-1,1 do
        addLine(layer, scale*PX[ii]*rx + CX, scale*PY[ii]*ry + CY, scale*PX[ii+1]*rx + CX, scale*PY[ii+1]*ry + CY) 
    end
end

-- Function from Jericho1060, It does other stuff.
function renderHeader(title)
    h_factor=12
    h=35
    addLine(back,0,h+12,rx,h+12)
    addBox(front,0,12,rx,h)
    addText(front,smallBold,title,44,35)
    addText(front,small,'Locura Hub X25 v1.0',rx-180,35)
end

renderHeader(title)
addText(left,smalltext,tl01,t1,165)
addText(left,smalltext,tl02,t1,262)
addText(left,smalltext,tl03,t1,358)
addText(left,smalltext,tl04,t1,455)
addText(left,smalltext,tl05,t1,551)
--
addText(left,smalltext,tl06,t2,165)
addText(left,smalltext,tl07,t2,262)
addText(left,smalltext,tl08,t2,358)
addText(right,smalltext,tl09,t2,455)
addText(right,smalltext,tl10,t2,551)
--
addText(right,smalltext,tl11,t3,165)
addText(right,smalltext,tl12,t3,262)
addText(right,smalltext,tl13,t3,358)
addText(right,smalltext,tl14,t3,455)
addText(right,smalltext,tl15,t3,551)
--
addText(right,smalltext,tl16,t4,165)
addText(right,smalltext,tl17,t4,262)
addText(right,smalltext,tl18,t4,358)
addText(right,smalltext,tl19,t4,455)
addText(right,smalltext,tl20,t4,551)
--
addText(right,smalltext,tl21,t5,165)
addText(right,smalltext,tl22,t5,262)
addText(right,smalltext,tl23,t5,358)
addText(right,smalltext,tl24,t5,455)
addText(right,smalltext,tl25,t5,551)
--
DrawHub(front,hublayer,0.075,0.125,0.156,h1,114,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h1,210,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h1,306,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h1,402,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h1,498,0.5)
-- 
DrawHub(front,hublayer,0.075,0.125,0.156,h2,114,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h2,210,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h2,306,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h2,402,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h2,498,0.5)
--
DrawHub(front,hublayer,0.075,0.125,0.156,h3,114,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h3,210,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h3,306,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h3,402,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h3,498,0.5)
--
DrawHub(front,hublayer,0.075,0.125,0.156,h4,114,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h4,210,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h4,306,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h4,402,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h4,498,0.5)
--
DrawHub(front,hublayer,0.075,0.125,0.156,h5,114,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h5,210,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h5,306,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h5,402,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,h5,498,0.5)
requestAnimationFrame(10)
