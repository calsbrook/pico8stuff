pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
player = {
	x = 64,
	y = 64,
	sprite = 2,
	speed = 3,
	level = 1,
	maxbullets = 400,
	shot_speed = 3,
	shot_timer = 10,
}
playerbullets = {}

function _init()
	cls()
end

function _draw()
	cls()
	print(player.level)
	print(#playerbullets)
	drawship()
	drawplayerbullets()
end

function drawship()
	spr(player.sprite, player.x, player.y)
end

function drawplayerbullets()
	for i=1,#playerbullets do
		line(playerbullets[i][1],playerbullets[i][2],playerbullets[i][1],playerbullets[i][2]+1,8)
	end
end
function _update()
	updateplayerbullets()
	getshooting()
	moveship()
end

function getshooting()
	player.shot_timer += 1
	if btn(❎) then
		player.speed = 1
	else
		player.speed = 2
	end
	
	if btn(🅾️) then
		if #playerbullets < player.maxbullets then
			if player.shot_timer >= player.shot_speed then
				player.shot_timer = 0
				fire()
			end
		end
	end
end

function updateplayerbullets()
    todelete = {}
	for i=1,#playerbullets do
		playerbullets[i][2]-=4
		playerbullets[i][1] += playerbullets[i][3]
		if playerbullets[i][2] <= 0 then
            add(todelete, playerbullets[i])
		end
	end
    for bullet in all(todelete) do
        del(playerbullets, bullet)
    end
end

function fire()
	sfx(0)
	playerbullets[#playerbullets+1]={player.x+4,player.y-2-rnd(1),0}
	playerbullets[#playerbullets+1]={player.x+4,player.y-2-rnd(1),-.5}
	playerbullets[#playerbullets+1]={player.x+4,player.y-2-rnd(1),.5}
	playerbullets[#playerbullets+1]={player.x+4,player.y-2-rnd(1),-1}
	playerbullets[#playerbullets+1]={player.x+4,player.y-2-rnd(1),1}
end

function moveship()
	if btn(⬅️) then
		player.sprite = 1
		if player.x >= 2 then
			player.x -= player.speed
		end
	elseif btn(➡️) then
		player.sprite = 3
		if player.x <= 118 then
			player.x += player.speed
		end
	else
		player.sprite = 2
	end
	
	if btn(⬆️) then
		if player.y >=2 then
			player.y -= player.speed
		end
	elseif btn(⬇️) then
		if player.y <=118 then
			player.y += player.speed
		end
	end
end
__gfx__
00000000000220000002200000022000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000002882000028820000288200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700002882000028820000288200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000288e2002e88e2002e88200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000027c88202e87c8e202887c20000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700021188202881188202881120000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000025588200285582002885520000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000002992000029920000299200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100001d010230102b0101c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
