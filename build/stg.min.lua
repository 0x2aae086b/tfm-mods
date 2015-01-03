do_addObject=tfm.exec.addShamanObject
do_removeObject=tfm.exec.removeObject;do_addGround=tfm.exec.addPhysicObject
do_removeGround=tfm.exec.removePhysicObject;do_addJoint=tfm.exec.addJoint;do_removeJoint=tfm.exec.removeJoint
do_respawn=tfm.exec.respawnPlayer;do_addExplosion=tfm.exec.explosion
addParticle=tfm.exec.displayParticle;setShaman=tfm.exec.setShaman
setShamanName=tfm.exec.setUIShamanName;setMapName=tfm.exec.setUIMapName
setNameColor=tfm.exec.setNameColor;movePlayer=tfm.exec.movePlayer;moveObject=tfm.exec.moveObject
setMap=tfm.exec.newGame;bindKey=tfm.exec.bindKeyboard;kill=tfm.exec.killPlayer;function nop()end;function to_table(a)
if
a==nil or type(a)=='table'then return a else return{a}end end;function alert(X,f)
ui.addPopup(0,0,string.format('<font face="mono" size="15">%s</font>',X),f,200,150,400,true)end;function randomColor()return
math.random(0x000000,0xFFFFFF)end;function rotate(d,v,A,K,g,G)d,v=d-A,v-K;d,v=d*g-v*G,
d*G+v*g;return A+d,K+v end
function length1(r)return math.sqrt(
r.x*r.x+r.y*r.y)end
function cache2(M)local i={}return
function(Z,w)local n=i[Z]local v=nil;if n==nil then n={}i[Z]=n else v=n[w]end;if v==nil then
v=M(Z,w)n[w]=v end;return v end end;function split(i)local j={}for I in string.gmatch(i,'[^%s]+')do j[#j+1]=I end
return j end
function parsePlayerNames(u,Q,D)local I={}local d
for O,C in
pairs(split(string.lower(Q)))do
if string.sub(C,1,1)=='!'then C=string.sub(C,2)d=nil else d=true end
if C=='me'then I[u]=d elseif C=='all'then for O,C in pairs(playerData)do I[O]=d end else
C=string.gsub(C,'^%l',string.upper)if playerData[C]==nil then
alert('Invalid player: '..C,u)return else I[C]=d end end end;for U,Y in pairs(I)do D(U)end end;unescape_map={a='\a',b='\b',f='\f',n='\n',r='\r',t='\t'}
function do_unescape(_,S)local w=tonumber(
_..S)if w==nil then
return(unescape_map[_]or _)..S else return string.char(w)end end
function unescape(a)return string.gsub(a,'\\(.)(%d?%d?)',do_unescape)end;function do_unpack(u,H,i)
if H<=i then return u[H],do_unpack(u,H+1,i)else return nil end end;function unpack(w,q)if q==nil then q=#w end;return
do_unpack(w,1,q)end;function length(m)local H=0
for g in pairs(m)do H=H+1 end;return H end;function copy(w,g)if g~=nil then
for C,c in pairs(g)do w[C]=c end end end;function append(H,L)for d,R in ipairs(L)do H[#H+
1]=R end end;function invert(n,w)local T={}
if w==nil then for A,p in
pairs(n)do T[p]=A end else for c,L in pairs(n)do T[L]=w end end;return T end
function keys(R)
local W={}for N,D in pairs(R)do W[#W+1]=N end;return W end;function keys1(m)local c=keys(m)table.sort(c)return c end
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
function eventChatCommand(L,l)local O,B;local x,s;for c,n in ipairs({{'&lt;','<'},{'&amp;','&'}})do
l=string.gsub(l,n[1],n[2])end
while true do
O,B=string.find(l,'%s+')
if O==nil then x=l;s=''break elseif O==1 then l=string.sub(l,B+1)if l==''then x=''s=''break end else x=string.sub(l,1,
O-1)s=string.sub(l,B+1)break end end;local K=string.lower(x)local D=MODULE_CHAT_COMMAND[K]if D~=nil then
D(L,K,s)else MODULE_CHAT_COMMAND_1(L,x,s)end end
function setColor(y,o)setNameColor(y,o)playerData[y].color=o end
function tbl_name(z)
if z==groundId then return'groundId'elseif z==jointId then return'jointId'elseif z==bulletId then return'bulletId'elseif z==
patternId then return'patternId'elseif z==objectData then return'objectData'elseif z==groundData then return'groundData'elseif z==
jointData then return'jointData'elseif z==bulletData then return'bulletData'elseif z==patternData then
return'patternData'end;return'&lt;other&gt;'end
function make_line(B,v)local C,s=v[1]-B[1],v[2]-B[2]return
{width=math.sqrt(C*C+s*s),angle=
math.atan2(s,C)*180.0/math.pi,x=(B[1]+v[1])/2,y=(B[2]+v[2])/2}end
make_star=cache2(function(l,v)local M={}local S={}for i=1,l do a=math.pi*2*i/l
M[#M+1]={math.cos(a),math.sin(a)}end;for i=1,l do
S[#S+1]=make_line(M[i],M[1+ (i+v-1)%l])end;local n=length1(S[1])return
{lines=S,points=M,r=n,l=math.sqrt(1-n*n)}end)
keycode={backspace=8,enter=13,shift=16,ctrl=17,alt=18,capslock=20,esc=27,space=32,['0']=48,['1']=49,['2']=50,['3']=51,['4']=52,['5']=53,['6']=54,['7']=55,['8']=56,['9']=57,a=81,b=66,c=67,d=68,e=69,f=70,g=71,h=72,i=73,j=74,k=75,l=76,m=77,n=78,o=79,p=80,q=65,r=82,s=83,t=84,u=85,v=86,w=90,x=88,y=89,z=87,[';']=186,['=']=187,[',']=188,['-']=189,['.']=190,['/']=191,['`']=192,[':']=186,['+']=187,['<']=188,['_']=189,['>']=190,['?']=191,['~']=192,['[']=219,['\\']=220,[']']=221,["'"]=222,['{']=219,['|']=220,['}']=221,['"']=222,[')']=48,['!']=49,['@']=50,['#']=51,['$']=52,['%']=53,['^']=54,['&']=55,['*']=56,['(']=57,kp0=96,kp1=97,kp2=98,kp3=99,kp4=100,kp5=101,kp6=102,kp7=103,kp8=104,kp9=105,['kp*']=106,['kp+']=107,['kp-']=109,['kp.']=110,['kp/']=111,left=37,up=38,right=39,down=40,f1=112,f2=113,f3=114,f4=115,f5=116,f6=117,f7=118,f8=119,f9=120,f10=121,f11=122,f12=123}
particles={white=0,purple=1,orange=2,soft_white=4,teal=9,yellow=11,red=13,spawn=3,heart=5,red_heart=30,pink_heart=31,bubble=6,bubble1=7,bubble2=8,water=14,spirit=10,red_spirit=12,plus1=15,plus10=16,plus12=17,plus14=18,plus16=19,meep=20,red_confetti=21,green_confetti=22,blue_confetti=23,yellow_confetti=24,rain=25,wind=26,wind1=27,lightning=28,star=29,flower=32}
objcode={arrow=0,small_box=1,box=2,small_plank=3,plank=4,ball=6,trampoline=7,anvil=10,anvil1=1002,B=11,Bc=12,Bcc=13,V=14,Vc=15,Vcc=16,cannon_up=17,cannon_down=18,cannon_right=19,cannon_left=20,C=22,bomb=23,spirit=24,cheese=25,blue_portal=26,orange_portal=27,balloon1=2806,balloon=28,red_balloon=29,green_balloon=30,yellow_balloon=31,rune=32,snow=34,arrow1=35,apple=39,sheep=40,demolition=41,totem=44,ice_plank=45,choco_plank=46,cloud=57,architect=58,bubble=59,tiny_plank=60,companion_crate=61,stable_rune=62,ballon_anchor=66,windmill_anchor=88}copy(objcode,tfm.enum.shamanObject)
function addError(v,I)
I=string.format("• %s\n",I)local x=#errors;if x==MAX_ERRORS then for i=3,x do errors[i]=errors[i-1]end
errors[2]=I else errors[x+1]=I end
ui.addTextArea(3,table.concat(errors),
nil,805,5,200,590,nil,nil,0.5,true)end
function getText(i)local V=i.lives-1;local u=i.bombs
if V>=maxLives then V=maxLives-1 end;if V<0 then V=0 end;if u>maxBombs then u=maxBombs elseif u<0 then u=0 end;if i.lives<1 then
l=0 else l=i.lives end;return
string.format('<TI><N>Player  <R>%s<N>\nBomb  <VP>%s',string.rep('★',V),string.rep('★',u))end;function updateTextAreas(G,f)ui.updateTextArea(1,getText(f),G)
ui.updateTextArea(104,'<TI><a href="event:help">?</a>',G)end
function clear()for J,B in
ipairs(keys(jointData))do removeJoint(B)end;for S,P in
ipairs(keys(tfm.get.room.objectList))do removeObject(P)end;for G,r in
ipairs(keys(groundData))do removeGround(r)end;for V,O in
ipairs(keys(bulletData))do removeBullet(O)end;for Y,U in
ipairs(keys(patternData))do removePattern(U)end end
function list_default(q,g,_)q[#q+1]=string.format('%d %d\n',g,_.time)end
function list_object(b,l,X)local h=tfm.get.room.objectList[l]if h==nil then
b[#b+1]=string.format('%d &lt;invalid&gt; %d\n',l,X.time)else
b[#b+1]=string.format('%d (%d, %d) %d\n',l,h.x,h.y,X.time)end end;function list_bullet(Z,H,D)
Z[#Z+1]=string.format("%d %d %d\n",H,D.controls[#D.controls],D.time)end
function step(D,O,j,U)local d={}local h;local R,n;if U==nil then
U=list_default end
for E,w in pairs(D)do U(j,E,w)h=w.time
if h==0 then
if w.on_remove then
for P,o in ipairs(w.on_remove)do
R,n=pcall(o,E,w)if not R then
addError(nil,string.format("step(%s): on_remove[%d]: %s\n",tbl_name(D),P,n))end end end;d[#d+1]=E elseif h>0 then w.time=h-1
if w.callback then
for m,i in ipairs(w.callback)do R,n=pcall(i,E,w)if not R then
addError(
nil,string.format("step(%s): callback[%d]: %s\n",tbl_name(D),m,n))d[#d+1]=E;break end end end elseif w.callback then
for g,T in ipairs(w.callback)do R,n=pcall(T,E,w)if not R then
addError(nil,string.format("step(%s): callback[%d]: %s\n",tbl_name(D),g,n))d[#d+1]=E;break end end end end;for I,w in ipairs(d)do O(w)end end
function clearT()local T={'<TI>'}T[#T+1]='<p align="center">Joints</p>'
step(jointData,removeJoint,T)T[#T+1]='<p align="center">Objects</p>'
step(objectData,removeObject,T,list_object)T[#T+1]='<p align="center">Grounds</p>'
step(groundData,removeGround,T)T[#T+1]='<p align="center">Bullets</p>'
step(bulletData,removeBullet,T,list_bullet)T[#T+1]='<p align="center">Patterns</p>'
step(patternData,removePattern,T)
ui.addTextArea(2,table.concat(T),nil,-155,5,150,590,nil,nil,0.5,true)end;function explode(R,A)local N=A.callback_args
addExplosion(N.x,N.y,N.power,N.distance,N.miceOnly,N.p1,N.p2)end
function explode1(s,t)
local g=t.callback_args
if g.t<=0 then
local E=randomKey1(tfm.get.room.playerList,t.user,true)local O,_=0,0;if E~=nil then local A=tfm.get.room.playerList[E]
O,_=A.x,A.y end
addExplosion(O,_,g.power,g.distance,g.miceOnly,g.p1,g.p2)g.t=g.cd else g.t=g.t-1 end end;function accelerate(c,U)local _=U.callback_args
moveObject(c,0,0,true,_.ax,_.ay,true)end
function moveHoming(E,x)
if
x.time<=7 and x.time>=5 then local R=x.callback_args
local Q=tfm.get.room.playerList[R.target]
if Q~=nil then local v=Q.x;local P=Q.y;local O=R.x;local X=R.y;v=v-O;P=P-X;local s=v*v+P*P;if s>0 then s=R.v/
math.sqrt(s)v=v*s;P=P*s end
moveObject(E,0,0,true,v,P,false)end end end
function newId(Z)local r=Z.free;local t,B=pairs(r)(r)
if t then r[t]=nil;return t else if Z.max==MAX_ID then
error(string.format("newId: %s.max == MAX_ID",tbl_name(Z)))end;Z.max=Z.max+1;return Z.max end end
function freeId(l,Y)local e=l.free;if Y==l.max then local g=l.max-1;while e[g]do e[g]=nil;g=g-1 end;l.max=g else
e[Y]=true end end
function addObject(J,_,t,x,h,i,W,a,b,m,c)local p=do_addObject(J,_,t,x,h,i,W)if a==nil then a=3 end
objectData[p]={time=a,callback=to_table(b),on_remove=to_table(m),callback_args=c}return p end
function removeObject(q)do_removeObject(q)objectData[q]=nil end
function addGround(O,s,c,T,o,F,i)local D=newId(groundId)do_addGround(D,O,s,c)
if T==nil then T=3 end
groundData[D]={time=T,callback=to_table(o),on_remove=to_table(F),callback_args=i}return D end;function removeGround(k)do_removeGround(k)groundData[k]=nil
freeId(groundId,k)end
function addJoint(J,K,D,R,i,S,o)local w=newId(jointId)
do_addJoint(w,J,K,D)if R==nil then R=-1 end;if D==nil then D={}end
jointData[w]={time=R,callback=to_table(i),on_remove=to_table(S),callback_args=o}return w end
function removeJoint(m)do_removeJoint(m)jointData[m]=nil;freeId(jointId,m)end
function addPattern(G,e,j,U)local N=nil;if j.time~=nil then N=newId(patternId)
patternData[N]={time=j.time,callback=j.callback,on_remove=j.on_remove}end
j.func(G,e,N,U)return N end
function removePattern(y)patternData[y]=nil;freeId(patternId,y)end
function addExplosion(n,B,K,a,Q,L,y)if L~=nil then addParticle(L,n,B,0,0,0,0)end
if y~=nil then end;do_addExplosion(n,B,K,a,Q)end
function addGround1(a,D,p,M)local J=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=J;do_addGround(J,D,p,M)a[#a+1]=J end
function addJoint1(k,P,u,E)local C=newId(jointId)
_tmp_joints[#_tmp_joints+1]=C;do_addJoint(C,P,u,E)k[#k+1]=C end;function do_addControl(l,p)l[#l+1]=p end;function do_removeControl(i,L)local P=#i;while P>0 and i[P]~=L do
i[P]=nil;P=P-1 end end
function addBullet(u,i,j,K,h,...)
local A=newId(bulletId)_tmp_grounds={}_tmp_joints={}local v,l,o,F=pcall(u,...)
if v then
bulletData[A]={controls={l},grounds=o,joints=F,time=i or 6,callback=to_table(j),on_remove=to_table(K),callback_args=h}else for e,T in ipairs(_tmp_joints)do removeJoint(T)end;for x,T in
ipairs(_tmp_grounds)do removeGround(T)end;freeId(bulletId,A)
error(string.format('addBullet: %s',l))end;return A end
function removeBullet(Y)local Z=bulletData[Y]for t,y in ipairs(Z.joints)do do_removeJoint(y)
freeId(jointId,y)end;for p,H in ipairs(Z.grounds)do
do_removeGround(H)freeId(groundId,H)end
bulletData[Y]=nil;freeId(bulletId,Y)end;bullet={}
bullet.rectangle=function(f,H,K,A,_,Q,s)local P,B=math.cos(K),math.sin(K)local n=A/2.0
local v={type=0,point1=string.format("%d,%d",f,H),point2=string.format("%d,%d",
f+P*A,H+B*A),color=0xFF0000,line=2.0*_+4,foreground=false}
local g={type=12,width=A,height=_,angle=K*180.0/math.pi,color=0xFFFFFF,miceCollision=true,groundCollision=false,foreground=true,dynamic=true,restitution=255}copy(g,s)local k=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=k;do_addGround(k,f+P*n,H+B*n,g)local U={}if Q then for l,X in ipairs(Q)do copy(v,X)
addJoint1(U,k,k,v)end end;return k,{k},U end
bullet.circle=function(f,b,v,z,A)local d=string.format('%d,%d',f,b+1)
local r={type=0,point2=d,color=0x0000FF,line=2*v,foreground=false}
local H={type=13,width=v,height=v,miceCollision=true,groundCollision=false,dynamic=true,restitution=255,color=0xFFFFFF}copy(H,A)local c=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=c;do_addGround(c,f,b,H)local x={}if z then for q,t in ipairs(z)do copy(r,t)
addJoint1(x,c,c,r)end end;return c,{c},x end
bullet.butterfly=function(O,G,z,q,N,a,H)local P=make_star(5,2)
local l={type=0,color=0xFF00FF,alpha=0.25,line=P.l*q*2,foreground=false}
local j={type=0,point1=string.format('%d,%d',O,G),point2=string.format('%d,%d',O,G+1),color=0x0000FF,line=q*2,foreground=false}
local I={type=13,width=q,height=q,dynamic=true,miceCollision=true,groundCollision=false,restitution=255,color=0xFFFFFF}copy(l,a)copy(I,H)local y={}local S={}local U,Z
local K,b=math.cos(z),math.sin(z)local u;local s=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=s;do_addGround(s,O,G,I)
for i=2,5 do u=P.points[i]U,Z=u[1]*K-u[2]*b,u[1]*b+
u[2]*K;U,Z=O+q*U,G+q*Z
l.point1=string.format('%d,%d',U,Z)l.point2=string.format('%d,%d',U,Z+1)
addJoint1(y,s,s,l)end;copy(j,N)addJoint1(y,s,s,j)return s,{s},y end
bullet.jstar=function(q,K,X,o,u,F,O,R,Y)local Z=make_star(u,F)
local H={type=0,color=0xFFFFFF,line=5,foreground=true}local T=o*Z.r
local V={type=0,point1=string.format('%d,%d',q,K),point2=string.format('%d,%d',q,K+1),color=0xFFFFFF,line=T*2,foreground=true}
local b={type=13,width=T,height=T,dynamic=true,miceCollision=true,groundCollision=false,restitution=255}copy(H,O)copy(V,R)copy(b,Y)local t={}local G={}local g,M
local x,i=math.cos(X),math.sin(X)
for S,r in ipairs(Z.points)do g,M=r[1]*x-r[2]*i,r[1]*i+r[2]*x;G[#G+1]=string.format('%d,%d',
q+o*g,K+o*M)end;local w=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=w;do_addGround(w,q,K,b)for i=1,u do H.point1=G[i]
H.point2=G[1+ (i+F-1)%u]addJoint1(t,w,w,H)end
addJoint1(t,w,w,V)return w,{w},t end
bullet.star=function(V,s,X,D,K,j,i,_,c,I)local C=make_star(K,j)
local Q={type=12,height=1,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}local f=D*C.r
local H={type=13,width=f,height=f,color=0xFFFFFF,groundCollision=false,miceCollision=true,dynamic=true,foreground=true,restitution=255}
local U={type=13,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}f=string.format('%d,%d',V,s)
local z={type=3,point1=f,point2=f,ratio=1,limit1=0,limit2=0}local E={type=0,frequency=10}copy(Q,_)copy(H,c)copy(U,I)
local B,k,S={},{},{}local M,T;local Y=X*180.0/math.pi
local o,d=math.cos(X),math.sin(X)
for l,y in ipairs(C.lines)do Q.angle=y.angle+Y;Q.width=y.width*D;M,T=y.x*o-y.y*d,
y.x*d+y.y*o;addGround1(B,V+D*M,s+D*T,Q)end;if i then
for t,e in ipairs(C.points)do M,T=e[1]*o-e[2]*d,e[1]*d+e[2]*o;addGround1(k,
V+D*M,s+D*T,U)end end
local N=newId(groundId)_tmp_grounds[#_tmp_grounds+1]=N
do_addGround(N,V,s,H)
if Q.dynamic then local y,Z=nil,nil;for J,P in ipairs(B)do addJoint1(S,P,N,z)if y~=nil then
addJoint1(S,P,y,E)else Z=P end;y=P end
addJoint1(S,Z,y,E)elseif H.dynamic then for u,w in ipairs(B)do addJoint1(S,w,N,z)end end
if i then
if U.dynamic then local u,y=nil,nil
for i=1,K do addJoint1(S,k[i],B[i],z)if u~=nil then
addJoint1(S,k[i],u,E)else y=k[i]end;u=k[i]end;addJoint1(S,y,u,E)elseif Q.dynamic then
for i=1,K do addJoint1(S,k[i],B[i],z)end end end;append(B,k)B[#B+1]=N;return N,B,S end
function bomb(D,s)
if s.bomb_cd==0 and not s.bombing then
if s.bombs>=s.bomb.cost then s.bombs=s.bombs-
s.bomb.cost;s.bombing=true;s.bombTime=s.bomb.time
local R,Y=pcall(s.bomb.func,D,s)addBomb(D,s)updateTextAreas(D,s)if not R then
addError(D,string.format("bomb: %s: %s",D,Y))end else
alert(string.format('bombs &lt; %d',s.bomb.cost),D)end end end
function addBomb(v,O)local M=bombs.top+1
local S=string.format('<TI><font color="#%X">%s <font color="#5F5F8D">|</font> %s</font>',O.color,v,O.bomb.name)O.bomb_id=M;bombs.top=M;bombs.val[M]=S;setShamanName(S)end
function removeBomb(s,H)local L=H.bomb_id;H.bomb_id=nil;bombs.val[L]=nil
if L==bombs.top then L=L-1;while
bombs.val[L]==nil and L>0 do L=L-1 end;bombs.top=L;if L>0 then
L=bombs.val[L]else L=''end;setShamanName(L)end end;function motionEnd(x,L)
do_removeControl(L.callback_args._controls,x)end
function addControl(s,...)local o=addGround(...)
local W=groundData[o]if W.callback_args==nil then W.callback_args={_controls=s}else
W.callback_args._controls=s end
if W.on_remove==nil then
W.on_remove=motionEnd else W.on_remove[#W.on_remove+1]=motionEnd end;s[#s+1]=o;return o end;function addControl1(F,...)return addGround(...)end
function addMotion(f,i,a,...)local J;local S;if a then
J=bulletData[i].controls;S=addControl else J={i}S=addControl1 end
local A,u=pcall(f,S,J,...)if not A then
error(string.format("addMotion: %s",u))end end;motion={}
motion.line=function(Y,p,f,j,A,C,J)local B=0;local D=p[#p]
local X={type=1,axis='-1,0',angle=0,forceMotor=255,speedMotor=1}copy(X,A)
if not f then
local e={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}B=Y(p,C or 0,J or 0,e,j or 3)end;addJoint(D,B,X,j or 3)end
motion.circle=function(O,r,Q,X,J,h,F)local o=0;local v=r[#r]local l={type=3,forceMotor=255,speedMotor=1}
copy(l,J)
if not Q then
local d={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}o=O(r,h or 0,F or 0,d,X or 3)end
if h and F then l.point1=string.format('%d,%d',h,F)end;addJoint(v,o,l,X or 3)end
motion.spiral=function(l,J,o,Q,e,a,u,w)motion.line(l,J,false,Q,e,u,w)
motion.circle(l,J,o,Q,a,u,w)end
function addBombTimer(C,Z,j,d,p)local O=j.bombTime*p+2
local W={type=13,angle=0,color='0xFF0000',foreground=false,friction=0.0,restitution=2.0,width=O,height=O,miceCollision=false,groundCollision=d,dynamic=false}
addGround(Z.x,Z.y,W,j.bombTime,moveBombTimer,nil,{player=C,pdata=j,offset=2,scale=p,obj=W})O=O-2
W={type=13,angle=0,color='0x6A7495',foreground=false,friction=0.0,restitution=2.0,width=O,height=O,miceCollision=false,groundCollision=d,dynamic=false}
addGround(Z.x,Z.y,W,j.bombTime,moveBombTimer,nil,{player=C,pdata=j,offset=0,scale=p,obj=W})end
function moveBombTimer(R,l)local P=l.callback_args
local u=tfm.get.room.playerList[P.player]local k=P.pdata.bombTime*P.scale+P.offset
P.obj.width=k;P.obj.height=k;do_addGround(R,u.x,u.y,P.obj)end
function defaultBombCallback(t,Q)local J=tfm.get.room.playerList[t]
local F=J.y+J.vy;local o;local z,P;local L=Q.bombCallbackArgs;local p=4;local x=4;local O=0;local q={ax=64,ay=0}x=L*x
q.ax=L*q.ax;o=J.x+L*Q.bombTime*5+10
for off=20,120,20 do P=off*L
z=o+P*1.5
addObject(objcode.anvil,z,F-P,0,x,-O*L,false,p,accelerate,nil,q)
addObject(objcode.anvil,z,F+P,0,x,O*L,false,p,accelerate,nil,q)O=O+1 end end
function defaultBomb(s,p)local c=tfm.get.room.playerList[s]
if
not c.isFacingRight then p.bombCallbackArgs=-1 else p.bombCallbackArgs=1 end;addBombTimer(s,c,p,true,5)end
function bomb2(A,X)local k=tfm.get.room.playerList[A]local r,h=k.x,k.y
local b=string.format('%d,%d',r,h)
local D={type=12,color=0xFFFFFF,foreground=true,width=512,height=8,dynamic=true,mass=8,restitution=255,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=true}
local q={type=13,color=0xFFFFFF,width=32,height=32,dynamic=false,groundCollision=false,miceCollision=false,foreground=true}local d={type=3,point1=b,point2=nil,forceMotor=255,speedMotor=2}
local s={type=3,point1=b,point2=b,ratio=1,limit1=0,limit2=8}local o={type=0,frequency=10}local _;local K;local i,g;local f,F
local u=32.0+D.width/2.0;local N=20;local O=nil;local z=nil;local x,p;addBombTimer(A,k,X,true,5)
p=addGround(r,h,q,N)
for _=0,359,120 do K=_*math.pi/180.0;i,g=math.cos(K),math.sin(K)f,F=r+
u*i,h+u*g;D.angle=_;x=addGround(f,F,D,N)addJoint(x,p,d,N)
if z~=
nil then addJoint(x,z,s,N)addJoint(x,z,o,N)else O=x end;z=x end;addJoint(O,x,s,N)addJoint(O,x,o,N)end
function bomb3(C,u)local o=tfm.get.room.playerList[C]local e,I=o.x,o.y
local t=string.format('%d,%d',e,I)
local W={type=13,color=0xFFFFFF,width=64,height=64,dynamic=true,mass=1,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=false,foreground=true}
local k={type=1,axis='-1,0',forceMotor=255,speedMotor=2,limit1=0,limit2=5}local w;local Y;local M,E;local s,X;local i=64.0+W.width;local B=5;local F;local Q
addBombTimer(C,o,u,true,10)
local j={[0]=0.15,[60]=0.13,[120]=0.11,[180]=0.075,[240]=0.05,[300]=0}
for w=0,359,60 do Y=w*math.pi/180.0;s,X=math.cos(Y),math.sin(Y)M,E=e+i*s,
I+i*X
Q={x=e+math.cos(Y+j[w])*280,y=I+
math.sin(Y+j[w])*280,power=127,distance=3*W.width,miceOnly=false,p1=particles.red_spirit,p2=nil}F=addGround(M,E,W,B,nil,explode,Q)
k.angle=2.0*math.pi-Y;addJoint(F,0,k,B)end end
function pattern(t,s,B,M,_)local R=s.patterns[B][M]
if R~=nil then local i=#R.points+1
if i>=
R.type.points then local y=os.time()
if y-R.lastTime>=R.type.cd then R.lastTime=y
R.points[i]=_;local S,v=pcall(addPattern,t,s,R.type,R.points)R.points={}if not S then
addError(t,string.format("pattern: %s: %s",t,v))end end else R.points[i]=_ end end end
function bind(h,N,B,z)local n=playerData[h]local c=n.patterns[N]if c[B]~=nil then
do_unbind(n,c[B],N,B)end
c[B]={id=z,type=patternTypes[z],points={},lastTime=0}c=n.pattern_data[z]
if N=='key'then bindKey(h,B,true,true)end
if c==nil then n.pattern_data[z]={binds=1}else c.binds=c.binds+1 end end
function do_unbind(g,K,e,S)local M=g.pattern_data[K.id]if M.binds<=1 then
g.pattern_data[K.id]=nil else M.binds=M.binds-1 end;g.patterns[e][S]=
nil end
function unbind(n,N,x)local m=playerData[n]
if N==nil then m.patterns={key={},obj={},objend={}}
m.pattern_data={}elseif x==nil then local P={}
for f,g in pairs(m.patterns[N])do P[#P+1]={f,g}end;for c,F in ipairs(P)do do_unbind(m,F[2],N,F[1])end else
local g=m.patterns[N][x]if g~=nil then do_unbind(m,g,N,x)end end end
function testPattern(m,K,C,r)local u=r[1]local A=6;local M=48;local Z=math.random(2,8)local o,v,S;local z=
u.angle*math.pi/180.0
for i=0,A-1 do
o=z+2.0*math.pi*i/A;v,S=math.cos(o),math.sin(o)addObject(u.type,u.x+M*v,u.y+M*S,u.angle+360*i/A,
Z*v,Z*S,false,9)end end
function testPattern1(Y,Z,A,o)local y=o[1]local p=math.random(8,16)local R,D,W;local L;local A
for i=1,p do
L=math.random(64,96)R=math.random()*2.0*math.pi
D,W=math.cos(R),math.sin(R)
A=addBullet(bullet.butterfly,8,nil,nil,nil,y.x+L*D,y.y+L*W,0.25-math.pi/2.0,16,{color=randomColor()},{line=24,alpha=0.5,color=randomColor()},{width=0,height=0,color=0xFFFFFF})
addMotion(motion.line,A,true,true,2,{speedMotor=math.random(2,6),angle=2*math.pi-R})end end
function testPattern2(Q,v,y,g)local c=g[1]
addBullet(bullet.rectangle,8,nil,nil,nil,c.x,c.y,c.angle*math.pi/180.0,math.random(200,400),13,{{color=randomColor()}},{dynamic=false})end
function shoot(b,P)
if P.shot_cd==0 then
if P.bombing and P.bomb.shot~=nil then
P.shot_cd=P.bomb.shot.cd;local B,M=pcall(P.bomb.shot.func,b,P)if not B then
addError(b,string.format("shoot(bombing): %s: %s",b,M))end else P.shot_cd=P.shot.cd
local d,i=pcall(P.shot.func,b,P)if not d then
addError(b,string.format("shoot: %s: %s",b,i))end end end end
function defaultShot(m,O)local H=tfm.get.room.playerList[m]local Z,c=H.x,H.y;local h;if
H.isFacingRight then h=-1 else h=1 end;local M=math.random()*math.pi
local G=addBullet(bullet.jstar,8,
nil,nil,nil,Z+64*math.cos(M),c+64*math.sin(M),0,16,5,2,{color=randomColor()},
nil,nil)M=math.random()*math.pi+math.pi
local n=addBullet(bullet.jstar,8,
nil,nil,nil,Z+64*math.cos(M),c+64*math.sin(M),0,16,5,2,{color=randomColor()},
nil,nil)
addMotion(motion.circle,G,true,true,math.random(1,4),{speedMotor=4*h},Z,c)
addMotion(motion.circle,n,true,true,math.random(1,4),{speedMotor=-4*h},Z,c)end
function homingShot(U,z)
local i=randomKey1(tfm.get.room.playerList,U,false)local j=tfm.get.room.playerList[U]local b=j.x;local P=j.y;local G=2
local O=2;local A=false;if not j.isFacingRight then G=-G end;b=b+16*G
local D={target=i,x=b,y=P+32,v=128}
addObject(objcode.anvil,b+G,P+O,0,G,O,A,10,moveHoming,nil,D)local D={target=i,x=b,y=P-32,v=128}
addObject(objcode.anvil,b+G,P-O,0,G,-O,A,10,moveHoming,nil,D)end
function initPlayer(n)
local Q={color=randomColor(),shooting=false,bombing=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},spawn={200,200},vx=0,lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}if playerConfig[n]==nil then playerConfig[n]={}end
copy(Q,playerConfig[n])playerData[n]=Q;for O,U in pairs(playerKeys)do bindKey(n,U,true,true)
bindKey(n,U,false,true)end
ui.addTextArea(1,getText(Q),n,5,25,151,40,nil,nil,0.5,true)
ui.addTextArea(104,'<TI><a href="event:help">?</a>',n,145,25,11,20,nil,nil,0.0,true)
ui.addTextArea(3,table.concat(errors),n,805,5,200,590,nil,nil,0.5,true)do_respawn(n)setShaman(n)
setNameColor(n,playerData[n].color)end
function resetPlayer(N)
local o={shooting=false,bombing=false,bombTime=nil,lives=5,bombs=3,shot_cd=0,bomb_cd=0,vx=0,bomb_id=nil}local v=playerData[N]copy(v,o)updateTextAreas(N,v)
do_respawn(N)setShaman(N)setNameColor(N,v.color)end;function deletePlayer(Y)local u=playerData[Y]if u.bombing then removeBomb(Y,u)end;playerData[Y]=
nil end
function respawn(R)
do_respawn(R)setNameColor(R,playerData[R].color)end;playerData={}objectData={}groundData={}jointData={}patternData={}bulletData={}
errors={'<TI><p align="center">Errors</p>'}MAX_ID=499;MAX_ERRORS=7
playerKeys={32,83,40,100,101,102,104,65,68,69,81,37,39}reservedKeys=invert(playerKeys,true)
eventCode={key=keycode,obj=objcode,objend=objcode}
defaultMap='<C><P defilante="0,0,0,1" L="1600" H="800" G="0,0" /><Z><S /><D><DS Y="200" X="200" /></D><O /></Z></C>'maxLives=8;maxBombs=6
shotTypes={{func=defaultShot,cd=1},{func=homingShot,cd=2}}
bombTypes={{name='default bomb',func=defaultBomb,callback=defaultBombCallback,shot={func=nop,cd=1},cost=1,time=20,cd=0},{name='',func=bomb2,callback=
nil,shot={func=nop,cd=1},cost=1,time=20,cd=5},{name='',func=bomb3,callback=nil,shot={func=nop,cd=1},cost=1,time=6,cd=5}}
patternTypes={{func=testPattern,time=0,callback=nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern1,time=0,callback=
nil,cd=500,points=1,maxBinds=3,restrict={key=nil,obj=nil,objend=nil}},{func=testPattern2,time=0,callback=
nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}}}
playerConfig={Cafecafe={bomb=bombTypes[2],color=0x9852B4}}MODULE_HELP_START='Keys'
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
local X=function(q,B)local H={'<font face="mono" size="15">'}local D;for t,A in ipairs(keys1(q))do
D=B-#A;if D>0 then t=A..string.rep(' ',D)else t=A end
H[#H+1]=string.format('%s = %4d\n',t,q[A])end
H[#H+1]='</font>'return table.concat(H)end;MODULE_HELP['Shaman objects']=X(objcode,15)end
MODULE_CHAT_COMMAND={['help']=help,['clear']=clear,['color']=function(W,V,s)s=string.upper(s)
if s==''or s=='RANDOM'or s==
'RND'then setColor(W,randomColor())playerConfig[W].color=
nil else local h=tonumber(s)if h~=nil then if h>0xFFFFFF then h=0xFFFFFF end
setColor(W,s)playerConfig[W].color=s else
alert('Invalid color: '..s,W)end end end,['reset']=function(L,_,W)
W=string.lower(W)if W==''or W=='map'then setMap(defaultMap)else
parsePlayerNames(L,W,resetPlayer)end end,['init']=function(w,A,p)local k=function(w)
deletePlayer(w)initPlayer(w)end
parsePlayerNames(w,p,k)end,['respawn']=function(K,c,o)
parsePlayerNames(K,o,respawn)end,['shot']=function(L,E,g)local d=tonumber(g)if d==nil then
alert('Invalid shot type: '..g,L)return end;d=shotTypes[d]
if d~=nil then
playerData[L].shot=d else alert('Invalid shot type: '..g,L)end end,['bomb']=function(k,l,c)
local J=tonumber(c)
if J==nil then alert('Invalid bomb type: '..c,k)return end;J=bombTypes[J]if J~=nil then playerData[k].bomb=J else
alert('Invalid bomb type: '..c,k)end end,['bind']=function(h,H,d)
d=split(d)if#d<3 then alert('Too few arguments',h)return elseif#d>3 then
alert('Too many arguments',h)return end
i=tonumber(d[1])local A=patternTypes[i]if i==nil or A==nil then
alert('Invalid pattern: '..d[1],h)return end;j=d[2]
if j~='key'and j~='obj'and
j~='objend'then alert('Invalid event: '..j,h)return end;local y=tonumber(d[3])
if y==nil then y=eventCode[j][d[3]]if y==nil then
alert(string.format('Invalid %s name/code: %s',j,d[3]),h)return end end;if
A.restrict[j]~=nil and A.restrict[j][y]==nil then
alert(string.format('Can\'t bind pattern %d to %s %d: restricted',i,j,y),h)return end;if
j=='key'and reservedKeys[y]then
alert(string.format('Can\'t bind pattern %d to %s %d: reserved',i,j,y),h)return end
local E=playerData[h]local Y=E.pattern_data[i]if Y~=nil and A.maxBinds<=Y.binds then
alert(string.format('Can\'t bind pattern %d to more than %d events',i,A.maxBinds),h)return end
bind(h,j,y,i)end,['unbind']=function(O,D,I)
I=split(I)if#I>2 then alert('Too many arguments',O)return end
i=I[1]
if i=='all'or i==nil then unbind(O)elseif
i~='key'and i~='obj'and i~='objend'then alert('Invalid event: '..i,O)return else
if I[2]==nil then
unbind(O,i)else j=tonumber(I[2])
if j==nil then j=eventCode[i][I[2]]if j==nil then
alert(string.format('Invalid %s name/code: %s',i,I[2]),O)return end end;unbind(O,i,j)end end end,['map']=function(y,R,c)if
c==''then c=defaultMap end;setMap(c)end}
MODULE_CHAT_COMMAND_1=function(n,E,b)alert('Invalid command: '..E,n)end;eventNewPlayer=initPlayer;eventPlayerLeft=deletePlayer
eventTextAreaCallback=helpTextAreaCallback
function eventNewGame()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)tfm.exec.setGameTime(0)objectData={}groundData={}
jointData={}patternData={}bulletData={}bombs={top=0,val={}}groundId={max=0,free={}}
jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}for N,F in
pairs(tfm.get.room.playerList)do resetPlayer(N)end
setMapName('<TI>')setShamanName('')
do_addGround(0,0,0,{type=13,width=10,height=10,color=0xFFFFFF,dynamic=false,miceCollision=false,groundCollision=false})end
function eventKeyboard(O,t,M,s,b)
if reservedKeys[t]then
if t==65 then local w=playerData[O]if M then bomb(O,w)end elseif t==69 then
local j=playerData[O]j.shooting=M;if M then shoot(O,j)end else local S=0;local G=0
if not M then
if

t==32 or t==104 or t==83 or t==40 or t==53 or t==101 then movePlayer(O,0,0,true,0,1,false)
movePlayer(O,0,0,true,0,-1,true)else movePlayer(O,0,0,true,1,0,false)
movePlayer(O,0,0,true,-1,0,true)playerData[O].vx=0 end else
if t==32 or t==104 or t==87 then S=-50 elseif t==83 or t==40 or t==101 then S=50 elseif t==
100 or t==37 or t==81 then G=-50 elseif t==102 or t==39 or t==68 then G=50 end;if G~=0 then playerData[O].vx=G elseif t==83 or t==40 then
G=playerData[O].vx end;if G~=0 or S~=0 then
movePlayer(O,0,0,true,G,S,false)end end end elseif M then local i=playerData[O]pattern(O,i,'key',t,{x=s,y=b})end end;function eventSummoningStart(e,Q,b,L,A)local w={x=b,y=L,angle=A,type=Q}
pattern(e,playerData[e],'obj',Q,w)end
function eventSummoningEnd(C,J,l,o,B,G,k,K,S)
objectData[K.id]={time=3}local g={x=l,y=o,angle=B,type=J,vx=G,vy=k,data=K,other=S}
pattern(C,playerData[C],'objend',J,g)end
function eventMouse(F,l,Q)local a=tfm.get.room.playerList[F]end
function eventPlayerDied(z)local y=playerData[z]
if y~=nil then
if y.bombing then respawn(z)else y.shot_cd=0
y.bomb_cd=0;y.shooting=false;y.lives=y.lives-1;if y.lives>0 then y.bombs=y.resetBombs
updateTextAreas(z,y)respawn(z)else
alert(string.format('playerData["%s"].lives &lt;= 0',z),z)end end end end
function eventLoop(K,p)local w,a,F,R,c,u,e,s;clearT()
for n,h in pairs(playerData)do
w=tfm.get.room.playerList[n]
if not w.isDead then a=w.x;F=w.y;if a<0 then a=10 elseif a>4800 then a=4790 end;if F<0 then F=10 elseif F>1600 then
F=1590 end;h.spawn[0]=a;h.spawn[1]=F;R=-w.vx;c=-w.vy;u=-
w.vx/10;e=-w.vy/10
for s=1,math.random(8,16)do
addParticle(particles.purple,a+
math.random(-4,4),F+math.random(-4,4),
(R+math.random()*2-1)/s,(c+math.random()*2-1)/s,u,e)end end;if h.shot_cd>0 then h.shot_cd=h.shot_cd-1 end;if h.bomb_cd>0 then h.bomb_cd=
h.bomb_cd-1 end
if h.shooting then shoot(n,h)end
if h.bombing then h.bombTime=h.bombTime-1
if h.bombTime<=0 then h.bombing=false
h.bomb_cd=h.bomb.cd;removeBomb(n,h)else if h.bomb.callback then
local L,Z=pcall(h.bomb.callback,n,h)
if not L then addError(n,'bomb.callback: '..Z)end end end end end end
for E,W in pairs(tfm.get.room.playerList)do initPlayer(E)end;setMap(defaultMap)