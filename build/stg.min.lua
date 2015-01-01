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
M[#M+1]=make_line(v[i],v[1+ (i+sl-1)%C])end;local S=length1(M[1])return
{lines=M,points=v,r=S,l=math.sqrt(1-S*S)}end)
keycode={backspace=8,enter=13,shift=16,ctrl=17,alt=18,capslock=20,esc=27,space=32,['0']=48,['1']=49,['2']=50,['3']=51,['4']=52,['5']=53,['6']=54,['7']=55,['8']=56,['9']=57,a=81,b=66,c=67,d=68,e=69,f=70,g=71,h=72,i=73,j=74,k=75,l=76,m=77,n=78,o=79,p=80,q=65,r=82,s=83,t=84,u=85,v=86,w=90,x=88,y=89,z=87,[';']=186,['=']=187,[',']=188,['-']=189,['.']=190,['/']=191,['`']=192,[':']=186,['+']=187,['<']=188,['_']=189,['>']=190,['?']=191,['~']=192,['[']=219,['\\']=220,[']']=221,["'"]=222,['{']=219,['|']=220,['}']=221,['"']=222,[')']=48,['!']=49,['@']=50,['#']=51,['$']=52,['%']=53,['^']=54,['&']=55,['*']=56,['(']=57,kp0=96,kp1=97,kp2=98,kp3=99,kp4=100,kp5=101,kp6=102,kp7=103,kp8=104,kp9=105,['kp*']=106,['kp+']=107,['kp-']=109,['kp.']=110,['kp/']=111,left=37,up=38,right=39,down=40,f1=112,f2=113,f3=114,f4=115,f5=116,f6=117,f7=118,f8=119,f9=120,f10=121,f11=122,f12=123}
particles={white=0,purple=1,orange=2,soft_white=4,teal=9,yellow=11,red=13,spawn=3,heart=5,red_heart=30,pink_heart=31,bubble=6,bubble1=7,bubble2=8,water=14,spirit=10,red_spirit=12,plus1=15,plus10=16,plus12=17,plus14=18,plus16=19,meep=20,red_confetti=21,green_confetti=22,blue_confetti=23,yellow_confetti=24,rain=25,wind=26,wind1=27,lightning=28,star=29,flower=32}
objcode={arrow=0,small_box=1,box=2,small_plank=3,plank=4,ball=6,trampoline=7,anvil=10,anvil1=1002,B=11,Bc=12,Bcc=13,V=14,Vc=15,Vcc=16,cannon_up=17,cannon_down=18,cannon_right=19,cannon_left=20,C=22,bomb=23,spirit=24,cheese=25,blue_portal=26,orange_portal=27,balloon1=2806,balloon=28,red_balloon=29,green_balloon=30,yellow_balloon=31,rune=32,snow=34,arrow1=35,apple=39,sheep=40,demolition=41,totem=44,ice_plank=45,choco_plank=46,cloud=57,architect=58,bubble=59,tiny_plank=60,companion_crate=61,stable_rune=62,ballon_anchor=66,windmill_anchor=88}copy(objcode,tfm.enum.shamanObject)
function getText(n)
local v=n.lives-1;local I=n.bombs;if v>=maxLives then v=maxLives-1 end;if v<0 then v=0 end;if
I>maxBombs then I=maxBombs elseif I<0 then I=0 end
if n.lives<1 then l=0 else l=n.lives end;return
string.format('<TI><N>Player  <R>%s<N>\nBomb  <VP>%s',string.rep('★',v),string.rep('★',I))end;function updateTextAreas(x,i)ui.updateTextArea(1,getText(i),x)
ui.updateTextArea(104,'<TI><a href="event:help">?</a>',x)end
function clear()for V,u in
ipairs(keys(jointData))do removeJoint(u)end;for G,f in
ipairs(keys(tfm.get.room.objectList))do removeObject(f)end;for J,B in
ipairs(keys(groundData))do removeGround(B)end;for S,P in
ipairs(keys(bulletData))do removeBullet(P)end;for G,r in
ipairs(keys(patternData))do removePattern(r)end end
function list_default(V,O,vY)V[#V+1]=string.format('%d %d\n',O,vY.time)end
function list_object(U,q,g)local _=tfm.get.room.objectList[q]if _==nil then
U[#U+1]=string.format('%d &lt;invalid&gt; %d\n',q,g.time)else
U[#U+1]=string.format('%d (%d, %d) %d\n',q,_.x,_.y,g.time)end end;function list_bullet(b,l,X)
b[#b+1]=string.format("%d %d %d\n",l,X.controls[#X.controls],X.time)end
function step(h,Z,H,D)local t={}local DO;if D==nil then
D=list_default end
for j,U in pairs(h)do D(H,j,U)DO=U.time
if DO==0 then if U.on_remove then
U.on_remove(j,U)end;t[#t+1]=j elseif DO>0 then U.time=DO-1;if U.callback then
U.callback(j,U)end elseif U.callback then U.callback(j,U)end end;for d,O in ipairs(t)do Z(O)end end
function clearT()local h={'<TI>'}h[#h+1]='--[Joints]--\n'
step(jointData,removeJoint,h)h[#h+1]='--[Objects]--\n'
step(objectData,removeObject,h,list_object)h[#h+1]='--[Grounds]--\n'step(groundData,removeGround,h)h[
#h+1]='--[Bullets]--\n'
step(bulletData,removeBullet,h,list_bullet)h[#h+1]='--[Patterns]--\n'
step(patternData,removePattern,h)
ui.addTextArea(2,table.concat(h),nil,-150,0,150,600,nil,nil,nil,true)end;function explode(R,n)local E=n.callback_args
addExplosion(E.x,E.y,E.power,E.distance,E.miceOnly,E.p1,E.p2)end
function explode1(w,P)
local D=P.callback_args
if D.t<=0 then
local d=randomKey1(tfm.get.room.playerList,P.user,true)local j,o=0,0;if d~=nil then local m=tfm.get.room.playerList[d]
j,o=m.x,m.y end
addExplosion(j,o,D.power,D.distance,D.miceOnly,D.p1,D.p2)D.t=D.cd else D.t=D.t-1 end end;function accelerate(i,g)local T=g.callback_args
moveObject(i,0,0,true,T.ax,T.ay,true)end
function moveHoming(I,w)
if
w.time<=7 and w.time>=5 then local T=w.callback_args
local R=tfm.get.room.playerList[T.target]
if R~=nil then local A=R.x;local N=R.y;local s=T.x;local t=T.y;A=A-s;N=N-t;local g=A*A+N*N;if g>0 then g=T.v/
math.sqrt(g)A=A*g;N=N*g end
moveObject(I,0,0,true,A,N,false)end end end
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
function removeBullet(u)local E=bulletData[u]for C,l in ipairs(E.joints)do do_removeJoint(l)
freeId(jointId,l)end;for p,i in ipairs(E.grounds)do
do_removeGround(i)freeId(groundId,i)end
bulletData[u]=nil;freeId(bulletId,u)end;bullet={}
bullet.circle=function(L,P,u,i,j)local K=string.format('%d,%d',L,P+1)
local h={type=0,point2=K,color=0xFFFFFF,line=2*u,foreground=true}
local A={type=13,width=u,height=u,miceCollision=true,groundCollision=false,dynamic=true,restitution=255}copy(A,j)local v=newId(groundId)do_addGround(v,L,P,A)local l={}
if i then for o,F in
ipairs(i)do copy(h,F)addJoint1(l,v,v,h)end end;return v,{v},l end
bullet.butterfly=function(e,T,F,x,l,TY,Z)local t=make_star(5,2)
local y={type=0,color=0xFFFFFF,alpha=0.25,line=t.l*x*2,foreground=true}
local p={type=0,point1=string.format('%d,%d',e,T),point2=string.format('%d,%d',e,T+1),color=0xFFFFFF,line=x*2,foreground=true}
local H={type=13,width=x,height=x,dynamic=true,miceCollision=true,groundCollision=false,restitution=255}copy(y,TY)copy(H,Z)local f={}local HK={}local A,_
local Q,sK=math.cos(F),math.sin(F)local P;local B=newId(groundId)do_addGround(B,e,T,H)
for i=2,5 do
P=t.points[i]A,_=P[1]*Q-P[2]*sK,P[1]*sK+P[2]*Q
A,_=e+x*A,T+x*_;y.point1=string.format('%d,%d',A,_)
y.point2=string.format('%d,%d',A,_+1)addJoint1(f,B,B,y)end
if l then for n,P in ipairs(l)do copy(p,P)addJoint1(f,B,B,p)end end;return B,{B},f end
bullet.jstar=function(v,g,k,U,l,X,f,b,vz)local A=make_star(l,X)
local d={type=0,color=0xFFFFFF,line=5,foreground=true}local r=U*A.r
local H={type=0,point1=string.format('%d,%d',v,g),point2=string.format('%d,%d',v,g+1),color=0xFFFFFF,line=r*2,foreground=true}
local cv={type=13,width=r,height=r,dynamic=true,miceCollision=true,groundCollision=false,restitution=255}copy(d,f)copy(H,b)copy(cv,vz)local x={}local q={}local t,O
local G,z=math.cos(k),math.sin(k)
for a,qH in ipairs(A.points)do
t,O=qH[1]*G-qH[2]*z,qH[1]*z+qH[2]*G;q[#q+1]=string.format('%d,%d',v+U*t,g+U*O)end;local qN=newId(groundId)do_addGround(qN,v,g,cv)
for i=1,l do d.point1=q[i]d.point2=q[
1+ (i+X-1)%l]addJoint1(x,qN,qN,d)end;addJoint1(x,qN,qN,H)return qN,{qN},x end
bullet.star=function(P,l,j,I,y,q,a,jP,S,qU)local IZ=make_star(y,q)
local K={type=12,height=1,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}local b=I*IZ.r
local v={type=13,width=b,height=b,color=0xFFFFFF,groundCollision=false,miceCollision=true,dynamic=true,foreground=true,restitution=255}
local u={type=13,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}b=string.format('%d,%d',P,l)
local as={type=3,point1=b,point2=b,ratio=1,limit1=0,limit2=0}local qK={type=0,frequency=10}copy(K,jP)copy(v,S)copy(u,qU)
local X,o,uF={},{},{}local O,R;local Y=j*180.0/math.pi
local oZ,H=math.cos(j),math.sin(j)for V,bt in ipairs(IZ.lines)do K.angle=bt.angle+Y;K.width=bt.width*I;O,R=bt.x*oZ-
bt.y*H,bt.x*H+bt.y*oZ
addGround1(X,P+I*O,l+I*R,K)end;if a then
for G,og in
ipairs(IZ.points)do O,R=og[1]*oZ-og[2]*H,og[1]*H+og[2]*oZ;addGround1(o,
P+I*O,l+I*R,u)end end
local KT=newId(groundId)do_addGround(KT,P,l,v)
if K.dynamic then local M,Ox=nil,nil
for i,w in ipairs(X)do
addJoint1(uF,w,KT,as)if M~=nil then addJoint1(uF,w,M,qK)else Ox=w end;M=w end;addJoint1(uF,Ox,M,qK)elseif v.dynamic then
for Sr,V in ipairs(X)do addJoint1(uF,V,KT,as)end end
if a then
if u.dynamic then local s,XD=nil,nil
for i=1,y do addJoint1(uF,o[i],X[i],as)if s~=nil then
addJoint1(uF,o[i],s,qK)else XD=o[i]end;s=o[i]end;addJoint1(uF,XD,s,qK)elseif K.dynamic then
for i=1,y do addJoint1(uF,o[i],X[i],as)end end end;append(X,o)X[#X+1]=KT;return KT,X,uF end
function bomb(K,j)
if j.bomb_cd==0 and not j.bombing then
if j.bombs>=j.bomb.cost then j.bombs=j.bombs-
j.bomb.cost;j.bombing=true;j.bombTime=j.bomb.time
j.bomb.func(K,j)addBomb(K,j)updateTextAreas(K,j)else
alert(string.format('bombs &lt; %d',j.bomb.cost),K)end end end
function addBomb(i,_)local K=bombs.top+1
local c=string.format('<TI><font color="#%X">%s <font color="#5F5F8D">|</font> %s</font>',_.color,i,_.bomb.name)_.bomb_id=K;bombs.top=K;bombs.val[K]=c;setShamanName(c)end
function removeBomb(I,C)local Q=C.bomb_id;C.bomb_id=nil;bombs.val[Q]=nil
if Q==bombs.top then Q=Q-1;while
bombs.val[Q]==nil and Q>0 do Q=Q-1 end;bombs.top=Q;if Q>0 then
Q=bombs.val[Q]else Q=''end;setShamanName(Q)end end
function motionEnd(f,fH)local U=fH.callback_args
if U._on_remove then U._on_remove(f,fH)end;do_removeControl(U._controls,f)end
function addControl(z,...)local j=addGround(...)local E=groundData[j]if E.callback_args==nil then
E.callback_args={_controls=z}else E.callback_args._on_remove=E.on_remove
E.callback_args._controls=z end
E.on_remove=motionEnd;z[#z+1]=j;return j end;function addControl1(B,...)return addGround(...)end
function addMotion(_,k,S,...)if S then
local M=bulletData[k]return _(addControl,bulletData[k].controls,...)else return
_(addControl1,{k},...)end end;motion={}
motion.line=function(z,T,Y,X,H,o,d)local U=0;local E=T[#T]
local EN={type=1,axis='-1,0',angle=0,forceMotor=255,speedMotor=1}copy(EN,H)
if not Y then
local f={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}U=z(T,o or 0,d or 0,f,X or 3)end;addJoint(E,U,EN,X or 3)end
motion.circle=function(l,B,U,yt,e,yZ,J)local c=0;local M=B[#B]local P={type=3,forceMotor=255,speedMotor=1}
copy(P,e)
if not U then
local u={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}c=l(B,yZ or 0,J or 0,u,yt or 3)end
if yZ and J then P.point1=string.format('%d,%d',yZ,J)end;addJoint(M,c,P,yt or 3)end
motion.spiral=function(w,u,yD,s,R,Y,v,O)motion.line(w,u,false,s,R,v,O)
motion.circle(w,u,yD,s,Y,v,O)end
function addBombTimer(M,S,s,H,L)local x=s.bombTime*L+2
local Ls={type=13,angle=0,color='0xFF0000',foreground=false,friction=0.0,restitution=2.0,width=x,height=x,miceCollision=false,groundCollision=H,dynamic=false}
addGround(S.x,S.y,Ls,s.bombTime,moveBombTimer,nil,{player=M,pdata=s,offset=2,scale=L,obj=Ls})x=x-2
Ls={type=13,angle=0,color='0x6A7495',foreground=false,friction=0.0,restitution=2.0,width=x,height=x,miceCollision=false,groundCollision=H,dynamic=false}
addGround(S.x,S.y,Ls,s.bombTime,moveBombTimer,nil,{player=M,pdata=s,offset=0,scale=L,obj=Ls})end
function moveBombTimer(o,W)local F=W.callback_args
local f=tfm.get.room.playerList[F.player]local i=F.pdata.bombTime*F.scale+F.offset
F.obj.width=i;F.obj.height=i;do_addGround(o,f.x,f.y,F.obj)end
function defaultBombCallback(a,J)local S=tfm.get.room.playerList[a]
local A=S.y+S.vy;local u;local Y,p;local f=J.bombCallbackArgs;local j=4;local AC=4;local JB=0;local D={ax=64,ay=0}AC=f*AC;D.ax=f*
D.ax;u=S.x+f*J.bombTime*5+10
for off=20,120,20 do
p=off*f;Y=u+p*1.5
addObject(objcode.anvil,Y,A-p,0,AC,-JB*f,false,j,accelerate,nil,D)
addObject(objcode.anvil,Y,A+p,0,AC,JB*f,false,j,accelerate,nil,D)JB=JB+1 end end
function defaultBomb(X,e)local O=tfm.get.room.playerList[X]
if
not O.isFacingRight then e.bombCallbackArgs=-1 else e.bombCallbackArgs=1 end;addBombTimer(X,O,e,true,5)end
function bomb2(r,Q)local X=tfm.get.room.playerList[r]local XJ,h=X.x,X.y
local F=string.format('%d,%d',XJ,h)
local o={type=12,color=0xFFFFFF,foreground=true,width=512,height=8,dynamic=true,mass=8,restitution=255,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=true}
local rv={type=13,color=0xFFFFFF,width=32,height=32,dynamic=false,groundCollision=false,miceCollision=false,foreground=true}local l={type=3,point1=F,point2=nil,forceMotor=255,speedMotor=2}
local d={type=3,point1=F,point2=F,ratio=1,limit1=0,limit2=8}local lJ={type=0,frequency=10}local oQ;local e;local a,u;local ow,C
local Z=32.0+o.width/2.0;local j=20;local dp=nil;local O=nil;local W,R;addBombTimer(r,X,Q,true,5)
R=addGround(XJ,h,rv,j)
for oQ=0,359,120 do e=oQ*math.pi/180.0;a,u=math.cos(e),math.sin(e)ow,C=
XJ+Z*a,h+Z*u;o.angle=oQ;W=addGround(ow,C,o,j)
addJoint(W,R,l,j)
if O~=nil then addJoint(W,O,d,j)addJoint(W,O,lJ,j)else dp=W end;O=W end;addJoint(dp,W,d,j)addJoint(dp,W,lJ,j)end
function bomb3(l,P)local u=tfm.get.room.playerList[l]local k,t=u.x,u.y
local Q=string.format('%d,%d',k,t)
local QJ={type=13,color=0xFFFFFF,width=64,height=64,dynamic=true,mass=1,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=false,foreground=true}
local F={type=1,axis='-1,0',forceMotor=255,speedMotor=2,limit1=0,limit2=5}local o;local z;local PL,p;local x,oJ;local xP=64.0+QJ.width;local O=5;local q;local s
addBombTimer(l,u,P,true,10)
local pc={[0]=0.15,[60]=0.13,[120]=0.11,[180]=0.075,[240]=0.05,[300]=0}
for o=0,359,60 do z=o*math.pi/180.0;x,oJ=math.cos(z),math.sin(z)PL,p=k+xP*
x,t+xP*oJ
s={x=k+math.cos(z+pc[o])*280,y=t+math.sin(
z+pc[o])*280,power=127,distance=3*QJ.width,miceOnly=false,p1=particles.red_spirit,p2=nil}q=addGround(PL,p,QJ,O,nil,explode,s)
F.angle=2.0*math.pi-z;addJoint(q,0,F,O)end end
function pattern(A,X,k,x,r)local h=X.patterns[k][x]
if h~=nil then local b=#h.points+1
if b>=
h.type.points then local D=os.time()
if D-h.lastTime>=h.type.cd then h.lastTime=D
h.points[b]=r;addPattern(A,X,h.type,h.points)h.points={}end else h.points[b]=r end end end
function bind(b,r,bq,rb)local d=playerData[b]local s=d.patterns[r]if s[bq]~=nil then
do_unbind(d,s[bq],r,bq)end
s[bq]={id=rb,type=patternTypes[rb],points={},lastTime=0}s=d.pattern_data[rb]
if r=='key'then bindKey(b,bq,true,true)end
if s==nil then d.pattern_data[rb]={binds=1}else s.binds=s.binds+1 end end
function do_unbind(y,o,_,b)local K=y.pattern_data[o.id]if K.binds<=1 then
y.pattern_data[o.id]=nil else K.binds=K.binds-1 end;y.patterns[_][b]=
nil end
function unbind(x,y,i)local g=playerData[x]
if y==nil then g.patterns={key={},obj={},objend={}}
g.pattern_data={}elseif i==nil then local f={}
for d,F in pairs(g.patterns[y])do f[#f+1]={d,F}end;for u,N in ipairs(f)do do_unbind(g,N[2],y,N[1])end else
local O=g.patterns[y][i]if O~=nil then do_unbind(g,O,y,i)end end end
function testPattern(d,z,x,p)local C=p[1]local u=6;local y=48;local o=math.random(2,8)local e,I,t;local W=
C.angle*math.pi/180.0
for i=0,u-1 do
e=W+2.0*math.pi*i/u;I,t=math.cos(e),math.sin(e)addObject(C.type,C.x+y*I,C.y+y*t,C.angle+360*i/u,
o*I,o*t,false,9)end end
function testPattern1(k,w,a,wY)local M=wY[1]local wE=math.random(8,16)local sX,i,B;local I;local a
for i=1,wE do
I=math.random(64,96)sX=math.random()*2.0*math.pi
i,B=math.cos(sX),math.sin(sX)
a=addBullet(bullet.butterfly,8,nil,nil,nil,M.x+I*i,M.y+I*B,0.25-math.pi/2.0,16,{{color=randomColor()},{line=24,color=0xFFFFFF}},{line=24,alpha=0.5,color=randomColor()},{width=0,height=0})
addMotion(motion.line,a,true,true,2,{speedMotor=math.random(2,6),angle=2*math.pi-sX})end end
function shoot(C,F)
if F.shot_cd==0 then if F.bombing and F.bomb.shot~=nil then
F.shot_cd=F.bomb.shot.cd;F.bomb.shot.func(C,F)else F.shot_cd=F.shot.cd
F.shot.func(C,F)end end end
function defaultShot(C,Q)local j=tfm.get.room.playerList[C]local t,s=j.x,j.y;local tB;if
j.isFacingRight then tB=-1 else tB=1 end;local M=math.random()*math.pi
local _=addBullet(bullet.jstar,8,
nil,nil,nil,t+64*math.cos(M),s+64*math.sin(M),0,16,5,2,{color=randomColor()},
nil,nil)M=math.random()*math.pi+math.pi
local R=addBullet(bullet.jstar,8,
nil,nil,nil,t+64*math.cos(M),s+64*math.sin(M),0,16,5,2,{color=randomColor()},
nil,nil)
addMotion(motion.circle,_,true,true,math.random(1,4),{speedMotor=4*tB},t,s)
addMotion(motion.circle,R,true,true,math.random(1,4),{speedMotor=-4*tB},t,s)end
function homingShot(R,i)
local yS=randomKey1(tfm.get.room.playerList,R,false)local S=tfm.get.room.playerList[R]local iv=S.x;local h=S.y;local N=2
local B=2;local z=false;if not S.isFacingRight then N=-N end;iv=iv+16*N
local n={target=yS,x=iv,y=h+32,v=128}
addObject(objcode.anvil,iv+N,h+B,0,N,B,z,10,moveHoming,nil,n)local n={target=yS,x=iv,y=h-32,v=128}
addObject(objcode.anvil,iv+N,h-B,0,N,-B,z,10,moveHoming,nil,n)end
function initPlayer(n)
local c={color=randomColor(),shooting=false,bombing=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},spawn={200,200},lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}if playerConfig[n]==nil then playerConfig[n]={}end
copy(c,playerConfig[n])playerData[n]=c;for g,K in pairs(playerKeys)do bindKey(n,K,true,true)
bindKey(n,K,false,true)end
ui.addTextArea(1,getText(c),n,5,25,151,40,nil,nil,nil,true)
ui.addTextArea(104,'<TI><a href="event:help">?</a>',n,145,25,11,20,nil,nil,nil,true)do_respawn(n)setShaman(n)
setNameColor(n,playerData[n].color)end
function resetPlayer(e)
local S={shooting=false,bombing=false,bombTime=nil,lives=5,bombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}local M=playerData[e]copy(M,S)updateTextAreas(e,M)
do_respawn(e)setShaman(e)setNameColor(e,M.color)end;function deletePlayer(n)local N=playerData[n]if N.bombing then removeBomb(n,N)end;playerData[n]=
nil end
function respawn(x)
do_respawn(x)setNameColor(x,playerData[x].color)end;playerData={}objectData={}groundData={}jointData={}patternData={}bulletData={}
playerKeys={32,83,40,100,101,102,104,65,68,69,81,37,39}reservedKeys=invert(playerKeys,true)
eventCode={key=keycode,obj=objcode,objend=objcode}
defaultMap='<C><P defilante="0,0,0,1" L="1600" H="800" G="0,0" /><Z><S /><D><DS Y="200" X="200" /></D><O /></Z></C>'maxLives=8;maxBombs=6
shotTypes={{func=defaultShot,cd=1},{func=homingShot,cd=2}}
bombTypes={{name='default bomb',func=defaultBomb,callback=defaultBombCallback,shot={func=nop,cd=1},cost=1,time=20,cd=0},{name='',func=bomb2,callback=
nil,shot={func=nop,cd=1},cost=1,time=20,cd=5},{name='',func=bomb3,callback=nil,shot={func=nop,cd=1},cost=1,time=6,cd=5}}
patternTypes={{func=testPattern,time=0,callback=nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern1,time=0,callback=
nil,cd=500,points=1,maxBinds=3,restrict={key=nil,obj=nil,objend=nil}}}
playerConfig={Cafecafe={bomb=bombTypes[3],color='0xB06FFD'}}MODULE_HELP_START='Keys'
MODULE_HELP_CONTENTS=[[<font face="mono" size="15"><a href="event:Keys">Keys</a>
<a href="event:Commands">Commands</a>
<a href="event:Shot types">Shot types</a>
<a href="event:Bomb types">Bomb types</a>
<a href="event:Pattern types">Pattern types</a>
<a href="event:Shaman objects">Shaman objects</a>
]]
MODULE_HELP={['Keys']=[[<font face="mono" size="15">Shoot - E
Bomb  - Q
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
]],['Pattern types']=[[<font face="mono" size="15">1 - 
    Cooldown: 0.25s
    Max. binds: 3
    Points: 1

2 - 
    Cooldown: 0.5s
    Max. binds: 3
    Points: 1
</font>
]]}
MODULE_HELP_CLOSE='<TI><a href="event:help_close"><p align="center">X</p></a>'
do
local m=function(P,N)local f={'<font face="mono" size="15">'}local g;for c,F in ipairs(keys1(P))do
g=N-#F;if g>0 then c=F..string.rep(' ',g)else c=F end
f[#f+1]=string.format('%s = %4d\n',c,P[F])end
f[#f+1]='</font>'return table.concat(f)end;MODULE_HELP['Shaman objects']=m(objcode,15)end
MODULE_CHAT_COMMAND={['help']=help,['clear']=clear,['color']=function(g,m,K)K=string.upper(K)
if K==''or K=='RANDOM'or K==
'RND'then setColor(g,randomColor())playerConfig[g].color=
nil else local C=tonumber(K)if C~=nil then if C>0xFFFFFF then C=0xFFFFFF end
setColor(g,K)playerConfig[g].color=K else
alert('Invalid color: '..K,g)end end end,['reset']=function(r,ru,A)
A=string.lower(A)if A==''or A=='map'then setMap(defaultMap)else
parsePlayerNames(r,A,resetPlayer)end end,['init']=function(M,Z,o)local v=function(M)
deletePlayer(M)initPlayer(M)end
parsePlayerNames(M,o,v)end,['respawn']=function(S,u,z)
parsePlayerNames(S,z,respawn)end,['shot']=function(Y,Z,A)local o=tonumber(A)if o==nil then
alert('Invalid shot type: '..A,Y)return end;o=shotTypes[o]
if o~=nil then
playerData[Y].shot=o else alert('Invalid shot type: '..A,Y)end end,['bomb']=function(y,p,yR)
local r=tonumber(yR)
if r==nil then alert('Invalid bomb type: '..yR,y)return end;r=bombTypes[r]if r~=nil then playerData[y].bomb=r else
alert('Invalid bomb type: '..yR,y)end end,['bind']=function(r,D,W)
W=split(W)if#W<3 then alert('Too few arguments',r)return elseif#W>3 then
alert('Too many arguments',r)return end
i=tonumber(W[1])local L=patternTypes[i]if i==nil or L==nil then
alert('Invalid pattern: '..W[1],r)return end;j=W[2]
if j~='key'and j~='obj'and
j~='objend'then alert('Invalid event: '..j,r)return end;local Q=tonumber(W[3])
if Q==nil then Q=eventCode[j][W[3]]if Q==nil then
alert(string.format('Invalid %s name/code: %s',j,W[3]),r)return end end;if
L.restrict[j]~=nil and L.restrict[j][Q]==nil then
alert(string.format('Can\'t bind pattern %d to %s %d: restricted',i,j,Q),r)return end;if
j=='key'and reservedKeys[Q]then
alert(string.format('Can\'t bind pattern %d to %s %d: reserved',i,j,Q),r)return end
local v=playerData[r]local y=v.pattern_data[i]if y~=nil and L.maxBinds<=y.binds then
alert(string.format('Can\'t bind pattern %d to more than %d events',i,L.maxBinds),r)return end
bind(r,j,Q,i)end,['unbind']=function(g,c,b)
b=split(b)if#b>2 then alert('Too many arguments',g)return end
i=b[1]
if i=='all'or i==nil then unbind(g)elseif
i~='key'and i~='obj'and i~='objend'then alert('Invalid event: '..i,g)return else
if b[2]==nil then
unbind(g,i)else j=tonumber(b[2])
if j==nil then j=eventCode[i][b[2]]if j==nil then
alert(string.format('Invalid %s name/code: %s',i,b[2]),g)return end end;unbind(g,i,j)end end end,['map']=function(P,B,M)if
M==''then M=defaultMap end;setMap(M)end}
MODULE_CHAT_COMMAND_1=function(d,i,m)alert('Invalid command: '..i,d)end;eventNewPlayer=initPlayer;eventPlayerLeft=deletePlayer
eventTextAreaCallback=helpTextAreaCallback
function eventNewGame()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)tfm.exec.setGameTime(0)objectData={}groundData={}
jointData={}patternData={}bulletData={}bombs={top=0,val={}}groundId={max=0,free={}}
jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}for O,H in
pairs(tfm.get.room.playerList)do resetPlayer(O)end
setMapName('<TI>')setShamanName('')
do_addGround(0,0,0,{type=13,width=10,height=10,color=0xFFFFFF,dynamic=false,miceCollision=false,groundCollision=false})end
function eventKeyboard(xZ,c,h,M,G)
if reservedKeys[c]then
if c==65 then local n=playerData[xZ]if h then bomb(xZ,n)end elseif c==
69 then local U=playerData[xZ]U.shooting=h;if h then shoot(xZ,U)end else local z=0
local i=0
if not h then
if
c==32 or c==104 or c==83 or c==40 or c==53 or c==101 then
movePlayer(xZ,0,0,true,0,1,false)movePlayer(xZ,0,0,true,0,-1,true)else
movePlayer(xZ,0,0,true,1,0,false)movePlayer(xZ,0,0,true,-1,0,true)end else
if c==32 or c==104 or c==87 then z=-50 elseif c==83 or c==40 or c==101 then z=50 elseif c==
100 then i=-50 elseif c==102 then i=50 end
if i~=0 or z~=0 then movePlayer(xZ,0,0,true,i,z,false)end end end elseif h then local j=playerData[xZ]pattern(xZ,j,'key',c,{x=M,y=G})end end;function eventSummoningStart(b,P,G,O,A)local i={x=G,y=O,angle=A,type=P}
pattern(b,playerData[b],'obj',P,i)end
function eventSummoningEnd(P,U,D,n,Q,O,UN,o,v)
objectData[o.id]={time=3}local Y={x=D,y=n,angle=Q,type=U,vx=O,vy=UN,data=o,other=v}
pattern(P,playerData[P],'objend',U,Y)end
function eventMouse(u,R,X)local q=tfm.get.room.playerList[u]end
function eventPlayerDied(B)local H=playerData[B]
if H~=nil then
if H.bombing then respawn(B)else H.shot_cd=0
H.bomb_cd=0;H.shooting=false;H.lives=H.lives-1;if H.lives>0 then H.bombs=H.resetBombs
updateTextAreas(B,H)respawn(B)else
alert(string.format('playerData["%s"].lives &lt;= 0',B),B)end end end end
function eventLoop(D,v)local t,A,W,V,s,h,L,_;clearT()
for Ww,Ap in pairs(playerData)do
t=tfm.get.room.playerList[Ww]
if not t.isDead then A=t.x;W=t.y;if A<0 then A=10 elseif A>4800 then A=4790 end;if W<0 then W=10 elseif W>1600 then
W=1590 end;Ap.spawn[0]=A;Ap.spawn[1]=W;V=-t.vx
s=-t.vy;h=-t.vx/10;L=-t.vy/10
for _=1,math.random(8,16)do
addParticle(particles.purple,A+math.random(-
4,4),W+math.random(-4,4),(
V+math.random()*2-1)/_,
(s+math.random()*2-1)/_,h,L)end end;if Ap.shot_cd>0 then Ap.shot_cd=Ap.shot_cd-1 end;if
Ap.bomb_cd>0 then Ap.bomb_cd=Ap.bomb_cd-1 end;if Ap.shooting then
shoot(Ww,Ap)end
if Ap.bombing then Ap.bombTime=Ap.bombTime-1
if Ap.bombTime<=0 then
Ap.bombing=false;Ap.bomb_cd=Ap.bomb.cd;removeBomb(Ww,Ap)else if Ap.bomb.callback then
Ap.bomb.callback(Ww,Ap)end end end end end
for kK,c in pairs(tfm.get.room.playerList)do initPlayer(kK)end;setMap(defaultMap)