pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
	t=0
	cooldowns = {1,3,5,1,2}
	on_cooldown ={false, false, false, false, false}
	act_times = {nil,nil,nil,nil,nil}
end

function _draw()
	cls()
	print(char.sel)
	foreach(on_cooldown, function(cool) print(cool)end)
	print(t)
	draw_char()
	draw_hotbar()
	draw_refresh()
	draw_sel()
end

function draw_refresh()
	for i=1, 5 do
		if on_cooldown[i] then
			if i <3 then
				sspr(8+(i-1)*8,0,8,(((time()-act_times[i])/cooldowns[i]))*8,37+9*(i-1),100)
			elseif i > 3 then
				sspr(8+(i-2)*8,0,8,(((time()-act_times[i])/cooldowns[i]))*8,(72 + (i - 4)*9),100)
			else
				sspr(40,0,16,(((time()-act_times[i])/cooldowns[i]))*16,55,96)
			end
		end
	end
end

function draw_char()
	-- local x
	-- if t%70 == 0 or t%90==0 then
	-- 	x = 76
	-- else
	-- 	x = 60
	-- end
	-- sspr(x,0,8,16,char.x,char.y,8,16,char.facing_right)
	sspr(112,0,15,16,char.x,char.y,15,16,char.facing_right)
end

function draw_hotbar()
	for i = 1, 5 do
		if not on_cooldown[i] then
			if i < 3 then
				x = 37 + 9*(i-1)
				y = 100
				spr(i,x,y)
			elseif i == 3 then
				sspr(40,0,16,16,55,96)
			elseif i > 3 then
				spr(i-1,(72 + (i - 4)*9),100)
			end
		end
		
	end
end

function _update()
	t+=1
	getbut()
	update_cooldown()
end

function getbut()
	local speed = char.spd
	if not btn(🅾️) then
		if btn(⬅️) then
			char.facing_right = true
			char.x -= speed
		elseif btn(➡️) then
			char.facing_right = false
			char.x += speed
		end
	
		if btn(⬆️) then
			char.y -= speed
		elseif btn(⬇️) then
			char.y += speed
		end
	end
	
	
	if btn(🅾️) then
		if btnp(➡️) then
			if char.sel < 5 then
				char.sel += 1
			else
				char.sel = 1
			end
		elseif btnp(⬅️) then
			if char.sel > 1 then
				char.sel -=1
			else
				char.sel = 5
			end
		end
	end
	
	if btnp(❎) then
		if on_cooldown[char.sel] == false then
			on_cooldown[char.sel] = true
			act_times[char.sel]=time()
		end
	end
end

function draw_sel()
	local sprite
	local x
	local y
	
	if char.sel < 3 then
		x = 37 + 9*(char.sel-1)
		y = 100
		spr(11,x,y)
	elseif char.sel == 3 then
		sspr(96,0,16,16,55,96)
	elseif char.sel > 3 then
		spr(11,(72 + (char.sel - 4)*9),100)
	end

end

function update_cooldown()
	for i=1, 5 do
		if on_cooldown[i] then
			if time() - act_times[i] >= cooldowns[i] then
				on_cooldown[i] = false
				act_times[i] = nil
				sfx(0)
			end
		end
	end
end
char = {
x=24,
y=90,
sel=1,
spd = 1.3,
facing_right= true
}
__gfx__
000000000066660000666600006666000066660000000666666000000000077777770000000007777777000000aaaa0000000aaaaaa0000000000bbbbbb00000
00000000069999600644446006e3e36006dddd600006677777766000000077777777700000007777777770000a0000a0000aa000000aa0000000bbbbbbbb0000
0070070069999c9664cccc4663eee3366dd99dd6006771111117760000007771771770000000777777777000a000000a00a0000000000a0000f0b444444b0f00
0007700069c9c99664cccc46633e33366d9dd9d6067717777771776000007771771770000000777117117000a000000a0a000000000000a000f0444444440f00
00077000699c999664cccc466333e3e66d9dd9d6067177111177176000007771771770000000777777777000a000000a0a000000000000a000ff4fbffbf4ff00
0070070069c9c996644cc4466333eee66dd99dd6671771777717717600000777777700000000077777770000a000000aa00000000000000a00ff4f4ff4f4ff00
00000000069999600644446006333e6006dddd606717177117717176000000d777d00000000000d777d000000a0000a0a00000000000000a000ffffffffff400
000000000066660000666600006666000066660067171717717171760000066777660000000006677766000000aaaa00a00000000000000a000bbff44ffbb400
00aaaaa00000000000000000000000000000000067171717717171760000070ddd0700000000070ddd07000000000000a00000000000000a044444ffffbb4440
0aaaaaaa0000000000000000000000000000000067171771177171760000070666070000000007066607000000000000a00000000000000a4434444bbbbbf440
0aaaaaaa0000000000000000000000000000000067177177771771760000070666070000000007066607000000000000a00000000000000a433344344bbfff40
0aafaafa00000000000000000000000000000000067177111177176000000706660700000000070666070000000000000a000000000000a04434443b4444fff0
0afcffc000000000000000000000000000000000067717777771776000000007070000000000000707000000000000000a000000000000a0443444344bbbbf00
00fffff0000000000000000000000000000000000067711111177600000000070700000000000007070000000000000000a0000000000a004444443bbbbb0000
008888000000000000000000000000000000000000066777777660000000000707000000000000070700000000000000000aa000000aa0000333334004440000
00100100000000000000000000000000000000000000066666600000000000070700000000000007070000000000000000000aaaaaa000000000444000000000
__sfx__
000200001155000500005000050000500005003155000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
