pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--config
n_players=2
start_pos={8,40,72,104}
colors={8,11,12,10}
alt_colors={2,3,1,9}

--core functions
function _init()
 cls()
 games= {
  "game1",
  "game2"
 }
 init_functions={
  init_one,
  init_two
 }
 update_functions={
  update_one,
  update_two
 }
 draw_functions={
  draw_one,
  draw_two
 }
 init_menu()
 init_one()
end

function _update()
 if menu then
  update_menu()
 elseif complete then
  init_menu()
 else
  for p in all(players)do
   update_functions[select_game](p)
  end
 end
end

function _draw()
 cls()
 for p in all(players)do
  draw_one(p)
 end
end

function init_one()
 cls()
 create_players(n_players)
end

function update_one(p)
 --vertical movement
 if btn(2,p.num-1)then
  p.pos[2]-=1
 elseif btn(3,p.num-1)then
  p.pos[2]+=1
 end
end

function draw_one(p)
 --local variables
 local x=p.pos[1]
 local y=p.pos[2]
 local color=colors[p.num]
 local alt_color=alt_colors[p.num]
 
 rectfill(x-5,y-15,x+5,y+15,0)
 circfill(x,y,5,color)
 print(p.num,x-1,y-12,alt_color)
end

function create_players(n)
 players={}
 for i=1,n do
  p={}
  p.num=i
  p.pos={start_pos[i],64}
  add(players,p)
 end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
