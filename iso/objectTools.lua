function addObject(x, y, z, tileID, oType, oBehaviour)
	local x = x or 0
	local y = y or 0
	local z = z or 0
	local tileID = tileID or 1
	local oType = oType or "object"
	local oBehaviour = oBehaviour or {{"all"}}
	local xy = x + y
	table.insert(objects, {tileID = tileID, curX = x, curY = y, curZ = z, behaviour = oBehaviour, curXY = xy})
end
