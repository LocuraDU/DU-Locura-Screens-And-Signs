-- ↓ START EDITABLE OPTIONS ↓ --
text = 'LOCURA MINING CO' -- What you want it to say
textSize = 100 -- Bigger means bigger, smaller means smaller
DaFont = 6 -- The Font
isVerticalText = false -- False if you want horizontal
totalDots = 200 -- Too many can crash the script, you have been warned
dotSpeed = 12 -- How fast the dots CAN move: Speed is random between 0 and selected dot speed
textColor = {Red = 1.0, Green = 1.0, Blue = 1.0, Opacity = 1.0} -- Text color and opacity
dotColor = {Red = 0.2, Green = 2.0, Blue = 0.2, Opacity = 1.0} -- Dot color and opacity
lineColor = {Red = 0.2, Green = 2.0, Blue = 0.2, Opacity = 1.0} -- Line color and opacity
backColor = {Red = 0.05, Green = 0.05, Blue = 0.05} -- Background color
rotate = true -- To rotate or not to rotate
-- ↑ END EDITABLE OPTIONS ↑ --

-- DONT EDIT BELOW THIS LINE --

-- Information / Updates / Downloads: GitHub/LocuraDU 
-- Code: GitHub/LocuraDU & Unknown
-- Design: Unknown
-- Info: LocuraDU is a mod hub for many games by GitHub/CredenceHamby
-- Love With Your Heart, Use Your Head For Everything Else - Captain Disillusion

backLayer = createLayer()
textLayer = createLayer()

if not init then -- Start Init
    init = true
    
    -- Available Font Styles
    fontStyles = {}
    fontStyles[1]  = 'FiraMono'
    fontStyles[2]  = 'FiraMono-Bold'
    fontStyles[3]  = 'Montserrat'
    fontStyles[4]  = 'Montserrat-Light'
    fontStyles[5]  = 'Montserrat-Bold'
    fontStyles[6]  = 'Play'
    fontStyles[7]  = 'Play-Bold'
    fontStyles[8]  = 'RefrigeratorDeluxe'
    fontStyles[9]  = 'RefrigeratorDeluxe-Light'
    fontStyles[10] = 'RobotoCondensed'
    fontStyles[11] = 'RobotoMono'
    fontStyles[12] = 'RobotoMono-Bold'
    
    
    -- Vars
    Screen = {}
    Dots = {}
    textVerticalPlacement = 0
    textVerticalIncrement = textSize - 10
    charIndex = 0
    xRotation = 1
    yRotation = 1
    zRotation = 0
    selectedFont = fontStyles[DaFont]
    
    -- Functions
    function Ternary(condition,x,y) if condition then return x else return y end end
    function GetScreen(w,h) Screen = {x = w, y = h, Half = {x = math.floor(w/2), y = math.floor(h/2)}, MaxLength = Ternary(w>h,w,h), HalfMaxLength = Ternary(w>h, w/2, h/2)} end
    function AddDot() Dots[#Dots+1] = {Velocity = {x = math.random(-dotSpeed,dotSpeed), y = math.random(-dotSpeed,dotSpeed), z = math.random(-dotSpeed,dotSpeed)}, Position = {x = math.random(-(10 + Screen.HalfMaxLength), Screen.HalfMaxLength + 10), y = math.random(-(10 + Screen.HalfMaxLength), Screen.HalfMaxLength + 10), z = math.random(-Screen.HalfMaxLength, Screen.HalfMaxLength)}} end
    function AddDots() for i = 1, totalDots + 1, 1 do AddDot() end end
    function RefreshDot() return {Velocity = {x = math.random(-dotSpeed,dotSpeed), y = math.random(-dotSpeed,dotSpeed), z = math.random(-dotSpeed,dotSpeed)}, Position = {x = math.random(-(10 + Screen.HalfMaxLength), Screen.HalfMaxLength + 10), y = math.random(-(10 + Screen.HalfMaxLength), Screen.HalfMaxLength + 10), z = math.random(-Screen.HalfMaxLength, Screen.HalfMaxLength)}} end
    function UpdateDots() for k,dot in ipairs(Dots) do Dots[k] = UpdateDot(dot) end end
    function GetDistnace(origin,des) return math.abs(math.sqrt((origin.x - des.x)^2 + (origin.y - des.y)^2 + (origin.z - des.z)^2)) end
    function RotateX(a, p) return {x = p.x, y = p.y * math.cos(a) - p.z * math.sin(a), z = p.z * math.cos(a) + p.y * math.sin(a)} end
    function RotateY(a, p) return {x = p.x * math.cos(a) - p.z * math.sin(a), y = p.y, z = p.z * math.cos(a) + p.x * math.sin(a)} end
    function RotateZ(a, p) return {x = p.x * math.cos(a) - p.y * math.sin(a), y = p.y * math.cos(a) + p.x * math.sin(a), z = p.z} end
    
    function DrawDots()
        for k,dot in ipairs(Dots) do
            local np = RotatePoints(xRotation, yRotation, zRotation, dot.Position)
            setNextFillColor(backLayer, dotColor.Red, dotColor.Green, dotColor.Blue, dotColor.Opacity)
            addCircle(backLayer, Screen.Half.x + np.x , Screen.Half.y + np.y, Ternary(np.z * 0.005 < 1, 1, np.z * 0.005))
        end    
    end
    
    function UpdateDot(dot)
        if dot.Position.x < -(Screen.HalfMaxLength + 10) then
            dot = RefreshDot()
        elseif dot.Position.x > Screen.HalfMaxLength + 10 then
            dot = RefreshDot()
        elseif dot.Position.y < -(Screen.HalfMaxLength + 10) then
            dot = RefreshDot()
        elseif dot.Position.y > Screen.HalfMaxLength + 10 then
            dot = RefreshDot()
        elseif dot.Position.z < -(Screen.HalfMaxLength + 10) then
            dot = RefreshDot()
        elseif dot.Position.z > Screen.HalfMaxLength + 10 then
            dot = RefreshDot()
        end
        
        dot.Position.x = dot.Position.x + dot.Velocity.x * 0.1 
        dot.Position.y = dot.Position.y + dot.Velocity.y * 0.1
        dot.Position.z = dot.Position.z + dot.Velocity.z * 0.1
        return dot
    end
    
    function DrawConnections()
        for i = 1, totalDots, 1 do
            for j = i + 1, totalDots, 1 do
                local dist = GetDistnace(Dots[i].Position,Dots[j].Position)
                if dist < 175 then
                    local np1 = RotatePoints(xRotation, yRotation, zRotation, Dots[i].Position)
                    local np2 = RotatePoints(xRotation, yRotation, zRotation, Dots[j].Position)
                    
                    setNextStrokeColor(backLayer, (dist *.002)*lineColor.Red, (dist *.002)*lineColor.Green, (dist *.002)*lineColor.Blue, (dist *.002)*lineColor.Opacity)
                    setNextStrokeWidth(backLayer, 1)
                    addLine(backLayer, Screen.Half.x + np1.x, Screen.Half.y + np1.y, Screen.Half.x + np2.x, Screen.Half.y + np2.y)
                end
            end 
        end
    end

    function Split(s, delimiter)
        result = {};
        for match in (s..delimiter):gmatch("(.-)"..delimiter) do
            table.insert(result, match);
        end
        return result;
    end
    
    function Wave()
        colorTick = colorTick + 30
        if (colorTick > 765) then colorTick = 0 end
        if (colorTick < 256) then
            return colorTick/255, 0, (255 - colorTick)/255
        elseif (colorTick < 511) then
            return (510 - colorTick)/255, (colorTick - 255)/255, 0
        elseif (colorTick < 766) then
            return 0, (765 - colorTick)/255, (colorTick - 510)/255
        end    
    end
    
    function ResetRotation()
        xRotation = 0
        yRotation = 0
    end
    
    function RotatePoints(xa, ya, za, p)
        p = RotateX(xa, p)
        p = RotateY(ya, p)
        p = RotateZ(za, p)
        return p
    end
    
    function GetNextTextVerticalPlacement()
        local t = textVerticalPlacement
        textVerticalPlacement = textVerticalPlacement + textVerticalIncrement 
        return t
    end
    
    function GetNextChar()
        charIndex = charIndex + 1
        local l = string.len(text)
        local c = string.sub(text,charIndex,charIndex)
        return c
    end
    
    -- Get the screen size
    GetScreen(getResolution())
    UpdateDots()
    AddDots()
end -- End Init

if rotate then
    xRotation = xRotation + 0.005
    yRotation = yRotation + 0.0025
end

local textY = Screen.Half.y - math.ceil(((textSize * string.len(text))/2)*0.90) + 25

-- Resets
font = loadFont(selectedFont, textSize)
textVerticalPlacement = 0
charIndex = 0

-- Update the dots
UpdateDots()
DrawConnections()
DrawDots()

-- Text
setDefaultFillColor(textLayer, Shape_Text, textColor.Red, textColor.Green, textColor.Blue, textColor.Opacity)

if isVerticalText then
    for i = 1, #text, 1 do 
       setNextTextAlign(textLayer, AlignH_Center, AlignV_Middle)
       addText(textLayer, font, GetNextChar(), Screen.Half.x, textY + GetNextTextVerticalPlacement())
    end
else
    setNextTextAlign(textLayer, AlignH_Center, AlignV_Middle)
    addText(textLayer, font, text, Screen.Half.x, Screen.Half.y)
end

setBackgroundColor(backColor.Red, backColor.Green, backColor.Blue)
requestAnimationFrame(2)
