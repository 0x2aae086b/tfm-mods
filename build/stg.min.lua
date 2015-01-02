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
function parsePlayerNames(I,u,Q)local D={}local d
for O,C in
pairs(split(string.lower(u)))do
if string.sub(C,1,1)=='!'then C=string.sub(C,2)d=nil else d=true end
if C=='me'then D[I]=d elseif C=='all'then for O,C in pairs(playerData)do D[O]=d end else
C=string.gsub(C,'^%l',string.upper)if playerData[C]==nil then
alert('Invalid player: '..C,I)return else D[C]=d end end end;for U,Y in pairs(D)do Q(U)end end;unescape_map={a='\a',b='\b',f='\f',n='\n',r='\r',t='\t'}
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
R,n=pcall(w.on_remove,E,w)if not R then
addError(string.format("step(%s): on_remove %s\n",tbl_name(D),n))end end;d[#d+1]=E elseif h>0 then w.time=h-1
if w.callback then R,n=pcall(w.callback,E,w)if not R then
addError(string.format("step(%s): callback: %s\n",tbl_name(D),n))end end elseif w.callback then R,n=pcall(w.callback,E,w)if not R then
addError(string.format("step(%s): %s\n",tbl_name(D),n))end end end;for P,o in ipairs(d)do O(o)end end
function clearT()local m={'<TI>'}m[#m+1]='<p align="center">Joints</p>'
step(jointData,removeJoint,m)m[#m+1]='<p align="center">Objects</p>'
step(objectData,removeObject,m,list_object)m[#m+1]='<p align="center">Grounds</p>'
step(groundData,removeGround,m)m[#m+1]='<p align="center">Bullets</p>'
step(bulletData,removeBullet,m,list_bullet)m[#m+1]='<p align="center">Patterns</p>'
step(patternData,removePattern,m)
ui.addTextArea(2,table.concat(m),nil,-155,5,150,590,nil,nil,0.5,true)end;function explode(i,g)local T=g.callback_args
addExplosion(T.x,T.y,T.power,T.distance,T.miceOnly,T.p1,T.p2)end
function explode1(I,w)
local T=w.callback_args
if T.t<=0 then
local R=randomKey1(tfm.get.room.playerList,w.user,true)local A,N=0,0;if R~=nil then local s=tfm.get.room.playerList[R]
A,N=s.x,s.y end
addExplosion(A,N,T.power,T.distance,T.miceOnly,T.p1,T.p2)T.t=T.cd else T.t=T.t-1 end end;function accelerate(t,g)local E=g.callback_args
moveObject(t,0,0,true,E.ax,E.ay,true)end
function moveHoming(O,_)
if
_.time<=7 and _.time>=5 then local A=_.callback_args
local c=tfm.get.room.playerList[A.target]
if c~=nil then local U=c.x;local E=c.y;local R=A.x;local Q=A.y;U=U-R;E=E-Q;local v=U*U+E*E;if v>0 then v=A.v/
math.sqrt(v)U=U*v;E=E*v end
moveObject(O,0,0,true,U,E,false)end end end
function newId(y)local P=y.free;local O,X=pairs(P)(P)
if O then P[O]=nil;return O else if y.max==MAX_ID then
error(string.format("newId: %s.max == MAX_ID",tbl_name(y)))end;y.max=y.max+1;return y.max end end
function freeId(v,s)local Z=v.free;if s==v.max then local r=v.max-1;while Z[r]do Z[r]=nil;r=r-1 end;v.max=r else
Z[s]=true end end
function addObject(t,B,l,Y,e,g,J,_,x,h,i)local W=do_addObject(t,B,l,Y,e,g,J)if _==nil then _=3 end
objectData[W]={time=_,callback=x,on_remove=h,callback_args=i}return W end
function removeObject(h)do_removeObject(h)objectData[h]=nil end
function addGround(a,b,x,m,h,c,_)local p=newId(groundId)do_addGround(p,a,b,x)
if m==nil then m=3 end;groundData[p]={time=m,callback=h,on_remove=c,callback_args=_}return p end;function removeGround(q)do_removeGround(q)groundData[q]=nil
freeId(groundId,q)end
function addJoint(O,s,c,T,o,F,i)local D=newId(jointId)
do_addJoint(D,O,s,c)if T==nil then T=-1 end;if c==nil then c={}end
jointData[D]={time=T,callback=o,on_remove=F,callback_args=i}return D end
function removeJoint(k)do_removeJoint(k)jointData[k]=nil;freeId(jointId,k)end
function addPattern(J,K,D,R)local i=nil;if D.time~=nil then i=newId(patternId)
patternData[i]={time=D.time,callback=D.callback,on_remove=D.on_remove}end
D.func(J,K,i,R)return i end
function removePattern(S)patternData[S]=nil;freeId(patternId,S)end
function addExplosion(o,w,m,G,e,j,U)if j~=nil then addParticle(j,o,w,0,0,0,0)end
if U~=nil then end;do_addExplosion(o,w,m,G,e)end
function addGround1(N,n,B,K)local a=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=a;do_addGround(a,n,B,K)N[#N+1]=a end
function addJoint1(B,Q,L,y)local a=newId(jointId)
_tmp_joints[#_tmp_joints+1]=a;do_addJoint(a,Q,L,y)B[#B+1]=a end;function do_addControl(D,p)D[#D+1]=p end;function do_removeControl(M,J)local k=#M;while k>0 and M[k]~=J do
M[k]=nil;k=k-1 end end
function addBullet(P,u,E,C,l,...)
local p=newId(bulletId)_tmp_grounds={}_tmp_joints={}local i,L,j,K=pcall(P,...)
if i then
bulletData[p]={controls={L},grounds=j,joints=K,time=u or 6,callback=E,on_remove=C,callback_args=l}else for h,A in ipairs(_tmp_joints)do removeJoint(A)end;for o,F in
ipairs(_tmp_grounds)do removeGround(F)end;freeId(bulletId,p)
error(string.format('addBullet: %s',L))end;return p end
function removeBullet(e)local T=bulletData[e]for F,x in ipairs(T.joints)do do_removeJoint(x)
freeId(jointId,x)end;for l,Y in ipairs(T.grounds)do
do_removeGround(Y)freeId(groundId,Y)end
bulletData[e]=nil;freeId(bulletId,e)end;bullet={}
bullet.circle=function(Z,t,y,p,H)local f=string.format('%d,%d',Z,t+1)
local K={type=0,point2=f,color=0x0000FF,line=2*y,foreground=false}
local A={type=13,width=y,height=y,miceCollision=true,groundCollision=false,dynamic=true,restitution=255,color=0xFFFFFF}copy(A,H)local _=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=_;do_addGround(_,Z,t,A)local Q={}if p then for s,P in ipairs(p)do copy(K,P)
addJoint1(Q,_,_,K)end end;return _,{_},Q end
bullet.butterfly=function(B,n,v,g,k,U,l)local X=make_star(5,2)
local f={type=0,color=0xFF00FF,alpha=0.25,line=X.l*g*2,foreground=false}
local b={type=0,point1=string.format('%d,%d',B,n),point2=string.format('%d,%d',B,n+1),color=0x0000FF,line=g*2,foreground=false}
local z={type=13,width=g,height=g,dynamic=true,miceCollision=true,groundCollision=false,restitution=255,color=0xFFFFFF}copy(f,U)copy(z,l)local A={}local d={}local r,H
local x,q=math.cos(v),math.sin(v)local t;local O=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=O;do_addGround(O,B,n,z)
for i=2,5 do t=X.points[i]r,H=t[1]*x-t[2]*q,t[1]*q+
t[2]*x;r,H=B+g*r,n+g*H
f.point1=string.format('%d,%d',r,H)f.point2=string.format('%d,%d',r,H+1)
addJoint1(A,O,O,f)end
if k then for G,t in ipairs(k)do copy(b,t)addJoint1(A,O,O,b)end end;return O,{O},A end
bullet.jstar=function(z,q,N,a,H,P,l,j,I)local y=make_star(H,P)
local S={type=0,color=0xFFFFFF,line=5,foreground=true}local U=a*y.r
local Z={type=0,point1=string.format('%d,%d',z,q),point2=string.format('%d,%d',z,q+1),color=0xFFFFFF,line=U*2,foreground=true}
local K={type=13,width=U,height=U,dynamic=true,miceCollision=true,groundCollision=false,restitution=255}copy(S,l)copy(Z,j)copy(K,I)local b={}local v={}local u,X
local o,F=math.cos(N),math.sin(N)
for R,Y in ipairs(y.points)do u,X=Y[1]*o-Y[2]*F,Y[1]*F+Y[2]*o;v[#v+1]=string.format('%d,%d',
z+a*u,q+a*X)end;local O=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=O;do_addGround(O,z,q,K)for i=1,H do S.point1=v[i]
S.point2=v[1+ (i+P-1)%H]addJoint1(b,O,O,S)end
addJoint1(b,O,O,Z)return O,{O},b end
bullet.star=function(o,Z,H,K,T,V,b,t,G,g)local M=make_star(T,V)
local O={type=12,height=1,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}local x=K*M.r
local i={type=13,width=x,height=x,color=0xFFFFFF,groundCollision=false,miceCollision=true,dynamic=true,foreground=true,restitution=255}
local w={type=13,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}x=string.format('%d,%d',o,Z)
local S={type=3,point1=x,point2=x,ratio=1,limit1=0,limit2=0}local r={type=0,frequency=10}copy(O,t)copy(i,G)copy(w,g)
local X,D,j={},{},{}local _,I;local C=H*180.0/math.pi
local Q,f=math.cos(H),math.sin(H)
for z,E in ipairs(M.lines)do O.angle=E.angle+C;O.width=E.width*K;_,I=E.x*Q-E.y*f,
E.x*f+E.y*Q;addGround1(X,o+K*_,Z+K*I,O)end;if b then
for B,k in ipairs(M.points)do _,I=k[1]*Q-k[2]*f,k[1]*f+k[2]*Q;addGround1(D,
o+K*_,Z+K*I,w)end end
local U=newId(groundId)_tmp_grounds[#_tmp_grounds+1]=U
do_addGround(U,o,Z,i)
if O.dynamic then local z,Y=nil,nil;for d,E in ipairs(X)do addJoint1(j,E,U,S)if z~=nil then
addJoint1(j,E,z,r)else Y=E end;z=E end
addJoint1(j,Y,z,r)elseif i.dynamic then for E,N in ipairs(X)do addJoint1(j,N,U,S)end end
if b then
if w.dynamic then local l,B=nil,nil
for i=1,T do addJoint1(j,D[i],X[i],S)if l~=nil then
addJoint1(j,D[i],l,r)else B=D[i]end;l=D[i]end;addJoint1(j,B,l,r)elseif O.dynamic then
for i=1,T do addJoint1(j,D[i],X[i],S)end end end;append(X,D)X[#X+1]=U;return U,X,j end
function bomb(U,y)
if y.bomb_cd==0 and not y.bombing then
if y.bombs>=y.bomb.cost then y.bombs=y.bombs-
y.bomb.cost;y.bombing=true;y.bombTime=y.bomb.time
local t,e=pcall(y.bomb.func,U,y)addBomb(U,y)updateTextAreas(U,y)if not t then
addError(U,string.format("bomb: %s: %s",U,e))end else
alert(string.format('bombs &lt; %d',y.bomb.cost),U)end end end
function addBomb(y,Z)local J=bombs.top+1
local c=string.format('<TI><font color="#%X">%s <font color="#5F5F8D">|</font> %s</font>',Z.color,y,Z.bomb.name)Z.bomb_id=J;bombs.top=J;bombs.val[J]=c;setShamanName(c)end
function removeBomb(M,P)local u=P.bomb_id;P.bomb_id=nil;bombs.val[u]=nil
if u==bombs.top then u=u-1;while
bombs.val[u]==nil and u>0 do u=u-1 end;bombs.top=u;if u>0 then
u=bombs.val[u]else u=''end;setShamanName(u)end end
function motionEnd(w,u)local y=u.callback_args
if y._on_remove then y._on_remove(w,u)end;do_removeControl(y._controls,w)end
function addControl(D,...)local s=addGround(...)local R=groundData[s]if R.callback_args==nil then
R.callback_args={_controls=D}else R.callback_args._on_remove=R.on_remove
R.callback_args._controls=D end
R.on_remove=motionEnd;D[#D+1]=s;return s end;function addControl1(Y,...)return addGround(...)end
function addMotion(v,O,M,...)local S;local s;if M then
S=bulletData[O].controls;s=addControl else S={O}s=addControl1 end
local H,L=pcall(v,s,S,...)if not H then
error(string.format("addMotion: %s",L))end end;motion={}
motion.line=function(L,s,o,W,F,f,i)local a=0;local J=s[#s]
local S={type=1,axis='-1,0',angle=0,forceMotor=255,speedMotor=1}copy(S,F)
if not o then
local A={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}a=L(s,f or 0,i or 0,A,W or 3)end;addJoint(J,a,S,W or 3)end
motion.circle=function(u,Y,p,f,j,A,C)local J=0;local B=Y[#Y]local D={type=3,forceMotor=255,speedMotor=1}
copy(D,j)
if not p then
local X={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}J=u(Y,A or 0,C or 0,X,f or 3)end
if A and C then D.point1=string.format('%d,%d',A,C)end;addJoint(B,J,D,f or 3)end
motion.spiral=function(e,O,r,Q,X,J,h,F)motion.line(e,O,false,Q,X,h,F)
motion.circle(e,O,r,Q,J,h,F)end
function addBombTimer(o,r,v,l,d)local J=v.bombTime*d+2
local Q={type=13,angle=0,color='0xFF0000',foreground=false,friction=0.0,restitution=2.0,width=J,height=J,miceCollision=false,groundCollision=l,dynamic=false}
addGround(r.x,r.y,Q,v.bombTime,moveBombTimer,nil,{player=o,pdata=v,offset=2,scale=d,obj=Q})J=J-2
Q={type=13,angle=0,color='0x6A7495',foreground=false,friction=0.0,restitution=2.0,width=J,height=J,miceCollision=false,groundCollision=l,dynamic=false}
addGround(r.x,r.y,Q,v.bombTime,moveBombTimer,nil,{player=o,pdata=v,offset=0,scale=d,obj=Q})end
function moveBombTimer(e,a)local u=a.callback_args
local o=tfm.get.room.playerList[u.player]local w=u.pdata.bombTime*u.scale+u.offset
u.obj.width=w;u.obj.height=w;do_addGround(e,o.x,o.y,u.obj)end
function defaultBombCallback(C,Z)local j=tfm.get.room.playerList[C]
local d=j.y+j.vy;local p;local O,W;local R=Z.bombCallbackArgs;local l=4;local P=4;local u=0;local k={ax=64,ay=0}P=R*P
k.ax=R*k.ax;p=j.x+R*Z.bombTime*5+10
for off=20,120,20 do W=off*R
O=p+W*1.5
addObject(objcode.anvil,O,d-W,0,P,-u*R,false,l,accelerate,nil,k)
addObject(objcode.anvil,O,d+W,0,P,u*R,false,l,accelerate,nil,k)u=u+1 end end
function defaultBomb(t,Q)local J=tfm.get.room.playerList[t]
if
not J.isFacingRight then Q.bombCallbackArgs=-1 else Q.bombCallbackArgs=1 end;addBombTimer(t,J,Q,true,5)end
function bomb2(F,o)local z=tfm.get.room.playerList[F]local P,L=z.x,z.y
local p=string.format('%d,%d',P,L)
local J={type=12,color=0xFFFFFF,foreground=true,width=512,height=8,dynamic=true,mass=8,restitution=255,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=true}
local O={type=13,color=0xFFFFFF,width=32,height=32,dynamic=false,groundCollision=false,miceCollision=false,foreground=true}local q={type=3,point1=p,point2=nil,forceMotor=255,speedMotor=2}
local s={type=3,point1=p,point2=p,ratio=1,limit1=0,limit2=8}local c={type=0,frequency=10}local A;local X;local k,r;local h,b
local D=32.0+J.width/2.0;local d=20;local y=nil;local _=nil;local K,x;addBombTimer(F,z,o,true,5)
x=addGround(P,L,O,d)
for A=0,359,120 do X=A*math.pi/180.0;k,r=math.cos(X),math.sin(X)h,b=P+
D*k,L+D*r;J.angle=A;K=addGround(h,b,J,d)addJoint(K,x,q,d)
if _~=
nil then addJoint(K,_,s,d)addJoint(K,_,c,d)else y=K end;_=K end;addJoint(y,K,s,d)addJoint(y,K,c,d)end
function bomb3(y,i)local g=tfm.get.room.playerList[y]local f,d=g.x,g.y
local F=string.format('%d,%d',f,d)
local u={type=13,color=0xFFFFFF,width=64,height=64,dynamic=true,mass=1,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=false,foreground=true}
local N={type=1,axis='-1,0',forceMotor=255,speedMotor=2,limit1=0,limit2=5}local O;local z;local p,C;local o,e;local I=64.0+u.width;local t=5;local W;local k
addBombTimer(y,g,i,true,10)
local w={[0]=0.15,[60]=0.13,[120]=0.11,[180]=0.075,[240]=0.05,[300]=0}
for O=0,359,60 do z=O*math.pi/180.0;o,e=math.cos(z),math.sin(z)p,C=f+I*o,
d+I*e
k={x=f+math.cos(z+w[O])*280,y=d+
math.sin(z+w[O])*280,power=127,distance=3*u.width,miceOnly=false,p1=particles.red_spirit,p2=nil}W=addGround(p,C,u,t,nil,explode,k)
N.angle=2.0*math.pi-z;addJoint(W,0,N,t)end end
function pattern(a,w,Y,M,E)local s=w.patterns[Y][M]
if s~=nil then local X=#s.points+1
if X>=
s.type.points then local i=os.time()
if i-s.lastTime>=s.type.cd then s.lastTime=i
s.points[X]=E;local B,I=pcall(addPattern,a,w,s.type,s.points)s.points={}if not B then
addError(a,string.format("pattern: %s: %s",a,I))end end else s.points[X]=E end end end
function bind(C,F,Q,j)local t=playerData[C]local s=t.patterns[F]if s[Q]~=nil then
do_unbind(t,s[Q],F,Q)end
s[Q]={id=j,type=patternTypes[j],points={},lastTime=0}s=t.pattern_data[j]
if F=='key'then bindKey(C,Q,true,true)end
if s==nil then t.pattern_data[j]={binds=1}else s.binds=s.binds+1 end end
function do_unbind(t,B,M,_)local R=t.pattern_data[B.id]if R.binds<=1 then
t.pattern_data[B.id]=nil else R.binds=R.binds-1 end;t.patterns[M][_]=
nil end
function unbind(R,i,y)local S=playerData[R]
if i==nil then S.patterns={key={},obj={},objend={}}
S.pattern_data={}elseif y==nil then local v={}
for h,N in pairs(S.patterns[i])do v[#v+1]={h,N}end;for B,z in ipairs(v)do do_unbind(S,z[2],i,z[1])end else
local n=S.patterns[i][y]if n~=nil then do_unbind(S,n,i,y)end end end
function testPattern(n,c,g,K)local e=K[1]local S=6;local M=48;local N=math.random(2,8)local x,m,P;local f=
e.angle*math.pi/180.0
for i=0,S-1 do
x=f+2.0*math.pi*i/S;m,P=math.cos(x),math.sin(x)addObject(e.type,e.x+M*m,e.y+M*P,e.angle+360*i/S,
N*m,N*P,false,9)end end
function testPattern1(g,c,F,m)local K=m[1]local C=math.random(8,16)local u,A,M;local Z;local F
for i=1,C do
Z=math.random(64,96)u=math.random()*2.0*math.pi
A,M=math.cos(u),math.sin(u)
F=addBullet(bullet.butterfly,8,nil,nil,nil,K.x+Z*A,K.y+Z*M,0.25-math.pi/2.0,16,{{color=randomColor()}},{line=24,alpha=0.5,color=randomColor()},{width=0,height=0,color=0xFFFFFF})
addMotion(motion.line,F,true,true,2,{speedMotor=math.random(2,6),angle=2*math.pi-u})end end
function shoot(o,v)
if v.shot_cd==0 then
if v.bombing and v.bomb.shot~=nil then
v.shot_cd=v.bomb.shot.cd;local S,u=pcall(v.bomb.shot.func,o,v)if not S then
addError(o,string.format("shoot(bombing): %s: %s",o,u))end else v.shot_cd=v.shot.cd
local z,Y=pcall(v.shot.func,o,v)if not z then
addError(o,string.format("shoot: %s: %s",o,Y))end end end end
function defaultShot(Z,A)local o=tfm.get.room.playerList[Z]local p,R=o.x,o.y;local r;if
o.isFacingRight then r=-1 else r=1 end;local D=math.random()*math.pi
local W=addBullet(bullet.jstar,8,
nil,nil,nil,p+64*math.cos(D),R+64*math.sin(D),0,16,5,2,{color=randomColor()},
nil,nil)D=math.random()*math.pi+math.pi
local L=addBullet(bullet.jstar,8,
nil,nil,nil,p+64*math.cos(D),R+64*math.sin(D),0,16,5,2,{color=randomColor()},
nil,nil)
addMotion(motion.circle,W,true,true,math.random(1,4),{speedMotor=4*r},p,R)
addMotion(motion.circle,L,true,true,math.random(1,4),{speedMotor=-4*r},p,R)end
function homingShot(Q,v)
local c=randomKey1(tfm.get.room.playerList,Q,false)local b=tfm.get.room.playerList[Q]local P=b.x;local B=b.y;local M=2
local d=2;local i=false;if not b.isFacingRight then M=-M end;P=P+16*M
local m={target=c,x=P,y=B+32,v=128}
addObject(objcode.anvil,P+M,B+d,0,M,d,i,10,moveHoming,nil,m)local m={target=c,x=P,y=B-32,v=128}
addObject(objcode.anvil,P+M,B-d,0,M,-d,i,10,moveHoming,nil,m)end
function initPlayer(O)
local H={color=randomColor(),shooting=false,bombing=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},spawn={200,200},lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}if playerConfig[O]==nil then playerConfig[O]={}end
copy(H,playerConfig[O])playerData[O]=H;for x,Z in pairs(playerKeys)do bindKey(O,Z,true,true)
bindKey(O,Z,false,true)end
ui.addTextArea(1,getText(H),O,5,25,151,40,nil,nil,0.5,true)
ui.addTextArea(104,'<TI><a href="event:help">?</a>',O,145,25,11,20,nil,nil,0.0,true)
ui.addTextArea(3,table.concat(errors),O,805,5,200,590,nil,nil,0.5,true)do_respawn(O)setShaman(O)
setNameColor(O,playerData[O].color)end
function resetPlayer(c)
local h={shooting=false,bombing=false,bombTime=nil,lives=5,bombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}local M=playerData[c]copy(M,h)updateTextAreas(c,M)
do_respawn(c)setShaman(c)setNameColor(c,M.color)end;function deletePlayer(G)local n=playerData[G]if n.bombing then removeBomb(G,n)end;playerData[G]=
nil end
function respawn(U)
do_respawn(U)setNameColor(U,playerData[U].color)end;playerData={}objectData={}groundData={}jointData={}patternData={}bulletData={}
errors={'<TI><p align="center">Errors</p>'}MAX_ID=499;MAX_ERRORS=7
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
local z=function(i,j)local b={'<font face="mono" size="15">'}local P;for G,O in ipairs(keys1(i))do
P=j-#O;if P>0 then G=O..string.rep(' ',P)else G=O end
b[#b+1]=string.format('%s = %4d\n',G,i[O])end
b[#b+1]='</font>'return table.concat(b)end;MODULE_HELP['Shaman objects']=z(objcode,15)end
MODULE_CHAT_COMMAND={['help']=help,['clear']=clear,['color']=function(A,i,P)P=string.upper(P)
if P==''or P=='RANDOM'or P==
'RND'then setColor(A,randomColor())playerConfig[A].color=
nil else local U=tonumber(P)if U~=nil then if U>0xFFFFFF then U=0xFFFFFF end
setColor(A,P)playerConfig[A].color=P else
alert('Invalid color: '..P,A)end end end,['reset']=function(D,n,Q)
Q=string.lower(Q)if Q==''or Q=='map'then setMap(defaultMap)else
parsePlayerNames(D,Q,resetPlayer)end end,['init']=function(O,U,N)local o=function(O)
deletePlayer(O)initPlayer(O)end
parsePlayerNames(O,N,o)end,['respawn']=function(v,Y,u)
parsePlayerNames(v,u,respawn)end,['shot']=function(R,X,q)local B=tonumber(q)if B==nil then
alert('Invalid shot type: '..q,R)return end;B=shotTypes[B]
if B~=nil then
playerData[R].shot=B else alert('Invalid shot type: '..q,R)end end,['bomb']=function(H,D,v)
local t=tonumber(v)
if t==nil then alert('Invalid bomb type: '..v,H)return end;t=bombTypes[t]if t~=nil then playerData[H].bomb=t else
alert('Invalid bomb type: '..v,H)end end,['bind']=function(A,W,V)
V=split(V)if#V<3 then alert('Too few arguments',A)return elseif#V>3 then
alert('Too many arguments',A)return end
i=tonumber(V[1])local s=patternTypes[i]if i==nil or s==nil then
alert('Invalid pattern: '..V[1],A)return end;j=V[2]
if j~='key'and j~='obj'and
j~='objend'then alert('Invalid event: '..j,A)return end;local h=tonumber(V[3])
if h==nil then h=eventCode[j][V[3]]if h==nil then
alert(string.format('Invalid %s name/code: %s',j,V[3]),A)return end end;if
s.restrict[j]~=nil and s.restrict[j][h]==nil then
alert(string.format('Can\'t bind pattern %d to %s %d: restricted',i,j,h),A)return end;if
j=='key'and reservedKeys[h]then
alert(string.format('Can\'t bind pattern %d to %s %d: reserved',i,j,h),A)return end
local L=playerData[A]local _=L.pattern_data[i]if _~=nil and s.maxBinds<=_.binds then
alert(string.format('Can\'t bind pattern %d to more than %d events',i,s.maxBinds),A)return end
bind(A,j,h,i)end,['unbind']=function(W,w,A)
A=split(A)if#A>2 then alert('Too many arguments',W)return end
i=A[1]
if i=='all'or i==nil then unbind(W)elseif
i~='key'and i~='obj'and i~='objend'then alert('Invalid event: '..i,W)return else
if A[2]==nil then
unbind(W,i)else j=tonumber(A[2])
if j==nil then j=eventCode[i][A[2]]if j==nil then
alert(string.format('Invalid %s name/code: %s',i,A[2]),W)return end end;unbind(W,i,j)end end end,['map']=function(p,k,K)if
K==''then K=defaultMap end;setMap(K)end}
MODULE_CHAT_COMMAND_1=function(c,o,L)alert('Invalid command: '..o,c)end;eventNewPlayer=initPlayer;eventPlayerLeft=deletePlayer
eventTextAreaCallback=helpTextAreaCallback
function eventNewGame()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)tfm.exec.setGameTime(0)objectData={}groundData={}
jointData={}patternData={}bulletData={}bombs={top=0,val={}}groundId={max=0,free={}}
jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}for E,g in
pairs(tfm.get.room.playerList)do resetPlayer(E)end
setMapName('<TI>')setShamanName('')
do_addGround(0,0,0,{type=13,width=10,height=10,color=0xFFFFFF,dynamic=false,miceCollision=false,groundCollision=false})end
function eventKeyboard(d,k,l,c,J)
if reservedKeys[k]then
if k==65 then local h=playerData[d]if l then bomb(d,h)end elseif k==69 then
local H=playerData[d]H.shooting=l;if l then shoot(d,H)end else local A=0;local y=0
if not l then
if

k==32 or k==104 or k==83 or k==40 or k==53 or k==101 then movePlayer(d,0,0,true,0,1,false)
movePlayer(d,0,0,true,0,-1,true)else movePlayer(d,0,0,true,1,0,false)
movePlayer(d,0,0,true,-1,0,true)end else
if k==32 or k==104 or k==87 then A=-50 elseif k==83 or k==40 or k==101 then A=50 elseif k==
100 then y=-50 elseif k==102 then y=50 end
if y~=0 or A~=0 then movePlayer(d,0,0,true,y,A,false)end end end elseif l then local E=playerData[d]pattern(d,E,'key',k,{x=c,y=J})end end;function eventSummoningStart(Y,O,D,I,y)local R={x=D,y=I,angle=y,type=O}
pattern(Y,playerData[Y],'obj',O,R)end
function eventSummoningEnd(c,n,E,b,N,F,y,O,t)
objectData[O.id]={time=3}local M={x=E,y=b,angle=N,type=n,vx=F,vy=y,data=O,other=t}
pattern(c,playerData[c],'objend',n,M)end
function eventMouse(s,b,w)local t=tfm.get.room.playerList[s]end
function eventPlayerDied(j)local S=playerData[j]
if S~=nil then
if S.bombing then respawn(j)else S.shot_cd=0
S.bomb_cd=0;S.shooting=false;S.lives=S.lives-1;if S.lives>0 then S.bombs=S.resetBombs
updateTextAreas(j,S)respawn(j)else
alert(string.format('playerData["%s"].lives &lt;= 0',j),j)end end end end
function eventLoop(G,i)local e,Q,b,L,A,w,C,J;clearT()
for l,o in pairs(playerData)do
e=tfm.get.room.playerList[l]
if not e.isDead then Q=e.x;b=e.y;if Q<0 then Q=10 elseif Q>4800 then Q=4790 end;if b<0 then b=10 elseif b>1600 then
b=1590 end;o.spawn[0]=Q;o.spawn[1]=b;L=-e.vx;A=-e.vy;w=-
e.vx/10;C=-e.vy/10
for J=1,math.random(8,16)do
addParticle(particles.purple,Q+
math.random(-4,4),b+math.random(-4,4),
(L+math.random()*2-1)/J,(A+math.random()*2-1)/J,w,C)end end;if o.shot_cd>0 then o.shot_cd=o.shot_cd-1 end;if o.bomb_cd>0 then o.bomb_cd=
o.bomb_cd-1 end
if o.shooting then shoot(l,o)end
if o.bombing then o.bombTime=o.bombTime-1;if o.bombTime<=0 then o.bombing=false
o.bomb_cd=o.bomb.cd;removeBomb(l,o)else
if o.bomb.callback then o.bomb.callback(l,o)end end end end end
for B,G in pairs(tfm.get.room.playerList)do initPlayer(B)end;setMap(defaultMap)