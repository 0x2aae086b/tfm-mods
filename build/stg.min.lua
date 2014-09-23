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
local h={type=13,width=16,height=16,miceCollision=true,groundCollision=false,dynamic=true,restitution=255}copy(h,i)local A=newId(groundId)do_addGround(A,L,P,h)local v={}for l,o in
ipairs(u)do copy(K,o)addJoint1(v,A,A,K)end;return A,{A},v end
bullet.jstar=function(F,e,T,Fx,l,TY,Z,t,y)local p=make_star(l,TY)
local H={type=0,color=0xFFFFFF,line=5,foreground=true}local f=Fx*p.r
local HK={type=0,point1=string.format('%d,%d',F,e),point2=string.format('%d,%d',F,e+1),color=0xFFFFFF,line=f*
2,foreground=true}
local A={type=13,width=f,height=f,dynamic=true,miceCollision=true,groundCollision=false,restitution=255}copy(H,Z)copy(HK,t)copy(A,y)local _={}local Q={}local sK,P
local B,n=math.cos(T),math.sin(T)
for g,k in ipairs(p.points)do sK,P=k[1]*B-k[2]*n,k[1]*n+k[2]*B;Q[#Q+1]=string.format('%d,%d',
F+Fx*sK,e+Fx*P)end;local v=newId(groundId)do_addGround(v,F,e,A)
for i=1,l do H.point1=Q[i]H.point2=Q[1+ (
i+TY-1)%l]addJoint1(_,v,v,H)end;addJoint1(_,v,v,HK)return v,{v},_ end
bullet.star=function(U,l,X,f,b,v,z,A,d,r)local H=make_star(b,v)
local cv={type=12,height=1,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}local x=f*H.r
local q={type=13,width=x,height=x,color=0xFFFFFF,groundCollision=false,miceCollision=true,dynamic=true,foreground=true,restitution=255}
local t={type=13,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}x=string.format('%d,%d',U,l)
local O={type=3,point1=x,point2=x,ratio=1,limit1=0,limit2=0}local G={type=0,frequency=10}copy(cv,A)copy(q,d)copy(t,r)
local zq,N,aq={},{},{}local HP,lj;local I=X*180.0/math.pi
local y,qa=math.cos(X),math.sin(X)for P,S in ipairs(H.lines)do cv.angle=S.angle+I;cv.width=S.width*f;HP,lj=S.x*y-S.y*qa,
S.x*qa+S.y*y
addGround1(zq,U+f*HP,l+f*lj,cv)end;if z then
for qU,IZ in
ipairs(H.points)do HP,lj=IZ[1]*y-IZ[2]*qa,IZ[1]*qa+IZ[2]*y;addGround1(N,
U+f*HP,l+f*lj,t)end end
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
function motionEnd(V,b)local t=b.callback_args
if t._on_remove then t._on_remove(V,b)end;do_removeControl(t._controls,V)end
function addControl(G,...)local o=addGround(...)local g=groundData[o]
g.callback_args._on_remove=g.on_remove;g.callback_args._controls=G;g.on_remove=motionEnd;G[#G+1]=o;return o end;function addControl1(M,...)return addGround(...)end
function addMotion(O,x,i,...)if i then
local w=bulletData[x]return O(addControl,bulletData[x].controls,...)else return
O(addControl1,{x},...)end end;motion={}
motion.line=function(S,r,V,s,X,D,K)local j=0;local i=r[#r]
local _={type=1,axis='-1,0',angle=0,forceMotor=255,speedMotor=1}copy(_,X)
if not V then
local Kc={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}j=S(r,D or 0,K or 0,Kc,s or 3)end;addJoint(i,j,_,s or 3)end
motion.circle=function(I,C,Q,f,fH,U,z)local j=0;local E=C[#C]local B={type=3,forceMotor=255,speedMotor=1}
copy(B,fH)
if not Q then
local _={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}j=I(C,U or 0,z or 0,_,f or 3)end
if U and z then B.point1=string.format('%d,%d',U,z)end;addJoint(E,j,B,f or 3)end
function addBombTimer(k,S,M,z,T)local Y=M.bombTime*T+2
local X={type=13,angle=0,color='0xFF0000',foreground=false,friction=0.0,restitution=2.0,width=Y,height=Y,miceCollision=false,groundCollision=z,dynamic=false}
addGround(S.x,S.y,X,M.bombTime,moveBombTimer,nil,{player=k,pdata=M,offset=2,scale=T,obj=X})Y=Y-2
X={type=13,angle=0,color='0x6A7495',foreground=false,friction=0.0,restitution=2.0,width=Y,height=Y,miceCollision=false,groundCollision=z,dynamic=false}
addGround(S.x,S.y,X,M.bombTime,moveBombTimer,nil,{player=k,pdata=M,offset=0,scale=T,obj=X})end
function moveBombTimer(H,o)local d=o.callback_args
local U=tfm.get.room.playerList[d.player]local E=d.pdata.bombTime*d.scale+d.offset
d.obj.width=E;d.obj.height=E;do_addGround(H,U.x,U.y,d.obj)end
function defaultBombCallback(E,N)local f=tfm.get.room.playerList[E]
local l=f.y+f.vy;local B;local U,yt;local e=N.bombCallbackArgs;local y=4;local Z=4;local J=0;local c={ax=64,ay=0}Z=e*Z
c.ax=e*c.ax;B=f.x+e*N.bombTime*5+10
for off=20,120,20 do yt=off*e
U=B+yt*1.5
addObject(objcode.anvil,U,l-yt,0,Z,-J*e,false,y,accelerate,nil,c)
addObject(objcode.anvil,U,l+yt,0,Z,J*e,false,y,accelerate,nil,c)J=J+1 end end
function defaultBomb(M,P)local u=tfm.get.room.playerList[M]
if
not u.isFacingRight then P.bombCallbackArgs=-1 else P.bombCallbackArgs=1 end;addBombTimer(M,u,P,true,5)end
function bomb2(w,u)local yD=tfm.get.room.playerList[w]local s,R=yD.x,yD.y
local Y=string.format('%d,%d',s,R)
local v={type=12,color=0xFFFFFF,foreground=true,width=512,height=8,dynamic=true,mass=8,restitution=255,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=true}
local O={type=13,color=0xFFFFFF,width=32,height=32,dynamic=false,groundCollision=false,miceCollision=false,foreground=false}local M={type=3,point1=Y,point2=nil,forceMotor=255,speedMotor=2}
local S={type=3,point1=Y,point2=Y,ratio=1,limit1=0,limit2=8}local sH={type=0,frequency=10}local L;local xL;local so,W;local F,f
local i=32.0+v.width/2.0;local a=20;local J=nil;local SA=nil;local uY,p;addBombTimer(w,yD,u,true,5)
p=addGround(s,R,O,a)
for L=0,359,120 do xL=L*math.pi/180.0
so,W=math.cos(xL),math.sin(xL)F,f=s+i*so,R+i*W;v.angle=L;uY=addGround(F,f,v,a)
addJoint(uY,p,M,a)
if SA~=nil then addJoint(uY,SA,S,a)addJoint(uY,SA,sH,a)else J=uY end;SA=uY end;addJoint(J,uY,S,a)addJoint(J,uY,sH,a)end
function bomb3(f,j)local A=tfm.get.room.playerList[f]local C,J=A.x,A.y
local B=string.format('%d,%d',C,J)
local D={type=13,color=0xFFFFFF,width=64,height=64,dynamic=true,mass=1,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=false,foreground=true}
local X={type=1,axis='-1,0',forceMotor=255,speedMotor=2,limit1=0,limit2=5}local e;local O;local r,Q;local XX,Jh;local F=64.0+D.width;local o=5;local rv;local l
addBombTimer(f,A,j,true,10)
local d={[0]=0.15,[60]=0.13,[120]=0.11,[180]=0.075,[240]=0.05,[300]=0}
for e=0,359,60 do O=e*math.pi/180.0;XX,Jh=math.cos(O),math.sin(O)r,Q=C+F*
XX,J+F*Jh
l={x=C+math.cos(O+d[e])*280,y=J+math.sin(O+
d[e])*280,power=127,distance=3*D.width,miceOnly=false,p1=particles.red_spirit,p2=nil}rv=addGround(r,Q,D,o,nil,explode,l)
X.angle=2.0*math.pi-O;addJoint(rv,0,X,o)end end
function pattern(l,J,o,Q,e)local a=J.patterns[o][Q]
if a~=nil then local u=#a.points+1
if u>=
a.type.points then local ow=os.time()
if ow-a.lastTime>=a.type.cd then a.lastTime=ow
a.points[u]=e;addPattern(l,J,a.type,a.points)a.points={}end else a.points[u]=e end end end
function bind(C,Z,j,d)local pO=playerData[C]local W=pO.patterns[Z]if W[j]~=nil then
do_unbind(pO,W[j],Z,j)end
W[j]={id=d,type=patternTypes[d],points={},lastTime=0}W=pO.pattern_data[d]if W==nil then pO.pattern_data[d]={binds=1}else W.binds=
W.binds+1 end end
function do_unbind(R,l,P,u)local k=R.pattern_data[l.id]if k.binds<=1 then
R.pattern_data[l.id]=nil else k.binds=k.binds-1 end;R.patterns[P][u]=
nil end
function unbind(t,Q,QJ)local F=playerData[t]
if Q==nil then F.patterns={key={},obj={},objend={}}
F.pattern_data={}elseif QJ==nil then local o={}
for z,P in pairs(F.patterns[Q])do o[#o+1]={z,P}end;for L,p in ipairs(o)do do_unbind(F,p[2],Q,p[1])end else
local x=F.patterns[Q][QJ]if x~=nil then do_unbind(F,x,Q,QJ)end end end
function testPattern(o,J,x,P)local O=P[1]local q=6;local sp=48;local cA=math.random(2,8)local X,k,xr;local h=
O.angle*math.pi/180.0;for i=0,q-1 do
X=h+2.0*math.pi*i/q;k,xr=math.cos(X),math.sin(X)
addObject(O.type,O.x+sp*k,O.y+sp*xr,O.angle+
360*i/q,cA*k,cA*xr,false,9)end end
function shoot(b,D)
if D.shot_cd==0 then if D.bombing and D.bomb.shot~=nil then
D.shot_cd=D.bomb.shot.cd;D.bomb.shot.func(b,D)else D.shot_cd=D.shot.cd
D.shot.func(b,D)end end end
function defaultShot(b,r)local bq=tfm.get.room.playerList[b]local rb,d=bq.x,bq.y
local s;if bq.isFacingRight then s=-1 else s=1 end
local y=math.random()*math.pi
local o=addBullet(bullet.jstar,8,nil,nil,nil,rb+64*math.cos(y),d+64*math.sin(y),0,16,5,2,{color=randomColor()},
nil,nil)y=math.random()*math.pi+math.pi
local _=addBullet(bullet.jstar,8,
nil,nil,nil,rb+64*math.cos(y),d+64*math.sin(y),0,16,5,2,{color=randomColor()},
nil,nil)
addMotion(motion.circle,o,true,true,math.random(1,4),{speedMotor=4*s},rb,d)
addMotion(motion.circle,_,true,true,math.random(1,4),{speedMotor=-4*s},rb,d)end
function homingShot(b,K)
local xy=randomKey1(tfm.get.room.playerList,b,false)local i=tfm.get.room.playerList[b]local gf=i.x;local d=i.y;local F=2
local u=2;local N=false;if not i.isFacingRight then F=-F end;gf=gf+16*F
local O={target=xy,x=gf,y=d+32,v=128}
addObject(objcode.anvil,gf+F,d+u,0,F,u,N,10,moveHoming,nil,O)local O={target=xy,x=gf,y=d-32,v=128}
addObject(objcode.anvil,gf+F,d-u,0,F,-u,N,10,moveHoming,nil,O)end
function initPlayer(d)
local z={color=randomColor(),shooting=false,bombing=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}if playerConfig[d]==nil then playerConfig[d]={}end
copy(z,playerConfig[d])playerData[d]=z;for x,p in pairs(playerKeys)do bindKey(d,p,true,true)
bindKey(d,p,false,true)end
ui.addTextArea(1,getText(z),d,5,25,150,38,nil,nil,nil,true)
ui.addTextArea(104,'<TI><a href="event:help">?</a>',d,145,25,10,20,nil,nil,nil,true)do_respawn(d)setShaman(d)
setNameColor(d,playerData[d].color)end
function resetPlayer(C)
local u={shooting=false,bombing=false,bombTime=nil,lives=5,bombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}local y=playerData[C]copy(y,u)updateTextAreas(C,y)
do_respawn(C)setShaman(C)setNameColor(C,y.color)end;function deletePlayer(o)local e=playerData[o]if e.bombing then removeBomb(o,e)end;playerData[o]=
nil end
function respawn(I)
do_respawn(I)setNameColor(I,playerData[I].color)end;playerData={}objectData={}groundData={}jointData={}patternData={}bulletData={}
playerKeys={32,83,40,100,101,102,104,81,68,69,82,87,37,39}reservedKeys=invert(playerKeys,true)
eventCode={key=keycode,obj=objcode,objend=objcode}
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
local t=function(W,k)local w={'<font face="mono" size="15">'}local a;for wY,M in ipairs(keys1(W))do
a=k-#M;if a>0 then wY=M..string.rep(' ',a)else wY=M end
w[#w+1]=string.format('%s = %4d\n',wY,W[M])end
w[#w+1]='</font>'return table.concat(w)end;MODULE_HELP['Shaman objects']=t(objcode,15)end
MODULE_CHAT_COMMAND={['help']=help,['clear']=clear,['color']=function(w,E,s)s=string.upper(s)
if s==''or s=='RANDOM'or s==
'RND'then setColor(w,randomColor())playerConfig[w].color=
nil else local X=tonumber(s)if X~=nil then if X>0xFFFFFF then X=0xFFFFFF end
setColor(w,s)playerConfig[w].color=s else
alert('Invalid color: '..s,w)end end end,['reset']=function(i,B,I)
I=string.lower(I)if I==''or I=='map'then setMap(defaultMap)else
parsePlayerNames(i,I,resetPlayer)end end,['init']=function(C,F,CQ)local j=function(C)
deletePlayer(C)initPlayer(C)end
parsePlayerNames(C,CQ,j)end,['respawn']=function(t,s,tB)
parsePlayerNames(t,tB,respawn)end,['shot']=function(M,_,R)local Ri=tonumber(R)if Ri==nil then
alert('Invalid shot type: '..R,M)return end;Ri=shotTypes[Ri]
if Ri~=nil then
playerData[M].shot=Ri else alert('Invalid shot type: '..R,M)end end,['bomb']=function(y,S,Si)
local v=tonumber(Si)
if v==nil then alert('Invalid bomb type: '..Si,y)return end;v=bombTypes[v]if v~=nil then playerData[y].bomb=v else
alert('Invalid bomb type: '..Si,y)end end,['bind']=function(h,N,B)
B=split(B)if#B<3 then alert('Too few arguments',h)return elseif#B>3 then
alert('Too many arguments',h)return end
i=tonumber(B[1])local z=patternTypes[i]if i==nil or z==nil then
alert('Invalid pattern: '..B[1],h)return end;j=B[2]
if j~='key'and j~='obj'and
j~='objend'then alert('Invalid event: '..j,h)return end;local n=tonumber(B[3])
if n==nil then n=eventCode[j][B[3]]if n==nil then
alert(string.format('Invalid %s name/code: %s',j,B[3]),h)return end end;if
z.restrict[j]~=nil and z.restrict[j][n]==nil then
alert(string.format('Can\'t bind pattern %d to %s %d: restricted',i,j,n),h)return end;if
j=='key'and reservedKeys[n]then
alert(string.format('Can\'t bind pattern %d to %s %d: reserved',i,j,n),h)return end
local nc=playerData[h]local g=nc.pattern_data[i]if g~=nil and z.maxBinds<=g.binds then
alert(string.format('Can\'t bind pattern %d to more than %d events',i,z.maxBinds),h)return end
bind(h,j,n,i)end,['unbind']=function(K,e,S)
S=split(S)if#S>2 then alert('Too many arguments',K)return end
i=S[1]
if i=='all'or i==nil then unbind(K)elseif
i~='key'and i~='obj'and i~='objend'then alert('Invalid event: '..i,K)return else
if S[2]==nil then
unbind(K,i)else j=tonumber(S[2])
if j==nil then j=eventCode[i][S[2]]if j==nil then
alert(string.format('Invalid %s name/code: %s',i,S[2]),K)return end end;unbind(K,i,j)end end end,['map']=function(M,n,N)if
N==''then N=defaultMap end;setMap(N)end}
MODULE_CHAT_COMMAND_1=function(x,m,P)alert('Invalid command: '..m,x)end;eventNewPlayer=initPlayer;eventPlayerLeft=deletePlayer
eventTextAreaCallback=helpTextAreaCallback
function eventNewGame()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)tfm.exec.setGameTime(0)objectData={}groundData={}
jointData={}patternData={}bulletData={}bombs={top=0,val={}}groundId={max=0,free={}}
jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}for N,f in
pairs(tfm.get.room.playerList)do resetPlayer(N)end
setMapName('<TI>')setShamanName('')
do_addGround(0,0,0,{type=13,width=10,height=10,color=0xFFFFFF,dynamic=false,miceCollision=false,groundCollision=false})end
function eventKeyboard(g,c,F,gm,K)
if reservedKeys[c]then
if c==82 then local C=playerData[g]if F then bomb(g,C)end elseif c==69 then
local r=playerData[g]r.shooting=F;if F then shoot(g,r)end else local r=0;local u=0
if not F then
if

c==32 or c==104 or c==83 or c==40 or c==53 or c==101 or c==87 then
movePlayer(g,0,0,true,0,1,false)movePlayer(g,0,0,true,0,-1,true)else
movePlayer(g,0,0,true,1,0,false)movePlayer(g,0,0,true,-1,0,true)end else
if c==32 or c==104 or c==87 then r=-50 elseif c==83 or c==40 or c==101 then r=50 elseif c==
100 then u=-50 elseif c==102 then u=50 end
if u~=0 or r~=0 then movePlayer(g,0,0,true,u,r,false)end end end elseif F then pattern(g,playerData[g],'key',c,{x=gm,y=K})end end;function eventSummoningStart(A,M,Z,o,v)local S={x=Z,y=o,angle=v,type=M}
pattern(A,playerData[A],'obj',M,S)end
function eventSummoningEnd(u,z,Y,Z,A,o,y,p,yR)
objectData[p.id]={time=3}local r={x=Y,y=Z,angle=A,type=z,vx=o,vy=y,data=p,other=yR}
pattern(u,playerData[u],'objend',z,r)end
function eventMouse(r,D,W)local L=tfm.get.room.playerList[r]end
function eventPlayerDied(Q)local v=playerData[Q]
if v~=nil then
if v.bombing then respawn(Q)else v.shot_cd=0
v.bomb_cd=0;v.shooting=false;v.lives=v.lives-1;if v.lives>0 then v.bombs=v.resetBombs
updateTextAreas(Q,v)respawn(Q)else
alert(string.format('playerData["%s"].lives &lt;= 0',Q),Q)end end end end
function eventLoop(y,g)local c,b,P,B,M,d,im,O;clearT()
for H,x in pairs(playerData)do
c=tfm.get.room.playerList[H]
if not c.isDead then b=c.x;P=c.y;B=-c.vx;M=-c.vy;d=-c.vx/10;im=-c.vy/10
for O=1,math.random(8,16)
do
addParticle(particles.purple,b+math.random(-4,4),P+math.random(-4,4),(B+
math.random()*2-1)/O,(
M+math.random()*2-1)/O,d,im)end end;if x.shot_cd>0 then x.shot_cd=x.shot_cd-1 end;if x.bomb_cd>0 then x.bomb_cd=
x.bomb_cd-1 end
if x.shooting then shoot(H,x)end
if x.bombing then x.bombTime=x.bombTime-1;if x.bombTime<=0 then x.bombing=false
x.bomb_cd=x.bomb.cd;removeBomb(H,x)else
if x.bomb.callback then x.bomb.callback(H,x)end end end end end
for Z,c in pairs(tfm.get.room.playerList)do initPlayer(Z)end;setMap(defaultMap)