-- ↓ START EDITABLE OPTIONS ↓ --
title='Your Title' -- Header Title
-- LEFT SIDE TEXT
tlt1='Lorem ipsum' -- Left side text #1
tlt2='Dolor sit amet' -- Left side text #2
tlt3='Consectetur adipiscing' -- Left side text #3
tlt4='Sed do eiusmod' -- Left side text #4
tlt5='Tempor incididunt' -- Left side text #5
tlt6='Labore et dolore' -- Left side text #6
tlt7='Magna aliqua' -- Left side text #7
tlt8='Ut enim ad minim' -- Left side text #8
-- RIGHT SIDE TEXT
trt1='Quis nostrud' -- Right side text #1
trt2='Exercitation ullamco' -- Right side text #2
trt3='Duis aute irure' -- Right side text #3
trt4='Reprehenderit in voluptate' -- Right side text #4
trt5='Excepteur sint occaecat' -- Right side text #5
trt6='Cupidatat non' -- Right side text #6
trt7='Sunt in culpa' -- Right side text #7
trt8='Deserunt mollit anim' -- Right side text #8
-- ↑ END EDITABLE OPTIONS ↑ --

-- DONT EDIT BELOW THIS LINE --

-- Information / Updates / Downloads: GitHub/LocuraDU 
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
subtext=loadFont('Play',8)

setDefaultStrokeColor(back,Shape_Line,0,0,0,0.5)
setDefaultShadow(back,Shape_Line,6,0,0,0,0.5)
setDefaultFillColor(front,Shape_BoxRounded,249/255,212/255,123/255,1)
setDefaultFillColor(front,Shape_Text,0,0,0,1)
setDefaultFillColor(front,Shape_Box,0.075,0.125,0.156,1)
setDefaultFillColor(front,Shape_Text,0.710,0.878,0.941,1)
setDefaultTextAlign(left,AlignH_Left,AlignV_Baseline)
setDefaultTextAlign(right,AlignH_Right,AlignV_Baseline)
setBackgroundColor(15/255,24/255,29/255)
tlv=230 trv=800 hlv=127.8 hrv=896

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
    addText(front,small,'Locura Hub X16 v1.0',rx-180,35)
end

renderHeader(title)
addText(left,smallBold,tlt1,tlv,120)
addText(left,smallBold,tlt2,tlv,185)
addText(left,smallBold,tlt3,tlv,250)
addText(left,smallBold,tlt4,tlv,315)
addText(left,smallBold,tlt5,tlv,380)
addText(left,smallBold,tlt6,tlv,445)
addText(left,smallBold,tlt7,tlv,508)
addText(left,smallBold,tlt8,tlv,570)
DrawHub(front,hublayer,0.075,0.125,0.156,hlv,114,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hlv,179,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hlv,242,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hlv,307,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hlv,371,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hlv,435,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hlv,499,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hlv,563,0.5)
addText(right,smallBold,trt1,trv,120)
addText(right,smallBold,trt2,trv,185)
addText(right,smallBold,trt3,trv,250)
addText(right,smallBold,trt4,trv,315)
addText(right,smallBold,trt5,trv,380)
addText(right,smallBold,trt6,trv,445)
addText(right,smallBold,trt7,trv,508)
addText(right,smallBold,trt8,trv,570)
DrawHub(front,hublayer,0.075,0.125,0.156,hrv,114,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hrv,179,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hrv,242,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hrv,307,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hrv,371,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hrv,435,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hrv,499,0.5)
DrawHub(front,hublayer,0.075,0.125,0.156,hrv,563,0.5)
requestAnimationFrame(10)
