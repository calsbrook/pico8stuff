pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

function _init()
	t=0
	gameboard = {}
	for i=1, 11 do 
		add(gameboard, {0,0,0,0,0,0})
	end
	locations = {}
	allblobs = {{x=1,y=1,col=9}, {x=3,y=1,col=9},{x=2,y=4,col=9},{x=2,y=1,col=9},{x=1,y=11,col=11}}
	placeblobs()
end

function _draw()
	cls()
	for i=1, #gameboard do
		for j=1, #gameboard[i] do
			if gameboard[i][j] > 0 then
				pal(9, gameboard[i][j])
				spr(findconnect(j,i),(j-1)*8+1,(i-1)*8+1)
				pal()
			end
		end
	end
	rect(0,0,8*6+1,8*11+1)
end

function findconnect(x,y)
	above, below, right, left = false
	connections = 0
	col=gameboard[y][x]
	if y>1 and gameboard[y-1][x] == col then
		connections += 1
		above = true
	end
	if y<11 and gameboard[y+1][x] == col then
		connections += 1
		below = true
	end
	if x>1 and gameboard[y][x-1] == col then
		connections += 1
		left = true
	end
	if x<6 and gameboard[y][x+1] == col then
		connections += 1
		right = true
	end
	
	if connections > 0 then
		if connections >=2 then
			return 6
		end
		if connections == 1 then
			if above then
				return 2
			elseif below then
				return 3
			elseif left then
				return 4
			elseif right then
				return 5
			end
		end
	else
		return 1
	end
end

function _update()
	t+=1
	if t%20==0 then
		checkallblobs()
		gravity()
		placeblobs()
	end
end

function placeblobs()
	foreach(allblobs, function(blob)
		gameboard[blob.y][blob.x] = blob.col
	end)
end

function gravity()
	for i=1, #gameboard do
		for j=1, #gameboard[i] do
			y = 12-i
			x = j
			foreach(allblobs, function(blob)
				if (blob.y == y and blob.x == x) then
					if blob.y < 11 then
						if gameboard[y+1][j] == 0 then
							gameboard[blob.y][blob.x] = 0
							blob.y+=1
						end
					end
				end
			end)
		end
	end
end

function checkallblobs()
	foreach(allblobs, function(blob1)
		size = 1
		attached = {}
		add(attached, blob1)
		findblobsize(blob1)
		if size >=4 then
			foreach(attached, function(dead)
				foreach(allblobs, function(blob)
					if blob.x == dead.x and blob.y == dead.y then
						gameboard[blob.y][blob.x] = 0
						del(allblobs, blob)
					end
				end)
			end)
		end
	end)
end

function findblobsize(blob2)
	foreach(allblobs, function(blob3)
		noted, connected = false
		foreach(attached, function(att)
			if att.x == blob3.x and att.y == blob3.y and att.col == blob3.col then
				noted = true
			end
			if blob3.col == att.col then
				if (blob3.x == (att.x+1 or att.x-1) and blob3.y==att.y) or (blob3.y == (att.y+1 or att.y-1) and blob3.x==att.x) then
					connected = true
				end
			end
		end)
		if noted == false and connected == true then
			size += 1
			add(attached, blob3)
			findblobsize(blob3)
		end
	end)
end

function checkallsides(x,y)
	col = gameboard[y][x]
	if y<11 then
		if gameboard[y+1][x] == col then
			for i=1, #locations do
				if locations[i][1] == x and locations[i][2] == y+1 then
					return
				else
					size += 1
					add(locations, {x,y+1})
					checkallsides(x,y+1)
				end
			end
		end
	end
	if y>1 then
		if gameboard[y-1][x] == col then
			for i=1, #locations do
				if locations[i][1] == x and locations[i][2] == y-1 then
					return
				else
					size += 1
					add(locations, {x,y-1})
					checkallsides(x,y-1)
				end
			end
		end
	end
	if x<11 then
		if gameboard[y][x+1] == col then
			for i=1, #locations do
				if locations[i][1] == x+1 and locations[i][2] == y then
					return
				else
					size += 1
					add(locations, {x+1,y})
					checkallsides(x+1,y)
				end
			end
		end
	end
	if x>1 then
		if gameboard[y][x-1] == col then
			for i=1, #locations do
				if locations[i][1] == x-1 and locations[i][2] == y then
					return
				else
					size += 1
					add(locations, {x+1,y})
					checkallsides(x+1,y)
				end
			end
		end
	end
	return
end
__gfx__
00000000000000900999999000999900099999000099999009999990900000090000000000000000000000000000000000000000000000000000000000000000
00000000009999009999999909999990999999900999999999999999090000900000000000000000000000000000000000000000000000000000000000000000
00700700099999909999999999999999999999999999999999999999000000000000000000000000000000000000000000000000000000000000000000000000
00077000990990999909909999099099990990999909909999099099000090000000000000000000000000000000000000000000000000000000000000000000
00077000999999999999999999999999999999999999999999999999000000000000000000000000000000000000000000000000000000000000000000000000
00700700999999999999999999999999999999999999999999999999000000000000000000000000000000000000000000000000000000000000000000000000
00000000099999900999999099999999999999900999999999999999090000900000000000000000000000000000000000000000000000000000000000000000
00000000009999000099990009999990099999000099999009999990900000090000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000010005060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000005060606060400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
