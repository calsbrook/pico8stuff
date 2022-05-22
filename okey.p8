pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

tophand = {}
bottomhand = {}
deck = {
	{1,12},{2,12},{3,12},{4,12},{5,12},{6,12},{7,12},{8,12},{9,12},{10,12},{11,12},{12,12},{13,12},
	{1,12},{2,12},{3,12},{4,12},{5,12},{6,12},{7,12},{8,12},{9,12},{10,12},{11,12},{12,12},{13,12},
	{1,8},{2,8},{3,8},{4,8},{5,8},{6,8},{7,8},{8,8},{9,8},{10,8},{11,8},{12,8},{13,8},
	{1,8},{2,8},{3,8},{4,8},{5,8},{6,8},{7,8},{8,8},{9,8},{10,8},{11,8},{12,8},{13,8},
	{1,1},{2,1},{3,1},{4,1},{5,1},{6,1},{7,1},{8,1},{9,1},{10,1},{11,1},{12,1},{13,1},
	{1,1},{2,1},{3,1},{4,1},{5,1},{6,1},{7,1},{8,1},{9,1},{10,1},{11,1},{12,1},{13,1},
	{1,9},{2,9},{3,9},{4,9},{5,9},{6,9},{7,9},{8,9},{9,9},{10,9},{11,9},{12,9},{13,9},
	{1,9},{2,9},{3,9},{4,9},{5,9},{6,9},{7,9},{8,9},{9,9},{10,9},{11,9},{12,9},{13,9},
	{14,0},{14,0}
}


function _draw()
	cls()
	--rectfill(5,29,5+(8*13),74)
	draw_deck()
	-- for i=0,12 do
	-- 	pal()
 	-- 	spr(i+1,5+(i*8),30)
 	-- 	pal(12,8)
 	-- 	spr(i+1,5+(i*8),39)
 	-- 	pal(12,1)
 	-- 	spr(i+1,5+(i*8),48)
 	-- 	pal(12,9)
 	-- 	spr(i+1,5+(i*8),57)
	-- end
	-- for i=0,1 do
	-- 	pal()
	-- 	spr(14,5+(i*8),66)
	-- end
	--spr(15,5+(2*8),66)
	-- draw_rack(5,74)
	-- print(deck[1][2])
end

function _init()
	--make_deck()
end

function draw_rack(x,y)
	rectfill(x,y,x+(8*10),y+16+2,6)
	line(x,y+9,x+(8*10),y+9,5)
end

function draw_deck()
	i = 0
	for tile in all(deck) do
		pal(12,tile[2])
		spr(tile[1], 5+((i%13)*8), 30+((i\13)*8))
		i += 1
		pal()
	end
end
__gfx__
0000000004ffffff04ffffff04ffffff04ffffff04ffffff04ffffff04ffffff04ffffff04ffffff04ffffff04ffffff04ffffff04ffffff04ffffff04ffffff
0000000004fffcff04ffcccf04ffcccf04ffcfcf04ffcccf04ffcfff04ffcccf04ffcccf04ffcccf04fcfccc04ffcfcf04fcfccc04fcfccc04ff111f04ffffff
0070070004fffcff04ffffcf04ffffcf04ffcfcf04ffcfff04ffcfff04ffffcf04ffcfcf04ffcfcf04fcfcfc04ffcfcf04fcfffc04fcfffc04f1616104ffffff
0007700004fffcff04ffcccf04fffccf04ffcccf04ffcccf04ffcccf04ffffcf04ffcccf04ffcccf04fcfcfc04ffcfcf04fcfccc04fcffcc04f1111104ffffff
0007700004fffcff04ffcfff04ffffcf04ffffcf04ffffcf04ffcfcf04ffffcf04ffcfcf04ffffcf04fcfcfc04ffcfcf04fcfcff04fcfffc04f1666104ffffff
0070070004fffcff04ffcccf04ffcccf04ffffcf04ffcccf04ffcccf04ffffcf04ffcccf04ffffcf04fcfccc04ffcfcf04fcfccc04fcfccc04ff111f04ffffff
00000000044fffff044fffff044fffff044fffff044fffff044fffff044fffff044fffff044fffff044fffff044fffff044fffff044fffff044fffff044fffff
00000000004444440044444400444444004444440044444400444444004444440044444400444444004444440044444400444444004444440044444400444444
