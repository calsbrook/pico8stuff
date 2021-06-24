pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
	timer= 0
	positions = {
	a={30,106},
	b={60,88},
	c={90,106}
	}
	notifications = {}
end

function _draw()
	cls()
	circ(64,128,50,7)
	line(32,90,64,127,7)
	line(98,90,64,127,7)
	draw_boys()
	draw_orbs()
	draw_progress()
	drawnotifications()
	sspr(0,32,27,31,50,30)
	
end

function _update()
	timer += 1
	if btnp(⬅️) then
		foreach(myboys, function(obj)
			if obj.pos == "a" then
				obj.pos = "c"
			elseif obj.pos == "b" then
				obj.pos = "a"
			elseif obj.pos == "c" then
				obj.pos = "b"
			end
		end)
	end
	if btnp(➡️) then
		foreach(myboys, function(obj)
			if obj.pos == "a" then
				obj.pos = "b"
			elseif obj.pos == "b" then
				obj.pos = "c"
			elseif obj.pos == "c" then
				obj.pos = "a"
			end
		end)
	end
	foreach(myboys, function(obj)
		if obj.state == "idle" then
			obj.timer +=1
		end
		if obj.state == "attack" then
			if timer - obj.atime >= 30 then
				obj.timer = 0
				obj.state = "idle"
			end
		end
	end)

	if timer % 30 == 0 then
		foreach(myboys,function(obj)
			if obj.ani == 0 then
				obj.ani = 1
			elseif blob.ani == 1 then
				obj.ani = 0
			end
		end)
	end
	foreach(myboys, function(obj)
		if obj.state == "idle" and obj.timer == (obj.spd * 50) then
			
			obj.atk()
			obj.state="attack"
			sfx(obj.atk_sound)
			obj.atime = timer
			notification(obj.atkval,positions[obj.pos][1]+8,positions[obj.pos][2]-8,8,30)
			
		end
	end)
end


blob = {
hp=10,
mp=0,
spd=2,
atkval=1,
sp=1,
state="idle",
ani=0,
atime=0,
timer= 0,
bluecntr = 0,
redcntr = 0,
atksprt = 17,
pos="a",
atk=function()
	if blob.redcntr >= 3 then
		blob.atksprt = 20
		blob.redcntr = 0
	elseif blob.bluecntr >= 2 then
		blob.bluecntr = 0
		blob.atksprt = 18
		blob.redcntr += 1
	else
		blob.bluecntr += 1
		blob.atksprt = 17
	end
end,
atk_sound = 0
}
boy= {
hp=15,
mp=0,
spd=5,
atkval=5,
sp=4,
state="idle",
ani=0,
atime = 0,
timer = 0,
bluecntr = 0,
atksprt = 16,
pos="b",
atk=function()
	if boy.bluecntr >= 1 then
		boy.bluecntr = 0
		boy.atksprt = 18
	else
		boy.bluecntr += 1
		boy.atksprt = 16
	end
end,
atk_sound = 1
}
toad = {
hp=5,
mp=10,
spd=1,
atkval=2,
sp=8,
state="idle",
ani=0,
atime = 0,
timer = 0,
bluecntr = 0,
atksprt = 19,
pos="c",
atk=function()
	if toad.bluecntr >= 5 then
		toad.bluecntr = 0
		toad.atksprt = 18
	else
		toad.bluecntr += 1
		toad.atksprt = 19
	end
end,
atk_sound = 1
}

myboys = {blob,boy,toad}
-->8
--attacks

function blobatk()
	if blob.bluecntr >= 2 then
		blob.bluecntr = 0
		blob.atksprt = 18
	else
		blob.bluecntr += 1
		blob.atksprt = 17
	end
end

function boyatk()
	if boy.bluecntr >= 1 then
		boy.bluecntr = 0
		boy.atksprt = 18
	else
		boy.bluecntr += 1
		boy.atksprt = 16
	end
end
-->8
--draws

function draw_orbs()
	foreach(myboys, function(obj)
		for i=0, obj.bluecntr-1 do
			spr(7,positions[obj.pos][1]-2+(i*3),positions[obj.pos][2]+13)
		end
	end)
end

function draw_progress()
	foreach(myboys, function(obj)
		line(positions[obj.pos][1]-2,positions[obj.pos][2]+10,positions[obj.pos][1]-2+flr(obj.timer/(obj.spd*50)*10),positions[obj.pos][2]+10,12)
		rect(positions[obj.pos][1]-2,positions[obj.pos][2]+9,positions[obj.pos][1]+9,positions[obj.pos][2]+11,6)
	end)
end

function draw_boys()
	foreach(myboys, function(obj)
		if obj.state == "idle" then
			spr(obj.sp+obj.ani,positions[obj.pos][1],positions[obj.pos][2])
		end
		if obj.state == "attack" then
			spr(obj.atksprt,positions[obj.pos][1],positions[obj.pos][2]-9)
			spr(obj.sp+2,positions[obj.pos][1],positions[obj.pos][2])
		end
	end)
end
-->8
--tools

function notification(txt,x,y,col,dur)
	local note={txt=txt,x=x,y=y,col=col,dur=dur}
	add(notifications,note)
end

function drawnotifications()
	for i=1,#notifications do
		local note=notifications[i]
		if note!=nil then
			print(note.txt,note.x,note.y,note.col)
			if note.dur > 0 then
				notifications[i].dur-=1
				notifications[i].y-=.05
			elseif note.dur<=0 then
				del(notifications,notifications[i])
			end
		end
	end
end
__gfx__
00000000000000000000000000999900011111100000000001111110cc0000000778880007788800077888000000000000000000000000000000000000000000
00000000009999000000000009000090111111100111111011111116cc0000007778887077788870777888700000000000000000000000000000000000000000
00700700090000900099990090000009144444401111111014444446000000008877778088777780887777800000000000000000000000000000000000000000
0007700090000009090000909090090914414410144444401441441600000000887fff80887fff80887fff800000000000000000000000000000000000000000
000770009090090990000009900000090144444014414410014441460000000077f1f160771f1f6077f1f1600000000000000000000000000000000000000000
0070070090000009909009099009900900cccc000144444000ccccc40000000000ffff0000ffff0000ff1f000000000000000000000000000000000000000000
0000000009000090090000900909909000cccc0000cccc0000cccc0000000000fcc771f0fcc771f0fcc771f00000000000000000000000000000000000000000
00000000009999000099990000999900001001000010010000100100000000000440440004404400044044000000000000000000000000000000000000000000
0000000000000000000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000888880000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0066660008888888000cc000000770000ee0ee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600006008888888000cc000007788000eeeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6066660600888880000cc0000887887000eee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600006000088800000cc00078877777000e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0006600000008000000cc00007777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000cc00000666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007040700000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000737300000000ff7f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000003303303300000000ff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000033033330330000007f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000400303333030040000f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000477000333300077400440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000047770bb0330bb077740000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000044700bb33bb0004033300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000004703333333300003330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000070403330330330333307000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00007777033030030030003307700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777000330030030700440000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07700703000300307770407000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07003003077000307704400700070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70033300777770077704070070070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70033330077770077044000070070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70330303004404400040000007070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70303003000004400440000007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
703030000ff000000400000007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000000fff70ff04400000077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07000700f7770ff04070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0700700ff770ff044070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070700f7770ff040770f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000700ff7770f0440770f70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000ff77770f04077770f7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0004ff07770f044077770ff400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00004077770f070777770f4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000777770077077777040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000777774070407777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000447774070407774000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000004440070444440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111111111111111111111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000
11111111111111111111111111111111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000
11111111111111111111111111111111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000
11111111111111111111111111111111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000
1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c0000000000000000000000000000000000000000000000000000000000000000
c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c10000000000000000000000000000000000000000000000000000000000000000
1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c0000000000000000000000000000000000000000000000000000000000000000
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000000000000000000000000000000000000000000000000000000000000
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000000000000000000000000000000000000000000000000000000000000
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000000000000000000000000000000000000000000000000000000000000
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000000000000000000000000000000000000000000000000000000000000
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000000000000000000000000000000000000000000000000000000000000
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000000000000000000000000000000000000000000000000000000000000000
c4ccc4ccccccccccccccc44cccccccc4c4ccc4ccccccccccccccc44cccccccc40000000000000000000000000000000000000000000000000000000000000000
bbbbb44bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44bbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b0000000000000000000000000000000000000000000000000000000000000000
b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b30000000000000000000000000000000000000000000000000000000000000000
33333333333333333333333333333333333333333333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
33333333333333333333333333333333333333333333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
33333333333333333333333333333333333333333333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
33333333333333333333333333333333333333333333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
33333333333333333333333333333333333333333333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
33333333333333333333333333333333333333333333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
__map__
8081828384858687000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9091929394959697000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a0a1a2a3a4a5a6a7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b1b2b3b4b5b6b7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c0c1c2c3c4c5c6c7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d1d2d3d4d5d6d7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e0e1e2e3e4e5e6e7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f0f1f2f3f4f5f6f7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100002d5502a55000500285502655023550005002155000500005001a550125500555000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
00010000005000d650195000965008650135001050005650036500650000650005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
001000000035000000003500000000350000000035000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 02424344

