-- ↓ START EDITABLE OPTIONS ↓ --
title='Your Title' -- Header Title

tl01='' --R1C2
tl06='' --R1C2
tl11='' --R1C3
tl16='' --R1C4

tl02='' --R2C1
tl07='' --R2C2
tl12='' --R2C3
tl17='' --R2C4

tl03='' --R3C1
tl08='' --R3C2
tl13='' --R3C3
tl18='' --R3C4

tl04='' --R4C1
tl09='' --R4C2
tl14='' --R4C3
tl19='' --R4C4

tl05='' --R5C1
tl10='' --R5C2
tl15='' --R5C3
tl20='' --R5C4

tl21='' --R6C1
tl22='' --R6C2
tl23='' --R6C3
tl24='' --R6C4


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
t1=95 t2=352 t3=608 t4=863
h1=95 h2=352 h3=608 h4=863
v1=51 v2=147 v3=243 v4=339 v5=435 v6=531

-- Function from d6rks1lv3rz3r0, It does stuff.
function DrawHub(layer,hublayer,r,g,b,CX,CY,scale,txto)
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
         if #txto > 0 then
        addLine(layer, scale*PX[ii]*rx + CX, scale*PY[ii]*ry + CY, scale*PX[ii+1]*rx + CX, scale*PY[ii+1]*ry + CY) 
         end
    end
end

-- Function from Jericho1060, It does other stuff.
function renderFooter(footerNote)
    local h_factor=0
    local h=20
    addLine(back,0,ry-h+h_factor,rx,ry-h+h_factor)
    addBox(front,0,ry-h-h_factor,rx,h)
    addText(front,smallBold,title,10,ry-4)
    setNextFillColor(front,0.24,0.25,0.25,1)
    addText(front,subtext,'Locura Hub X24 v1.0',rx-90,ry-8)
end

renderFooter(footerNote)
addText(left,smalltext,tl01,t1,v1+53)
addText(left,smalltext,tl02,t1,v2+53)
addText(left,smalltext,tl03,t1,v3+53)
addText(left,smalltext,tl04,t1,v4+53)
addText(left,smalltext,tl05,t1,v5+53)
addText(left,smalltext,tl21,t1,v6+53)
--
addText(left,smalltext,tl06,t2,v1+53)
addText(left,smalltext,tl07,t2,v2+53)
addText(left,smalltext,tl08,t2,v3+53)
addText(right,smalltext,tl09,t2,v4+53)
addText(right,smalltext,tl10,t2,v5+53)
addText(right,smalltext,tl22,t2,v6+53)
--
addText(right,smalltext,tl11,t3,v1+53)
addText(right,smalltext,tl12,t3,v2+53)
addText(right,smalltext,tl13,t3,v3+53)
addText(right,smalltext,tl14,t3,v4+53)
addText(right,smalltext,tl15,t3,v5+53)
addText(right,smalltext,tl23,t3,v6+53)
--
addText(right,smalltext,tl16,t4,v1+53)
addText(right,smalltext,tl17,t4,v2+53)
addText(right,smalltext,tl18,t4,v3+53)
addText(right,smalltext,tl19,t4,v4+53)
addText(right,smalltext,tl20,t4,v5+53)
addText(right,smalltext,tl24,t4,v6+53)
--
DrawHub(front,hublayer,0.075,0.125,0.156,h1,v1,0.5,tl01)
DrawHub(front,hublayer,0.075,0.125,0.156,h1,v2,0.5,tl02)
DrawHub(front,hublayer,0.075,0.125,0.156,h1,v3,0.5,tl03)
DrawHub(front,hublayer,0.075,0.125,0.156,h1,v4,0.5,tl04)
DrawHub(front,hublayer,0.075,0.125,0.156,h1,v5,0.5,tl05)
DrawHub(front,hublayer,0.075,0.125,0.156,h1,v6,0.5,tl21)
-- 
DrawHub(front,hublayer,0.075,0.125,0.156,h2,v1,0.5,tl06)
DrawHub(front,hublayer,0.075,0.125,0.156,h2,v2,0.5,tl07)
DrawHub(front,hublayer,0.075,0.125,0.156,h2,v3,0.5,tl08)
DrawHub(front,hublayer,0.075,0.125,0.156,h2,v4,0.5,tl09)
DrawHub(front,hublayer,0.075,0.125,0.156,h2,v5,0.5,tl10)
DrawHub(front,hublayer,0.075,0.125,0.156,h2,v6,0.5,tl22)
--
DrawHub(front,hublayer,0.075,0.125,0.156,h3,v1,0.5,tl11)
DrawHub(front,hublayer,0.075,0.125,0.156,h3,v2,0.5,tl12)
DrawHub(front,hublayer,0.075,0.125,0.156,h3,v3,0.5,tl13)
DrawHub(front,hublayer,0.075,0.125,0.156,h3,v4,0.5,tl14)
DrawHub(front,hublayer,0.075,0.125,0.156,h3,v5,0.5,tl15)
DrawHub(front,hublayer,0.075,0.125,0.156,h3,v6,0.5,tl23)
--
DrawHub(front,hublayer,0.075,0.125,0.156,h4,v1,0.5,tl16)
DrawHub(front,hublayer,0.075,0.125,0.156,h4,v2,0.5,tl17)
DrawHub(front,hublayer,0.075,0.125,0.156,h4,v3,0.5,tl18)
DrawHub(front,hublayer,0.075,0.125,0.156,h4,v4,0.5,tl19)
DrawHub(front,hublayer,0.075,0.125,0.156,h4,v5,0.5,tl20)
DrawHub(front,hublayer,0.075,0.125,0.156,h4,v6,0.5,tl24)

requestAnimationFrame(10)
