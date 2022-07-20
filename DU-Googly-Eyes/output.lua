if RightEye ~= nil then RightEye.activate() end
if LeftEye ~= nil then LeftEye.activate() end
if Mouth ~= nil then Mouth.activate() end
if RightEye ~= nil then RightEye.setCenteredText('Right Eye') end
if LeftEye ~= nil then LeftEye.setCenteredText('Left Eye') end
if Mouth ~= nil then Mouth.setCenteredText('Mouth') end

-- vars
eyeX = 950
eyeY = 520
eyePosX = 950
eyePosY = 520
mouthX = 950
mouthY = 520
mouthPosX = 950
mouthPosY = 520
currentMouth = 1
holdMouthCount = 1
direction = 1
speed = 20
mouthSpeed = 3
isEyeMoving = true
stare = false
stareCount = 0
lastEyePos = 1
isBlinking = false
blinkHeight = 0

eye1 = '<circle cx="'.. eyeX ..'" cy="'.. eyeY ..'" r="500" stroke="white" stroke-width="3" fill="red" />'
eye1 = eye1 .. '<circle cx="'.. eyeX ..'" cy="'.. eyeY ..'" r="300" fill="black" />'
eye1 = eye1 .. '<circle cx="'.. eyeX - 80 ..'" cy="'.. eyeY + 80 ..'" r="75" fill="white" />'
eye2 = '<circle cx="'.. eyeX ..'" cy="'.. eyeY ..'" r="500" stroke="white" stroke-width="3" fill="red" />'
eye2 = eye2 .. '<circle cx="'.. eyeX ..'" cy="'.. eyeY ..'" r="300" fill="black" />'
eye2 = eye2 .. '<circle cx="'.. eyeX + 80 ..'" cy="'.. eyeY + 80 ..'" r="75" fill="white" />'
