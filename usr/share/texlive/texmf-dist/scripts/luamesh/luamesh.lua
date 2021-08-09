require "luamesh-polygon"
require "luamesh-tex"

local function shallowCopy(original)
   local copy = {}
   for key, value in pairs(original) do
      copy[key] = value
   end
   return copy
end

-- Bowyer and Watson algorithm
-- Delaunay meshing
function BowyerWatson (listPoints,bbox)
   local triangulation = {}
   lgth = #listPoints
   -- add four points to listPoints to have a bounding box
   listPoints = buildBoundingBox(listPoints)
   -- the first triangle
   triangulation[1] = {lgth+1, lgth+2, lgth+3,type="bbox"}
   -- the second triangle
   triangulation[2] = {lgth+1, lgth+3, lgth+4,type="bbox"}
   -- add points one by one
   for i=1,lgth do
      -- find the triangles which the circumcircle contained the point to add
      badTriangles = buildBadTriangles(listPoints[i],triangulation,listPoints)
      -- build the polygon of the cavity containing the point to add
      polygon = buildCavity(badTriangles, triangulation)
      -- remove the bad triangles
      for j=1,#badTriangles do
         table.remove(triangulation,badTriangles[j]-(j-1))
      end
      -- build the new triangles and add them to triangulation
      for j=1,#polygon do
         if((polygon[j][1]>lgth) or (polygon[j][2]>lgth) or (i>lgth)) then
            table.insert(triangulation,{polygon[j][1],polygon[j][2],i,type="bbox"})
         else
            table.insert(triangulation,{polygon[j][1],polygon[j][2],i,type="in"})
         end
      end
   end	-- end adding points of the listPoints
   -- remove bounding box
   if(bbox ~= "bbox") then
      triangulation = removeBoundingBox(triangulation,lgth)
      table.remove(listPoints,lgth+1)
      table.remove(listPoints,lgth+1)
      table.remove(listPoints,lgth+1)
      table.remove(listPoints,lgth+1)
   end
   return triangulation
end


function buildBoundingBox(listPoints)
   -- listPoints : list of points
   -- epsV        : parameter for the distance of the bounding box
   local xmin, xmax, ymin, ymax, eps
   xmin = 1000
   ymin = 1000
   xmax = -1000
   ymax = -1000
   for i=1,#listPoints do
      if (listPoints[i].x < xmin) then
         xmin = listPoints[i].x
      end
      if (listPoints[i].x > xmax) then
         xmax = listPoints[i].x
      end
      if (listPoints[i].y < ymin) then
         ymin = listPoints[i].y
      end
      if (listPoints[i].y > ymax) then
         ymax = listPoints[i].y
      end
   end
   eps = math.max(math.abs(xmax-xmin),math.abs(ymax-ymin))*0.15
   xmin = xmin - eps
   xmax = xmax + eps
   ymin = ymin - eps
   ymax = ymax + eps
   -- add points of the bounding box in last positions
   table.insert(listPoints,{x=xmin,y=ymin,type="bbox"})
   table.insert(listPoints,{x=xmin,y=ymax,type="bbox"})
   table.insert(listPoints,{x=xmax,y=ymax,type="bbox"})
   table.insert(listPoints,{x=xmax,y=ymin,type="bbox"})
   return listPoints
end

function BoundingBox(listPoints)
   -- listPoints : list of points
   -- epsV        : parameter for the distance of the bounding box
   local xmin, xmax, ymin, ymax, eps
   xmin = 1000
   ymin = 1000
   xmax = -1000
   ymax = -1000
   for i=1,#listPoints do
      if (listPoints[i].x < xmin) then
         xmin = listPoints[i].x
      end
      if (listPoints[i].x > xmax) then
         xmax = listPoints[i].x
      end
      if (listPoints[i].y < ymin) then
         ymin = listPoints[i].y
      end
      if (listPoints[i].y > ymax) then
         ymax = listPoints[i].y
      end
   end
   eps = math.max(math.abs(xmax-xmin),math.abs(ymax-ymin))*0.15
   xmin = xmin - eps
   xmax = xmax + eps
   ymin = ymin - eps
   ymax = ymax + eps
   return xmin, xmax, ymin, ymax
end

function removeBoundingBox(triangulation,lgth)
   -- build the four bounding box edge
   point1 = lgth+1
   point2 = lgth+2
   point3 = lgth+3
   point4 = lgth+4
   -- for all triangle
   local newTriangulation = {}
   for i=1,#triangulation do
      boolE1 = pointInTriangle(point1,triangulation[i])
      boolE2 = pointInTriangle(point2,triangulation[i])
      boolE3 = pointInTriangle(point3,triangulation[i])
      boolE4 = pointInTriangle(point4,triangulation[i])
      if((not boolE1) and (not boolE2) and (not boolE3) and (not boolE4)) then
         table.insert(newTriangulation,triangulation[i])
      end
   end
   return newTriangulation
end


function buildBadTriangles(point, triangulation,listPoints)
   local badTriangles = {}
   for j=1,#triangulation do -- for all triangles
      A = listPoints[triangulation[j][1]]
      B = listPoints[triangulation[j][2]]
      C = listPoints[triangulation[j][3]]
      center, radius = circoncircle(A,B,C)
      CP = Vector(center,point)
      if(VectorNorm(CP)<radius) then -- the point belongs to the circoncirle
         table.insert(badTriangles,j)
      end
   end
   return badTriangles
end

-- construction of the cavity composed by the bad triangles around the point to add
function buildCavity(badTriangles, triangulation)
   local polygon = {}
   for j=1,#badTriangles do -- for all bad triangles
      ind = badTriangles[j]
      for k=1,3 do -- for all edges
         edge = {triangulation[ind][k],triangulation[ind][k%3+1]}
         edgeBord = false
         for l = 1,#badTriangles do -- for all badtriangles
            badInd = badTriangles[l]
            if(badInd ~= ind) then -- if not the current one
               edgeBord = edgeBord or edgeInTriangle(edge,triangulation[badInd])
            end
         end --
         -- if the edge does not belong to another bad triangle
         if(edgeBord == false) then
            -- insert the edge to the cavity
            table.insert(polygon,edge)
         end
      end --
   end --
   return polygon
end

function edgeInTriangle(e,t)
   in1 = false
   in2 = false
   for i=1,3 do
      if e[1] == t[i] then
         in1 = true
      end
      if e[2] == t[i] then
         in2 = true
      end
   end
   out = (in1 and in2)
   return out
end

function pointInTriangle(e,t)
   in1 = false
   for i=1,3 do
      if e == t[i] then
         in1 = true
      end
   end
   return in1
end


function Vector(A,B)
   local out = {x = B.x - A.x, y = B.y - A.y}
   return out
end

function VectorNorm(NP)
   return math.sqrt(NP.x*NP.x +NP.y*NP.y)
end

-- circoncircle
function circoncircle(M, N, P)
   -- Compute center and radius of the circoncircle of the triangle M N P

   -- return : (center [Point],radius [float])

   local MN = Vector(M,N)
   local NP = Vector(N,P)
   local PM = Vector(P,M)
   m = VectorNorm(NP)  -- |NP|
   n = VectorNorm(PM)  -- |PM|
   p = VectorNorm(MN)  -- |MN|

   d = (m + n + p) * (-m + n + p) * (m - n + p) * (m + n - p)
   if d > 0 then
      rad = m * n * p / math.sqrt(d)
   else
      rad = 0
   end
   d = -2 * (M.x * NP.y + N.x * PM.y + P.x * MN.y)
   O = {x=0, y=0}
   OM = Vector(O, M)
   ON = Vector(O, N)
   OP = Vector(O, P)
   om2 = math.pow(VectorNorm(OM),2)  -- |OM|**2
   on2 = math.pow(VectorNorm(ON),2)  -- |ON|**2
   op2 = math.pow(VectorNorm(OP),2)  -- |OP|**2
   x0 = -(om2 * NP.y + on2 * PM.y + op2 * MN.y) / d
   y0 = (om2 * NP.x + on2 * PM.x + op2 * MN.x) / d
   if d == 0 then
      Out = {nil, nil}
   else
      Out = {x=x0, y=y0}
   end
   return Out, rad  -- (center [Point], R [float])
end

-- compute the list of the circumcircle of a triangulation
function listCircumCenter(listPoints,triangulation)
   local list = {}
   for j=1,#triangulation do
      A = listPoints[triangulation[j][1]]
      B = listPoints[triangulation[j][2]]
      C = listPoints[triangulation[j][3]]
      center, radius = circoncircle(A,B,C)
      table.insert(list,{x=center.x,y=center.y,r=radius})
   end
   return list
end

-- find the three neighbour triangles of T
function findNeighbour(T,i,triangulation)
   -- T : triangle
   -- i : index of T in triangualation
   -- triangulation

   list = {}
   -- define the three edge
   e1 = {T[1],T[2]}
   e2 = {T[2],T[3]}
   e3 = {T[3],T[1]}
   for j=1,#triangulation do
      if j~= i then
         if(edgeInTriangle(e1,triangulation[j])) then
            table.insert(list,j)
         end
         if(edgeInTriangle(e2,triangulation[j])) then
            table.insert(list,j)
         end
         if(edgeInTriangle(e3,triangulation[j])) then
            table.insert(list,j)
         end
      end
   end
   return list
end

-- test if edge are the same (reverse)
function equalEdge(e1,e2)
   if(((e1[1] == e2[1]) and (e1[2] == e2[2])) or ((e1[1] == e2[2]) and (e1[2] == e2[1]))) then
      return true
   else
      return false
   end
end

-- test if the edge belongs to the list
function edgeInList(e,listE)
   output = false
   for i=1,#listE do
      if(equalEdge(e,listE[i])) then
         output = true
      end
   end
   return output
end

-- build the edges of the Voronoi diagram with a given triangulation
function buildVoronoi(listPoints, triangulation)
   local listCircumCircle = listCircumCenter(listPoints, triangulation)
   local listVoronoi = {}
   for i=1,#listCircumCircle do
      listN = findNeighbour(triangulation[i],i,triangulation)
      for j=1,#listN do
         edge = {i,listN[j]}
         if( not edgeInList(edge, listVoronoi)) then
            table.insert(listVoronoi, edge)
         end
      end
   end
   return listVoronoi
end

-- build the list of points
function buildList(chaine, mode)
   -- if mode = int : the list is given in the chaine string (x1,y1);(x2,y2);...;(xn,yn)
   -- if mode = ext : the list is given in a file line by line with space separation
   local listPoints = {}
   if mode == "int" then
      local points = string.explode(chaine, ";")
      local lgth=#points
      for i=1,lgth do
         Sx,Sy=string.match(points[i],"%((.+),(.+)%)")
         listPoints[i]={x=tonumber(Sx),y=tonumber(Sy)}
      end
   elseif mode == "ext" then
      io.input(chaine) -- open the file
      text=io.read("*all")
      lines=string.explode(text,"\n+") -- all the lines
      tablePoints={}
      for i=1,#lines do
	 xy=string.explode(lines[i]," +")
	 listPoints[i]={x=tonumber(xy[1]),y=tonumber(xy[2])}
      end
   else
      print("Non existing mode")
   end
   return listPoints
end


-- function to add points on a polygon to respect
-- the size of unit mesh
function addPointsPolygon(polygon,h)
   local newPolygon = shallowCopy(polygon)
   k=0 -- to follow in the newPolygon
   for i=1,#polygon do
      k = k+1
      ip = (i)%(#polygon)+1
      dist = math.sqrt(math.pow(polygon[i].x-polygon[ip].x,2) + math.pow(polygon[i].y-polygon[ip].y,2))
      -- if the distance between two ponits of the polygon is greater than 1.5*h
      if(dist>=2*h) then
         n = math.floor(dist/h)
         step = dist/(n+1)
         for j=1,n do
            a = {x=polygon[i].x+j*step*(polygon[ip].x-polygon[i].x)/dist,y=polygon[i].y+j*step*(polygon[ip].y-polygon[i].y)/dist}
            table.insert(newPolygon,k+j,a)
         end
         k=k+n
      end
   end
   return newPolygon
end

-- function to build a gridpoints from the bounding box
-- with a prescribed
function buildGrid(listPoints,h,random)
   -- listPoints : list of the points of the polygon, ordered
   -- h : parameter for the grid
   xmin, xmax, ymin, ymax = BoundingBox(listPoints)

   local grid = rectangleList(xmin,xmax,ymin,ymax,h,random)
   return grid
end

-- function to build the list of points in the rectangle
function rectangleList(xmin,xmax,ymin,ymax,h,random)
   -- for the random
   math.randomseed( os.time() )
   nbrX = math.floor(math.abs(xmax-xmin)/h)
   nbrY = math.floor(math.abs(ymax-ymin)/h)
   local listPoints = {}
   k=1
   for i=1,(nbrX+1) do
      for j=1,(nbrY+1) do
         rd = math.random()
         if(random=="perturb") then
            fact = 0.3*h
            --print(fact)
         else
            fact = 0.0
         end
         listPoints[k] = {x = xmin+(i-1)*h+rd*fact, y=ymin+(j-1)*h+rd*fact}
         k=k+1
      end
   end
   return listPoints
end


-- function to add points from a grid to the interior of a polygon
function addGridPoints(polygon, grid,h)
   local listPoints = shallowCopy(polygon)
   k = #polygon
   for i=1, #grid do
      --print(grid[i].x,grid[i].y)
      --print(isInside(polygon,grid[i]))
      if(isInside(polygon,grid[i],h)) then
         k=k+1
         listPoints[k] = grid[i]
      end
   end
   return listPoints
end



-- function give a real polygon without repeting points
function cleanPoly(polygon)
   local polyNew = {}
   local polyCopy = shallowCopy(polygon)
   e1 = polyCopy[1][1]
   e2 = polyCopy[1][2]
   table.insert(polyNew, e1)
   table.insert(polyNew, e2)
   table.remove(polyCopy,1)
   j = 2
   while #polyCopy>1 do
      i=1
      find = false
      while (i<=#polyCopy and find==false) do
         bool1 = (polyCopy[i][1] == polyNew[j])
         bool2 = (polyCopy[i][2] == polyNew[j])
         if(bool1 or bool2) then -- the edge has a common point with polyNew[j]
            if(not bool1) then
               table.insert(polyNew, polyCopy[i][1])
               find = true
               table.remove(polyCopy,i)
               j = j+1
            elseif(not bool2) then
               table.insert(polyNew, polyCopy[i][2])
               find = true
               table.remove(polyCopy,i)
               j = j+1
            end
         end
         i=i+1
      end
   end
   return polyNew
end



-- build the list of points extern and stop at nbr
function buildListExt(chaine, stop)
   local listPoints = {}
   io.input(chaine) -- open the file
   text=io.read("*all")
   lines=string.explode(text,"\n+") -- all the lines
   for i=1,tonumber(stop) do
      xy=string.explode(lines[i]," +")
      table.insert(listPoints,{x=tonumber(xy[1]),y=tonumber(xy[2])})
   end
   xy=string.explode(lines[stop+1]," +")
   point={x=tonumber(xy[1]),y=tonumber(xy[2])}
   return point, listPoints
end

function split(pString, pPattern)
   local Table = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pPattern
   local last_end = 1
   local s, e, cap = pString:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(Table,cap)
      end
      last_end = e+1
      s, e, cap = pString:find(fpat, last_end)
   end
   if last_end <= #pString then
      cap = pString:sub(last_end)
      table.insert(Table, cap)
   end
   return Table
end

function readGmsh(file)
   io.input(file) -- open the file
   text=io.read("*all")
   local lines = split(text,"\n+") -- all the lines
   local listPoints={}
   local triangulation ={}
   boolNodes = false
   Jnodes = 0
   boolElements = false
   Jelements = 0
   J=0
   for i=1,#lines-J do
      if(lines[i+J] == "$EndNodes") then
         boolNodes = false
         -- go to the next line
      end
      if(boolNodes) then -- we are in the Nodes environment
         xy=split(lines[i+J]," +")
         table.insert(listPoints,{x=tonumber(xy[2]),y=tonumber(xy[3])})
      end
      if(lines[i+J] == "$Nodes") then
         boolNodes = true
         -- go to the next line
         J=J+1
      end
      if(lines[i+J] == "$EndElements") then
         boolElements = false
         -- go to the next line
      end
      if(boolElements) then -- we are in the Nodes environment
         xy=split(lines[i+J]," +")
         if(tonumber(xy[2]) == 2) then -- if the element is a triangle
            nbrTags = xy[3]+1
            table.insert(triangulation,{tonumber(xy[2+nbrTags+1]),tonumber(xy[2+nbrTags+2]),tonumber(xy[2+nbrTags+3])})
         end
      end
      if(lines[i+J] == "$Elements") then
         boolElements = true
         -- go to the next line
         J=J+1
      end
   end
   return listPoints, triangulation
end
