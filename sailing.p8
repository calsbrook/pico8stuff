pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
	charx = 60
	chary = 60
	direction = 1
	speed = 1.5
end

function _draw()
	cls()
	map()
	drawcharacter()
end

function drawcharacter()
	spr(direction,charx,chary)
end

function _update()
	if btnp(⬆️) then
		direction = 1
		speed = 1.5
	elseif btnp(⬇️) then
		direction = 2
		speed = .5
	elseif btnp(➡️) then
		direction = 3
		speed = 1
	elseif btnp(⬅️) then
		direction = 4
		speed = 1
	end
	
	if direction == 1 then
		chary -= speed
	elseif direction == 2 then
		chary += speed
	elseif direction == 3 then
		charx += speed
	elseif direction == 4 then
		charx -= speed
	end
end
__gfx__
000000000000f00000ff7ff00000000000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000f7f0000f774f00ffff700007ffff0cc7ccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000f477f0007774f00f4477f00f7744f0c7c7cccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000f4777000f444f00f47774ff47774f0cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000f444f000f444f00f4444f44f4444f0cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000f444f0004f4f400fffff4004fffff0cccccc7c00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000fffff00004f4000444440000444440ccccc7c700000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000444440000040000000000000000000cccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505050505050505050505050505050505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
