local rx,ry = getResolution()
-- Discord/Koruzarius
if(not _init)then
    currX=0
    currImage=1
    nextImage=2
    _init=true
end

local layer = createLayer()

_time = _time and _time+getDeltaTime() or 0


images = {}


table.insert(images,loadImage("https://assets.prod.novaquark.com/4745/566b4304-6cc5-4d3d-92ea-44b7f03f453d.jpg") )
table.insert(images,loadImage("https://assets.prod.novaquark.com/4745/5a7a5b02-4a01-4694-b761-199ae2729fb7.jpg") )
table.insert(images,loadImage("https://assets.prod.novaquark.com/91187/3f6d30de-febb-4d3e-9a19-ed1ea8d7467f.jpg"))
table.insert(images,loadImage("https://assets.prod.novaquark.com/91187/185f0d36-518b-4f6c-a85e-223f7c7b2461.jpg"))
table.insert(images,loadImage("https://assets.prod.novaquark.com/94313/6e426a20-6d97-4dfe-91cb-a0e11c285ad4.jpg"))

addImage( layer, images[currImage],currX,0,rx,ry)
addImage( layer, images[nextImage],currX+rx,0,rx,ry)

currX=currX-1
if(currX<-1*rx) then
    currX=0
    currImage=nextImage
    nextImage=nextImage+1
    if(nextImage>#images) then
        nextImage=1
    end
end
---# Request one run per frame
requestAnimationFrame(1)
