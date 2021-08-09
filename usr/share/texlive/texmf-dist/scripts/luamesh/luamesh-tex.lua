-- trace Voronoi with MP
function traceVoronoiMP(listPoints, triangulation,listVoronoi, points, tri,styleD,styleV)
   if(styleD == "dashed") then
      sDelaunay = "dashed evenly"
   else
      sDelaunay = ""
   end
   if(styleV == "dashed") then
      sVoronoi = "dashed evenly"
   else
      sVoronoi = ""
   end
   listCircumC = listCircumCenter(listPoints,triangulation)
   output = "";
   output = output .. " pair MeshPoints[];"
   for i=1,#listPoints do
      output = output .. "MeshPoints[".. i .. "] = (" .. listPoints[i].x .. "," .. listPoints[i].y .. ")*u;"
   end
   output = output .. " pair CircumCenters[];"
   for i=1,#listCircumC do
      output = output .. "CircumCenters[".. i .. "] = (" .. listCircumC[i].x .. "," .. listCircumC[i].y .. ")*u;"
   end
   if(tri=="show") then
      for i=1,#triangulation do
         PointI = listPoints[triangulation[i][1]]
         PointJ = listPoints[triangulation[i][2]]
         PointK = listPoints[triangulation[i][3]]
         if(triangulation[i].type == "bbox") then
            output = output .. "draw (".. PointI.x ..",".. PointI.y ..")*u--("..PointJ.x..",".. PointJ.y ..")*u--("..PointK.x..",".. PointK.y ..")*u--cycle "..sDelaunay.." withcolor \\luameshmpcolorBbox;"
         else
            output = output .. "draw (".. PointI.x ..",".. PointI.y ..")*u--("..PointJ.x..",".. PointJ.y ..")*u--("..PointK.x..",".. PointK.y ..")*u--cycle "..sDelaunay.." withcolor \\luameshmpcolor;"
         end
      end
   end
   for i=1,#listVoronoi do
      PointI = listCircumC[listVoronoi[i][1]]
      PointJ = listCircumC[listVoronoi[i][2]]
      output = output .. "draw (".. PointI.x ..",".. PointI.y ..")*u--("..PointJ.x..",".. PointJ.y ..")*u "..sVoronoi.." withcolor \\luameshmpcolorVoronoi;"
   end
   if(points=="points") then
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "dotlabel.llft (btex $\\MeshPoint^{*}_{"..j.."}$ etex, (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u ) withcolor \\luameshmpcolorBbox ;"
            j=j+1
         else
            output = output .. "dotlabel.llft (btex $\\MeshPoint_{" .. i .. "}$ etex, (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u ) withcolor \\luameshmpcolor ;"
         end
      end
      for i=1,#listCircumC do
         output = output .. "dotlabel.llft (btex $\\CircumPoint_{" .. i .. "}$ etex, (" .. listCircumC[i].x ..",".. listCircumC[i].y .. ")*u ) withcolor \\luameshmpcolorVoronoi ;"
      end
   else
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "drawdot  (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u  withcolor \\luameshmpcolorBbox withpen pencircle scaled 3;"
            j=j+1
         else
            output = output .. "drawdot  (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u  withcolor \\luameshmpcolor withpen pencircle scaled 3;"
         end
      end
      for i=1,#listCircumC do
         output = output .. "drawdot  (" .. listCircumC[i].x ..",".. listCircumC[i].y .. ")*u  withcolor \\luameshmpcolorVoronoi withpen pencircle scaled 3;"
      end
   end

   return output
end


-- trace Voronoi with TikZ
function traceVoronoiTikZ(listPoints, triangulation,listVoronoi, points, tri,color,colorBbox,colorVoronoi,styleD,styleV)
   if(styleD == "dashed") then
      sDelaunay = ",dashed"
   else
      sDelaunay = ""
   end
   if(styleV == "dashed") then
      sVoronoi = ",dashed"
   else
      sVoronoi = ""
   end
   listCircumC = listCircumCenter(listPoints,triangulation)
    output = ""
   for i=1,#listPoints do
      output = output .. "\\coordinate (MeshPoints".. i .. ") at  (" .. listPoints[i].x .. "," .. listPoints[i].y .. ");"
   end
   for i=1,#listCircumC do
      output = output .. "\\coordinate (CircumPoints".. i .. ") at  (" .. listCircumC[i].x .. "," .. listCircumC[i].y .. ");"
   end
   if(tri=="show") then
      for i=1,#triangulation do
         PointI = listPoints[triangulation[i][1]]
         PointJ = listPoints[triangulation[i][2]]
         PointK = listPoints[triangulation[i][3]]
         if(triangulation[i].type == "bbox") then
            output = output .. "\\draw[color="..colorBbox..sDelaunay.."] (".. PointI.x ..",".. PointI.y ..")--("..PointJ.x..",".. PointJ.y ..")--("..PointK.x..",".. PointK.y ..")--cycle;"
         else
            output = output .. "\\draw[color="..color..sDelaunay.."] (".. PointI.x ..",".. PointI.y ..")--("..PointJ.x..",".. PointJ.y ..")--("..PointK.x..",".. PointK.y ..")--cycle;"
         end
      end
   end
   for i=1,#listVoronoi do
      PointI = listCircumC[listVoronoi[i][1]]
      PointJ = listCircumC[listVoronoi[i][2]]
      output = output .. "\\draw[color="..colorVoronoi..sVoronoi.."] (".. PointI.x ..",".. PointI.y ..")--("..PointJ.x..",".. PointJ.y ..");"
   end
   if(points=="points") then
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "\\draw[color="..colorBbox.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\MeshPoint^*_{" .. j .. "}$};"
            j=j+1
         else
            output = output .. "\\draw[color="..color.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\MeshPoint_{" .. i .. "}$};"
         end
      end
      for i=1,#listCircumC do
         output = output .. "\\draw[color="..colorVoronoi.."] (" .. listCircumC[i].x ..",".. listCircumC[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\CircumPoint_{" .. i .. "}$};"
      end
   else
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "\\draw[color="..colorBbox.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} ;"
            j=j+1
         else
            output = output .. "\\draw[color="..color.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} ;"
         end
      end
      for i=1,#listCircumC do
         output = output .. "\\draw[color="..colorVoronoi.."] (" .. listCircumC[i].x ..",".. listCircumC[i].y .. ") node {$\\bullet$};"
      end
   end
   return output
end



-- buildVoronoi with MP
function buildVoronoiMPBW(chaine,mode,points,bbox,scale,tri,styleD,styleV)
   local listPoints = buildList(chaine, mode)
   local triangulation = BowyerWatson(listPoints,bbox)
   local listVoronoi = buildVoronoi(listPoints, triangulation)
   output = traceVoronoiMP(listPoints,triangulation,listVoronoi,points,tri,styleD,styleV)
   output = "\\leavevmode\\begin{mplibcode}beginfig(0);u:="..scale.. ";" .. output .."endfig;\\end{mplibcode}"
   tex.sprint(output)
end


-- buildVoronoi with TikZ
function buildVoronoiTikZBW(chaine,mode,points,bbox,scale,tri,color,colorBbox,colorVoronoi,styleD,styleV)
   local listPoints = buildList(chaine, mode)
   local triangulation = BowyerWatson(listPoints,bbox)
   local listVoronoi = buildVoronoi(listPoints, triangulation)
   output = traceVoronoiTikZ(listPoints,triangulation,listVoronoi,points,tri,color,colorBbox,colorVoronoi,styleD,styleV)
   output = "\\noindent\\begin{tikzpicture}[x=" .. scale .. ",y=" .. scale .."]" .. output .."\\end{tikzpicture}"   tex.sprint(output)
end


-- buildVoronoi with MP
function buildVoronoiMPBWinc(chaine,beginning, ending,mode,points,bbox,scale,tri,styleD,styleV)
   local listPoints = buildList(chaine, mode)
   local triangulation = BowyerWatson(listPoints,bbox)
   local listVoronoi = buildVoronoi(listPoints, triangulation)
   output = traceVoronoiMP(listPoints,triangulation,listVoronoi,points,tri,styleD,styleV)
   output = "\\leavevmode\\begin{mplibcode}u:="..scale..";"..beginning .. output .. ending .. "\\end{mplibcode}"
   tex.sprint(output)
end


-- buildVoronoi with TikZ
function buildVoronoiTikZBWinc(chaine,beginning, ending,mode,points,bbox,scale,tri,color,colorBbox,colorVoronoi)
   local listPoints = buildList(chaine, mode,styleD,styleV)
   local triangulation = BowyerWatson(listPoints,bbox)
   local listVoronoi = buildVoronoi(listPoints, triangulation)
   output = traceVoronoiTikZ(listPoints,triangulation,listVoronoi,points,tri,color,colorBbox,colorVoronoi,styleD,styleV)
   output = "\\noindent\\begin{tikzpicture}[x=" .. scale .. ",y=" .. scale .."]" ..beginning.. output..ending .."\\end{tikzpicture}"
   tex.sprint(output)
end



-- trace a triangulation with TikZ
function traceMeshTikZ(listPoints, triangulation,points,color,colorBbox)
   output = ""
   for i=1,#listPoints do
      output = output .. "\\coordinate (MeshPoints".. i .. ") at  (" .. listPoints[i].x .. "," .. listPoints[i].y .. ");"
   end
   for i=1,#triangulation do
      PointI = listPoints[triangulation[i][1]]
      PointJ = listPoints[triangulation[i][2]]
      PointK = listPoints[triangulation[i][3]]
      if(triangulation[i].type == "bbox") then
         output = output .. "\\draw[color="..colorBbox.."] (".. PointI.x ..",".. PointI.y ..")--("..PointJ.x..",".. PointJ.y ..")--("..PointK.x..",".. PointK.y ..")--cycle;"
      else
         output = output .. "\\draw[color="..color.."] (".. PointI.x ..",".. PointI.y ..")--("..PointJ.x..",".. PointJ.y ..")--("..PointK.x..",".. PointK.y ..")--cycle;"
      end
   end
   if(points=="points") then
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "\\draw[color="..colorBbox.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\MeshPoint^*_{" .. j .. "}$};"
            j=j+1
         else
            output = output .. "\\draw[color="..color.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\MeshPoint_{" .. i .. "}$};"
         end
      end
   end
   if(points=="dotpoints") then
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "\\draw[color="..colorBbox.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$};"
            j=j+1
         else
            output = output .. "\\draw[color="..color.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$};"
         end
      end
   end
   return output
end


-- trace a triangulation with MP
function traceMeshMP(listPoints, triangulation,points)
   output = "";
   output = output .. " pair MeshPoints[];"
   for i=1,#listPoints do
      output = output .. "MeshPoints[".. i .. "] = (" .. listPoints[i].x .. "," .. listPoints[i].y .. ")*u;"
   end
   for i=1,#triangulation do
      PointI = listPoints[triangulation[i][1]]
      PointJ = listPoints[triangulation[i][2]]
      PointK = listPoints[triangulation[i][3]]
      if(triangulation[i].type == "bbox") then
         output = output .. "draw (".. PointI.x ..",".. PointI.y ..")*u--("..PointJ.x..",".. PointJ.y ..")*u--("..PointK.x..",".. PointK.y ..")*u--cycle withcolor \\luameshmpcolorBbox;"
      else
         output = output .. "draw (".. PointI.x ..",".. PointI.y ..")*u--("..PointJ.x..",".. PointJ.y ..")*u--("..PointK.x..",".. PointK.y ..")*u--cycle withcolor \\luameshmpcolor;"
      end
   end
   if(points=="points") then
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "dotlabel.llft (btex $\\MeshPoint^{*}_{"..j.."}$ etex, (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u ) withcolor \\luameshmpcolorBbox ;"
            j=j+1
         else
            output = output .. "dotlabel.llft (btex $\\MeshPoint_{" .. i .. "}$ etex, (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u ) withcolor \\luameshmpcolor ;"
         end
      end
   end
   if(points=="dotpoints") then
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "drawdot (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u withcolor \\luameshmpcolorBbox withpen pencircle scaled 3;"
            j=j+1
         else
            output = output .. "drawdot (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u withcolor \\luameshmpcolor withpen pencircle scaled 3;"
         end
      end
   end
   return output
end


-- buildMesh with MP
function buildMeshMPBW(chaine,mode,points,bbox,scale)
   local listPoints = buildList(chaine, mode)
   local triangulation = BowyerWatson(listPoints,bbox)
   output = traceMeshMP(listPoints, triangulation,points)
   output = "\\leavevmode\\begin{mplibcode}beginfig(0);u:="..scale.. ";" .. output .."endfig;\\end{mplibcode}"
   tex.sprint(output)
end

-- buildMesh with MP include code
function buildMeshMPBWinc(chaine,beginning, ending,mode,points,bbox,scale)
   local listPoints = buildList(chaine, mode)
   local triangulation = BowyerWatson(listPoints,bbox)
   output = traceMeshMP(listPoints, triangulation,points)
   output = "\\leavevmode\\begin{mplibcode}u:="..scale..";"..beginning .. output .. ending .. "\\end{mplibcode}"
   tex.sprint(output)
end

-- buildMesh with TikZ
function buildMeshTikZBW(chaine,mode,points,bbox,scale,color,colorBbox)
   local listPoints = buildList(chaine, mode)
   local triangulation = BowyerWatson(listPoints,bbox)
   output = traceMeshTikZ(listPoints, triangulation,points,color,colorBbox)
   output = "\\noindent\\begin{tikzpicture}[x=" .. scale .. ",y=" .. scale .."]" .. output .."\\end{tikzpicture}"
   tex.sprint(output)
end

-- buildMesh with TikZ
function buildMeshTikZBWinc(chaine,beginning, ending,mode,points,bbox,scale,color,colorBbox)
   local listPoints = buildList(chaine, mode)
   local triangulation = BowyerWatson(listPoints,bbox)
   output = traceMeshTikZ(listPoints, triangulation,points,color,colorBbox)
   output = "\\noindent\\begin{tikzpicture}[x=" .. scale .. ",y=" .. scale .."]" ..beginning.. output..ending .."\\end{tikzpicture}"
   tex.sprint(output)
end


-- print points of the mesh
function tracePointsMP(listPoints,points)
   output = "";
   output = output .. " pair MeshPoints[];"
   for i=1,#listPoints do
      output = output .. "MeshPoints[".. i .. "] = (" .. listPoints[i].x .. "," .. listPoints[i].y .. ")*u;"
   end
   if(points=="points") then
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "dotlabel.llft (btex $\\MeshPoint^{*}_{" .. j .. "}$ etex, (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u ) withcolor \\luameshmpcolorBbox ;"
            j=j+1
         else
            output = output .. "dotlabel.llft (btex $\\MeshPoint_{" .. i .. "}$ etex, (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u ) withcolor \\luameshmpcolor ;"
         end
      end
   else
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "drawdot  (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u  withcolor \\luameshmpcolorBbox withpen pencircle scaled 3;"
         else
            output = output .. "drawdot (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u  withcolor \\luameshmpcolor withpen pencircle scaled 3;"
         end
      end
   end
   return output
end

-- print points of the mesh
function tracePointsTikZ(listPoints,points,color,colorBbox)
   output = "";
   for i=1,#listPoints do
      output = output .. "\\coordinate (MeshPoints".. i .. ") at  (" .. listPoints[i].x .. "," .. listPoints[i].y .. ");"
   end
   if(points=="points") then
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "\\draw[color="..colorBbox.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\MeshPoint^*_{" .. j .. "}$};"
            j = j+1
         else
            output = output .. "\\draw[color="..color.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\MeshPoint_{" .. i .. "}$};"
         end
      end
   else
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "\\draw[color="..colorBbox.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} ;"
         else
            output = output .. "\\draw[color="..color.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} ;"
         end
      end
   end
   return output
end

-- print points to mesh
function printPointsMP(chaine,mode,points,bbox,scale)
   local listPoints = buildList(chaine, mode)
   if(bbox == "bbox" ) then
      listPoints = buildBoundingBox(listPoints)
   end
   output = tracePointsMP(listPoints,points)
   output = "\\leavevmode\\begin{mplibcode}beginfig(0);u:="..scale.. ";" .. output .."endfig;\\end{mplibcode}"
   tex.sprint(output)
end


-- print points to mesh
function printPointsMPinc(chaine,beginning, ending, mode,points,bbox,scale)
   local listPoints = buildList(chaine, mode)
   if(bbox == "bbox" ) then
      listPoints = buildBoundingBox(listPoints)
   end
   output = tracePointsMP(listPoints,points)
   output = "\\leavevmode\\begin{mplibcode}u:="..scale..";"..beginning .. output .. ending .. "\\end{mplibcode}"
   tex.sprint(output)
end

-- print points to mesh
function printPointsTikZ(chaine,mode,points,bbox,scale,color,colorBbox)
   local listPoints = buildList(chaine, mode)
   if(bbox == "bbox" ) then
      listPoints = buildBoundingBox(listPoints)
   end
   output = tracePointsTikZ(listPoints,points,color,colorBbox)
   output = "\\noindent\\begin{tikzpicture}[x=" .. scale .. ",y=" .. scale .."]" .. output .."\\end{tikzpicture}"
   tex.sprint(output)
end


-- print points to mesh
function printPointsTikZinc(chaine,beginning, ending, mode,points,bbox,scale,color,colorBbox)
   local listPoints = buildList(chaine, mode)
   if(bbox == "bbox" ) then
      listPoints = buildBoundingBox(listPoints)
   end
   output = tracePointsTikZ(listPoints,points,color,colorBbox)
   output = "\\noindent\\begin{tikzpicture}[x=" .. scale .. ",y=" .. scale .."]" ..beginning.. output..ending .."\\end{tikzpicture}"
   tex.sprint(output)
end


-- buildMesh
function buildRect(largeur,a,b,nbrA, nbrB)
   local listPoints = rectangleList(a,b,nbrA,nbrB)
   local triangulation = BowyerWatson(listPoints,"none")
   traceTikZ(listPoints, triangulation,largeur,"none")
end


--
function TeXaddOnePointTikZ(listPoints,P,step,bbox,color,colorBack, colorNew, colorCircle,colorBbox)
   output = ""
   -- build the triangulation
   local triangulation = BowyerWatson(listPoints,bbox)
   local badTriangles = buildBadTriangles(P,triangulation,listPoints)
   for i=1,#listPoints do
      output = output .. "\\coordinate (MeshPoints".. i .. ") at  (" .. listPoints[i].x .. "," .. listPoints[i].y .. ");"
   end
   if(step == "badT") then
      -- draw all triangle
      for i=1,#triangulation do
         PointI = listPoints[triangulation[i][1]]
         PointJ = listPoints[triangulation[i][2]]
         PointK = listPoints[triangulation[i][3]]
         if(triangulation[i].type == "bbox") then
            output = output .. "\\draw[color="..colorBbox.."] (".. PointI.x ..",".. PointI.y ..")--("..PointJ.x..",".. PointJ.y ..")--("..PointK.x..",".. PointK.y ..")--cycle;"
         else
            output = output .. "\\draw[color="..color.."] (".. PointI.x ..",".. PointI.y ..")--("..PointJ.x..",".. PointJ.y ..")--("..PointK.x..",".. PointK.y ..")--cycle;"
         end
      end
      -- draw and fill the bad triangle
      for i=1,#badTriangles do
         PointI = listPoints[triangulation[badTriangles[i]][1]]
         PointJ = listPoints[triangulation[badTriangles[i]][2]]
         PointK = listPoints[triangulation[badTriangles[i]][3]]
         output = output .. "\\draw[fill="..colorBack.."] (".. PointI.x ..",".. PointI.y ..")--("..PointJ.x..",".. PointJ.y ..")--("..PointK.x..",".. PointK.y ..")--cycle;"
      end
      -- draw the circoncircle
      for i=1,#badTriangles do
         PointI = listPoints[triangulation[badTriangles[i]][1]]
         PointJ = listPoints[triangulation[badTriangles[i]][2]]
         PointK = listPoints[triangulation[badTriangles[i]][3]]
         center, radius = circoncircle(PointI, PointJ, PointK)
         output = output .. "\\draw[dashed, color="..colorCircle.."] ("..center.x .. "," .. center.y .. ") circle ("..radius ..");"
      end
      -- mark the points
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "\\draw[color="..colorBbox.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\MeshPoint^*_{" .. j .. "}$};"
            j = j+1
         else
            output = output .. "\\draw[color="..color.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\MeshPoint_{" .. i .. "}$};"
         end
      end
      -- mark the point to add
      output = output .. "\\draw[color="..colorNew.."] (" .. P.x ..",".. P.y .. ") node {$\\bullet$} node[anchor=north east] {$\\NewPoint$};"
   elseif(step == "cavity") then
      polygon = buildCavity(badTriangles, triangulation)
      polyNew = cleanPoly(polygon)
      -- remove the bad triangles
      for j=1,#badTriangles do
         table.remove(triangulation,badTriangles[j]-(j-1))
      end
      -- draw the triangles
      for i=1,#triangulation do
         PointI = listPoints[triangulation[i][1]]
         PointJ = listPoints[triangulation[i][2]]
         PointK = listPoints[triangulation[i][3]]
         if(triangulation[i].type == "bbox") then
            output = output .. "\\draw[color="..colorBbox.."] (".. PointI.x ..",".. PointI.y ..")--("..PointJ.x..",".. PointJ.y ..")--("..PointK.x..",".. PointK.y ..")--cycle;"
         else
            output = output .. "\\draw[color="..color.."] (".. PointI.x ..",".. PointI.y ..")--("..PointJ.x..",".. PointJ.y ..")--("..PointK.x..",".. PointK.y ..")--cycle;"
         end
      end
      -- fill and draw the cavity
      path = ""
      for i=1,#polyNew do
         PointI = listPoints[polyNew[i]]
         path = path .. "(".. PointI.x ..",".. PointI.y ..")--"
      end
      output = output .. "\\draw[color="..colorNew..",fill ="..colorBack..", thick] " .. path .. "cycle;"
      -- mark the points of the mesh
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "\\draw[color="..colorBbox.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\MeshPoint^*_{" .. j .. "}$};"
            j=j+1
         else
            output = output .. "\\draw[color="..color.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\MeshPoint_{" .. i .. "}$};"
         end
      end
      -- mark the adding point
      output = output .. "\\draw[color="..colorNew.."] (" .. P.x ..",".. P.y .. ") node {$\\bullet$} node[anchor=north east] {$\\NewPoint$};"
   elseif(step == "newT") then
      polygon = buildCavity(badTriangles, triangulation)
      polyNew = cleanPoly(polygon)
      -- remove the bad triangles
      for j=1,#badTriangles do
         table.remove(triangulation,badTriangles[j]-(j-1))
      end
      -- draw the triangle of the triangulation
      for i=1,#triangulation do
         PointI = listPoints[triangulation[i][1]]
         PointJ = listPoints[triangulation[i][2]]
         PointK = listPoints[triangulation[i][3]]
         if(triangulation[i].type == "bbox") then
            output = output .. "\\draw[color="..colorBbox.."] (".. PointI.x ..",".. PointI.y ..")--("..PointJ.x..",".. PointJ.y ..")--("..PointK.x..",".. PointK.y ..")--cycle;"
         else
            output = output .. "\\draw[color="..color.."] (".. PointI.x ..",".. PointI.y ..")--("..PointJ.x..",".. PointJ.y ..")--("..PointK.x..",".. PointK.y ..")--cycle;"
         end
      end
      -- fill and draw the cavity
      path = ""
      for i=1,#polyNew do
         PointI = listPoints[polyNew[i]]
         path = path .. "(".. PointI.x ..",".. PointI.y ..")--"
      end
      output = output .. "\\draw[color="..colorNew..",fill ="..colorBack..", thick] " .. path .. "cycle;"
      -- draw the new triangles composed by the edges of the polygon and the added point
      for i=1,#polygon do
         output = output .. "\\draw[color=TeXCluaMeshNewTikZ, thick]".."(".. listPoints[polygon[i][1]].x .. "," .. listPoints[polygon[i][1]].y .. ") -- (" .. listPoints[polygon[i][2]].x .. "," .. listPoints[polygon[i][2]].y ..");"
         output = output .. "\\draw[color="..colorNew..", thick]".."(".. listPoints[polygon[i][1]].x .. "," .. listPoints[polygon[i][1]].y .. ") -- (" .. P.x .. "," .. P.y ..");"
         output = output .. "\\draw[color="..colorNew..", thick]".."(".. listPoints[polygon[i][2]].x .. "," .. listPoints[polygon[i][2]].y .. ") -- (" .. P.x .. "," .. P.y ..");"
      end
      -- mark points
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "\\draw[color="..colorBbox.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\MeshPoint^*_{" .. j .. "}$};"
            j=j+1
         else
            output = output .. "\\draw[color="..color.."] (" .. listPoints[i].x ..",".. listPoints[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\MeshPoint_{" .. i .. "}$};"
         end
      end
      -- mark the added point
      output = output .. "\\draw[color="..colorNew.."] (" .. P.x ..",".. P.y .. ") node {$\\bullet$} node[anchor=north east] {$\\NewPoint$};"
   end
   return output
end

function TeXaddOnePointMPBW(listPoints,P,step,bbox)
   output = "";
   output = output .. "pair MeshPoints[];"
   -- build the triangulation
   local triangulation = {}
   local badTriangles = {}
   triangulation = BowyerWatson(listPoints,bbox)
   badTriangles = buildBadTriangles(P,triangulation,listPoints)
   for i=1,#listPoints do
      output = output .. "MeshPoints[".. i .. "] = (" .. listPoints[i].x .. "," .. listPoints[i].y .. ")*u;"
   end
   if(step == "badT") then
      -- draw all triangle
      for i=1,#triangulation do
         PointI = listPoints[triangulation[i][1]]
         PointJ = listPoints[triangulation[i][2]]
         PointK = listPoints[triangulation[i][3]]
         if(triangulation[i].type == "bbox") then
            output = output .. "draw (".. PointI.x ..",".. PointI.y ..")*u--("..PointJ.x..",".. PointJ.y ..")*u--("..PointK.x..",".. PointK.y ..")*u--cycle withcolor \\luameshmpcolorBbox;"
         else
            output = output .. "draw (".. PointI.x ..",".. PointI.y ..")*u--("..PointJ.x..",".. PointJ.y ..")*u--("..PointK.x..",".. PointK.y ..")*u--cycle withcolor \\luameshmpcolor;"
         end
      end
      -- draw and fill the bad triangle
      for i=1,#badTriangles do
         PointI = listPoints[triangulation[badTriangles[i]][1]]
         PointJ = listPoints[triangulation[badTriangles[i]][2]]
         PointK = listPoints[triangulation[badTriangles[i]][3]]
         output = output .. "draw (".. PointI.x ..",".. PointI.y ..")*u--("..PointJ.x..",".. PointJ.y ..")*u--("..PointK.x..",".. PointK.y ..")*u--cycle withcolor \\luameshmpcolor;"
         output = output .. "fill (".. PointI.x ..",".. PointI.y ..")*u--("..PointJ.x..",".. PointJ.y ..")*u--("..PointK.x..",".. PointK.y ..")*u--cycle withcolor \\luameshmpcolorBack;"
      end
      -- draw the circoncircle
      for i=1,#badTriangles do
         PointI = listPoints[triangulation[badTriangles[i]][1]]
         PointJ = listPoints[triangulation[badTriangles[i]][2]]
         PointK = listPoints[triangulation[badTriangles[i]][3]]
         center, radius = circoncircle(PointI, PointJ, PointK)
         output = output .. "draw fullcircle scaled ("..radius .."*2u) shifted ("..center.x .. "*u," .. center.y .. "*u) dashed evenly withcolor \\luameshmpcolorCircle;"
      end
      -- mark the points
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "dotlabel.llft (btex $\\MeshPoint^{*}_{" .. j .. "}$ etex, (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u ) withcolor \\luameshmpcolorBbox ;"
            j=j+1
         else
            output = output .. "dotlabel.llft (btex $\\MeshPoint_{" .. i .. "}$ etex, (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u ) withcolor \\luameshmpcolor ;"
         end
      end
      -- mark the point to add
      output = output .. "dotlabel.llft (btex $\\NewPoint$ etex,(" .. P.x ..",".. P.y .. ")*u) withcolor \\luameshmpcolorNew;"
   elseif(step == "cavity") then
      polygon = buildCavity(badTriangles, triangulation)
      polyNew = cleanPoly(polygon)
      -- remove the bad triangles
      for j=1,#badTriangles do
         table.remove(triangulation,badTriangles[j]-(j-1))
      end
      -- draw the triangles
      for i=1,#triangulation do
         PointI = listPoints[triangulation[i][1]]
         PointJ = listPoints[triangulation[i][2]]
         PointK = listPoints[triangulation[i][3]]
         if(triangulation[i].type == "bbox") then
            output = output .. "draw (".. PointI.x ..",".. PointI.y ..")*u--("..PointJ.x..",".. PointJ.y ..")*u--("..PointK.x..",".. PointK.y ..")*u--cycle withcolor \\luameshmpcolorBbox;"
         else
            output = output .. "draw (".. PointI.x ..",".. PointI.y ..")*u--("..PointJ.x..",".. PointJ.y ..")*u--("..PointK.x..",".. PointK.y ..")*u--cycle withcolor \\luameshmpcolor;"
         end
      end
      -- fill and draw the cavity
      path = ""
      for i=1,#polyNew do
         PointI = listPoints[polyNew[i]]
         path = path .. "(".. PointI.x ..",".. PointI.y ..")*u--"
      end
      output = output .. "fill " .. path .. "cycle withcolor \\luameshmpcolorBack;"
      output = output .. "draw " .. path .. "cycle withcolor \\luameshmpcolorNew  withpen pencircle scaled 1pt;"
      -- mark the points of the mesh
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "dotlabel.llft (btex $\\MeshPoint^{*}_{" .. j .. "}$ etex, (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u ) withcolor \\luameshmpcolorBbox ;"
            j=j+1
         else
            output = output .. "dotlabel.llft (btex $\\MeshPoint_{" .. i .. "}$ etex, (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u ) withcolor \\luameshmpcolor ;"
         end
      end
      -- mark the adding point
      output = output .. "dotlabel.llft (btex $\\NewPoint$ etex,(" .. P.x ..",".. P.y .. ")*u) withcolor \\luameshmpcolorNew ;"
   elseif(step == "newT") then
      polygon = buildCavity(badTriangles, triangulation)
      polyNew = cleanPoly(polygon)
      -- remove the bad triangles
      for j=1,#badTriangles do
         table.remove(triangulation,badTriangles[j]-(j-1))
      end
      -- draw the triangle of the triangulation
      for i=1,#triangulation do
         PointI = listPoints[triangulation[i][1]]
         PointJ = listPoints[triangulation[i][2]]
         PointK = listPoints[triangulation[i][3]]
         if(triangulation[i].type == "bbox") then
            output = output .. "draw (".. PointI.x ..",".. PointI.y ..")*u--("..PointJ.x..",".. PointJ.y ..")*u--("..PointK.x..",".. PointK.y ..")*u--cycle withcolor \\luameshmpcolorBbox;"
         else
            output = output .. "draw (".. PointI.x ..",".. PointI.y ..")*u--("..PointJ.x..",".. PointJ.y ..")*u--("..PointK.x..",".. PointK.y ..")*u--cycle withcolor \\luameshmpcolor;"
         end
      end
      -- fill  the cavity
      path = ""
      for i=1,#polyNew do
         PointI = listPoints[polyNew[i]]
         path = path .. "(".. PointI.x ..",".. PointI.y ..")*u--"
      end
      output = output .. "fill " .. path .. "cycle withcolor \\luameshmpcolorBack;"
      -- draw the new triangles composed by the edges of the polygon and the added point
      for i=1,#polygon do
         output = output .. "draw".."(".. listPoints[polygon[i][1]].x .. "," .. listPoints[polygon[i][1]].y .. ")*u -- (" .. listPoints[polygon[i][2]].x .. "," .. listPoints[polygon[i][2]].y ..")*u withcolor \\luameshmpcolorNew  withpen pencircle scaled 1pt;"
         output = output .. "draw".."(".. listPoints[polygon[i][1]].x .. "," .. listPoints[polygon[i][1]].y .. ")*u -- (" .. P.x .. "," .. P.y ..")*u withcolor \\luameshmpcolorNew withpen pencircle scaled 1pt;"
         output = output .. "draw".."(".. listPoints[polygon[i][2]].x .. "," .. listPoints[polygon[i][2]].y .. ")*u -- (" .. P.x .. "," .. P.y ..")*u withcolor \\luameshmpcolorNew withpen pencircle scaled 1pt;"
      end
      -- mark points
      j=1
      for i=1,#listPoints do
         if(listPoints[i].type == "bbox") then
            output = output .. "dotlabel.llft (btex $\\MeshPoint^{*}_{" .. j .. "}$ etex, (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u ) withcolor \\luameshmpcolorBbox ;"
            j=j+1
         else
            output = output .. "dotlabel.llft (btex $\\MeshPoint_{" .. i .. "}$ etex, (" .. listPoints[i].x ..",".. listPoints[i].y .. ")*u ) withcolor \\luameshmpcolor ;"
         end
      end
      -- mark the added point
      output = output .. "dotlabel.llft (btex $\\NewPoint$ etex,(" .. P.x ..",".. P.y .. ")*u) withcolor \\luameshmpcolorNew ;"
   end
   return output
end


function TeXOnePointTikZBW(chaine,point,step,scale,mode,bbox,color,colorBack,colorNew,colorCircle,colorBbox)
   local listPoints = {}
   if(mode=="int") then
      Sx,Sy=string.match(point,"%((.+),(.+)%)")
      P = {x=Sx, y=Sy}
      listPoints = buildList(chaine, mode)
   else
      -- point is a number
      P, listPoints = buildListExt(chaine,tonumber(point))
   end
   output = TeXaddOnePointTikZ(listPoints,P,step,bbox,color,colorBack,colorNew,colorCircle,colorBbox)
   output = "\\noindent\\begin{tikzpicture}[x="..scale..",y="..scale.."]".. output .. "\\end{tikzpicture}"
   tex.sprint(output)
end

function TeXOnePointTikZBWinc(chaine,point,beginning, ending,step,scale,mode,bbox,color,colorBack,colorNew,colorCircle,colorBbox)
   local listPoints = {}
   if(mode=="int") then
      Sx,Sy=string.match(point,"%((.+),(.+)%)")
      P = {x=Sx, y=Sy}
      listPoints = buildList(chaine, mode)
   else
      -- point is a number
      P, listPoints = buildListExt(chaine,tonumber(point))
   end
   output = TeXaddOnePointTikZ(listPoints,P,step,bbox,color,colorBack,colorNew,colorCircle,colorBbox)
   output = "\\noindent\\begin{tikzpicture}[x="..scale..",y="..scale.."]".. beginning..output ..ending.. "\\end{tikzpicture}"
   tex.sprint(output)
end

function TeXOnePointMPBW(chaine,point,step,scale,mode,bbox)
   local listPoints = {}
   if(mode=="int") then
      Sx,Sy=string.match(point,"%((.+),(.+)%)")
      P = {x=Sx, y=Sy}
      listPoints = buildList(chaine, mode)
   else
      -- point is a number
      P, listPoints = buildListExt(chaine,tonumber(point))
   end
   output = TeXaddOnePointMPBW(listPoints,P,step,bbox)
   output = "\\leavevmode\\begin{mplibcode}beginfig(0);u:="..scale..";".. output .. "endfig;\\end{mplibcode}"
   tex.sprint(output)
end

function TeXOnePointMPBWinc(chaine,point,beginning,ending,step,scale,mode,bbox)
   local listPoints = {}
   if(mode=="int") then
      Sx,Sy=string.match(point,"%((.+),(.+)%)")
      P = {x=Sx, y=Sy}
      listPoints = buildList(chaine, mode)
   else
      -- point is a number
      P, listPoints = buildListExt(chaine,tonumber(point))
   end
   output = TeXaddOnePointMPBW(listPoints,P,step,bbox)
   output = "\\begin{mplibcode}u:="..scale..";"..beginning .. output .. ending .. "\\end{mplibcode}"
   tex.sprint(output)
end


function drawGmshMP(file,points,scale)
   local listPoints,triangulation = readGmsh(file)
   output = traceMeshMP(listPoints,triangulation,points)
   output = "\\leavevmode\\begin{mplibcode}beginfig(0);u:="..scale.. ";" .. output .."endfig;\\end{mplibcode}"
   tex.sprint(output)
end

function drawGmshMPinc(file,beginning,ending,points,scale)
   local listPoints,triangulation = readGmsh(file)
   output = traceMeshMP(listPoints,triangulation,points)
   output = "\\leavevmode\\begin{mplibcode}u:="..scale..";"..beginning .. output .. ending .. "\\end{mplibcode}"
   tex.sprint(output)
end



--
function drawGmshTikZ(file,points,scale,color)
   local listPoints,triangulation = readGmsh(file)
   output = traceMeshTikZ(listPoints, triangulation,points,color,colorBbox)
   output = "\\noindent\\begin{tikzpicture}[x=" .. scale .. ",y=" .. scale .."]" .. output .."\\end{tikzpicture}"
   tex.sprint(output)
end

--
function drawGmshTikZinc(file,beginning, ending,points,scale,color)
   local listPoints,triangulation = readGmsh(file)
   output = traceMeshTikZ(listPoints, triangulation,points,color,colorBbox)
   output = "\\noindent\\begin{tikzpicture}[x=" .. scale .. ",y=" .. scale .."]" ..beginning.. output..ending .."\\end{tikzpicture}"
   tex.sprint(output)
end


-- buildVoronoi with MP
function gmshVoronoiMP(file,points,scale,tri,styleD,styleV)
   local listPoints,triangulation = readGmsh(file)
   local listVoronoi = buildVoronoi(listPoints, triangulation)
   output = traceVoronoiMP(listPoints,triangulation,listVoronoi,points,tri,styleD,styleV)
   output = "\\leavevmode\\begin{mplibcode}beginfig(0);u:="..scale.. ";" .. output .."endfig;\\end{mplibcode}"
   tex.sprint(output)
end


-- buildVoronoi with TikZ
function gmshVoronoiTikZ(file,points,scale,tri,color,colorVoronoi,styleD,styleV)
   local listPoints,triangulation = readGmsh(file)
   local listVoronoi = buildVoronoi(listPoints, triangulation)
   output = traceVoronoiTikZ(listPoints,triangulation,listVoronoi,points,tri,color,colorBbox,colorVoronoi,styleD,styleV)
   output = "\\noindent\\begin{tikzpicture}[x=" .. scale .. ",y=" .. scale .."]" .. output .."\\end{tikzpicture}"   tex.sprint(output)
end


-- buildVoronoi with MP
function gmshVoronoiMPinc(file,beginning, ending,points,scale,tri,styleD,styleV)
   local listPoints,triangulation = readGmsh(file)
   local listVoronoi = buildVoronoi(listPoints, triangulation)
   output = traceVoronoiMP(listPoints,triangulation,listVoronoi,points,tri,styleD,styleV)
   output = "\\leavevmode\\begin{mplibcode}u:="..scale..";"..beginning .. output .. ending .. "\\end{mplibcode}"
   tex.sprint(output)
end


-- buildVoronoi with TikZ
function gmshVoronoiTikZinc(file,beginning, ending,points,scale,tri,color,colorVoronoi,styleD,styleV)
   local listPoints,triangulation = readGmsh(file)
   local listVoronoi = buildVoronoi(listPoints, triangulation)
   output = traceVoronoiTikZ(listPoints,triangulation,listVoronoi,points,tri,color,colorBbox,colorVoronoi,styleD,styleV)
   output = "\\noindent\\begin{tikzpicture}[x=" .. scale .. ",y=" .. scale .."]" ..beginning.. output..ending .."\\end{tikzpicture}"
   tex.sprint(output)
end


--------------------------------------------------
--         Meshing of a polygon                 --
--------------------------------------------------

function  tracePolygonMP(polygon,points)
   output = "";
   output = output .. "pair polygon[];"
   for i=1,#polygon do
      output = output .. "polygon[".. i .. "] = (" .. polygon[i].x .. "," .. polygon[i].y .. ")*u;"
   end
   output = output .. "draw "
   for i=1,#polygon do
      output = output .. "(" .. polygon[i].x .. "," .. polygon[i].y .. ")*u -- "
   end
   output = output .. "cycle withcolor \\luameshmpcolorPoly withpen pencircle scaled 1pt;"
   if(points=="points") then
      for i=1,#polygon do
         output = output .. "dotlabel.llft (btex $\\MeshPoint_{" .. i .. "}$ etex, (" .. polygon[i].x ..",".. polygon[i].y .. ")*u ) withcolor \\luameshmpcolorPoly ;"
      end
   end
   if(points=="dotpoints") then
         for i=1,#polygon do
         output = output .. "drawdot  (" .. polygon[i].x ..",".. polygon[i].y .. ")*u  withcolor \\luameshmpcolorPoly withpen pencircle scaled 3;"
      end
   end
   return output
end


function  tracePolygonTikZ(polygon,points, colorPoly)
   output = "";
   for i=1,#polygon do
      output = output .. "\\coordinate (polygon".. i .. ") at  (" .. polygon[i].x .. "," .. polygon[i].y .. ");"
   end
   output = output .. "\\draw[color=".. colorPoly .. ", thick]"
   for i=1,#polygon do
      output = output .. "(" .. polygon[i].x .. "," .. polygon[i].y .. ") -- "
   end
   output = output .. "cycle;"
   if(points=="points") then
      for i=1,#polygon do
         output = output .. "\\draw[color="..colorPoly.."] (" .. polygon[i].x ..",".. polygon[i].y .. ") node {$\\bullet$} node[anchor=north east] {$\\MeshPoint_{" .. i .. "}$};"
      end
   end
   if(points=="dotpoints") then
      for i=1,#polygon do
         output = output .. "\\draw[color="..colorPoly.."] (" .. polygon[i].x ..",".. polygon[i].y .. ") node {$\\bullet$};"
      end
   end
   return output
end



function drawMeshPolygonMP(chaine,mode,h,step,
                             points,scale,random)
   local polygon = buildList(chaine, mode)
   polygon = addPointsPolygon(polygon,h)
   local grid = buildGrid(polygon,h,random)
   local listPoints = addGridPoints(polygon,grid,h)
   if(step=="polygon") then
      -- the polygon
      output = tracePolygonMP(polygon,points)
   end
   if(step=="grid") then
      -- polygon + grid
      output = tracePointsMP(grid,points)
      output = output .. tracePolygonMP(polygon,points)
   end
   if(step=="points") then
      -- polygon + only grid points inside the polygon
      output = tracePointsMP(listPoints,points)
      output = output .. tracePolygonMP(polygon,points)
   end
   if(step=="mesh") then
      -- polygon + mesh
      triangulation = BowyerWatson(listPoints,"none") -- no bbox
      output = traceMeshMP(listPoints,triangulation,points)
      output = output .. tracePolygonMP(polygon,points)
   end

   output = "\\leavevmode\\begin{mplibcode}beginfig(0);u:="..scale.. ";" .. output .."endfig;\\end{mplibcode}"
   tex.sprint(output)
end



function drawMeshPolygonTikZ(chaine,mode,h,step,
                             points,scale,color,colorPoly,random)
   local polygon = buildList(chaine, mode)
   polygon = addPointsPolygon(polygon,h)
   local grid = buildGrid(polygon,h,random)
   local listPoints = addGridPoints(polygon,grid,h)
   if(step=="polygon") then
      -- the polygon
      output = tracePolygonTikZ(polygon,points,colorPoly)
   end
   if(step=="grid") then
      -- polygon + grid
      output = tracePointsTikZ(grid,points,color,"none") -- none for colorBbox
      output = output .. tracePolygonTikZ(polygon,points,colorPoly)
   end
   if(step=="points") then
      -- polygon + only grid points inside the polygon
      output = tracePointsTikZ(listPoints,points,color,"none")
      output = output .. tracePolygonTikZ(polygon,points,colorPoly)
   end
   if(step=="mesh") then
      -- polygon + mesh
      triangulation = BowyerWatson(listPoints,"none") -- no bbox
      output = traceMeshTikZ(listPoints,triangulation,points,color,"none")
      output = output .. tracePolygonTikZ(polygon,points,colorPoly)
   end
   output = "\\noindent\\begin{tikzpicture}[x=" .. scale .. ",y=" .. scale .."]" .. output .."\\end{tikzpicture}"
   tex.sprint(output)
end

function drawMeshPolygonMPinc(chaine,beginning,ending,mode,h,step,
                             points,scale,random)
   local polygon = buildList(chaine, mode)
   polygon = addPointsPolygon(polygon,h)
   local grid = buildGrid(polygon,h,random)
   local listPoints = addGridPoints(polygon,grid,h)
   if(step=="polygon") then
      -- the polygon
      output = tracePolygonMP(polygon,points)
   end
   if(step=="grid") then
      -- polygon + grid
      output = tracePointsMP(grid,points)
      output = output .. tracePolygonMP(polygon,points)
   end
   if(step=="points") then
      -- polygon + only grid points inside the polygon
      output = tracePointsMP(listPoints,points)
      output = output .. tracePolygonMP(polygon,points)
   end
   if(step=="mesh") then
      -- polygon + mesh
      triangulation = BowyerWatson(listPoints,"none") -- no bbox
      output = traceMeshMP(listPoints,triangulation,points)
      output = output .. tracePolygonMP(polygon,points)
   end
   output = "\\begin{mplibcode}u:="..scale..";"..beginning .. output .. ending .. "\\end{mplibcode}"
   tex.sprint(output)
end



function drawMeshPolygonTikZinc(chaine,beginning,ending,mode,h,step,
                             points,scale,color,colorPoly,random)
   local polygon = buildList(chaine, mode)
   polygon = addPointsPolygon(polygon,h)
   local grid = buildGrid(polygon,h,random)
   local listPoints = addGridPoints(polygon,grid,h)
   if(step=="polygon") then
      -- the polygon
      output = tracePolygonTikZ(polygon,points,colorPoly)
   end
   if(step=="grid") then
      -- polygon + grid
      output = tracePointsTikZ(grid,points,color,"none") -- none for colorBbox
      output = output .. tracePolygonTikZ(polygon,points,colorPoly)
   end
   if(step=="points") then
      -- polygon + only grid points inside the polygon
      output = tracePointsTikZ(listPoints,points,color,"none")
      output = output .. tracePolygonTikZ(polygon,points,colorPoly)
   end
   if(step=="mesh") then
      -- polygon + mesh
      triangulation = BowyerWatson(listPoints,"none") -- no bbox
      output = traceMeshTikZ(listPoints,triangulation,points,color,"none")
      output = output .. tracePolygonTikZ(polygon,points,colorPoly)
   end
   output = "\\noindent\\begin{tikzpicture}[x="..scale..",y="..scale.."]".. beginning..output ..ending.. "\\end{tikzpicture}"
   tex.sprint(output)
end
