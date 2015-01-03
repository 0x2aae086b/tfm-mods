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
bullet.circle=function(f,H,K,A,_)local Q=string.format('%d,%d',f,H+1)
local s={type=0,point2=Q,color=0x0000FF,line=2*K,foreground=false}
local P={type=13,width=K,height=K,miceCollision=true,groundCollision=false,dynamic=true,restitution=255,color=0xFFFFFF}copy(P,_)local B=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=B;do_addGround(B,f,H,P)local n={}if A then for g,k in ipairs(A)do copy(s,k)
addJoint1(n,B,B,s)end end;return B,{B},n end
bullet.butterfly=function(U,l,X,f,b,v,z)local A=make_star(5,2)
local d={type=0,color=0xFF00FF,alpha=0.25,line=A.l*f*2,foreground=false}
local r={type=0,point1=string.format('%d,%d',U,l),point2=string.format('%d,%d',U,l+1),color=0x0000FF,line=f*2,foreground=false}
local H={type=13,width=f,height=f,dynamic=true,miceCollision=true,groundCollision=false,restitution=255,color=0xFFFFFF}copy(d,v)copy(H,z)local x={}local q={}local t,O
local G,N=math.cos(X),math.sin(X)local a;local P=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=P;do_addGround(P,U,l,H)
for i=2,5 do a=A.points[i]t,O=a[1]*G-a[2]*N,a[1]*N+
a[2]*G;t,O=U+f*t,l+f*O
d.point1=string.format('%d,%d',t,O)d.point2=string.format('%d,%d',t,O+1)
addJoint1(x,P,P,d)end
if b then for j,a in ipairs(b)do copy(r,a)addJoint1(x,P,P,r)end end;return P,{P},x end
bullet.jstar=function(I,q,a,j,P,S,U,Z,K)local b=make_star(P,S)
local v={type=0,color=0xFFFFFF,line=5,foreground=true}local u=j*b.r
local X={type=0,point1=string.format('%d,%d',I,q),point2=string.format('%d,%d',I,q+1),color=0xFFFFFF,line=u*2,foreground=true}
local o={type=13,width=u,height=u,dynamic=true,miceCollision=true,groundCollision=false,restitution=255}copy(v,U)copy(X,Z)copy(o,K)local F={}local O={}local R,Y
local H,T=math.cos(a),math.sin(a)
for t,G in ipairs(b.points)do R,Y=G[1]*H-G[2]*T,G[1]*T+G[2]*H;O[#O+1]=string.format('%d,%d',
I+j*R,q+j*Y)end;local V=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=V;do_addGround(V,I,q,o)for i=1,P do v.point1=O[i]
v.point2=O[1+ (i+S-1)%P]addJoint1(F,V,V,v)end
addJoint1(F,V,V,X)return V,{V},F end
bullet.star=function(o,g,M,O,x,i,w,S,r,V)local X=make_star(x,i)
local D={type=12,height=1,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}local K=O*X.r
local j={type=13,width=K,height=K,color=0xFFFFFF,groundCollision=false,miceCollision=true,dynamic=true,foreground=true,restitution=255}
local _={type=13,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}K=string.format('%d,%d',o,g)
local I={type=3,point1=K,point2=K,ratio=1,limit1=0,limit2=0}local C={type=0,frequency=10}copy(D,S)copy(j,r)copy(_,V)
local Q,f,H={},{},{}local U,z;local E=M*180.0/math.pi
local B,k=math.cos(M),math.sin(M)
for Y,d in ipairs(X.lines)do D.angle=d.angle+E;D.width=d.width*O;U,z=d.x*B-d.y*k,
d.x*k+d.y*B;addGround1(Q,o+O*U,g+O*z,D)end;if w then
for N,l in ipairs(X.points)do U,z=l[1]*B-l[2]*k,l[1]*k+l[2]*B;addGround1(f,
o+O*U,g+O*z,_)end end
local T=newId(groundId)_tmp_grounds[#_tmp_grounds+1]=T
do_addGround(T,o,g,j)
if D.dynamic then local y,t=nil,nil;for e,Z in ipairs(Q)do addJoint1(H,Z,T,I)if y~=nil then
addJoint1(H,Z,y,C)else t=Z end;y=Z end
addJoint1(H,t,y,C)elseif j.dynamic then for J,c in ipairs(Q)do addJoint1(H,c,T,I)end end
if w then
if _.dynamic then local P,u=nil,nil
for i=1,x do addJoint1(H,f[i],Q[i],I)if P~=nil then
addJoint1(H,f[i],P,C)else u=f[i]end;P=f[i]end;addJoint1(H,u,P,C)elseif D.dynamic then
for i=1,x do addJoint1(H,f[i],Q[i],I)end end end;append(Q,f)Q[#Q+1]=T;return T,Q,H end
function bomb(w,u)
if u.bomb_cd==0 and not u.bombing then
if u.bombs>=u.bomb.cost then u.bombs=u.bombs-
u.bomb.cost;u.bombing=true;u.bombTime=u.bomb.time
local y,D=pcall(u.bomb.func,w,u)addBomb(w,u)updateTextAreas(w,u)if not y then
addError(w,string.format("bomb: %s: %s",w,D))end else
alert(string.format('bombs &lt; %d',u.bomb.cost),w)end end end
function addBomb(s,R)local Y=bombs.top+1
local v=string.format('<TI><font color="#%X">%s <font color="#5F5F8D">|</font> %s</font>',R.color,s,R.bomb.name)R.bomb_id=Y;bombs.top=Y;bombs.val[Y]=v;setShamanName(v)end
function removeBomb(O,M)local S=M.bomb_id;M.bomb_id=nil;bombs.val[S]=nil
if S==bombs.top then S=S-1;while
bombs.val[S]==nil and S>0 do S=S-1 end;bombs.top=S;if S>0 then
S=bombs.val[S]else S=''end;setShamanName(S)end end;function motionEnd(s,H)
do_removeControl(H.callback_args._controls,s)end
function addControl(L,...)local x=addGround(...)
local s=groundData[x]if s.callback_args==nil then s.callback_args={_controls=L}else
s.callback_args._controls=L end
if s.on_remove==nil then
s.on_remove=motionEnd else s.on_remove[#s.on_remove+1]=motionEnd end;L[#L+1]=x;return x end;function addControl1(o,...)return addGround(...)end
function addMotion(W,F,f,...)local i;local a;if f then
i=bulletData[F].controls;a=addControl else i={F}a=addControl1 end
local J,S=pcall(W,a,i,...)if not J then
error(string.format("addMotion: %s",S))end end;motion={}
motion.line=function(A,u,Y,p,f,j,C)local J=0;local B=u[#u]
local D={type=1,axis='-1,0',angle=0,forceMotor=255,speedMotor=1}copy(D,f)
if not Y then
local X={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}J=A(u,j or 0,C or 0,X,p or 3)end;addJoint(B,J,D,p or 3)end
motion.circle=function(e,O,r,Q,X,J,h)local F=0;local o=O[#O]local v={type=3,forceMotor=255,speedMotor=1}
copy(v,X)
if not r then
local l={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}F=e(O,J or 0,h or 0,l,Q or 3)end
if J and h then v.point1=string.format('%d,%d',J,h)end;addJoint(o,F,v,Q or 3)end
motion.spiral=function(d,l,J,o,Q,e,a,u)motion.line(d,l,false,o,Q,a,u)
motion.circle(d,l,J,o,e,a,u)end
function addBombTimer(o,w,C,Z,j)local d=C.bombTime*j+2
local p={type=13,angle=0,color='0xFF0000',foreground=false,friction=0.0,restitution=2.0,width=d,height=d,miceCollision=false,groundCollision=Z,dynamic=false}
addGround(w.x,w.y,p,C.bombTime,moveBombTimer,nil,{player=o,pdata=C,offset=2,scale=j,obj=p})d=d-2
p={type=13,angle=0,color='0x6A7495',foreground=false,friction=0.0,restitution=2.0,width=d,height=d,miceCollision=false,groundCollision=Z,dynamic=false}
addGround(w.x,w.y,p,C.bombTime,moveBombTimer,nil,{player=o,pdata=C,offset=0,scale=j,obj=p})end
function moveBombTimer(O,W)local R=W.callback_args
local l=tfm.get.room.playerList[R.player]local P=R.pdata.bombTime*R.scale+R.offset
R.obj.width=P;R.obj.height=P;do_addGround(O,l.x,l.y,R.obj)end
function defaultBombCallback(u,k)local t=tfm.get.room.playerList[u]
local Q=t.y+t.vy;local J;local F,o;local z=k.bombCallbackArgs;local P=4;local L=4;local p=0;local x={ax=64,ay=0}L=z*L
x.ax=z*x.ax;J=t.x+z*k.bombTime*5+10
for off=20,120,20 do o=off*z
F=J+o*1.5
addObject(objcode.anvil,F,Q-o,0,L,-p*z,false,P,accelerate,nil,x)
addObject(objcode.anvil,F,Q+o,0,L,p*z,false,P,accelerate,nil,x)p=p+1 end end
function defaultBomb(o,J)local x=tfm.get.room.playerList[o]
if
not x.isFacingRight then J.bombCallbackArgs=-1 else J.bombCallbackArgs=1 end;addBombTimer(o,x,J,true,5)end
function bomb2(P,O)local q=tfm.get.room.playerList[P]local s,p=q.x,q.y
local c=string.format('%d,%d',s,p)
local A={type=12,color=0xFFFFFF,foreground=true,width=512,height=8,dynamic=true,mass=8,restitution=255,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=true}
local X={type=13,color=0xFFFFFF,width=32,height=32,dynamic=false,groundCollision=false,miceCollision=false,foreground=true}local k={type=3,point1=c,point2=nil,forceMotor=255,speedMotor=2}
local r={type=3,point1=c,point2=c,ratio=1,limit1=0,limit2=8}local h={type=0,frequency=10}local b;local D;local d,o;local _,K
local x=32.0+A.width/2.0;local y=20;local i=nil;local g=nil;local f,F;addBombTimer(P,q,O,true,5)
F=addGround(s,p,X,y)
for b=0,359,120 do D=b*math.pi/180.0;d,o=math.cos(D),math.sin(D)_,K=s+
x*d,p+x*o;A.angle=b;f=addGround(_,K,A,y)addJoint(f,F,k,y)
if g~=
nil then addJoint(f,g,r,y)addJoint(f,g,h,y)else i=f end;g=f end;addJoint(i,f,r,y)addJoint(i,f,h,y)end
function bomb3(u,N)local O=tfm.get.room.playerList[u]local d,z=O.x,O.y
local p=string.format('%d,%d',d,z)
local C={type=13,color=0xFFFFFF,width=64,height=64,dynamic=true,mass=1,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=false,foreground=true}
local o={type=1,axis='-1,0',forceMotor=255,speedMotor=2,limit1=0,limit2=5}local e;local I;local t,W;local k,w;local a=64.0+C.width;local Y=5;local M;local E
addBombTimer(u,O,N,true,10)
local s={[0]=0.15,[60]=0.13,[120]=0.11,[180]=0.075,[240]=0.05,[300]=0}
for e=0,359,60 do I=e*math.pi/180.0;k,w=math.cos(I),math.sin(I)t,W=d+a*k,
z+a*w
E={x=d+math.cos(I+s[e])*280,y=z+
math.sin(I+s[e])*280,power=127,distance=3*C.width,miceOnly=false,p1=particles.red_spirit,p2=nil}M=addGround(t,W,C,Y,nil,explode,E)
o.angle=2.0*math.pi-I;addJoint(M,0,o,Y)end end
function pattern(X,i,B,I,C)local F=i.patterns[B][I]
if F~=nil then local Q=#F.points+1
if Q>=
F.type.points then local j=os.time()
if j-F.lastTime>=F.type.cd then F.lastTime=j
F.points[Q]=C;local t,s=pcall(addPattern,X,i,F.type,F.points)F.points={}if not t then
addError(X,string.format("pattern: %s: %s",X,s))end end else F.points[Q]=C end end end
function bind(t,B,M,_)local R=playerData[t]local i=R.patterns[B]if i[M]~=nil then
do_unbind(R,i[M],B,M)end
i[M]={id=_,type=patternTypes[_],points={},lastTime=0}i=R.pattern_data[_]
if B=='key'then bindKey(t,M,true,true)end
if i==nil then R.pattern_data[_]={binds=1}else i.binds=i.binds+1 end end
function do_unbind(y,S,i,v)local h=y.pattern_data[S.id]if h.binds<=1 then
y.pattern_data[S.id]=nil else h.binds=h.binds-1 end;y.patterns[i][v]=
nil end
function unbind(N,B,z)local n=playerData[N]
if B==nil then n.patterns={key={},obj={},objend={}}
n.pattern_data={}elseif z==nil then local c={}
for g,K in pairs(n.patterns[B])do c[#c+1]={g,K}end;for e,S in ipairs(c)do do_unbind(n,S[2],B,S[1])end else
local M=n.patterns[B][z]if M~=nil then do_unbind(n,M,B,z)end end end
function testPattern(n,N,x,m)local P=m[1]local f=6;local g=48;local F=math.random(2,8)local K,C,r;local u=
P.angle*math.pi/180.0
for i=0,f-1 do
K=u+2.0*math.pi*i/f;C,r=math.cos(K),math.sin(K)addObject(P.type,P.x+g*C,P.y+g*r,P.angle+360*i/f,
F*C,F*r,false,9)end end
function testPattern1(A,M,Z,o)local v=o[1]local S=math.random(8,16)local u,z,Y;local y;local Z
for i=1,S do
y=math.random(64,96)u=math.random()*2.0*math.pi
z,Y=math.cos(u),math.sin(u)
Z=addBullet(bullet.butterfly,8,nil,nil,nil,v.x+y*z,v.y+y*Y,0.25-math.pi/2.0,16,{{color=randomColor()}},{line=24,alpha=0.5,color=randomColor()},{width=0,height=0,color=0xFFFFFF})
addMotion(motion.line,Z,true,true,2,{speedMotor=math.random(2,6),angle=2*math.pi-u})end end
function shoot(p,y)
if y.shot_cd==0 then
if y.bombing and y.bomb.shot~=nil then
y.shot_cd=y.bomb.shot.cd;local R,r=pcall(y.bomb.shot.func,p,y)if not R then
addError(p,string.format("shoot(bombing): %s: %s",p,r))end else y.shot_cd=y.shot.cd
local r,D=pcall(y.shot.func,p,y)if not r then
addError(p,string.format("shoot: %s: %s",p,D))end end end end
function defaultShot(W,L)local Q=tfm.get.room.playerList[W]local v,g=Q.x,Q.y;local c;if
Q.isFacingRight then c=-1 else c=1 end;local b=math.random()*math.pi
local P=addBullet(bullet.jstar,8,
nil,nil,nil,v+64*math.cos(b),g+64*math.sin(b),0,16,5,2,{color=randomColor()},
nil,nil)b=math.random()*math.pi+math.pi
local B=addBullet(bullet.jstar,8,
nil,nil,nil,v+64*math.cos(b),g+64*math.sin(b),0,16,5,2,{color=randomColor()},
nil,nil)
addMotion(motion.circle,P,true,true,math.random(1,4),{speedMotor=4*c},v,g)
addMotion(motion.circle,B,true,true,math.random(1,4),{speedMotor=-4*c},v,g)end
function homingShot(M,d)
local i=randomKey1(tfm.get.room.playerList,M,false)local m=tfm.get.room.playerList[M]local O=m.x;local H=m.y;local x=2
local Z=2;local c=false;if not m.isFacingRight then x=-x end;O=O+16*x
local h={target=i,x=O,y=H+32,v=128}
addObject(objcode.anvil,O+x,H+Z,0,x,Z,c,10,moveHoming,nil,h)local h={target=i,x=O,y=H-32,v=128}
addObject(objcode.anvil,O+x,H-Z,0,x,-Z,c,10,moveHoming,nil,h)end
function initPlayer(M)
local G={color=randomColor(),shooting=false,bombing=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},spawn={200,200},vx=0,lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}if playerConfig[M]==nil then playerConfig[M]={}end
copy(G,playerConfig[M])playerData[M]=G;for n,U in pairs(playerKeys)do bindKey(M,U,true,true)
bindKey(M,U,false,true)end
ui.addTextArea(1,getText(G),M,5,25,151,40,nil,nil,0.5,true)
ui.addTextArea(104,'<TI><a href="event:help">?</a>',M,145,25,11,20,nil,nil,0.0,true)
ui.addTextArea(3,table.concat(errors),M,805,5,200,590,nil,nil,0.5,true)do_respawn(M)setShaman(M)
setNameColor(M,playerData[M].color)end
function resetPlayer(z)
local i={shooting=false,bombing=false,bombTime=nil,lives=5,bombs=3,shot_cd=0,bomb_cd=0,vx=0,bomb_id=nil}local j=playerData[z]copy(j,i)updateTextAreas(z,j)
do_respawn(z)setShaman(z)setNameColor(z,j.color)end;function deletePlayer(b)local P=playerData[b]if P.bombing then removeBomb(b,P)end;playerData[b]=
nil end
function respawn(G)
do_respawn(G)setNameColor(G,playerData[G].color)end;playerData={}objectData={}groundData={}jointData={}patternData={}bulletData={}
errors={'<TI><p align="center">Errors</p>'}MAX_ID=499;MAX_ERRORS=7
playerKeys={32,83,40,100,101,102,104,65,68,69,81,37,39}reservedKeys=invert(playerKeys,true)
eventCode={key=keycode,obj=objcode,objend=objcode}
defaultMap='<C><P defilante="0,0,0,1" L="1600" H="800" G="0,0" /><Z><S /><D><DS Y="200" X="200" /></D><O /></Z></C>'maxLives=8;maxBombs=6
shotTypes={{func=defaultShot,cd=1},{func=homingShot,cd=2}}
bombTypes={{name='default bomb',func=defaultBomb,callback=defaultBombCallback,shot={func=nop,cd=1},cost=1,time=20,cd=0},{name='',func=bomb2,callback=
nil,shot={func=nop,cd=1},cost=1,time=20,cd=5},{name='',func=bomb3,callback=nil,shot={func=nop,cd=1},cost=1,time=6,cd=5}}
patternTypes={{func=testPattern,time=0,callback=nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern1,time=0,callback=
nil,cd=500,points=1,maxBinds=3,restrict={key=nil,obj=nil,objend=nil}}}
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
local O=function(A,i)local P={'<font face="mono" size="15">'}local U;for D,n in ipairs(keys1(A))do
U=i-#n;if U>0 then D=n..string.rep(' ',U)else D=n end
P[#P+1]=string.format('%s = %4d\n',D,A[n])end
P[#P+1]='</font>'return table.concat(P)end;MODULE_HELP['Shaman objects']=O(objcode,15)end
MODULE_CHAT_COMMAND={['help']=help,['clear']=clear,['color']=function(Q,O,U)U=string.upper(U)
if U==''or U=='RANDOM'or U==
'RND'then setColor(Q,randomColor())playerConfig[Q].color=
nil else local N=tonumber(U)if N~=nil then if N>0xFFFFFF then N=0xFFFFFF end
setColor(Q,U)playerConfig[Q].color=U else
alert('Invalid color: '..U,Q)end end end,['reset']=function(o,v,Y)
Y=string.lower(Y)if Y==''or Y=='map'then setMap(defaultMap)else
parsePlayerNames(o,Y,resetPlayer)end end,['init']=function(u,R,X)local q=function(u)
deletePlayer(u)initPlayer(u)end
parsePlayerNames(u,X,q)end,['respawn']=function(B,H,D)
parsePlayerNames(B,D,respawn)end,['shot']=function(v,t,A)local W=tonumber(A)if W==nil then
alert('Invalid shot type: '..A,v)return end;W=shotTypes[W]
if W~=nil then
playerData[v].shot=W else alert('Invalid shot type: '..A,v)end end,['bomb']=function(V,s,h)
local L=tonumber(h)
if L==nil then alert('Invalid bomb type: '..h,V)return end;L=bombTypes[L]if L~=nil then playerData[V].bomb=L else
alert('Invalid bomb type: '..h,V)end end,['bind']=function(_,W,w)
w=split(w)if#w<3 then alert('Too few arguments',_)return elseif#w>3 then
alert('Too many arguments',_)return end
i=tonumber(w[1])local A=patternTypes[i]if i==nil or A==nil then
alert('Invalid pattern: '..w[1],_)return end;j=w[2]
if j~='key'and j~='obj'and
j~='objend'then alert('Invalid event: '..j,_)return end;local p=tonumber(w[3])
if p==nil then p=eventCode[j][w[3]]if p==nil then
alert(string.format('Invalid %s name/code: %s',j,w[3]),_)return end end;if
A.restrict[j]~=nil and A.restrict[j][p]==nil then
alert(string.format('Can\'t bind pattern %d to %s %d: restricted',i,j,p),_)return end;if
j=='key'and reservedKeys[p]then
alert(string.format('Can\'t bind pattern %d to %s %d: reserved',i,j,p),_)return end
local k=playerData[_]local K=k.pattern_data[i]if K~=nil and A.maxBinds<=K.binds then
alert(string.format('Can\'t bind pattern %d to more than %d events',i,A.maxBinds),_)return end
bind(_,j,p,i)end,['unbind']=function(c,o,L)
L=split(L)if#L>2 then alert('Too many arguments',c)return end
i=L[1]
if i=='all'or i==nil then unbind(c)elseif
i~='key'and i~='obj'and i~='objend'then alert('Invalid event: '..i,c)return else
if L[2]==nil then
unbind(c,i)else j=tonumber(L[2])
if j==nil then j=eventCode[i][L[2]]if j==nil then
alert(string.format('Invalid %s name/code: %s',i,L[2]),c)return end end;unbind(c,i,j)end end end,['map']=function(E,g,d)if
d==''then d=defaultMap end;setMap(d)end}
MODULE_CHAT_COMMAND_1=function(k,l,c)alert('Invalid command: '..l,k)end;eventNewPlayer=initPlayer;eventPlayerLeft=deletePlayer
eventTextAreaCallback=helpTextAreaCallback
function eventNewGame()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)tfm.exec.setGameTime(0)objectData={}groundData={}
jointData={}patternData={}bulletData={}bombs={top=0,val={}}groundId={max=0,free={}}
jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}for J,h in
pairs(tfm.get.room.playerList)do resetPlayer(J)end
setMapName('<TI>')setShamanName('')
do_addGround(0,0,0,{type=13,width=10,height=10,color=0xFFFFFF,dynamic=false,miceCollision=false,groundCollision=false})end
function eventKeyboard(H,d,A,E,Y)
if reservedKeys[d]then
if d==65 then local O=playerData[H]if A then bomb(H,O)end elseif d==69 then
local D=playerData[H]D.shooting=A;if A then shoot(H,D)end else local I=0;local y=0
if not A then
if

d==32 or d==104 or d==83 or d==40 or d==53 or d==101 then movePlayer(H,0,0,true,0,1,false)
movePlayer(H,0,0,true,0,-1,true)else movePlayer(H,0,0,true,1,0,false)
movePlayer(H,0,0,true,-1,0,true)playerData[H].vx=0 end else
if d==32 or d==104 or d==87 then I=-50 elseif d==83 or d==40 or d==101 then I=50 elseif d==
100 or d==37 or d==81 then y=-50 elseif d==102 or d==39 or d==68 then y=50 end;if y~=0 then playerData[H].vx=y elseif d==83 or d==40 then
y=playerData[H].vx end;if y~=0 or I~=0 then
movePlayer(H,0,0,true,y,I,false)end end end elseif A then local R=playerData[H]pattern(H,R,'key',d,{x=E,y=Y})end end;function eventSummoningStart(c,n,E,b,N)local F={x=E,y=b,angle=N,type=n}
pattern(c,playerData[c],'obj',n,F)end
function eventSummoningEnd(O,t,M,s,b,w,j,S,G)
objectData[S.id]={time=3}local i={x=M,y=s,angle=b,type=t,vx=w,vy=j,data=S,other=G}
pattern(O,playerData[O],'objend',t,i)end
function eventMouse(e,Q,b)local L=tfm.get.room.playerList[e]end
function eventPlayerDied(A)local w=playerData[A]
if w~=nil then
if w.bombing then respawn(A)else w.shot_cd=0
w.bomb_cd=0;w.shooting=false;w.lives=w.lives-1;if w.lives>0 then w.bombs=w.resetBombs
updateTextAreas(A,w)respawn(A)else
alert(string.format('playerData["%s"].lives &lt;= 0',A),A)end end end end
function eventLoop(C,J)local l,o,B,G,k,K,S,g;clearT()
for F,Q in pairs(playerData)do
l=tfm.get.room.playerList[F]
if not l.isDead then o=l.x;B=l.y;if o<0 then o=10 elseif o>4800 then o=4790 end;if B<0 then B=10 elseif B>1600 then
B=1590 end;Q.spawn[0]=o;Q.spawn[1]=B;G=-l.vx;k=-l.vy;K=-
l.vx/10;S=-l.vy/10
for g=1,math.random(8,16)do
addParticle(particles.purple,o+
math.random(-4,4),B+math.random(-4,4),
(G+math.random()*2-1)/g,(k+math.random()*2-1)/g,K,S)end end;if Q.shot_cd>0 then Q.shot_cd=Q.shot_cd-1 end;if Q.bomb_cd>0 then Q.bomb_cd=
Q.bomb_cd-1 end
if Q.shooting then shoot(F,Q)end
if Q.bombing then Q.bombTime=Q.bombTime-1
if Q.bombTime<=0 then Q.bombing=false
Q.bomb_cd=Q.bomb.cd;removeBomb(F,Q)else if Q.bomb.callback then
local a,z=pcall(Q.bomb.callback,F,Q)
if not a then addError(F,'bomb.callback: '..z)end end end end end end
for y,K in pairs(tfm.get.room.playerList)do initPlayer(y)end;setMap(defaultMap)