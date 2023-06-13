-- ↓ START EDITABLE OPTIONS ↓ --
-- Column 1
tl01='TEXT01'
tl02='TEXT02'
tl03='TEXT03'

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
smalltext=loadFont('Play',30)
subtext=loadFont('Play',8)

setDefaultStrokeColor(back,Shape_Line,0,0,0,0.5)
setDefaultShadow(back,Shape_Line,6,0,0,0,0.5)
setDefaultFillColor(front,Shape_BoxRounded,249/255,212/255,123/255,1)
setDefaultFillColor(front,Shape_Text,0,0,0,1)
setDefaultFillColor(front,Shape_Box,0.075,0.125,0.156,1)
setDefaultFillColor(front,Shape_Text,0.710,0.878,0.941,1)
setDefaultTextAlign(left,AlignH_Left,AlignV_Baseline)
setDefaultTextAlign(right,AlignH_Left,AlignV_Baseline)
setBackgroundColor(15/255,24/255,29/255)
t1=390
h1=190

-- Function from d6rks1lv3rz3r0, It does stuff.
function DrawHub(layer,hublayer,r,g,b,CX,CY,scale)
    local rx, ry = getResolution()
    local vw = rx/100
    local vh = ry/100
    local PX = {-0.1715,-0.1715,-0.1735,-0.1735,-0.1535,0,0.7600,0.7835,0.7835,0.7835,0.7835,
        0.7835,0.7835,0.7835,0.7600,0,-0.1535,-0.1735,-0.1735,-0.1715,-0.1715}
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
function renderFooter(footerNote)
    local h_factor=0
    local h=20
    addLine(back,0,ry-h+h_factor,rx,ry-h+h_factor)
    addBox(front,0,ry-h-h_factor,rx,h)
    setNextFillColor(front,0.24,0.25,0.25,1)
    addText(front,subtext,'Locura Hub X3 v1.0',10,ry-8)
    addText(front,subtext,'G I T H U B  /  L O C U R A D U',rx-120,ry-8)
end

renderFooter(footerNote)
addText(left,smalltext,tl01,t1,125)
addText(left,smalltext,tl02,t1,321)
addText(left,smalltext,tl03,t1,514)
--
DrawHub(front,hublayer,0.075,0.125,0.156,h1,114,1)
DrawHub(front,hublayer,0.075,0.125,0.156,h1,307,1)
DrawHub(front,hublayer,0.075,0.125,0.156,h1,500,1)
requestAnimationFrame(10)
