pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--data
ages = {
--reference for what is required
--reference to which to evolve to
--reference to which to evolve to if it doesn't meet requirements
--organized by age right now
--make objects in the object to reference multiple evolutions in an age

{sprite=32, evolve=300, nextevo=1, maxmistakes=5},
{sprite=1, evolve=1500},
{sprite=6, evolve=2500},
{sprite=10,evolve=30000},
}

selected = 0
currentpoop=19
eatingtimer = 120
trainingtimer = 120
trainingcounter = 0
evolvetimer = 120
col=15
cleany=0
attackx=0

icons = {
"status","eat","train","poop","lights","medic","cry"
}

boy = {
x=28,
y=30,
iseating=no,
issleeping=no,
sprite=32,
isleft=false,
age=1,
strengthmax=4,
strength=0,
hungermax=4,
hunger=0,
issick=false,
mistakes=0,
poopcountdown=200,
poops=0,
currentsprite=32,
calling=false,
evolve=300,
totalstrength=0,
}


function checkevolve()
	if t >= boy.evolve then
		boy.currentsprite=boy.sprite
		_drw=drawevolve
		music(0)
		_upd=updateevolve
	end
end

function checkalive()
	if boy.mistakes > 4 then
		_drw = drawdeath
		_upd = updates[#updates]
	end
end


-->8
--updates
function updatebaby()
	checkinput()
	boy.poopcountdown-=1
	if t%30 == 0 then
		coin = rnd()
		if coin <= .5 then
			if coin > .25 then
				if boy.x <= 50 then
					boy.x += 4
				end
				boy.currentsprite = boy.sprite+2
				boy.isleft = false
			else
				if boy.x >= 9 then
					boy.x -= 4
				end
				boy.currentsprite = boy.sprite+2
				boy.isleft = true
			end
		else
			if boy.currentsprite != boy.sprite then
				boy.currentsprite = boy.sprite
			else
				boy.currentsprite = boy.sprite+1
			end
		end
	end
	checkevolve()
	checkpoop()
	checkcalling()
	checkalive()
	degrade()
end

function updateegg()
	checkevolve()
	if t%30 == 0 then
		if boy.currentsprite == 32 then
			boy.currentsprite = 33
		else
			boy.currentsprite = 32
		end
	end
end

function death()
	boy.x=28
	boy.y=30
	boy.currentsprite=5
end

function eating()
	boy.x=28
	eatingtimer -= 1
	if eatingtimer%30==0 then
		if boy.currentsprite==boy.sprite+2 then
			boy.currentsprite=boy.sprite+3
		else
		 boy.currentsprite=boy.sprite+2
		 sfx(6)
		end
	end
	
	if eatingtimer == 0 then
		eatingtimer = 120
		boy.iseating=false
		if boy.hunger < boy.hungermax then
			boy.hunger += 1
		end
		if boy.poops >0 then
			boy.issick = true
			boy.mistakes+=1
		end
		_upd=updatebaby
	end
end

function updatestatus()
	checkevolve()
	degrade()
	boy.poopcountdown-=1
	checkpoop()
	if btnp(❎) or btnp(🅾️) then
		sfx(0)
		_drw=normaldraw
		_upd=updatebaby
	end
end

function updatetrain()
	trainingtimer-=1
	if trainingtimer > 0 then
		if btnp(❎) or btnp(🅾️) then
			trainingcounter+=1
		end
	else
		if trainingcounter==13 then
			boy.totalstrength+= boy.strengthmax - boy.strength
			boy.strength = boy.strengthmax
		elseif trainingcounter>=5 then
			boy.strength+=1
			boy.totalstrength+=1
		end
		trainingtimer=120
		trainingcounter=0
		--boy.x=32
		attackx=boy.x-8
		boy.currentsprite=boy.sprite+3
		_drw=drawattack
		_upd=updateattack
	end
end

function updateevolve()
	evolvetimer-=1
	--update requirements
	if evolvetimer <=0 then
		evolvetimer=120
		boy.age+=1
		boy.evolve=ages[boy.age].evolve
		boy.sprite=ages[boy.age].sprite
		boy.currentsprite=boy.sprite
		_drw=normaldraw
		_upd=updatebaby
	end
end

function updateclean()
	cleany+=1
	
	if cleany >= 72 then
		boy.poops=0
		_drw=normaldraw
		_upd=updatebaby
	end
end

function updateattack()
	attackx-=1
	if attackx <= 13 then
		boy.x=28
		_drw=normaldraw
		_upd=updatebaby
	end
end

updates = {updateegg,updatebaby,death}
-->8
--draw
function normaldraw()
	drawpoops()
 drawboy()
 drawfood()
 --print(t,0,9,0)
 --print(boy.issick,0,15,0)
	--print(boy.poopcountdown,0,21,0)
	--print(boy.mistakes,0,27,0)
end

function drawboy()
	palt(7,true)
	palt(0,false)
	spr(boy.currentsprite,boy.x,boy.y,1,1,boy.isleft)
	if boy.issick then
		spr(202,boy.x+9,boy.y-9,1,1)
	end
end

function drawpoops()
	palt(7,true)
	palt(0,false)
	if t%30==0 then
		if currentpoop != 19 then
			currentpoop = 19
		else
			currentpoop = 20
		end
	end
	if boy.poops > 0 then
		for i = 0, boy.poops - 1 do
			if i < 2 then
				spr(currentpoop,40,30-(i * 9),1,1)
			else
				spr(currentpoop,49,30-((i-2) * 9),1,1)
			end		
		end
	end
end

function drawicons()
	palt(7,true)
	palt(0,false)
	for i = 1, #icons do
		if selected == i then
			pal(6,0)
		elseif boy.calling and i==#icons then
			pal(6,0)
		else
			pal()
		end
		palt(7,true)
		palt(0,false)
		if i <= 6 then
			spr(192 + i-1,(i-1) * 11,0,1,1)
		else
			spr(192 + i-1,(i-7) * 11,56,1,1)
		end
	 pal()
	end
end

function drawfood()
	if boy.iseating then
		if eatingtimer >= 90 then
			spr(16,boy.x+8,boy.y,1,1)
		elseif eatingtimer >= 60 then
			spr(17,boy.x+8,boy.y,1,1)
		elseif eatingtimer >= 30 then
			spr(18,boy.x+8,boy.y,1,1)
		end
	end
end

function drawstatus()
	print("hunger",20,10,0)
	for i=0,3 do
		pal()
		palt(7,true)
		palt(0,false)
		if boy.hunger > i then
			pal(6,8)
			spr(199,(32-16)+i*8,18)
		else
			spr(199,(32-16)+i*8,18)
		end
	end
	
	print("strength",16,30,0)
	for i=0,3 do
		pal()
		palt(7,true)
		palt(0,false)
		if boy.strength > i then
			pal(6,8)
			spr(199,(32-16)+i*8,36)
		else
			spr(199,(32-16)+i*8,36)
		end
	end
end

function drawtrain()
	drawboy()
	palt(7,true)
	palt(0,false)
	for i=0, trainingcounter do
		if i%2==0 and i>0 then
			spr(200, boy.x-9,boy.y-i+2,1,1)
		end
	end
	for i=0,2 do
		spr(201, 5, boy.y-(i*8),1,1)
	end
end

function drawevolve()
	boy.currentsprite=boy.sprite
	drawboy()
	if t%10==0 then
		if boy.x==30 then
			boy.x=28
		else
			boy.x=30
		end
	end
end

function drawdeath()
	drawboy()
	drawpoops()
	print("rip in pepperoni",0,15,5)
	print("your boy was "..boy.age-1,5,boy.y+13,5)
end

function drawclean()
	palt(7,true)
	palt(0,false)
	if cleany < 25 then
		drawpoops()
	end
	spr(204,40,cleany,1,1)
	if boy.poops>2 then
		spr(204,49,cleany,1,1)
	end
	drawboy()
end

function drawattack()
	palt(7,true)
	palt(0,false)
	drawboy()
	for i=0,2 do
		spr(201, 5, boy.y-(i*8),1,1)
	end
	spr(15,attackx,boy.y,1,1)
	spr(15,attackx,boy.y-8,1,1)
end
-->8
--inputs
function checkinput()
	if btnp(➡️) then
		sfx(0)
		if selected < #icons-1 then
			selected += 1
		else
			selected = 1
		end
		
	elseif btnp(⬅️) then
		sfx(0)
		if selected>1 then
			selected -= 1
		else
			selected = #icons -1
		end
		
	end
	
	if btnp(⬆️) then
		if col < 15 then
			col+=1
			if col==6 then
			 col+=1
			end
		else
			col = 1
		end
	end
	
	if btnp(⬇️) then
		if col > 1 then
			col-=1
			if col==6 then
			 col-=1
			end
		else
			col = 15
		end
	end
	
	if selected > 0 then
		if btnp(❎) then
			sfx(0)
			selected = 0
		end
	end
	
	if btnp(🅾️) and selected > 0 then
		if selected == 1 then
			sfx(0)
			_drw=drawstatus
			_upd=updatestatus
		end
		
		if selected == 3 then
			
			if boy.strength < boy.strengthmax then
				sfx(0)
				boy.x=50
				boy.isleft=true
				boy.currentsprite=boy.sprite+2
				_drw=drawtrain
				_upd=updatetrain
			else
				sfx(2)
			end
		end
		
		if selected == 4 then
			if boy.poops > 0 then
				sfx(1)
				_drw=drawclean
				_upd=updateclean
			else
				sfx(2)
			end
		end
		
		if selected == 6 then
			if boy.issick then
				sfx(1)
				boy.issick = false
			else
				sfx(2)
			end
		end
		
		if selected == 2 then
			if not boy.issick then
				sfx(0)
				boy.currentsprite=boy.sprite+2
				boy.isleft=false
				boy.iseating=true
				_upd=eating
			else
				sfx(2)
			end
			
		end
	end
	
end
-->8
--features
function checkpoop()
	if boy.poopcountdown == 0 then
		boy.poopcountdown= 500 + flr(rnd(500))
		if boy.poops < 4 then
			boy.poops += 1
		else
			boy.issick = true
			boy.mistakes += 1
		end
	end
end

function checkcalling()
	if boy.hunger==0 or boy.strength==0 then
		if boy.calling==false then
			music(1)
		end
		boy.calling = true
	else
		boy.calling = false
	end
end

function degrade()
	if t%1000==0 then
		if boy.hunger > 0 then
			boy.hunger-=1
		else
			boy.mistakes+=1
		end
		
		if boy.strength > 0 then
			boy.strength-=1
		else
			boy.mistakes+=1
		end
	end 
end
-->8

-->8

-->8
--globals
function _init()
	--make 64x64
	poke(0x5f2c,3)
	cls()
	_upd = updateegg
	_drw = normaldraw
	t=0
end

function _update()
	t+=1
	_upd()
end

function _draw()
	-- clear screen
	pal()
 rectfill(0,0,64,64,col)
 rectfill(0,9,64,54,15)
 drawicons()
 _drw()
end

__gfx__
00000000777777777777777777777777777777777700007777000077777777777700007777000007700000777777777770000077700000070000000077000077
00000000777777777777777777777777770000777066660770cccc077700007770cccc0770ccccc0099999077000007709999907099999900000000070677707
0070070077777777770000777777777770009007066666600cccccc070cccc070cccccc00cccccc0099099900999990709909990099099070000000007677770
00077000770000777090090777000077700000070600606000cccc000cccccc00c0cccc00ccccc07099999900990999009999990099990770066660007777770
0007700070900907700000077000900770000997066666600cccccc000cccc000cccc0000c0cc077099900070999999009990007099900070000060007677770
0070070070000007709999077000000770000997060600600cc00cc00cc00cc00cccccc00ccccc07709990770999000770999077709990000000600070777707
0000000070999907700000077000099770000997066666600cccccc00cccccc070cccc0770ccccc0099099070990990709909907099099070006000077000077
00000000770000777700007777000077770000770000000070000007700000077700007777000007000000070000000700000007000000070066660077777777
77777777777777777777777777707777777777077700077700000000000000000000000000000000000000000000000000000000000000000000000000000000
77774767777777677777776777777777777777777099907700000000000000000000000000000000000000000000000000000000000000000000000000000000
77744477777744777777767777777077777077777099990700000000000000000000000000000000000000000000000000000000000000000000000000000000
77444447777444777777677777770777777707777099999000000000000000000000000000000000000000000000000000000000000000000000000000000000
74444477774447777776777777700077777000777099990700000000000000000000000000000000000000000000000000000000000000000000000000000000
77444777774477777767777777007007770007077099907700000000000000000000000000000000000000000000000000000000000000000000000000000000
76747777767777777677777770000070700700007700077700000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777777777770000000700000007777777700000000000000000000000000000000000000000000000000000000000000000000000000000000
77700777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77077077777007770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70777707770770770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07770770707777070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07770770077707700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07777770077707700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70777707077777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77000077700000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
77777777777777776777777777767777776666777767767777666677777777777777777700000000677777767777777707777770000000000000000000000000
77777777777767676677767777777777767777677666676776666667770070077777777777077777766666677777777700777700000000000000000000000000
77666677777666776676767777777677677777766666777677667666706606607777777777077777766666677777777770077007000000000000000000000000
76777767776666676677667777776777677777767667776777766666706666607777777777077777760660677777777707000070000000000000000000000000
67677776766666776677767777766677767677677677766777776666706666607777777700000000766666677777777700700700000000000000000000000000
76767767776667776677767777666667767677676777666677666666770666077777777777777707676006767000777770077007000000000000000000000000
77676677767677776677676776676666776666777676666776666667777060777000000777777707776666770777007777000077000000000000000000000000
77766777777777777777676776666676777667777767767777666677777707770000000077777707777777777700770777700777000000000000000000000000
__sfx__
000300003b1503b1503e1003c10000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
000300000f6500f65010650116501465016650196501d65022650286502e650346503e6501b600196001760014600116000f6000c600006000060000600006000060000600006000060000600006000060000600
000300000315003150000000000000000031500315003150031500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000180521c0522305224052180521c0522305224052180521c0522305224052180521c0522305224052180521c0522305224052180521c0522305224052180521c0522305224052180521c0522305224052
001000000c3550c3550c355000000c3550c355000000c355000000c35500000000000c3550c3550c355000000c3550c3550c355000000c3550c355000000c355000000c35500000000000c3550c3550c35500000
000300003462034620396303e640346302c6202261000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600
001000002015520155201552015500100001000010000000201552015520155201550000000000000000000020155201552015520155000000000000000000002015520155201552015500000000000000000000
__music__
04 04054344
04 07424344
