local rx, ry = getResolution()
local background = createLayer()
local layer = createLayer()

local font = loadFont('FiraMono', 20)

if not init then
    init = true
    
    points_list = {}
    points_update = {}
    
    sqrtOfHalf = math.sqrt(0.5)

    border = 25
    pointsNumber = 150
    pointSpeed = 25

    X0 = border
    X1 = rx-border
    Y0 = border
    Y1 = ry-border

    --Point that share the exact same coordinates can cause problems; adding a random decimal is a quick fix.
    for i = 1,pointsNumber do
        points_list[i] = {x = math.random(X0,X1) + math.random(),y = math.random(Y0,Y1) + math.random()}
        points_update[i] = {dx = math.random(-pointSpeed,pointSpeed), dy = math.random(-pointSpeed,pointSpeed)}
    end    
end

--[[


Based on the work of David Ng taken from here: 
http://forums.coronalabs.com/topic/1947-does-anyone-have-lua-code-for-delauney-triangulation-or-voronoi-diagram-generation/
and of Steve J. Fortune (1987) A Sweepline Algorithm for Voronoi Diagrams,
Algorithmica 2, 153-174, and its translation to C++ by Matt Brubeck, 
http://www.cs.hmc.edu/~mbrubeck/voronoi.html

the code below is largly from https://love2d.org/forums/viewtopic.php?t=78403
]]
--- HEAP ---
local Heap = {}
function Heap:new() 
    o = {heap = {}, nodes = {}} 
    setmetatable(o, self) 
    self.__index = self 
    return o
end

function Heap:push(k, v)
    assert(v ~= nil, "cannot push nil")
    local t = self.nodes
    local h = self.heap
    local n = #h + 1 -- node position in heap array (leaf)
    local p = (n - n % 2) / 2 -- parent position in heap array
    h[n] = k -- insert at a leaf
    t[k] = v
    while n > 1 and t[h[p]] > v do -- climb heap?
        h[p], h[n] = h[n], h[p]
        n = p
        p = (n - n % 2) / 2
    end
end

function Heap:pop()
    local t = self.nodes
    local h = self.heap
    local s = #h
    assert(s > 0, "cannot pop from empty heap")
    local e = h[1] -- min (heap root)
    local r = t[e]
    local v = t[h[s]]
    h[1] = h[s] -- move leaf to root
    h[s] = nil -- remove leaf
    t[e] = nil
    s = s - 1
    local n = 1 -- node position in heap array
    local p = 2 * n -- left sibling position
    if s > p and t[h[p]] > t[h[p + 1]] then
        p = 2 * n + 1 -- right sibling position
    end
    while s >= p and t[h[p]] < v do -- descend heap?
        h[p], h[n] = h[n], h[p]
        n = p
        p = 2 * n
        if s > p and t[h[p]] > t[h[p + 1]] then
            p = 2 * n + 1
        end
    end
    return e, r
end

function Heap:isEmpty() 
    return self.heap[1] == nil 
end

--- DOUBLE-LINKED LIST --- 

local DoubleLinkedList = {}
function DoubleLinkedList:new()
    o = {first = nil, last = nil} -- empty list head
    setmetatable(o, self) 
    self.__index = self 
    return o
end

function DoubleLinkedList:insertAfter(node, data)
    local new = {prev = node, next = node.next, x = data.x, y = data.y } -- creates a new node
    node.next = new -- the node after node is the new node
    if node == self.last then -- check if the old node is the last node...
        self.last = new -- ...and set the new node as last node
    else
        --otherwise set the next nodes previous node to the new one
        new.next.prev = new 
    end
    return new -- return the new node
end

function DoubleLinkedList:insertAtStart(data)
    local new = {prev = nil, next = self.first, x = data.x, y = data.y} -- create the new node
    if not self.first then -- check if the list is empty
        self.first = new -- the new node is the first and the last in this case
        self.last = new
    else
        -- the node before the old first node is the new first node
        self.first.prev = new
        self.first = new -- update the list's first field
    end
    return new
end

function DoubleLinkedList:delete(node)
    if node == self.first then -- check if the node is the first one...
        -- ...and set the new first node if we remove the first
        self.first = node.next
    else
        -- set the previous node's next node to the next node
        node.prev.next = node.next
    end

    if node == self.last then -- check if the node is the last one...
        -- ...the new last node is the node before the deleted node
        self.last = node.prev
    else
        node.next.prev = node.prev -- update the next node's prev field
    end
end

function DoubleLinkedList:nextNode(node)
    return (not node and self.first) or node.next
end

--- ORDERING FUNCTION FOR VERTICES ---

function isToTheLeft(center, a, b)
    -- calculates which of the two points a and b is more "to the left" in relation
    -- to the center point
    -- adapted from here: http://stackoverflow.com/questions/6989100/sort-points-in-clockwise-order
    if (a.x - center.x >= 0 and b.x - center.x < 0) then
        return true
    elseif (a.x - center.x < 0 and b.x - center.x >= 0) then
        return false
    elseif (a.x - center.x == 0 and b.x - center.x == 0) then
        if (a.y - center.y >= 0 or b.y - center.y >= 0) then
            return a.y > b.y
        else
            return b.y > a.y
        end
    end

    -- compute the cross product of vectors (center -> a) x (center -> b)
    local det = (a.x - center.x) * (b.y - center.y) - (b.x - center.x) * (a.y - center.y)
    if (det < 0) then
        return true
    elseif (det > 0) then
        return false
    end

    -- points a and b are on the same line from the center
    -- check which point is closer to the center
    local d1 = (a.x - center.x) * (a.x - center.x) + (a.y - center.y) * (a.y - center.y)
    local d2 = (b.x - center.x) * (b.x - center.x) + (b.y - center.y) * (b.y - center.y)
    return d1 > d2
end


--- LOCAL VARIABLES USED THROUGHOUGHT THE ALGORITHM ---
local beachline, events, vertex, segments, centroids

--- MAIN ALGORITHM ---

local voronoi = {}

function voronoi.processEvent(event)
    if event.valid then
        segment = {startPoint = {x = event.x, y = event.y}, endPoint = {x = 0, y = 0}, done = false, type = 1}
        table.insert(segments, segment)
        --Remove the associated arc from the front, and update segment info

        beachline:delete(event.arc)

        if event.arc.prev then
            event.arc.prev.seg1 = segment
        end

        if event.arc.next then
            event.arc.next.seg0 = segment
        end

        --Finish the edges before and after arc.
        if event.arc.seg0 then
            event.arc.seg0.endPoint = {x = event.x, y = event.y}
            event.arc.seg0.done = true
        end    

        if event.arc.seg1 then
            event.arc.seg1.endPoint = {x = event.x, y = event.y}
            event.arc.seg1.done = true
        end    

        -- debugging vertix list!!!
        table.insert(vertex, {x = event.x, y = event.y, centroids={event.arc.prev, event.arc, event.arc.next}})

        --Recheck circle events on either side of p:
        if (event.arc.prev) then
            voronoi.check_circle_event(event.arc.prev, event.x)
        end
        if (event.arc.next) then
            voronoi.check_circle_event(event.arc.next, event.x)
        end    
        event.arc = nil
    end
    event = nil 
end
function voronoi.processPoint(point)
    --Adds a point to the beachline
    local intersect = voronoi.intersect
    if (not beachline.first) then
        beachline:insertAtStart(point)
        return
    end

    --Find the current arc(s) at height p.y (if there are any).
    for arc in beachline.nextNode, beachline do
        z = (intersect(point,arc))
        if z then
            --New parabola intersects arc i.  If necessary, duplicate i.
            -- ie if there is a next node, but there is not interation, then creat a duplicate
            if not (arc.next and (intersect(point,arc.next))) then
                beachline:insertAfter(arc, arc)
            else    
                --print("test", arc.next,intersect(point,arc.next).x,intersect(point,arc.next).y, z.x,z.y  )
                return
            end    
            arc.next.seg1 = arc.seg1

            --Add p between i and i->next.
            beachline:insertAfter(arc, point)


            segment = {startPoint = {x = z.x, y = z.y}, endPoint = {x = 0, y = 0}, done = false, type = 2}
            segment2 = {startPoint = {x = z.x, y = z.y}, endPoint = {x = 0, y = 0}, done = false, type = 2}

            -- debugging segment list!!!
            table.insert(segments, segment)
            table.insert(segments, segment2)


            --Add new half-edges connected to i's endpoints.
            arc.next.seg0 = segment
            arc.seg1 = segment
            arc.next.seg1 = segment2
            arc.next.next.seg0 = segment2

            --Check for new circle events around the new arc:
            voronoi.check_circle_event(arc, point.x)
            voronoi.check_circle_event(arc.next, point.x)
            voronoi.check_circle_event(arc.next.next, point.x)

            return

        end    
    end
    --Special case: If p never intersects an arc, append it to the list.
    -- Find the last node.

    beachline:insertAtStart(point)

    segment = {startPoint = {x = X0, y = (beachline.last.y + beachline.last.prev.y) / 2}, endPoint = {x = 0, y = 0}, done = false, type = 3}

    table.insert(segments, segment)

    beachline.last.seg0 = segment
    beachline.last.prev.seg1 = segment
end

function voronoi.check_circle_event(arc, x0)
    --Look for a new circle event for arc i.
    --Invalidate any old event.

    if (arc.event and arc.event.x ~= x0) then
        arc.event.valid = false
    end
    arc.event = nil

    if ( not arc.prev or not arc.next) then
        return
    end

    local a = arc.prev
    local b = arc
    local c = arc.next

    if ((b.x-a.x)*(c.y-a.y) - (c.x-a.x)*(b.y-a.y) >= 0) then
        return false
    end    

    --Algorithm from O'Rourke 2ed p. 189.
    local A = b.x - a.x
    local B = b.y - a.y
    local C = c.x - a.x
    local D = c.y - a.y
    local E = A*(a.x+b.x) + B*(a.y+b.y)
    local F = C*(a.x+c.x) + D*(a.y+c.y)
    local G = 2*(A*(c.y-b.y) - B*(c.x-b.x))

    if (G == 0) then
        -- print("g is 0")
        return false --Points are co-linear
    end

    --Point o is the center of the circle.
    local o = {}
    o.x = (D*E-B*F)/G
    o.y = (A*F-C*E)/G

    --o.x plus radius equals max x coordinate.
    local x = o.x + math.sqrt( (a.x-o.x)*(a.x-o.x) + (a.y-o.y)*(a.y-o.y) )

    if x and x > x0 then
        --Create new event.
        arc.event = {x = o.x, y = o.y, arc = arc, valid = true, event = true}
        events:push(arc.event, x)
    end
end

function voronoi.intersect(point, arc)
    --Will a new parabola at point p intersect with arc i?
    local res = {}
    if (arc.x == point.x) then 
        return false 
    end

    if (arc.prev) then
        --Get the intersection of i->prev, i.
        a = voronoi.intersection(arc.prev, arc, point.x).y
    end    
    if (arc.next) then
        --Get the intersection of i->next, i.
        b = voronoi.intersection(arc, arc.next, point.x).y
    end    
    --print("intersect", a,b,p.y)
    if (( not arc.prev or a <= point.y) and (not arc.next or point.y <= b)) then
        res.y = point.y
        -- Plug it back into the parabola equation.
        res.x = (arc.x*arc.x + (arc.y-res.y)*(arc.y-res.y) - point.x*point.x) / (2*arc.x - 2*point.x)
        return res
    end
    return false
end
function voronoi.intersection(p0, p1, l)
    -- Where do two parabolas intersect?

    local res = {}
    local p = {x = p0.x, y = p0.y}

    if (p0.x == p1.x) then
        res.y = (p0.y + p1.y) / 2
    elseif (p1.x == l) then
        res.y = p1.y
    elseif (p0.x == l) then
        res.y = p0.y
        p = p1
    else
        -- Use the quadratic formula.
        local z0 = 2*(p0.x - l);
        local z1 = 2*(p1.x - l);

        local a = 1/z0 - 1/z1;
        local b = -2*(p0.y/z0 - p1.y/z1);
        local c = (p0.y*p0.y + p0.x*p0.x - l*l)/z0 - (p1.y*p1.y + p1.x*p1.x - l*l)/z1
        res.y = ( -b - math.sqrt(b*b - 4*a*c) ) / (2*a)
    end

    -- Plug back into one of the parabola equations.
    res.x = (p.x*p.x + (p.y-res.y)*(p.y-res.y) - l*l)/(2*p.x-2*l)
    return res
end

function voronoi.finishEdges(X0, Y0, X1, Y1)
    --Advance the sweep line so no parabolas can cross the bounding box.
    --The arguments are the boundaries of the bounding box.
    l = X1 + (X1-X0) + (Y1-Y0)

    --Extend each remaining segment to the new parabola intersections.
    for arc in beachline.nextNode, beachline do
        if arc.seg1 then
            p = voronoi.intersection(arc, arc.next, l*2)
            arc.seg1.endPoint = {x = p.x, y = p.y}
            arc.seg1.done = true
            -- These points are always new so adding them to the centroids
            table.insert(vertex, {x = p.x, y = p.y, centroids={arc, arc.next}})
        end    
    end
end




-- EXPORT --


function voronoi.run(points_list, X0, Y0, X1, Y1)

    --Clear and reset tables
    beachline = DoubleLinkedList:new()
    events = Heap:new()
    vertex = {}
    segments = {}
    centroids = {}
    local cindex = {}

    --Update point positions
    for i = 1,#points_list do
        events:push(points_list[i], points_list[i].x)
        -- prepare centroids
        table.insert(centroids, {x=points_list[i].x, y=points_list[i].y, vertices={}, neighbors = {}})
        cindex[points_list[i].x] = cindex[points_list[i].x] or {}
        cindex[points_list[i].x][points_list[i].y] = i
    end

    while not events:isEmpty() do
        e, x = events:pop()
        if e.event then
            voronoi.processEvent(e)
        else
            voronoi.processPoint(e)
        end    
    end
    if Y1 then
        voronoi.finishEdges(X0, Y0, X1, Y1)
    end

    for i=1, #vertex do
        for j=1, #vertex[i].centroids do
            local c = vertex[i].centroids[j]
            local index = cindex[c.x][c.y]
            table.insert(centroids[index].vertices, {x=vertex[i].x, y=vertex[i].y})
            for j1=1, #vertex[i].centroids do
                if j ~= j1 then
                    local index2 = cindex[vertex[i].centroids[j1].x][vertex[i].centroids[j1].y]
                    table.insert(centroids[index].neighbors, centroids[index2])
                end
            end
        end
    end
    -- sort vertices clockwise to ensure convex polygons
    for i=1, #centroids do
        table.sort(centroids[i].vertices, function (a, b) return isToTheLeft(centroids[i], a, b) end)
    end 

    return vertex, segments, centroids
end

-----------------
-- Helper Func --
-----------------

function clamp(n, low, high) 
    return math.min(math.max(n, low), high) 
end

function isPointOutOfBound(x, y)
   return x < 0 or y < 0 or x > rx or y > ry
end

function hsvToRgb(h, s, v) --0 to 1 in/out
    local r, g, b

    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    i = i % 6

    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end

    return r ,g ,b
end
   
-------------
-- Updates --
-------------
delta = getDeltaTime ()

--Update point positions
for i = 1,#points_list do 
    points_list[i].x =  points_list[i].x + points_update[i].dx*delta
    if points_list[i].x < X0 then
        points_list[i].x = X0
        points_update[i].dx = -1*points_update[i].dx
    end
    if points_list[i].x > X1 then
        points_list[i].x = X1
        points_update[i].dx = -1*points_update[i].dx
    end

    points_list[i].y =  points_list[i].y + points_update[i].dy*delta
    if points_list[i].y < Y0 then
        points_list[i].y = Y0
        points_update[i].dy = -1*points_update[i].dy
    end
    if points_list[i].y > Y1 then
        points_list[i].y = Y1
        points_update[i].dy = -1*points_update[i].dy
    end
end

-------------
-- Drawing --
-------------

vertex, segments, centroids = voronoi.run(points_list, X0, Y0, X1, Y1)

for i=1, #centroids do
    --local r, g, b = hsvToRgb((1/#centroids)*i, 1, 1)
    
    
    local centerX = centroids[i].x
    local centerY = centroids[i].y
    
    local r, g, b = hsvToRgb(centerX/rx, centerY/ry, 1)
    
    local edge = {}
    
    local numberVertices = #centroids[i].vertices
    for currentVertices=1, numberVertices do
        
        local nextVertices = currentVertices+1
        if nextVertices > numberVertices then 
            nextVertices = 1 
        end
        
        local currentX = centroids[i].vertices[currentVertices].x
        local currentY = centroids[i].vertices[currentVertices].y
        local nextX = centroids[i].vertices[nextVertices].x
        local nextY = centroids[i].vertices[nextVertices].y
        
        local curentOut = isPointOutOfBound(currentX, currentY)
        local nextOut = isPointOutOfBound(nextX, nextY)
        
        if (curentOut and nextOut) == false then -- if not out of bound
            if curentOut or nextOut then 
                
                -- reverse so start is always inbound
                if curentOut then
                    currentX, currentY, nextX, nextY = nextX, nextY, currentX, currentY
                end
                
                -- thx to Elias Villd for the border detection code
                local x0, y0 = currentX, currentY --Your point A
                local x1, y1 = nextX, nextY -- Your point B

                local x, y = x1, y1

                if y < 0 or y > ry then
                    y = y < 0 and 0 or ry
                    x = (y - y0)*(x1-x0)/(y1-y0) + x0
                end
                if x < 0 or x > rx then
                    x = x < 0 and 0 or rx
                    y = (x - x0)*(y1-y0)/(x1-x0) + y0
                end

                nextX, nextY = x, y
                
                table.insert(edge, {x=nextX, y=nextY})

            end
            
            setNextFillColor(background, r, g, b, 1)
            addTriangle(background, currentX, currentY, nextX, nextY, centerX, centerY)
        end
    end
    
    if #edge > 0 then
        setNextFillColor(background, r, g, b, 1)
        if edge[1].x ~= edge[2].x and edge[1].y ~= edge[2].y then
            
            local cornerX, cornerY = 0,0
            if (edge[1].x == rx or edge[2].x == rx) and (edge[1].y == 0 or edge[2].y == 0) then -- top right
                cornerX = rx
                cornerY = 0
            elseif (edge[1].x == rx or edge[2].x == rx) and (edge[1].y == ry or edge[2].y == ry) then --bottom right
                cornerX = rx
                cornerY = ry
            elseif (edge[1].x == 0 or edge[2].x == 0) and (edge[1].y == ry or edge[2].y == ry) then -- bottom left
                cornerX = 0
                cornerY = ry
            end
                       
            addQuad(background, edge[1].x, edge[1].y, cornerX, cornerY, edge[2].x, edge[2].y, centerX, centerY)
        else
            addTriangle(background, edge[1].x, edge[1].y, edge[2].x, edge[2].y, centerX, centerY)
        end
    end
    
    --[[
    -- Draw center
    setNextStrokeColor(layer, 1-r, 1-g, 1-b, 1)
    setNextStrokeWidth(layer, 1)
    setNextFillColor(layer, r, g, b, 1)
    addCircle(layer, centerX, centerY, 5)
    ]]
    --[[
    -- Draw point number in the center
    setNextFillColor(layer, 1-r, 1-g, 1-b, 1)
    setNextTextAlign(layer, AlignH_Center, AlignV_Middle)
    addText(layer, font, i, centerX, centerY)
    ]]
end

-- render debug var
if false then
    local debugLayer = createLayer()
    local font = loadFont('FiraMono', 20)
    
    local debugList = {
        string.format("FPS: %s ",math.floor(0.5+(1/getDeltaTime())) ),
        string.format("render cost : %d / %d", getRenderCost(), getRenderCostMax())
    }
    for k,v in pairs(debugList) do
        setNextFillColor(debugLayer, 1, 0, 0, 1)
        addText(debugLayer, font, v, 5, ry-(#debugList-k)*20)
    end
end

requestAnimationFrame(1)


