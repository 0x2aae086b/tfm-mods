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
function addGround1(o,w,m,G)local e=newId(groundId)do_addGround(e,w,m,G)o[#o+1]=e end
function addJoint1(j,U,N,y)local n=newId(jointId)do_addJoint(n,U,N,y)j[#j+1]=n end;function do_addControl(B,K)B[#B+1]=K end;function do_removeControl(a,B)local Q=#a;while Q>0 and a[Q]~=B do
a[Q]=nil;Q=Q-1 end end
function addBullet(L,y,a,D,p,...)
local M=newId(bulletId)local MJ,k,P=L(...)
bulletData[M]={controls={MJ},grounds=k,joints=P,time=y or 6,callback=a,on_remove=D,callback_args=p}return M end
function removeBullet(u)local E=bulletData[u]for C,l in ipairs(E.grounds)do do_removeGround(l)
freeId(groundId,l)end;for p,i in ipairs(E.joints)do
do_removeJoint(i)freeId(jointId,i)end
bulletData[u]=nil;freeId(bulletId,u)end;bullet={}
bullet.circle=function(L,P,u,i)local j=string.format('%d,%d',L,P+1)
local K={type=0,point2=j,color=0xFFFFFF,line=32,foreground=true}
local h={type=13,width=16,height=16,miceCollision=true,groundCollision=false,dynamic=true,restitution=255}if i~=nil then copy(h,i)end;local A=newId(groundId)
do_addGround(A,L,P,h)local v={}
for l,o in ipairs(u)do copy(K,o)addJoint1(v,A,A,K)end;return A,{A},v end
bullet.jstar=function(F,e,T,Fx,l,TY,Z,t,y)local p=make_star(l,TY)
local H={type=0,color=0xFFFFFF,line=5,foreground=true}local f=Fx*p.r
local HK={type=0,point1=string.format('%d,%d',F,e),point2=string.format('%d,%d',F,e+1),color=0xFFFFFF,line=f*
2,foreground=true}
local A={type=13,width=f,height=f,dynamic=true,miceCollision=true,groundCollision=false,restitution=255}if Z~=nil then copy(H,Z)end;if t~=nil then copy(HK,t)end;if y~=nil then
copy(A,y)end;local _={}local Q={}local sK,P;local B,n=math.cos(T),math.sin(T)
for g,k in
ipairs(p.points)do sK,P=k[1]*B-k[2]*n,k[1]*n+k[2]*B;Q[#Q+1]=string.format('%d,%d',
F+Fx*sK,e+Fx*P)end;local v=newId(groundId)do_addGround(v,F,e,A)
for i=1,l do H.point1=Q[i]H.point2=Q[1+ (
i+TY-1)%l]addJoint1(_,v,v,H)end;addJoint1(_,v,v,HK)return v,{v},_ end
bullet.star=function(U,l,X,f,b,v,z,A,d,r)local H=make_star(b,v)
local cv={type=12,height=1,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}local x=f*H.r
local q={type=13,width=x,height=x,color=0xFFFFFF,groundCollision=false,miceCollision=true,dynamic=true,foreground=true,restitution=255}
local t={type=13,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}x=string.format('%d,%d',U,l)
local O={type=3,point1=x,point2=x,ratio=1,limit1=0,limit2=0}local G={type=0,frequency=10}if A~=nil then copy(cv,A)end;if d~=nil then
copy(q,d)end;if r~=nil then copy(t,r)end;local zq,N,aq={},{},{}local HP,lj;local I=X*180.0/
math.pi;local y,qa=math.cos(X),math.sin(X)
for P,S in
ipairs(H.lines)do cv.angle=S.angle+I;cv.width=S.width*f;HP,lj=S.x*y-S.y*qa,S.x*qa+
S.y*y;addGround1(zq,U+f*HP,l+f*lj,cv)end;if z then
for qU,IZ in ipairs(H.points)do
HP,lj=IZ[1]*y-IZ[2]*qa,IZ[1]*qa+IZ[2]*y;addGround1(N,U+f*HP,l+f*lj,t)end end
local j=newId(groundId)do_addGround(j,U,l,q)
if cv.dynamic then local K,bv=nil,nil
for u,a in ipairs(zq)do
addJoint1(aq,a,j,O)if K~=nil then addJoint1(aq,a,K,G)else bv=a end;K=a end;addJoint1(aq,bv,K,G)elseif q.dynamic then
for s,qK in ipairs(zq)do addJoint1(aq,qK,j,O)end end
if z then
if t.dynamic then local Xo,u=nil,nil
for i=1,b do addJoint1(aq,N[i],zq[i],O)if Xo~=nil then
addJoint1(aq,N[i],Xo,G)else u=N[i]end;Xo=N[i]end;addJoint1(aq,u,Xo,G)elseif cv.dynamic then
for i=1,b do addJoint1(aq,N[i],zq[i],O)end end end;append(zq,N)zq[#zq+1]=j;return j,zq,aq end
function bomb(F,O)
if O.bomb_cd==0 and not O.bombing then
if O.bombs>=O.bomb.cost then O.bombs=O.bombs-
O.bomb.cost;O.bombing=true;O.bombTime=O.bomb.time
O.bomb.func(F,O)addBomb(F,O)updateTextAreas(F,O)else
alert(string.format('bombs &lt; %d',O.bomb.cost),F)end end end
function addBomb(R,Y)local o=bombs.top+1
local Z=string.format('<TI><font color="#%X">%s <font color="#5F5F8D">|</font> %s</font>',Y.color,R,Y.bomb.name)Y.bomb_id=o;bombs.top=o;bombs.val[o]=Z;setShamanName(Z)end
function removeBomb(H,K)local T=K.bomb_id;K.bomb_id=nil;bombs.val[T]=nil
if T==bombs.top then T=T-1;while
bombs.val[T]==nil and T>0 do T=T-1 end;bombs.top=T;if T>0 then
T=bombs.val[T]else T=''end;setShamanName(T)end end
function addBombTimer(V,b,t,G,o)local g=t.bombTime*o+2
local M={type=13,angle=0,color='0xFF0000',foreground=false,friction=0.0,restitution=2.0,width=g,height=g,miceCollision=false,groundCollision=G,dynamic=false}
addGround(b.x,b.y,M,t.bombTime,moveBombTimer,nil,{player=V,pdata=t,offset=2,scale=o,obj=M})g=g-2
M={type=13,angle=0,color='0x6A7495',foreground=false,friction=0.0,restitution=2.0,width=g,height=g,miceCollision=false,groundCollision=G,dynamic=false}
addGround(b.x,b.y,M,t.bombTime,moveBombTimer,nil,{player=V,pdata=t,offset=0,scale=o,obj=M})end
function moveBombTimer(O,x)local i=x.callback_args
local w=tfm.get.room.playerList[i.player]local S=i.pdata.bombTime*i.scale+i.offset
i.obj.width=S;i.obj.height=S;do_addGround(O,w.x,w.y,i.obj)end
function defaultBombCallback(r,V)local s=tfm.get.room.playerList[r]
local X=s.y+s.vy;local D;local K,j;local i=V.bombCallbackArgs;local _=4;local Kc=4;local I=0;local C={ax=64,ay=0}Kc=i*Kc;C.ax=i*
C.ax;D=s.x+i*V.bombTime*5+10
for off=20,120,20 do
j=off*i;K=D+j*1.5
addObject(objcode.anvil,K,X-j,0,Kc,-I*i,false,_,accelerate,nil,C)
addObject(objcode.anvil,K,X+j,0,Kc,I*i,false,_,accelerate,nil,C)I=I+1 end end
function defaultBomb(Q,f)local fH=tfm.get.room.playerList[Q]
if
not fH.isFacingRight then f.bombCallbackArgs=-1 else f.bombCallbackArgs=1 end;addBombTimer(Q,fH,f,true,5)end
function bomb2(U,z)local j=tfm.get.room.playerList[U]local E,B=j.x,j.y
local _=string.format('%d,%d',E,B)
local k={type=12,color=0xFFFFFF,foreground=true,width=512,height=8,dynamic=true,mass=8,restitution=255,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=true}
local S={type=13,color=0xFFFFFF,width=32,height=32,dynamic=false,groundCollision=false,miceCollision=false,foreground=false}local M={type=3,point1=_,point2=nil,forceMotor=255,speedMotor=2}
local zT={type=3,point1=_,point2=_,ratio=1,limit1=0,limit2=8}local Y={type=0,frequency=10}local X;local H;local o,d;local UE,EN
local f=32.0+k.width/2.0;local l=20;local BU=nil;local y=nil;local t,e;addBombTimer(U,j,z,true,5)
e=addGround(E,B,S,l)
for X=0,359,120 do H=X*math.pi/180.0;o,d=math.cos(H),math.sin(H)UE,EN=E+
f*o,B+f*d;k.angle=X;t=addGround(UE,EN,k,l)
addJoint(t,e,M,l)
if y~=nil then addJoint(t,y,zT,l)addJoint(t,y,Y,l)else BU=t end;y=t end;addJoint(BU,t,zT,l)addJoint(BU,t,Y,l)end
function bomb3(y,Z)local J=tfm.get.room.playerList[y]local c,M=J.x,J.y
local P=string.format('%d,%d',c,M)
local u={type=13,color=0xFFFFFF,width=64,height=64,dynamic=true,mass=1,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=false,foreground=true}
local w={type=1,axis='-1,0',forceMotor=255,speedMotor=2,limit1=0,limit2=5}local uy;local D;local s,R;local Y,v;local O=64.0+u.width;local MS=5;local sH;local L
addBombTimer(y,J,Z,true,10)
local x={[0]=0.15,[60]=0.13,[120]=0.11,[180]=0.075,[240]=0.05,[300]=0}
for uy=0,359,60 do D=uy*math.pi/180.0;Y,v=math.cos(D),math.sin(D)s,R=c+O*
Y,M+O*v
L={x=c+math.cos(D+x[uy])*280,y=M+math.sin(D+
x[uy])*280,power=127,distance=3*u.width,miceOnly=false,p1=particles.red_spirit,p2=nil}sH=addGround(s,R,u,MS,nil,explode,L)
w.angle=2.0*math.pi-D;addJoint(sH,0,w,MS)end end
function pattern(L,s,o,W,F)local f=s.patterns[o][W]
if f~=nil then local i=#f.points+1
if i>=
f.type.points then local a=os.time()
if a-f.lastTime>=f.type.cd then f.lastTime=a
f.points[i]=F;addPattern(L,s,f.type,f.points)f.points={}end else f.points[i]=F end end end
function bind(J,S,A,u)local Y=playerData[J]local pf=Y.patterns[S]if pf[A]~=nil then
do_unbind(Y,pf[A],S,A)end
pf[A]={id=u,type=patternTypes[u],points={},lastTime=0}pf=Y.pattern_data[u]if pf==nil then Y.pattern_data[u]={binds=1}else pf.binds=
pf.binds+1 end end
function do_unbind(j,A,C,J)local B=j.pattern_data[A.id]if B.binds<=1 then
j.pattern_data[A.id]=nil else B.binds=B.binds-1 end;j.patterns[C][J]=
nil end
function unbind(D,X,e)local O=playerData[D]
if X==nil then O.patterns={key={},obj={},objend={}}
O.pattern_data={}elseif e==nil then local r={}
for Q,XX in pairs(O.patterns[X])do r[#r+1]={Q,XX}end;for J,h in ipairs(r)do do_unbind(O,h[2],X,h[1])end else
local F=O.patterns[X][e]if F~=nil then do_unbind(O,F,X,e)end end end
function testPattern(o,r,v,l)local d=l[1]local lJ=6;local oQ=48;local e=math.random(2,8)local au,ow,C;local Z=
d.angle*math.pi/180.0;for i=0,lJ-1 do
au=Z+2.0*math.pi*i/lJ;ow,C=math.cos(au),math.sin(au)
addObject(d.type,d.x+oQ*ow,d.y+oQ*C,d.angle+
360*i/lJ,e*ow,e*C,false,9)end end
function shoot(j,d)
if d.shot_cd==0 then if d.bombing and d.bomb.shot~=nil then
d.shot_cd=d.bomb.shot.cd;d.bomb.shot.func(j,d)else d.shot_cd=d.shot.cd
d.shot.func(j,d)end end end
function defaultShot(p,O)local W=tfm.get.room.playerList[p]local R,l=W.x,W.y;local P;if
W.isFacingRight then P='-1,0'R=R+32 else P='1,0'R=R-32 end
local u=addBullet(bullet.jstar,6,nil,nil,
nil,R,l+32,0,16,5,2,{color=randomColor()},nil,nil)local k=bulletData[u]
local t=addBullet(bullet.jstar,6,nil,nil,nil,R,l-32,0,16,5,2,{color=randomColor()},nil,nil)local Q=bulletData[t]
addJoint(k.controls[#k.controls],0,{type=1,axis=P,forceMotor=255,speedMotor=255},6)
addJoint(Q.controls[#Q.controls],0,{type=1,axis=P,forceMotor=255,speedMotor=255},6)end
function homingShot(Q,J)
local F=randomKey1(tfm.get.room.playerList,Q,false)local o=tfm.get.room.playerList[Q]local z=o.x;local P=o.y;local L=2
local p=2;local x=false;if not o.isFacingRight then L=-L end;z=z+16*L
local oJ={target=F,x=z,y=P+32,v=128}
addObject(objcode.anvil,z+L,P+p,0,L,p,x,10,moveHoming,nil,oJ)local oJ={target=F,x=z,y=P-32,v=128}
addObject(objcode.anvil,z+L,P-p,0,L,-p,x,10,moveHoming,nil,oJ)end
function initPlayer(x)
local P={color=randomColor(),shooting=false,bombing=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}if playerConfig[x]==nil then playerConfig[x]={}end
copy(P,playerConfig[x])playerData[x]=P;for O,q in pairs(playerKeys)do bindKey(x,q,true,true)
bindKey(x,q,false,true)end
ui.addTextArea(1,getText(P),x,5,25,150,38,nil,nil,nil,true)
ui.addTextArea(104,'<TI><a href="event:help">?</a>',x,145,25,10,20,nil,nil,nil,true)do_respawn(x)setShaman(x)
setNameColor(x,playerData[x].color)end
function resetPlayer(s)
local p={shooting=false,bombing=false,bombTime=nil,lives=5,bombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}local c=playerData[s]copy(c,p)updateTextAreas(s,c)
do_respawn(s)setShaman(s)setNameColor(s,c.color)end;function deletePlayer(A)local X=playerData[A]if X.bombing then removeBomb(A,X)end;playerData[A]=
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
local x=function(r,h)local b={'<font face="mono" size="15">'}local D
for br,bq in ipairs(keys1(r))do D=h-
#bq
if D>0 then br=bq..string.rep(' ',D)else br=bq end;b[#b+1]=string.format('%s = %4d\n',br,r[bq])end;b[#b+1]='</font>'return table.concat(b)end;MODULE_HELP['Shaman objects']=x(objcode,15)end
MODULE_CHAT_COMMAND={['help']=help,['clear']=clear,['color']=function(r,b,d)d=string.upper(d)
if d==''or d=='RANDOM'or d==
'RND'then setColor(r,randomColor())playerConfig[r].color=
nil else local s=tonumber(d)if s~=nil then if s>0xFFFFFF then s=0xFFFFFF end
setColor(r,d)playerConfig[r].color=d else
alert('Invalid color: '..d,r)end end end,['reset']=function(y,o,_)
_=string.lower(_)if _==''or _=='map'then setMap(defaultMap)else
parsePlayerNames(y,_,resetPlayer)end end,['init']=function(b,K,x)local y=function(b)
deletePlayer(b)initPlayer(b)end
parsePlayerNames(b,x,y)end,['respawn']=function(i,g,f)
parsePlayerNames(i,f,respawn)end,['shot']=function(d,F,u)local N=tonumber(u)if N==nil then
alert('Invalid shot type: '..u,d)return end;N=shotTypes[N]
if N~=nil then
playerData[d].shot=N else alert('Invalid shot type: '..u,d)end end,['bomb']=function(O,d,z)
local x=tonumber(z)
if x==nil then alert('Invalid bomb type: '..z,O)return end;x=bombTypes[x]if x~=nil then playerData[O].bomb=x else
alert('Invalid bomb type: '..z,O)end end,['bind']=function(p,C,u)
u=split(u)if#u<3 then alert('Too few arguments',p)return elseif#u>3 then
alert('Too many arguments',p)return end
i=tonumber(u[1])local y=patternTypes[i]if i==nil or y==nil then
alert('Invalid pattern: '..u[1],p)return end;j=u[2]
if j~='key'and j~='obj'and
j~='objend'then alert('Invalid event: '..j,p)return end;local o=tonumber(u[3])
if o==nil then o=eventCode[j][u[3]]if o==nil then
alert(string.format('Invalid %s name/code: %s',j,u[3]),p)return end end;if
y.restrict[j]~=nil and y.restrict[j][o]==nil then
alert(string.format('Can\'t bind pattern %d to %s %d: restricted',i,j,o),p)return end;if
j=='key'and reservedKeys[o]then
alert(string.format('Can\'t bind pattern %d to %s %d: reserved',i,j,o),p)return end
local e=playerData[p]local I=e.pattern_data[i]if I~=nil and y.maxBinds<=I.binds then
alert(string.format('Can\'t bind pattern %d to more than %d events',i,y.maxBinds),p)return end
bind(p,j,o,i)end,['unbind']=function(t,W,k)
k=split(k)if#k>2 then alert('Too many arguments',t)return end
i=k[1]
if i=='all'or i==nil then unbind(t)elseif
i~='key'and i~='obj'and i~='objend'then alert('Invalid event: '..i,t)return else
if k[2]==nil then
unbind(t,i)else j=tonumber(k[2])
if j==nil then j=eventCode[i][k[2]]if j==nil then
alert(string.format('Invalid %s name/code: %s',i,k[2]),t)return end end;unbind(t,i,j)end end end,['map']=function(w,a,wY)if
wY==''then wY=defaultMap end;setMap(wY)end}
MODULE_CHAT_COMMAND_1=function(M,w,E)alert('Invalid command: '..w,M)end;eventNewPlayer=initPlayer;eventPlayerLeft=deletePlayer
eventTextAreaCallback=helpTextAreaCallback
function eventNewGame()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)tfm.exec.setGameTime(0)objectData={}groundData={}
jointData={}patternData={}bulletData={}bombs={top=0,val={}}groundId={max=0,free={}}
jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}for s,X in
pairs(tfm.get.room.playerList)do resetPlayer(s)end
setMapName('<TI>')setShamanName('')
do_addGround(0,0,0,{type=13,width=10,height=10,color=0xFFFFFF,dynamic=false,miceCollision=false,groundCollision=false})end
function eventKeyboard(i,B,I,C,F)
if reservedKeys[B]then
if B==82 then local CQ=playerData[i]if I then bomb(i,CQ)end elseif
B==69 then local j=playerData[i]j.shooting=I;if I then shoot(i,j)end else local t=0;local s=0
if not I then
if

B==32 or B==104 or B==83 or B==40 or B==53 or B==101 or B==87 then
movePlayer(i,0,0,true,0,1,false)movePlayer(i,0,0,true,0,-1,true)else
movePlayer(i,0,0,true,1,0,false)movePlayer(i,0,0,true,-1,0,true)end else
if B==32 or B==104 or B==87 then t=-50 elseif B==83 or B==40 or B==101 then t=50 elseif B==
100 then s=-50 elseif B==102 then s=50 end
if s~=0 or t~=0 then movePlayer(i,0,0,true,s,t,false)end end end elseif I then pattern(i,playerData[i],'key',B,{x=C,y=F})end end;function eventSummoningStart(t,B,M,_,R)local Ri={x=M,y=_,angle=R,type=B}
pattern(t,playerData[t],'obj',B,Ri)end
function eventSummoningEnd(yS,S,i,v,h,N,B,z,n)
objectData[z.id]={time=3}local nc={x=i,y=v,angle=h,type=S,vx=N,vy=B,data=z,other=n}
pattern(yS,playerData[yS],'objend',S,nc)end
function eventMouse(g,K,e)local S=tfm.get.room.playerList[g]end
function eventPlayerDied(M)local n=playerData[M]
if n~=nil then
if n.bombing then respawn(M)else n.shot_cd=0
n.bomb_cd=0;n.shooting=false;n.lives=n.lives-1;if n.lives>0 then n.bombs=n.resetBombs
updateTextAreas(M,n)respawn(M)else
alert(string.format('playerData["%s"].lives &lt;= 0',M),M)end end end end
function eventLoop(N,x)clearT()
for m,P in pairs(playerData)do
if P.shot_cd>0 then P.shot_cd=P.shot_cd-1 end;if P.bomb_cd>0 then P.bomb_cd=P.bomb_cd-1 end;if P.shooting then
shoot(m,P)end
if P.bombing then P.bombTime=P.bombTime-1
if P.bombTime<=0 then
P.bombing=false;P.bomb_cd=P.bomb.cd;removeBomb(m,P)else if P.bomb.callback then
P.bomb.callback(m,P)end end end end end
for N,f in pairs(tfm.get.room.playerList)do initPlayer(N)end;setMap(defaultMap)