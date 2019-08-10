pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
function _init()
	--music(0,0,0)
	music(2,0,0)
	player.character=1
	_upd=update_game
	--_drw=draw_game
	_drw=draw_title
	dirx={-1,1,0,0}
	diry={0,0,-1,1}
	t=0
	startgame()
end

function _update()
	t+=1
	_upd()
end

function _draw()
	_drw()
end

function startgame()
	player.x=3
	player.y=10
end

player = {
	x=12,
	y=2,
	ox=0,
	oy=0,
	character=1,
	isleft=false,
	life={10,10,10,10},
	strength={1,2,1,5},
	range={0,1,0,1},
	level=1,
	colors={8,3,9,14},
	xp=0,
	mana=5
}
-->8
--update
function update_game()
	for i=0,3 do
		if btnp(i) then
			moveplayer(dirx[i+1],diry[i+1])
			
		 _upd=update_playerturn
		end
	end
	
	if btnp(❎)and player.character<4 then
		player.character+=1
		else if btnp(❎) then
			player.character=1
		end
	end
	if btnp(🅾️) and player.character>1 then
		player.character-=1
		else if btnp(🅾️) then
			player.character=4
		end
	end
end

function update_playerturn()
	
	if player.ox>0 then
		player.ox-=2
	end
	if player.ox<0 then
		player.ox+=2
	end
	if player.oy>0 then
	 player.oy-=2
	end
	if player.oy<0 then
		player.oy+=2
	end
	if player.ox==0 and player.oy==0 then
		_upd=update_game
	end
end

function update_gameover()

end
-->8
--draw

function draw_game()
	cls()
	map()
	spr(player.character+(flr(t/6)%2*16),player.x*8+player.ox,player.y*8+player.oy,1,1,player.isleft)
	rectfill(0,0,128,5,0)
	rectfill( 26*(player.character-1)-1,0,26*(player.character-1)+19,5,player.colors[player.character])
	print("du:"..player.life[1],0,0,7)
	print("lu:"..player.life[2],26,0)
	print("mi:"..player.life[3],26*2,0)
	print("el:"..player.life[4],26*3,0)
	print("mana:"..player.mana,26*4,0,12)
end

function draw_title()
	cls()
	local x,y = 30,50
	for i=0,9 do
		spr(192+i,x+i*8,y+0)
		spr(208+i,x+i*8,y+8)
		spr(224+i,x+i*8,y+16)
		spr(240+i,x+i*8,y+24)
	end
	print("press ❎/🅾️ to start",x,y+32)
end
function draw_gameover()

end
-->8
--tools
function getframe(_ani,_num)
	return ani[flr(t/6)%num*16]
end

function drawspr(_spr,_x,_y,_c)
	palt(0,false)
	pal(6,_c)
	spr(_spr,_x*8,_y*8)
	pal()
end

function moveplayer(dx,dy)
	if player.life[player.character]>0 then
	
	local tile=mget(player.x+dx,player.y+dy)
	if dx>0 then
		player.isleft=false
	elseif dx<0 then
		player.isleft=true
	end
	if fget(tile,0) then
		player.ox=dx*4
		player.oy=dy*4
	else
		player.x+=dx
	 player.y+=dy
	 player.ox+=-dx*8
	 player.oy+=-dy*8
	end
	
	if fget(tile,1) then
		triggerbump(tile,player.x+dx,player.y+dy)
	end
	end
end

function triggerbump(tile,destx,desty)
		if tile==74 or tile==75 then
			--vases
			mset(destx,desty,65)
		elseif tile==69 then
			--doors
			mset(destx,desty,65)
		elseif tile==70 or tile==71 then
			--chests
			mset(destx,desty,tile+2)
		end
end
-->8


__gfx__
00000000008777700001110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008777700011111000111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700008888880011111001111111044444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000044ffff00033333001fffff104fffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700004fcffc00141441001f1ff1004f1ff100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000fffff00044444001fffff004fffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000033330000cccc000099990000eeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007007000070070000700700007007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008777700001110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008777700011111000111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008888880011111001111111044444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000044ffff00033333001fffff104fffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000004fcffc00141441001f1ff1004f1ff100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000fffff00044444001fffff004fffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007007000070070000700700007007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
60666060000000009999999010000000000000019099909000999000000000000000000000000000009990000099900000999000660000066000006600000000
0000000000000000000000001011000000001101000000009099909009999990ddddddd00dddddd0090009000900090009000900686000666600068600000000
6660666000000000990000001011011001101101909990909000009009000090d00000d00d0000d0090009000900090099000990688600688600688600000000
0000000000000000990990000011011001101100009990009009009009099090d00000d00d0000d0909990900099900090999090687860687606878600000000
6066606000000000990990901000011001100001909990909990999009999990ddddddd00dddddd0990099900900990090090090068886878868886000000000
00000000001000009909909010110000000011010099900000000000000000000000000000000000099999000999990090000090068786888868786000000000
6660666000000000990990901011011001101101909990909999999009999990ddddddd00dddddd0009990000099900009999900006887878788860000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006888111178860000000000
1dd22120000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000687111188600000000000
11d12120000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000068111176000000000000
dd1dd220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000687111188600000000000
d11222d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006888787878860000000000
d2221dd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000068786666668786000000000
d2d121d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000688660666606688600000000
12dd2d10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066000666600066000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600600000000000000
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
88888888888888888888888888888888888888888888888888888888888888888888888888000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08888888088888888088888880008888800888800888008888880088888888088888888800000000000000000000000000000000000000000000000000000000
88000088088088088008800088000888000088800080088000880008800088008880008880000000000000000000000000000000000000000000000000000000
88000008080088008008800088000888000088880080880000080008800808008880008880000000000000000000000000000000000000000000000000000000
88800000000088000008800880008008800080888080880000000008888800008880008880000000000000000000000000000000000000000000000000000000
88888000000088000008888800008008800080088880880008888008800800008880088800000000000000000000000000000000000000000000000000000000
08888880000088000008808880008888800080008880880000880008800000008888888000000000000000000000000000000000000000000000000000000000
00088888000088000008800880080008880080000880880000880008800008008880888000000000000000000000000000000000000000000000000000000000
00000888800088000008800888080000880080000080088000880008800008008880088800000000000000000000000000000000000000000000000000000000
00000088800088000008800088080000880080000080008800880008800088008880088800000000000000000000000000000000000000000000000000000000
80000088800888800088880088888008888888000888000888888088888888008880008880000000000000000000000000000000000000000000000000000000
88000888000000000000000000000000000000000000000000000000000000008880008880000000000000000000000000000000000000000000000000000000
88888880000000000000000000000000000000000000000000000000000000088888088888000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000888888880888808888088880888800888008888880008888800000000000000000000000000000000000000000000000000000000000000000000
88888888880880880880088000880008800088800080088000880088008800088888888888000000000000000000000000000000000000000000000000000000
00000000000800880080088000880008800088880080880000080088000800000000000000000000000000000000000000000000000000000000000000000000
00000000000000880000088888880008800080888080880000000088880000000000000000000000000000000000000000000000000000000000000000000000
00000000000000880000088000880008800080088880880008888008888800000000000000000000000000000000000000000000000000000000000000000000
00000000000000880000088000880008800080008880880000880000088880000000000000000000000000000000000000000000000000000000000000000000
00000000000000880000088000880008800080000880880000880000008880000000000000000000000000000000000000000000000000000000000000000000
00000000000000880000088000880008800080000080088000880080000880000000000000000000000000000000000000000000000000000000000000000000
00000000000000880000088000880008800080000080008800880088000880000000000000000000000000000000000000000000000000000000000000000000
00000000000008888000888808888088880880000888000888888088888800000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000303030101030303030300010000000000000000000000000303000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
5050505050505050505050505050505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050505050505050505050505050505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5041414141415050505041414150505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5041504141414141414541414150505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5041504141415050505050414150505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
50415042414a505050505041414d4e5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5041505050505050504a4b41415d5e5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5041505047414141414b41414141415000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5041505047414141414141414141415000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5041505050505050505050505050415000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5041504341415050505050505050415000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5041504141415050505050505050415000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5046504141414541414141414145415000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050505050505050505050505050505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050505050505050505050505050505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050505050505050505050505050505000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001600080c14010140131401714018140171401314010140001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
001600000024000241002410024100241002410024100241002410024100241002410024100241002410024100241002410024100241002410024100241002410024100231002210021102240022410224102231
00160000042400424104241042410424104241042410424104241042410424104241042410424104241042410424104241042410424104241042410424104241042410423104221042110b2400b2410b2410b231
001600080057300573006000060000573005730060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600
001e000007050070510705107051070510705107051070510a0500a0510a0510a0510a0510a0510a0510a05103050030510305103051030510305103051030510505005051050510505105051050510505105051
001e00081f1501f12122150221211d1501d1212215022121001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
001e00101f1501f1411f1311f121221502214122131221211d1501d1411d1311d1212215022141221312212100000000000000000000000000000000000000000000000000000000000000000000000000000000
001e002000400004000040000400004001f440224401f440264402040024440004002244000400244402244000400004000040000400004001f440224401f440264400040024440004002244000400244401f440
001e00101313013121131111311116130161211611116111111301112111111111111613016121161111611100000000000000000000000000000000000000000000000000000000000000000000000000000000
001e00080050000500075730000000500005000757300500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
__music__
01 01020444
02 01030444
00 05064a44
00 05070a44
03 0509080a

