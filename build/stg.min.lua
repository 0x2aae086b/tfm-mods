do_addObject=tfm.exec.addShamanObject
do_removeObject=tfm.exec.removeObject;do_addGround=tfm.exec.addPhysicObject
do_removeGround=tfm.exec.removePhysicObject;do_addJoint=tfm.exec.addJoint;do_removeJoint=tfm.exec.removeJoint
do_respawn=tfm.exec.respawnPlayer;do_addExplosion=tfm.exec.explosion
addParticle=tfm.exec.displayParticle;setShaman=tfm.exec.setShaman
setShamanName=tfm.exec.setUIShamanName;setMapName=tfm.exec.setUIMapName
setNameColor=tfm.exec.setNameColor;movePlayer=tfm.exec.movePlayer;moveObject=tfm.exec.moveObject
setMap=tfm.exec.newGame;bindKey=tfm.exec.bindKeyboard;kill=tfm.exec.killPlayer;function nop()end;function alert(a,X)
ui.addPopup(0,0,string.format('<font face="mono" size="15">%s</font>',a),X,200,150,400,true)end;function randomColor()return
math.random(0x000000,0xFFFFFF)end;function rotate(f,d,v,A,K,g)f,d=f-v,d-A;f,d=f*K-d*g,
f*g+d*K;return v+f,A+d end
function length1(G)return math.sqrt(
G.x*G.x+G.y*G.y)end
function cache2(r)local M={}return
function(i,Z)local w=M[i]local n=nil;if w==nil then w={}M[i]=w else n=w[Z]end;if n==nil then
n=r(i,Z)w[Z]=n end;return n end end;function split(v)local i={}for j in string.gmatch(v,'[^%s]+')do i[#i+1]=j end
return i end
function parsePlayerNames(I,u,Q)local D={}local Id
for O,C in
pairs(split(string.lower(u)))do
if string.sub(C,1,1)=='!'then C=string.sub(C,2)Id=nil else Id=true end
if C=='me'then D[I]=Id elseif C=='all'then for O,C in pairs(playerData)do D[O]=Id end else
C=string.gsub(C,'^%l',string.upper)if playerData[C]==nil then
alert('Invalid player: '..C,I)return else D[C]=Id end end end;for U,Y in pairs(D)do Q(U)end end;unescape_map={a='\a',b='\b',f='\f',n='\n',r='\r',t='\t'}
function do_unescape(_,S)local w=tonumber(
_..S)if w==nil then
return(unescape_map[_]or _)..S else return string.char(w)end end
function unescape(a)return string.gsub(a,'\\(.)(%d?%d?)',do_unescape)end;function do_unpack(u,H,i)
if H<=i then return u[H],do_unpack(u,H+1,i)else return nil end end;function unpack(w,q)if q==nil then q=#w end;return
do_unpack(w,1,q)end;function length(m)local H=0
for g in pairs(m)do H=H+1 end;return H end;function copy(w,g)if g~=nil then
for C,c in pairs(g)do w[C]=c end end end;function append(H,L)for d,vR in ipairs(L)do H[#H+
1]=vR end end;function invert(n,w)local T={}
if
w==nil then for A,p in pairs(n)do T[p]=A end else for c,L in pairs(n)do T[L]=w end end;return T end
function keys(R)
local W={}for N,RD in pairs(R)do W[#W+1]=N end;return W end;function keys1(m)local c=keys(m)table.sort(c)return c end
function randomKey1(z,G,e)
local Z,g={},1
for w,p in pairs(z)do if not(w==G)then Z[g]=w;g=g+1 end end
if g>1 then return Z[math.random(1,#Z)]elseif e then return nil else return G end end;function randomValue1(e,E,B)local b=randomKey1(e,E,B)
if b~=nil then return e[b]else return nil end end
function help(b)
ui.addTextArea(100,MODULE_HELP[MODULE_HELP_START],b,258,78,421,284,
nil,nil,nil,true)
ui.addTextArea(101,string.format('<p align="center"><font face="mono" size="15">%s</font></p>',MODULE_HELP_START),b,258,50,398,20,
nil,nil,nil,true)
ui.addTextArea(102,MODULE_HELP_CONTENTS,b,100,50,150,312,nil,nil,nil,true)
ui.addTextArea(103,MODULE_HELP_CLOSE,b,664,50,15,20,nil,nil,nil,true)end
function helpTextAreaCallback(j,H,h)
if h=='help'then help(H)elseif h=='help_close'and j==103 then
ui.removeTextArea(100,H)ui.removeTextArea(101,H)ui.removeTextArea(102,H)
ui.removeTextArea(103,H)else local i=MODULE_HELP[h]
if i~=nil then ui.updateTextArea(100,i,H)
ui.updateTextArea(101,string.format('<font face="mono" size="15"><p align="center">%s</p></font>',h),H)else return false end end;return true end
function eventChatCommand(L,l)local O,B;local x,s;for c,Ll in ipairs({{'&lt;','<'},{'&amp;','&'}})do
l=string.gsub(l,Ll[1],Ll[2])end
while true do
O,B=string.find(l,'%s+')
if O==nil then x=l;s=''break elseif O==1 then l=string.sub(l,B+1)if l==''then x=''s=''break end else x=string.sub(l,1,
O-1)s=string.sub(l,B+1)break end end;local K=string.lower(x)local D=MODULE_CHAT_COMMAND[K]if D~=nil then
D(L,K,s)else MODULE_CHAT_COMMAND_1(L,x,s)end end
function setColor(n,y)setNameColor(n,y)playerData[n].color=y end
function make_line(o,z)local B,v=z[1]-o[1],z[2]-o[2]return
{width=math.sqrt(B*B+v*v),angle=
math.atan2(v,B)*180.0/math.pi,x=(o[1]+z[1])/2,y=(o[2]+z[2])/2}end
make_star=cache2(function(C,sl)local v={}local M={}for i=1,C do a=math.pi*2*i/C
v[#v+1]={math.cos(a),math.sin(a)}end;for i=1,C do
M[#M+1]=make_line(v[i],v[1+ (i+sl-1)%C])end
return{lines=M,points=v,r=length1(M[1])}end)
keycode={backspace=8,enter=13,shift=16,ctrl=17,alt=18,capslock=20,esc=27,space=32,['0']=48,['1']=49,['2']=50,['3']=51,['4']=52,['5']=53,['6']=54,['7']=55,['8']=56,['9']=57,a=65,b=66,c=67,d=68,e=69,f=70,g=71,h=72,i=73,j=74,k=75,l=76,m=77,n=78,o=79,p=80,q=81,r=82,s=83,t=84,u=85,v=86,w=87,x=88,y=89,z=90,[';']=186,['=']=187,[',']=188,['-']=189,['.']=190,['/']=191,['`']=192,[':']=186,['+']=187,['<']=188,['_']=189,['>']=190,['?']=191,['~']=192,['[']=219,['\\']=220,[']']=221,["'"]=222,['{']=219,['|']=220,['}']=221,['"']=222,[')']=48,['!']=49,['@']=50,['#']=51,['$']=52,['%']=53,['^']=54,['&']=55,['*']=56,['(']=57,kp0=96,kp1=97,kp2=98,kp3=99,kp4=100,kp5=101,kp6=102,kp7=103,kp8=104,kp9=105,['kp*']=106,['kp+']=107,['kp-']=109,['kp.']=110,['kp/']=111,left=37,up=38,right=39,down=40,f1=112,f2=113,f3=114,f4=115,f5=116,f6=117,f7=118,f8=119,f9=120,f10=121,f11=122,f12=123}
particles={white=0,purple=1,orange=2,soft_white=4,teal=9,yellow=11,red=13,spawn=3,heart=5,red_heart=30,pink_heart=31,bubble=6,bubble1=7,bubble2=8,water=14,spirit=10,red_spirit=12,plus1=15,plus10=16,plus12=17,plus14=18,plus16=19,meep=20,red_confetti=21,green_confetti=22,blue_confetti=23,yellow_confetti=24,rain=25,wind=26,wind1=27,lightning=28,star=29,flower=32}
objcode={arrow=0,small_box=1,box=2,small_plank=3,plank=4,ball=6,trampoline=7,anvil=10,anvil1=1002,B=11,Bc=12,Bcc=13,V=14,Vc=15,Vcc=16,cannon_up=17,cannon_down=18,cannon_right=19,cannon_left=20,C=22,bomb=23,spirit=24,cheese=25,blue_portal=26,orange_portal=27,balloon=28,red_balloon=29,green_balloon=30,yellow_balloon=31,rune=32,snow=34,arrow1=35,apple=39,sheep=40,demolition=41,totem=44,ice_plank=45,choco_plank=46,cloud=57,architect=58,bubble=59,tiny_plank=60,companion_crate=61,stable_rune=62,ballon_anchor=66,windmill_anchor=88}copy(objcode,tfm.enum.shamanObject)
function getText(S)
local n=S.lives-1;local v=S.bombs;if n>=maxLives then n=maxLives-1 end;if n<0 then n=0 end;if
v>maxBombs then v=maxBombs elseif v<0 then v=0 end
if S.lives<1 then l=0 else l=S.lives end;return
string.format('<TI><N>Player  <R>%s<N>\nBomb  <VP>%s',string.rep('★',n),string.rep('★',v))end;function updateTextAreas(I,x)ui.updateTextArea(1,getText(x),I)
ui.updateTextArea(104,'<TI><a href="event:help">?</a>',I)end
function clear()for i,V in
ipairs(keys(patternData))do removePattern(V)end;for u,G in
ipairs(keys(bulletData))do removeBullet(G)end;for f,J in
ipairs(keys(jointData))do removeJoint(J)end;for B,S in
ipairs(keys(groundData))do removeGround(S)end;for P,G in
ipairs(keys(tfm.get.room.objectList))do removeObject(G)end end
function list_default(r,V,O)r[#r+1]=string.format('%d %d\n',V,O.time)end
function list_object(vY,U,q)local g=tfm.get.room.objectList[U]if g==nil then
vY[#vY+1]=string.format('%d &lt;invalid&gt; %d\n',U,q.time)else
vY[#vY+1]=string.format('%d (%d, %d) %d\n',U,g.x,g.y,q.time)end end;function list_bullet(_,b,l)
_[#_+1]=string.format("%d %d %d\n",b,l.controls[#l.controls],l.time)end
function step(X,h,Z,H)local D={}local t;if H==nil then
H=list_default end
for DO,j in pairs(X)do H(Z,DO,j)t=j.time
if t==0 then if j.on_remove then
j.on_remove(DO,j)end;D[#D+1]=DO elseif t>0 then j.time=t-1;if j.callback then
j.callback(DO,j)end elseif j.callback then j.callback(DO,j)end end;for U,d in ipairs(D)do h(d)end end
function clearT()local O={'<TI>--[Patterns]--\n'}
step(patternData,removePattern,O)O[#O+1]='--[Bullets]--\n'
step(bulletData,removeBullet,O,list_bullet)O[#O+1]='--[Grounds]--\n'step(groundData,removeGround,O)O[
#O+1]='--[Joints]--\n'step(jointData,removeJoint,O)
O[#O+1]='--[Objects]--\n'step(objectData,removeObject,O,list_object)
ui.addTextArea(2,table.concat(O),
nil,-150,0,150,600,nil,nil,nil,true)end;function explode(h,R)local n=R.callback_args
addExplosion(n.x,n.y,n.power,n.distance,n.miceOnly,n.p1,n.p2)end
function explode1(E,w)
local P=w.callback_args
if P.t<=0 then
local D=randomKey1(tfm.get.room.playerList,w.user,true)local d,j=0,0;if D~=nil then local o=tfm.get.room.playerList[D]
d,j=o.x,o.y end
addExplosion(d,j,P.power,P.distance,P.miceOnly,P.p1,P.p2)P.t=P.cd else P.t=P.t-1 end end;function accelerate(m,i)local g=i.callback_args
moveObject(m,0,0,true,g.ax,g.ay,true)end
function moveHoming(T,I)
if
I.time<=7 and I.time>=5 then local w=I.callback_args
local TR=tfm.get.room.playerList[w.target]
if TR~=nil then local A=TR.x;local N=TR.y;local s=w.x;local t=w.y;A=A-s;N=N-t;local g=A*A+N*N;if g>0 then g=w.v/
math.sqrt(g)A=A*g;N=N*g end
moveObject(T,0,0,true,A,N,false)end end end
function newId(E)local O=E.free;local _,A=pairs(O)(O)if _ then O[_]=nil;return _ else E.max=E.max+1
return E.max end end
function freeId(c,U)local _=c.free;if U==c.max then local E=c.max-1;while _[E]do _[E]=nil;E=E-1 end;c.max=E else
_[U]=true end end
function addObject(xR,Q,v,y,P,O,X,vs,Z,r,t)local B=do_addObject(xR,Q,v,y,P,O,X)if vs==nil then vs=3 end
objectData[B]={time=vs,callback=Z,on_remove=r,callback_args=t}return B end
function removeObject(l)do_removeObject(l)objectData[l]=nil end
function addGround(Y,e,g,J,_,t,x)local h=newId(groundId)do_addGround(h,Y,e,g)
if J==nil then J=3 end
groundData[h]={time=J,callback=_,on_remove=t,callback_args=x,joints={}}return h end
function removeGround(i)
for W,h in pairs(groundData[i].joints)do removeJoint(h)end;do_removeGround(i)groundData[i]=nil;freeId(groundId,i)end
function addJoint(a,b,x,am,h,c,_)local p=newId(jointId)do_addJoint(p,a,b,x)
if am==nil then am=-1 end;if x==nil then x={}end
jointData[p]={time=am,callback=h,on_remove=c,callback_args=_}return p end
function removeJoint(q)do_removeJoint(q)jointData[q]=nil;freeId(jointId,q)end
function addPattern(O,s,c,T)local o=nil;if c.time~=nil then o=newId(patternId)
patternData[o]={time=c.time,callback=c.callback,on_remove=c.on_remove}end
c.func(O,s,o,T)return o end
function removePattern(F)patternData[F]=nil;freeId(patternId,F)end
function addExplosion(i,D,k,J,K,DR,iS)if DR~=nil then addParticle(DR,i,D,0,0,0,0)end;if
iS~=nil then end;do_addExplosion(i,D,k,J,K)end
function bomb(o,w)
if w.bomb_cd==0 and not w.bombing then
if w.bombs>=w.bomb.cost then w.bombs=w.bombs-
w.bomb.cost;w.bombing=true;w.bombTime=w.bomb.time
w.bomb.func(o,w)addBomb(o,w)updateTextAreas(o,w)else
alert(string.format('bombs &lt; %d',w.bomb.cost),o)end end end
function addBomb(m,G)local e=bombs.top+1
local j=string.format('<TI><font color="#%X">%s <font color="#5F5F8D">|</font> %s</font>',G.color,m,G.bomb.name)G.bomb_id=e;bombs.top=e;bombs.val[e]=j;setShamanName(j)end
function removeBomb(U,N)local y=N.bomb_id;N.bomb_id=nil;bombs.val[y]=nil
if y==bombs.top then y=y-1;while
bombs.val[y]==nil and y>0 do y=y-1 end;bombs.top=y;if y>0 then
y=bombs.val[y]else y=''end;setShamanName(y)end end
function addBombTimer(n,B,K,a,BQ)local L=K.bombTime*BQ+2
local y={type=13,angle=0,color='0xFF0000',foreground=false,friction=0.0,restitution=2.0,width=L,height=L,miceCollision=false,groundCollision=a,dynamic=false}
addGround(B.x,B.y,y,K.bombTime,moveBombTimer,nil,{player=n,pdata=K,offset=2,scale=BQ,obj=y})L=L-2
y={type=13,angle=0,color='0x6A7495',foreground=false,friction=0.0,restitution=2.0,width=L,height=L,miceCollision=false,groundCollision=a,dynamic=false}
addGround(B.x,B.y,y,K.bombTime,moveBombTimer,nil,{player=n,pdata=K,offset=0,scale=BQ,obj=y})end
function moveBombTimer(a,D)local p=D.callback_args
local M=tfm.get.room.playerList[p.player]local MJ=p.pdata.bombTime*p.scale+p.offset
p.obj.width=MJ;p.obj.height=MJ;do_addGround(a,M.x,M.y,p.obj)end
function defaultBombCallback(k,P)local u=tfm.get.room.playerList[k]
local E=u.y+u.vy;local C;local l,p;local i=P.bombCallbackArgs;local L=4;local Pu=4;local ij=0;local K={ax=64,ay=0}Pu=i*Pu;K.ax=i*
K.ax;C=u.x+i*P.bombTime*5+10
for off=20,120,20 do
p=off*i;l=C+p*1.5
addObject(objcode.anvil,l,E-p,0,Pu,-ij*i,false,L,accelerate,nil,K)
addObject(objcode.anvil,l,E+p,0,Pu,ij*i,false,L,accelerate,nil,K)ij=ij+1 end end
function defaultBomb(h,A)local v=tfm.get.room.playerList[h]
if
not v.isFacingRight then A.bombCallbackArgs=-1 else A.bombCallbackArgs=1 end;addBombTimer(h,v,A,true,5)end
function bomb2(l,o)local F=tfm.get.room.playerList[l]local e,T=F.x,F.y
local Fx=string.format('%d,%d',e,T)
local lT={type=12,color='0xFFFFFF',foreground=true,width=512,height=8,dynamic=true,mass=8,restitution=255,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=true}
local Y={type=13,color='0xFFFFFF',width=32,height=32,dynamic=false,groundCollision=false,miceCollision=false,foreground=false}local Z={type=3,point1=Fx,point2=nil,forceMotor=255,speedMotor=2}
local t={type=3,point1=Fx,point2=Fx,ratio=1,limit1=0,limit2=8}local yp={type=0,frequency=10}local H;local f;local HK,A;local _,Q
local s=32.0+lT.width/2.0;local K=20;local P=nil;local B=nil;local n,v;addBombTimer(l,F,o,true,5)
v=addGround(e,T,Y,K)
for H=0,359,120 do f=H*math.pi/180.0;HK,A=math.cos(f),math.sin(f)_,Q=e+s*
HK,T+s*A;lT.angle=H;n=addGround(_,Q,lT,K)
addJoint(n,v,Z,K)
if B~=nil then addJoint(n,B,t,K)addJoint(n,B,yp,K)else P=n end;B=n end;addJoint(P,n,t,K)addJoint(P,n,yp,K)end
function bomb3(g,k)local U=tfm.get.room.playerList[g]local l,X=U.x,U.y
local f=string.format('%d,%d',l,X)
local b={type=13,color='0xFFFFFF',width=64,height=64,dynamic=true,mass=1,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=false,foreground=true}
local v={type=1,axis='-1,0',forceMotor=255,speedMotor=2,limit1=0,limit2=5}local z;local A;local d,r;local H,c;local vx=64.0+b.width;local q=5;local t;local O
addBombTimer(g,U,k,true,10)
local G={[0]=0.15,[60]=0.13,[120]=0.11,[180]=0.075,[240]=0.05,[300]=0}
for z=0,359,60 do A=z*math.pi/180.0;H,c=math.cos(A),math.sin(A)d,r=l+
vx*H,X+vx*c
O={x=l+math.cos(A+G[z])*280,y=X+
math.sin(A+G[z])*280,power=127,distance=3*b.width,miceOnly=false,p1=particles.red_spirit,p2=nil}t=addGround(d,r,b,q,nil,explode,O)
v.angle=2.0*math.pi-A;addJoint(t,0,v,q)end end
function pattern(z,q,N,a,qH)local P=q.patterns[N][a]
if P~=nil then local lj=#P.points+1
if lj>=
P.type.points then local I=os.time()
if I-P.lastTime>=P.type.cd then P.lastTime=I
P.points[lj]=qH;addPattern(z,q,P.type,P.points)P.points={}end else P.points[lj]=qH end end end
function bind(y,q,a,j)local P=playerData[y]local S=P.patterns[q]if S[a]~=nil then
do_unbind(P,S[a],q,a)end
S[a]={id=j,type=patternTypes[j],points={},lastTime=0}S=P.pattern_data[j]if S==nil then P.pattern_data[j]={binds=1}else
S.binds=S.binds+1 end end
function do_unbind(q,U,I,Z)local K=q.pattern_data[U.id]if K.binds<=1 then
q.pattern_data[U.id]=nil else K.binds=K.binds-1 end;q.patterns[I][Z]=
nil end
function unbind(b,v,u)local a=playerData[b]
if v==nil then a.patterns={key={},obj={},objend={}}
a.pattern_data={}elseif u==nil then local s={}
for q,K in pairs(a.patterns[v])do s[#s+1]={q,K}end;for X,o in ipairs(s)do do_unbind(a,o[2],v,o[1])end else
local uF=a.patterns[v][u]if uF~=nil then do_unbind(a,uF,v,u)end end end
function testPattern(O,R,Y,o)local Z=o[1]local H=6;local K=48;local T=math.random(2,8)local V,b,t;local G=
Z.angle*math.pi/180.0
for i=0,H-1 do
V=G+2.0*math.pi*i/H;b,t=math.cos(V),math.sin(V)addObject(Z.type,Z.x+K*b,Z.y+K*t,Z.angle+360*i/H,
T*b,T*t,false,9)end end
function shoot(o,g)
if g.shot_cd==0 then if g.bombing and g.bomb.shot~=nil then
g.shot_cd=g.bomb.shot.cd;g.bomb.shot.func(o,g)else g.shot_cd=g.shot.cd
g.shot.func(o,g)end end end
function defaultShot(M,O)local xi=tfm.get.room.playerList[M]local w,S=xi.x,xi.y
local r;if xi.isFacingRight then r='-1,0'w=w+32 else r='1,0'w=w-32 end
local V=addGround(w,S+32,{type=13,width=8,height=8,restitution=255,mass=10,dynamic=true,miceCollision=true,groundCollision=false,color='0xFFFFFF',foreground=true},6)
addJoint(V,0,{color='0x00FFFF',line=2,type=1,axis=r,forceMotor=100,speedMotor=100},6)
V=addGround(w,S-32,{type=13,width=8,height=8,restitution=255,mass=10,dynamic=true,miceCollision=true,groundCollision=false,color='0xFFFFFF',foreground=true},6)
addJoint(V,0,{color='0x00FFFF',line=2,type=1,axis=r,forceMotor=100,speedMotor=100},6)end
function homingShot(s,X)
local D=randomKey1(tfm.get.room.playerList,s,false)local K=tfm.get.room.playerList[s]local j=K.x;local i=K.y;local _=2
local Kc=2;local I=false;if not K.isFacingRight then _=-_ end;j=j+16*_
local C={target=D,x=j,y=i+32,v=128}
addObject(objcode.anvil,j+_,i+Kc,0,_,Kc,I,10,moveHoming,nil,C)local C={target=D,x=j,y=i-32,v=128}
addObject(objcode.anvil,j+_,i-Kc,0,_,-Kc,I,10,moveHoming,nil,C)end
function initPlayer(Q)
local f={color=randomColor(),shooting=false,bombing=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}if playerConfig[Q]==nil then playerConfig[Q]={}end
copy(f,playerConfig[Q])playerData[Q]=f;for fH,U in pairs(playerKeys)do bindKey(Q,U,true,true)
bindKey(Q,U,false,true)end
ui.addTextArea(1,getText(f),Q,5,25,150,38,nil,nil,nil,true)
ui.addTextArea(104,'<TI><a href="event:help">?</a>',Q,145,25,10,20,nil,nil,nil,true)do_respawn(Q)setShaman(Q)
setNameColor(Q,playerData[Q].color)end
function resetPlayer(z)
local j={shooting=false,bombing=false,bombTime=nil,lives=5,bombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}local E=playerData[z]copy(E,j)updateTextAreas(z,E)
do_respawn(z)setShaman(z)setNameColor(z,E.color)end;function deletePlayer(B)local _=playerData[B]if _.bombing then removeBomb(B,_)end;playerData[B]=
nil end
function respawn(k)
do_respawn(k)setNameColor(k,playerData[k].color)end;playerData={}objectData={}groundData={}jointData={}patternData={}bulletData={}
groundId={max=0,free={}}jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}
bombs={top=0,val={}}playerKeys={32,83,40,100,101,102,104,81,68,69,82,87,37,39}
reservedKeys=invert(playerKeys,true)eventCode={key=keycode,obj=objcode,objend=objcode}
defaultMap='<C><P defilante="0,0,0,1" L="1600" H="800" G="0,0" /><Z><S /><D><DS Y="200" X="200" /></D><O /></Z></C>'maxLives=8;maxBombs=6
shotTypes={{func=defaultShot,cd=1},{func=homingShot,cd=2}}
bombTypes={{name='default bomb',func=defaultBomb,callback=defaultBombCallback,shot={func=nop,cd=1},cost=1,time=20,cd=0},{name='',func=bomb2,callback=
nil,shot={func=nop,cd=1},cost=1,time=20,cd=5},{name='',func=bomb3,callback=nil,shot={func=nop,cd=1},cost=1,time=6,cd=5}}
patternTypes={{func=testPattern,time=0,callback=nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}}}
playerConfig={Cafecafe={bomb=bombTypes[3],color='0xB06FFD'}}MODULE_HELP_START='Keys'
MODULE_HELP_CONTENTS=[[<font face="mono" size="15"><a href="event:Keys">Keys</a>
<a href="event:Commands">Commands</a>
<a href="event:Shot types">Shot types</a>
<a href="event:Bomb types">Bomb types</a>
<a href="event:Pattern types">Pattern types</a>
<a href="event:Shaman objects">Shaman objects</a>
]]
MODULE_HELP={['Keys']=[[<font face="mono" size="15">Shoot - E
Bomb  - R
Up    - Space
Down  - S, ↓
Left  - A, ←
Right - D, →</font>
]],['Commands']=[[<font face="mono" size="15">!help

!clear

!color [&lt;color&gt;]

!reset [map]
    tfm.exec.newGame(defaultMap)

!reset [!]me|all|&lt;name&gt;...
    resetPlayer()

!init [!]me|all|&lt;name&gt;...
    deletePlayer()
    initPlayer()

!respawn [!]me|all|&lt;name&gt;...
    tfm.exec.respawnPlayer()

!map [&lt;map&gt;]
    tfm.exec.newGame()

!shot [type]

!bomb [type]

!bind &lt;pattern&gt; key|obj|objend &lt;name|code&gt;

!unbind [all]
!unbind key|obj|objend [&lt;name|code&gt;]
</font>
]],['Shot types']=[[<font face="mono" size="15">1 - default shot
    Cooldown: 0.5s

2 - homing anvils
    Cooldown: 1s
</font>
]],['Bomb types']=[[<font face="mono" size="15">1 - default bomb
    Cost: 1
    Duration: 10s
    Cooldown: 0s

2 - 
    Cost: 1
    Duration: 10s
    Cooldown: 2.5s

3 - 
    Cost: 1
    Duration: 3s
    Cooldown: 2.5s
</font>
]],['Pattern types']=[[<font face="mono" size="15">1
    Cooldown: 0.5s
    Max. binds: 3
    Points: 1
</font>
]]}
MODULE_HELP_CLOSE='<TI><a href="event:help_close"><p align="center">X</p></a>'
do
local S=function(M,z)local T={'<font face="mono" size="15">'}local Y;for X,H in ipairs(keys1(M))do
Y=z-#H;if Y>0 then X=H..string.rep(' ',Y)else X=H end
T[#T+1]=string.format('%s = %4d\n',X,M[H])end
T[#T+1]='</font>'return table.concat(T)end;MODULE_HELP['Shaman objects']=S(objcode,15)end
MODULE_CHAT_COMMAND={['help']=help,['clear']=clear,['color']=function(o,d,U)U=string.upper(U)
if U==''or U=='RANDOM'or U==
'RND'then setColor(o,randomColor())playerConfig[o].color=
nil else local E=tonumber(U)if E~=nil then if E>0xFFFFFF then E=0xFFFFFF end
setColor(o,U)playerConfig[o].color=U else
alert('Invalid color: '..U,o)end end end,['reset']=function(E,N,f)
f=string.lower(f)if f==''or f=='map'then setMap(defaultMap)else
parsePlayerNames(E,f,resetPlayer)end end,['init']=function(l,B,U)local y=function(l)
deletePlayer(l)initPlayer(l)end
parsePlayerNames(l,U,y)end,['respawn']=function(t,e,y)
parsePlayerNames(t,y,respawn)end,['shot']=function(Z,J,c)local M=tonumber(c)if M==nil then
alert('Invalid shot type: '..c,Z)return end;M=shotTypes[M]
if M~=nil then
playerData[Z].shot=M else alert('Invalid shot type: '..c,Z)end end,['bomb']=function(P,u,w)
local uy=tonumber(w)
if uy==nil then alert('Invalid bomb type: '..w,P)return end;uy=bombTypes[uy]if uy~=nil then playerData[P].bomb=uy else
alert('Invalid bomb type: '..w,P)end end,['bind']=function(D,s,R)
R=split(R)if#R<3 then alert('Too few arguments',D)return elseif#R>3 then
alert('Too many arguments',D)return end
i=tonumber(R[1])local Y=patternTypes[i]if i==nil or Y==nil then
alert('Invalid pattern: '..R[1],D)return end;j=R[2]
if j~='key'and j~='obj'and
j~='objend'then alert('Invalid event: '..j,D)return end;local v=tonumber(R[3])
if v==nil then v=eventCode[j][R[3]]if v==nil then
alert(string.format('Invalid %s name/code: %s',j,R[3]),D)return end end;if
Y.restrict[j]~=nil and Y.restrict[j][v]==nil then
alert(string.format('Can\'t bind pattern %d to %s %d: restricted',i,j,v),D)return end;if
j=='key'and reservedKeys[v]then
alert(string.format('Can\'t bind pattern %d to %s %d: reserved',i,j,v),D)return end
local O=playerData[D]local M=O.pattern_data[i]if M~=nil and Y.maxBinds<=M.binds then
alert(string.format('Can\'t bind pattern %d to more than %d events',i,Y.maxBinds),D)return end
bind(D,j,v,i)end,['unbind']=function(S,s,H)
H=split(H)if#H>2 then alert('Too many arguments',S)return end
i=H[1]
if i=='all'or i==nil then unbind(S)elseif
i~='key'and i~='obj'and i~='objend'then alert('Invalid event: '..i,S)return else
if H[2]==nil then
unbind(S,i)else j=tonumber(H[2])
if j==nil then j=eventCode[i][H[2]]if j==nil then
alert(string.format('Invalid %s name/code: %s',i,H[2]),S)return end end;unbind(S,i,j)end end end,['map']=function(L,x,Ls)if
Ls==''then Ls=defaultMap end;setMap(Ls)end}
MODULE_CHAT_COMMAND_1=function(o,W,F)alert('Invalid command: '..W,o)end;eventNewPlayer=initPlayer;eventPlayerLeft=deletePlayer
eventTextAreaCallback=helpTextAreaCallback
function eventNewGame()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)tfm.exec.setGameTime(0)objectData={}groundData={}
jointData={}patternData={}bulletData={}bombs={top=0,val={}}groundId={max=0,free={}}
jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}for f,i in
pairs(tfm.get.room.playerList)do resetPlayer(f)end
setMapName('<TI>')setShamanName('')
do_addGround(0,0,0,{type=13,width=10,height=10,color='0xFFFFFF',dynamic=false,miceCollision=false,groundCollision=false})end
function eventKeyboard(a,J,S,A,u)
if reservedKeys[J]then
if J==82 then local Y=playerData[a]if S then bomb(a,Y)end elseif J==69 then
local p=playerData[a]p.shooting=S;if S then shoot(a,p)end else local f=0;local j=0
if not S then
if

J==32 or J==104 or J==83 or J==40 or J==53 or J==101 or J==87 then
movePlayer(a,0,0,true,0,1,false)movePlayer(a,0,0,true,0,-1,true)else
movePlayer(a,0,0,true,1,0,false)movePlayer(a,0,0,true,-1,0,true)end else
if J==32 or J==104 or J==87 then f=-50 elseif J==83 or J==40 or J==101 then f=50 elseif J==
100 then j=-50 elseif J==102 then j=50 end
if j~=0 or f~=0 then movePlayer(a,0,0,true,j,f,false)end end end elseif S then pattern(a,playerData[a],'key',J,{x=A,y=u})end end;function eventSummoningStart(A,C,J,B,D)local X={x=J,y=B,angle=D,type=C}
pattern(A,playerData[A],'obj',C,X)end
function eventSummoningEnd(e,O,r,Q,X,XJ,h,F,o)
objectData[F.id]={time=3}local rv={x=r,y=Q,angle=X,type=O,vx=XJ,vy=h,data=F,other=o}
pattern(e,playerData[e],'objend',O,rv)end
function eventMouse(l,d,lJ)local o=tfm.get.room.playerList[l]end
function eventPlayerDied(Q)local e=playerData[Q]
if e~=nil then
if e.bombing then respawn(Q)else e.shot_cd=0
e.bomb_cd=0;e.shooting=false;e.lives=e.lives-1;if e.lives>0 then e.bombs=e.resetBombs
updateTextAreas(Q,e)respawn(Q)else
alert(string.format('playerData["%s"].lives &lt;= 0',Q),Q)end end end end
function eventLoop(a,u)clearT()
for o,w in pairs(playerData)do
if w.shot_cd>0 then w.shot_cd=w.shot_cd-1 end;if w.bomb_cd>0 then w.bomb_cd=w.bomb_cd-1 end;if w.shooting then
shoot(o,w)end
if w.bombing then w.bombTime=w.bombTime-1
if w.bombTime<=0 then
w.bombing=false;w.bomb_cd=w.bomb.cd;removeBomb(o,w)else if w.bomb.callback then
w.bomb.callback(o,w)end end end end end
for C,Z in pairs(tfm.get.room.playerList)do initPlayer(C)end;setMap(defaultMap)