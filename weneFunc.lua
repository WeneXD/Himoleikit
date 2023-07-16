cMath={}
function Sleep(x)
  if x > 0 then os.execute("ping -n " .. tonumber(x+1) .. " localhost > NUL") end
end

function Clear()
	os.execute("cls")
end

function cMath.clamp(x,min,max)
	if x<min then x=min end
	if x>max then x=max end
	return x
end

function cMath.dist(x1,y1,x2,y2)
	return math.sqrt((x2-x1)^2+(y2-y1)^2)
end

function TableLen(x)
	_x=0
	for i,v in pairs(x)do
		_x=_x+1
	end
	return _x
end