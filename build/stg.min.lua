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
objcode={arrow=0,small_box=1,box=2,small_plank=3,plank=4,ball=6,trampoline=7,anvil=10,anvil1=1002,B=11,Bc=12,Bcc=13,V=14,Vc=15,Vcc=16,cannon_up=17,cannon_down=18,cannon_right=19,cannon_left=20,C=22,bomb=23,spirit=24,cheese=25,blue_portal=26,orange_portal=27,balloon1=2806,balloon=28,red_balloon=29,green_balloon=30,yellow_balloon=31,rune=32,snow=34,arrow1=35,apple=39,sheep=40,demolition=41,totem=44,ice_plank=45,choco_plank=46,cloud=57,architect=58,bubble=59,tiny_plank=60,companion_crate=61,stable_rune=62,ballon_anchor=66,windmill_anchor=88}copy(objcode,tfm.enum.shamanObject)
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
function addControl(G,...)local o=addGround(...)local g=groundData[o]if g.callback_args==nil then
g.callback_args={_controls=G}else g.callback_args._on_remove=g.on_remove
g.callback_args._controls=G end
g.on_remove=motionEnd;G[#G+1]=o;return o end;function addControl1(M,...)return addGround(...)end
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
motion.spiral=function(k,S,M,z,T,Y,X,H)motion.line(k,S,false,z,T,X,H)
motion.circle(k,S,M,z,Y,X,H)end
function addBombTimer(o,d,U,E,EN)local f=U.bombTime*EN+2
local l={type=13,angle=0,color='0xFF0000',foreground=false,friction=0.0,restitution=2.0,width=f,height=f,miceCollision=false,groundCollision=E,dynamic=false}
addGround(d.x,d.y,l,U.bombTime,moveBombTimer,nil,{player=o,pdata=U,offset=2,scale=EN,obj=l})f=f-2
l={type=13,angle=0,color='0x6A7495',foreground=false,friction=0.0,restitution=2.0,width=f,height=f,miceCollision=false,groundCollision=E,dynamic=false}
addGround(d.x,d.y,l,U.bombTime,moveBombTimer,nil,{player=o,pdata=U,offset=0,scale=EN,obj=l})end
function moveBombTimer(B,U)local y=U.callback_args
local t=tfm.get.room.playerList[y.player]local e=y.pdata.bombTime*y.scale+y.offset
y.obj.width=e;y.obj.height=e;do_addGround(B,t.x,t.y,y.obj)end
function defaultBombCallback(y,Z)local J=tfm.get.room.playerList[y]
local c=J.y+J.vy;local M;local P,u;local w=Z.bombCallbackArgs;local uy=4;local D=4;local s=0;local R={ax=64,ay=0}D=w*D
R.ax=w*R.ax;M=J.x+w*Z.bombTime*5+10
for off=20,120,20 do u=off*w
P=M+u*1.5
addObject(objcode.anvil,P,c-u,0,D,-s*w,false,uy,accelerate,nil,R)
addObject(objcode.anvil,P,c+u,0,D,s*w,false,uy,accelerate,nil,R)s=s+1 end end
function defaultBomb(Y,v)local O=tfm.get.room.playerList[Y]
if
not O.isFacingRight then v.bombCallbackArgs=-1 else v.bombCallbackArgs=1 end;addBombTimer(Y,O,v,true,5)end
function bomb2(M,S)local s=tfm.get.room.playerList[M]local H,L=s.x,s.y
local xL=string.format('%d,%d',H,L)
local so={type=12,color=0xFFFFFF,foreground=true,width=512,height=8,dynamic=true,mass=8,restitution=255,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=true}
local W={type=13,color=0xFFFFFF,width=32,height=32,dynamic=false,groundCollision=false,miceCollision=false,foreground=true}local F={type=3,point1=xL,point2=nil,forceMotor=255,speedMotor=2}
local f={type=3,point1=xL,point2=xL,ratio=1,limit1=0,limit2=8}local i={type=0,frequency=10}local aJ;local SA;local u,Y;local p,fj
local A=32.0+so.width/2.0;local C=20;local J=nil;local B=nil;local D,X;addBombTimer(M,s,S,true,5)
X=addGround(H,L,W,C)
for aJ=0,359,120 do SA=aJ*math.pi/180.0
u,Y=math.cos(SA),math.sin(SA)p,fj=H+A*u,L+A*Y;so.angle=aJ;D=addGround(p,fj,so,C)
addJoint(D,X,F,C)
if B~=nil then addJoint(D,B,f,C)addJoint(D,B,i,C)else J=D end;B=D end;addJoint(J,D,f,C)addJoint(J,D,i,C)end
function bomb3(e,O)local r=tfm.get.room.playerList[e]local Q,X=r.x,r.y
local XJ=string.format('%d,%d',Q,X)
local h={type=13,color=0xFFFFFF,width=64,height=64,dynamic=true,mass=1,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=false,foreground=true}
local F={type=1,axis='-1,0',forceMotor=255,speedMotor=2,limit1=0,limit2=5}local o;local rv;local l,d;local lJ,oQ;local ea=64.0+h.width;local u=5;local ow;local C
addBombTimer(e,r,O,true,10)
local Z={[0]=0.15,[60]=0.13,[120]=0.11,[180]=0.075,[240]=0.05,[300]=0}
for o=0,359,60 do rv=o*math.pi/180.0
lJ,oQ=math.cos(rv),math.sin(rv)l,d=Q+ea*lJ,X+ea*oQ
C={x=Q+math.cos(rv+Z[o])*280,y=X+math.sin(
rv+Z[o])*280,power=127,distance=3*h.width,miceOnly=false,p1=particles.red_spirit,p2=nil}ow=addGround(l,d,h,u,nil,explode,C)
F.angle=2.0*math.pi-rv;addJoint(ow,0,F,u)end end
function pattern(j,d,p,O,W)local R=d.patterns[p][O]
if R~=nil then local lP=#R.points+1
if lP>=
R.type.points then local u=os.time()
if u-R.lastTime>=R.type.cd then R.lastTime=u
R.points[lP]=W;addPattern(j,d,R.type,R.points)R.points={}end else R.points[lP]=W end end end
function bind(k,t,Q,QJ)local F=playerData[k]local o=F.patterns[t]if o[Q]~=nil then
do_unbind(F,o[Q],t,Q)end
o[Q]={id=QJ,type=patternTypes[QJ],points={},lastTime=0}o=F.pattern_data[QJ]if t=='key'then bindKey(k,Q,true,true)
alert(string.format('%d',Q),k)end;if o==nil then
F.pattern_data[QJ]={binds=1}else o.binds=o.binds+1 end end
function do_unbind(z,P,L,p)local x=z.pattern_data[P.id]if x.binds<=1 then
z.pattern_data[P.id]=nil else x.binds=x.binds-1 end;z.patterns[L][p]=
nil end
function unbind(o,J,x)local P=playerData[o]
if J==nil then P.patterns={key={},obj={},objend={}}
P.pattern_data={}elseif x==nil then local O={}
for q,s in pairs(P.patterns[J])do O[#O+1]={q,s}end;for p,c in ipairs(O)do do_unbind(P,c[2],J,c[1])end else
local A=P.patterns[J][x]if A~=nil then do_unbind(P,A,J,x)end end end
function testPattern(X,k,x,r)local h=r[1]local b=6;local D=48;local br=math.random(2,8)local bq,rb,d;local s=
h.angle*math.pi/180.0;for i=0,b-1 do
bq=s+2.0*math.pi*i/b;rb,d=math.cos(bq),math.sin(bq)
addObject(h.type,h.x+D*rb,h.y+D*d,h.angle+
360*i/b,br*rb,br*d,false,9)end end
function testPattern1(y,o,_,b)local K=b[1]local x=math.random(8,16)local yi,g,f;local d;local _
for i=1,x do
d=math.random(0,32)yi=math.random()*2*math.pi
g,f=math.cos(yi),math.sin(yi)
_=addBullet(bullet.circle,8,nil,nil,nil,K.x+d*g,K.y+d*f,{{color=randomColor()},{line=24,color=0xFFFFFF}},
nil)
addMotion(motion.line,_,true,true,2,{speedMotor=math.random(2,8),angle=2*math.pi-yi})end end
function shoot(F,u)
if u.shot_cd==0 then if u.bombing and u.bomb.shot~=nil then
u.shot_cd=u.bomb.shot.cd;u.bomb.shot.func(F,u)else u.shot_cd=u.shot.cd
u.shot.func(F,u)end end end
function defaultShot(N,O)local d=tfm.get.room.playerList[N]local z,x=d.x,d.y;local p;if
d.isFacingRight then p=-1 else p=1 end;local C=math.random()*math.pi
local u=addBullet(bullet.jstar,8,
nil,nil,nil,z+64*math.cos(C),x+64*math.sin(C),0,16,5,2,{color=randomColor()},
nil,nil)C=math.random()*math.pi+math.pi
local y=addBullet(bullet.jstar,8,
nil,nil,nil,z+64*math.cos(C),x+64*math.sin(C),0,16,5,2,{color=randomColor()},
nil,nil)
addMotion(motion.circle,u,true,true,math.random(1,4),{speedMotor=4*p},z,x)
addMotion(motion.circle,y,true,true,math.random(1,4),{speedMotor=-4*p},z,x)end
function homingShot(o,e)
local I=randomKey1(tfm.get.room.playerList,o,false)local t=tfm.get.room.playerList[o]local W=t.x;local k=t.y;local w=2
local a=2;local wY=false;if not t.isFacingRight then w=-w end;W=W+16*w
local M={target=I,x=W,y=k+32,v=128}
addObject(objcode.anvil,W+w,k+a,0,w,a,wY,10,moveHoming,nil,M)local M={target=I,x=W,y=k-32,v=128}
addObject(objcode.anvil,W+w,k-a,0,w,-a,wY,10,moveHoming,nil,M)end
function initPlayer(w)
local E={color=randomColor(),shooting=false,bombing=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},spawn={200,200},lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}if playerConfig[w]==nil then playerConfig[w]={}end
copy(E,playerConfig[w])playerData[w]=E;for s,X in pairs(playerKeys)do bindKey(w,X,true,true)
bindKey(w,X,false,true)end
ui.addTextArea(1,getText(E),w,5,25,150,38,nil,nil,nil,true)
ui.addTextArea(104,'<TI><a href="event:help">?</a>',w,145,25,10,20,nil,nil,nil,true)do_respawn(w)setShaman(w)
setNameColor(w,playerData[w].color)end
function resetPlayer(i)
local B={shooting=false,bombing=false,bombTime=nil,lives=5,bombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}local I=playerData[i]copy(I,B)updateTextAreas(i,I)
do_respawn(i)setShaman(i)setNameColor(i,I.color)end;function deletePlayer(C)local F=playerData[C]if F.bombing then removeBomb(C,F)end;playerData[C]=
nil end
function respawn(C)
do_respawn(C)setNameColor(C,playerData[C].color)end;playerData={}objectData={}groundData={}jointData={}patternData={}bulletData={}
playerKeys={32,83,40,100,101,102,104,81,68,69,82,37,39}reservedKeys=invert(playerKeys,true)
eventCode={key=keycode,obj=objcode,objend=objcode}
defaultMap='<C><P defilante="0,0,0,1" L="1600" H="800" G="0,0" /><Z><S /><D><DS Y="200" X="200" /></D><O /></Z></C>'maxLives=8;maxBombs=6
shotTypes={{func=defaultShot,cd=1},{func=homingShot,cd=2}}
bombTypes={{name='default bomb',func=defaultBomb,callback=defaultBombCallback,shot={func=nop,cd=1},cost=1,time=20,cd=0},{name='',func=bomb2,callback=
nil,shot={func=nop,cd=1},cost=1,time=20,cd=5},{name='',func=bomb3,callback=nil,shot={func=nop,cd=1},cost=1,time=6,cd=5}}
patternTypes={{func=testPattern,time=0,callback=nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern1,time=0,callback=
nil,cd=250,points=1,maxBinds=3,restrict={key=nil,obj=nil,objend=nil}}}
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
local Q=function(j,t)local s={'<font face="mono" size="15">'}local tB
for M,_ in ipairs(keys1(j))do tB=t-
#_
if tB>0 then M=_..string.rep(' ',tB)else M=_ end;s[#s+1]=string.format('%s = %4d\n',M,j[_])end;s[#s+1]='</font>'return table.concat(s)end;MODULE_HELP['Shaman objects']=Q(objcode,15)end
MODULE_CHAT_COMMAND={['help']=help,['clear']=clear,['color']=function(R,Ri,y)y=string.upper(y)
if y==''or y=='RANDOM'or y==
'RND'then setColor(R,randomColor())playerConfig[R].color=
nil else local S=tonumber(y)if S~=nil then if S>0xFFFFFF then S=0xFFFFFF end
setColor(R,y)playerConfig[R].color=y else
alert('Invalid color: '..y,R)end end end,['reset']=function(S,i,v)
v=string.lower(v)if v==''or v=='map'then setMap(defaultMap)else
parsePlayerNames(S,v,resetPlayer)end end,['init']=function(h,N,B)local z=function(h)
deletePlayer(h)initPlayer(h)end
parsePlayerNames(h,B,z)end,['respawn']=function(n,nc,g)
parsePlayerNames(n,g,respawn)end,['shot']=function(K,e,S)local M=tonumber(S)if M==nil then
alert('Invalid shot type: '..S,K)return end;M=shotTypes[M]
if M~=nil then
playerData[K].shot=M else alert('Invalid shot type: '..S,K)end end,['bomb']=function(n,N,x)
local m=tonumber(x)
if m==nil then alert('Invalid bomb type: '..x,n)return end;m=bombTypes[m]if m~=nil then playerData[n].bomb=m else
alert('Invalid bomb type: '..x,n)end end,['bind']=function(P,N,f)
f=split(f)if#f<3 then alert('Too few arguments',P)return elseif#f>3 then
alert('Too many arguments',P)return end
i=tonumber(f[1])local g=patternTypes[i]if i==nil or g==nil then
alert('Invalid pattern: '..f[1],P)return end;j=f[2]
if j~='key'and j~='obj'and
j~='objend'then alert('Invalid event: '..j,P)return end;local c=tonumber(f[3])
if c==nil then c=eventCode[j][f[3]]if c==nil then
alert(string.format('Invalid %s name/code: %s',j,f[3]),P)return end end;if
g.restrict[j]~=nil and g.restrict[j][c]==nil then
alert(string.format('Can\'t bind pattern %d to %s %d: restricted',i,j,c),P)return end;if
j=='key'and reservedKeys[c]then
alert(string.format('Can\'t bind pattern %d to %s %d: reserved',i,j,c),P)return end
local F=playerData[P]local gm=F.pattern_data[i]if gm~=nil and g.maxBinds<=gm.binds then
alert(string.format('Can\'t bind pattern %d to more than %d events',i,g.maxBinds),P)return end
bind(P,j,c,i)end,['unbind']=function(K,C,r)
r=split(r)if#r>2 then alert('Too many arguments',K)return end
i=r[1]
if i=='all'or i==nil then unbind(K)elseif
i~='key'and i~='obj'and i~='objend'then alert('Invalid event: '..i,K)return else
if r[2]==nil then
unbind(K,i)else j=tonumber(r[2])
if j==nil then j=eventCode[i][r[2]]if j==nil then
alert(string.format('Invalid %s name/code: %s',i,r[2]),K)return end end;unbind(K,i,j)end end end,['map']=function(r,u,A)if
A==''then A=defaultMap end;setMap(A)end}
MODULE_CHAT_COMMAND_1=function(M,Z,o)alert('Invalid command: '..Z,M)end;eventNewPlayer=initPlayer;eventPlayerLeft=deletePlayer
eventTextAreaCallback=helpTextAreaCallback
function eventNewGame()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)tfm.exec.setGameTime(0)objectData={}groundData={}
jointData={}patternData={}bulletData={}bombs={top=0,val={}}groundId={max=0,free={}}
jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}for v,S in
pairs(tfm.get.room.playerList)do resetPlayer(v)end
setMapName('<TI>')setShamanName('')
do_addGround(0,0,0,{type=13,width=10,height=10,color=0xFFFFFF,dynamic=false,miceCollision=false,groundCollision=false})end
function eventKeyboard(u,z,Y,Z,A)
if reservedKeys[z]then
if z==82 then local o=playerData[u]if Y then bomb(u,o)end elseif z==69 then
local y=playerData[u]y.shooting=Y;if Y then shoot(u,y)end else local p=0;local y=0
if not Y then
if

z==32 or z==104 or z==83 or z==40 or z==53 or z==101 then movePlayer(u,0,0,true,0,1,false)
movePlayer(u,0,0,true,0,-1,true)else movePlayer(u,0,0,true,1,0,false)
movePlayer(u,0,0,true,-1,0,true)end else
if z==32 or z==104 or z==87 then p=-50 elseif z==83 or z==40 or z==101 then p=50 elseif z==
100 then y=-50 elseif z==102 then y=50 end
if y~=0 or p~=0 then movePlayer(u,0,0,true,y,p,false)end end end else alert(string.format('%d',z),u)
pattern(u,playerData[u],'key',z,{x=Z,y=A})end end;function eventSummoningStart(R,r,rD,W,L)local Q={x=rD,y=W,angle=L,type=r}
pattern(R,playerData[R],'obj',r,Q)end
function eventSummoningEnd(v,yg,c,b,P,B,M,d,i)
objectData[d.id]={time=3}local m={x=c,y=b,angle=P,type=yg,vx=B,vy=M,data=d,other=i}
pattern(v,playerData[v],'objend',yg,m)end
function eventMouse(O,H,x)local Z=tfm.get.room.playerList[O]end
function eventPlayerDied(c)local h=playerData[c]
if h~=nil then
if h.bombing then respawn(c)else h.shot_cd=0
h.bomb_cd=0;h.shooting=false;h.lives=h.lives-1;if h.lives>0 then h.bombs=h.resetBombs
updateTextAreas(c,h)respawn(c)else
alert(string.format('playerData["%s"].lives &lt;= 0',c),c)end end end end
function eventLoop(M,G)local n,U,z,ij,b,P,GO,A;clearT()
for i,PU in pairs(playerData)do
n=tfm.get.room.playerList[i]
if not n.isDead then U=n.x;z=n.y;if U<0 then U=10 elseif U>4800 then U=4790 end;if z<0 then z=10 elseif z>1600 then
z=1590 end;PU.spawn[0]=U;PU.spawn[1]=z;ij=-n.vx
b=-n.vy;P=-n.vx/10;GO=-n.vy/10
for A=1,math.random(8,16)do
addParticle(particles.purple,U+math.random(
-4,4),z+math.random(-4,4),(
ij+math.random()*2-1)/A,
(b+math.random()*2-1)/A,P,GO)end end;if PU.shot_cd>0 then PU.shot_cd=PU.shot_cd-1 end;if
PU.bomb_cd>0 then PU.bomb_cd=PU.bomb_cd-1 end;if PU.shooting then
shoot(i,PU)end
if PU.bombing then PU.bombTime=PU.bombTime-1
if PU.bombTime<=0 then
PU.bombing=false;PU.bomb_cd=PU.bomb.cd;removeBomb(i,PU)else if PU.bomb.callback then
PU.bomb.callback(i,PU)end end end end end
for D,n in pairs(tfm.get.room.playerList)do initPlayer(D)end;setMap(defaultMap)