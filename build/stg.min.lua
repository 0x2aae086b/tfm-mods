do_addObject=tfm.exec.addShamanObject
do_removeObject=tfm.exec.removeObject;do_addGround=tfm.exec.addPhysicObject
do_removeGround=tfm.exec.removePhysicObject;do_addJoint=tfm.exec.addJoint;do_removeJoint=tfm.exec.removeJoint
do_respawn=tfm.exec.respawnPlayer;do_addExplosion=tfm.exec.explosion
addParticle=tfm.exec.displayParticle;setShaman=tfm.exec.setShaman
setShamanName=tfm.exec.setUIShamanName;setMapName=tfm.exec.setUIMapName
setNameColor=tfm.exec.setNameColor;movePlayer=tfm.exec.movePlayer;moveObject=tfm.exec.moveObject
setMap=tfm.exec.newGame;bindKey=tfm.exec.bindKeyboard;kill=tfm.exec.killPlayer;function nop()end;function randomColor()return
math.random(0x000000,0xFFFFFF)end
function to_table(a)if a==nil or
type(a)=='table'then return a else return{a}end end
_axis={'-1,0','-1,1','0,1','1,1','1,0','1,-1','0,-1','-1,-1'}_axis_step=math.pi/4.0
function to_axis(X)
local f=(math.floor(X/_axis_step)%#_axis)return _axis[f+1],_axis_step*f end
function rotate(d,v,A,K,g,G)d,v=d-A,v-K;d,v=d*g-v*G,d*G+v*g;return A+d,K+v end
function length1(r)return math.sqrt(r.x*r.x+r.y*r.y)end
function cache2(M)local i={}return
function(Z,w)local n=i[Z]local v=nil;if n==nil then n={}i[Z]=n else v=n[w]end;if v==nil then
v=M(Z,w)n[w]=v end;return v end end;function split(i)local j={}for I in string.gmatch(i,'[^%s]+')do j[#j+1]=I end
return j end
function parsePlayerNames(u,Q,D)local I={}local d
for O,C in
ipairs(split(string.lower(Q)))do
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
local Z,g={},1;for w,p in pairs(z)do if w~=G then Z[g]=w;g=g+1 end end
if g>1 then return Z[math.random(1,#
Z)]elseif e then return nil else return G end end;function randomValue1(e,E,B)local b=randomKey1(e,E,B)
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
D(L,K,s)else MODULE_CHAT_COMMAND_1(L,x,s)end end;MAX_ID=499;function tbl_name(y)return'&lt;table&gt;'end
function newId(o)local z=o.free
local B,C=pairs(z)(z)
if B then z[B]=nil;return B else if o.max==MAX_ID then
error(string.format("newId: %s.max == MAX_ID",tbl_name(o)))end;o.max=o.max+1;return o.max end end
function freeId(s,l)local v=s.free;if l==s.max then local M=s.max-1;while v[M]do v[M]=nil;M=M-1 end;s.max=M else
v[l]=true end end;_errors={'<TI><p align="center">Errors</p>'}ERROR_TA=3
MAX_ERRORS=7;function alert(S,n)
ui.addPopup(0,0,string.format('<font face="mono" size="15">%s</font>',S),n,200,150,400,true)end
function addError(v)
v=string.format("• %s\n",v)for i=3,#_errors+1 do _errors[i]=_errors[i-1]end
_errors[2]=v;_errors[MAX_ERRORS+1]=nil;ui.updateTextArea(ERROR_TA,table.concat(_errors),
nil)end;TIME=os.time()TIMER_RES=250;_timerId={max=0,free={}}_timerData={}
function initTimers()
TIME=os.time()_timerId={max=0,free={}}_timerData={}end
function timer()local I=os.time()while TIME+TIMER_RES<=I do eventTimer()
TIME=TIME+TIMER_RES end end
function timers()local x=os.time()local i,V,u
for G,f in ipairs(_timerData)do i=f.time;u=true
while i+f.res<=x do
i=i+f.res;V,u=pcall(f.func,G,f)if not V then
addError(nil,string.format('timer %d: %s',G,u))u=false end;if not u then break end end;if u then f.time=i else removeTimer(G)end end end;function addTimer(J,B,S)local P=newId(_timerId)
_timerData[P]={func=J,args=B,res=S,time=os.time()}end;function removeTimer(G)
freeId(_timerId,G)end;function setColor(r,V)setNameColor(r,V)
playerData[r].color=V end
function tbl_name(O)
if O==groundId then return'groundId'elseif O==jointId then
return'jointId'elseif O==bulletId then return'bulletId'elseif O==patternId then return'patternId'elseif O==_timerId then return'_timerId'elseif O==
objectData then return'objectData'elseif O==groundData then return'groundData'elseif O==jointData then return'jointData'elseif O==
bulletData then return'bulletData'elseif O==patternData then return'patternData'elseif O==_timerData then
return'_timerData'end;return'&lt;other&gt;'end
function make_line(v,Y)local U,q=Y[1]-v[1],Y[2]-v[2]return
{width=math.sqrt(U*U+q*q),angle=math.deg(math.atan2(q,U)),x=(
v[1]+Y[1])/2,y=(v[2]+Y[2])/2}end
make_star=cache2(function(g,_)local b={}local l={}for i=1,g do a=math.pi*2.0*i/g
b[#b+1]={math.cos(a),math.sin(a)}end;for i=1,g do
l[#l+1]=make_line(b[i],b[1+ (i+_-1)%g])end;local X=length1(l[1])return
{lines=l,points=b,r=X,l=math.sqrt(1-X*X)}end)
keycode={backspace=8,enter=13,shift=16,ctrl=17,alt=18,capslock=20,esc=27,space=32,['0']=48,['1']=49,['2']=50,['3']=51,['4']=52,['5']=53,['6']=54,['7']=55,['8']=56,['9']=57,a=81,b=66,c=67,d=68,e=69,f=70,g=71,h=72,i=73,j=74,k=75,l=76,m=77,n=78,o=79,p=80,q=65,r=82,s=83,t=84,u=85,v=86,w=90,x=88,y=89,z=87,[';']=186,['=']=187,[',']=188,['-']=189,['.']=190,['/']=191,['`']=192,[':']=186,['+']=187,['<']=188,['_']=189,['>']=190,['?']=191,['~']=192,['[']=219,['\\']=220,[']']=221,["'"]=222,['{']=219,['|']=220,['}']=221,['"']=222,[')']=48,['!']=49,['@']=50,['#']=51,['$']=52,['%']=53,['^']=54,['&']=55,['*']=56,['(']=57,kp0=96,kp1=97,kp2=98,kp3=99,kp4=100,kp5=101,kp6=102,kp7=103,kp8=104,kp9=105,['kp*']=106,['kp+']=107,['kp-']=109,['kp.']=110,['kp/']=111,left=37,up=38,right=39,down=40,f1=112,f2=113,f3=114,f4=115,f5=116,f6=117,f7=118,f8=119,f9=120,f10=121,f11=122,f12=123}
particles={white=0,purple=1,orange=2,soft_white=4,teal=9,yellow=11,red=13,spawn=3,heart=5,red_heart=30,pink_heart=31,bubble=6,bubble1=7,bubble2=8,water=14,spirit=10,red_spirit=12,plus1=15,plus10=16,plus12=17,plus14=18,plus16=19,meep=20,red_confetti=21,green_confetti=22,blue_confetti=23,yellow_confetti=24,rain=25,wind=26,wind1=27,lightning=28,star=29,flower=32}
objcode={arrow=0,small_box=1,box=2,small_plank=3,plank=4,ball=6,trampoline=7,anvil=10,anvil1=1002,B=11,Bc=12,Bcc=13,V=14,Vc=15,Vcc=16,cannon_up=17,cannon_down=18,cannon_right=19,cannon_left=20,C=22,bomb=23,spirit=24,cheese=25,blue_portal=26,orange_portal=27,balloon1=2806,balloon=28,red_balloon=29,green_balloon=30,yellow_balloon=31,rune=32,snow=34,arrow1=35,apple=39,sheep=40,demolition=41,totem=44,ice_plank=45,choco_plank=46,cloud=57,architect=58,bubble=59,tiny_plank=60,companion_crate=61,stable_rune=62,ballon_anchor=66,windmill_anchor=88}copy(objcode,tfm.enum.shamanObject)
function getText(h)
local Z=h.lives-1;local H=h.bombs;if Z>=maxLives then Z=maxLives-1 end;if Z<0 then Z=0 end;if
H>maxBombs then H=maxBombs elseif H<0 then H=0 end
if h.lives<1 then l=0 else l=h.lives end;return
string.format('<TI><N>Player  <R>%s<N>\nBomb  <VP>%s',string.rep('★',Z),string.rep('★',H))end;function updateTextAreas(D,t)ui.updateTextArea(1,getText(t),D)
ui.updateTextArea(104,'<TI><a href="event:help">?</a>',D)end
function clear()for D,O in
ipairs(keys(jointData))do removeJoint(O)end;for j,U in
ipairs(keys(tfm.get.room.objectList))do removeObject(U)end;for d,O in
ipairs(keys(groundData))do removeGround(O)end;for h,R in
ipairs(keys(bulletData))do removeBullet(R)end;for n,E in
ipairs(keys(patternData))do removePattern(E)end end
function list_default(w,P,D)w[#w+1]=string.format('%d %d\n',P,D.time)end
function list_object(d,j,o)local m=tfm.get.room.objectList[j]if m==nil then
d[#d+1]=string.format('%d &lt;invalid&gt; %d\n',j,o.time)else
d[#d+1]=string.format('%d (%d, %d) %d\n',j,m.x,m.y,o.time)end end;function list_bullet(i,g,T)
i[#i+1]=string.format("%d %d %d\n",g,T.controls[#T.controls],T.time)end
function step(I,w,T,R,A)local N={}local s;local t,g;if A==nil then
A=list_default end
for E,O in pairs(w)do A(R,E,O)
if O.time<=0 then
if O.on_remove then
for _,c in ipairs(O.on_remove)do
t,g=pcall(c,E,O)if not t then
addError(string.format("step(%s): on_remove[%d]: %s\n",tbl_name(w),_,g))end end end;N[#N+1]=E else O.time=O.time-I
if O.callback then
for U,_ in ipairs(O.callback)do t,g=pcall(_,E,O)if
not t then
addError(string.format("step(%s): callback[%d]: %s\n",tbl_name(w),U,g))N[#N+1]=E;break end end end end end;for E,x in ipairs(N)do T(x)end end
function clearT(R)local Q={'<TI>'}Q[#Q+1]='<p align="center">Joints</p>'
step(R,jointData,removeJoint,Q)Q[#Q+1]='<p align="center">Objects</p>'
step(R,objectData,removeObject,Q,list_object)Q[#Q+1]='<p align="center">Grounds</p>'
step(R,groundData,removeGround,Q)Q[#Q+1]='<p align="center">Bullets</p>'
step(R,bulletData,removeBullet,Q,list_bullet)Q[#Q+1]='<p align="center">Patterns</p>'
step(R,patternData,removePattern,Q)
ui.addTextArea(2,table.concat(Q),nil,-155,5,150,590,nil,nil,0.5,true)end
function shoot_bullet(v,y)local P=y.callback_args;if P._cd==nil then P._cd=0 end
if P._cd>0 then
P._cd=P._cd-1 else P._cd=P.cd
local v=addBullet(P.btype,P.bdata,P.bttl,P.callback,P.on_remove,P.cbargs)
if P.mtype~=nil then addMotion(P.mtype,v,true,P.mdata)end end end;function explode(O,X)local v=X.callback_args
addExplosion(v.x,v.y,v.power,v.distance,v.miceOnly,v.p1,v.p2)end
function explode1(s,Z)
local r=Z.callback_args
if r.t<=0 then
local t=randomKey1(tfm.get.room.playerList,Z.user,true)local B,l=0,0;if t~=nil then local Y=tfm.get.room.playerList[t]
B,l=Y.x,Y.y end
addExplosion(B,l,r.power,r.distance,r.miceOnly,r.p1,r.p2)r.t=r.cd else r.t=r.t-1 end end;function accelerate(e,g)local J=g.callback_args
moveObject(e,0,0,true,J.ax,J.ay,true)end
function moveHoming(_,t)
if
t.time<=7 and t.time>=5 then local x=t.callback_args
local h=tfm.get.room.playerList[x.target]
if h~=nil then local i=h.x;local W=h.y;local a=x.x;local b=x.y;i=i-a;W=W-b;local m=i*i+W*W;if m>0 then m=x.v/
math.sqrt(m)i=i*m;W=W*m end
moveObject(_,0,0,true,i,W,false)end end end
function addObject(h,c,_,p,q,O,s,T,o,F,i)local D=do_addObject(h,c,_,p,q,O,s)if T==nil then T=3 end
objectData[D]={time=T,callback=to_table(o),on_remove=to_table(F),callback_args=i}return D end
function removeObject(k)do_removeObject(k)objectData[k]=nil end
function addGround(J,K,D,R,i,S,o)local w=newId(groundId)do_addGround(w,J,K,D)
if R==nil then R=3 end
groundData[w]={time=R,callback=to_table(i),on_remove=to_table(S),callback_args=o}return w end;function removeGround(m)do_removeGround(m)groundData[m]=nil
freeId(groundId,m)end
function addJoint(G,e,j,U,N,y,n)local B=newId(jointId)
do_addJoint(B,G,e,j)if U==nil then U=-1 end;if j==nil then j={}end
jointData[B]={time=U,callback=to_table(N),on_remove=to_table(y),callback_args=n}return B end
function removeJoint(K)do_removeJoint(K)jointData[K]=nil;freeId(jointId,K)end
function addPattern(a,B,Q,L)local y=nil;if Q.time~=nil then y=newId(patternId)
patternData[y]={time=Q.time,callback=Q.callback,on_remove=Q.on_remove}end
Q.func(a,B,y,L)return y end
function removePattern(a)patternData[a]=nil;freeId(patternId,a)end
function addExplosion(D,p,M,J,k,P,u)if P~=nil then addParticle(P,D,p,0,0,0,0)end
if u~=nil then end;do_addExplosion(D,p,M,J,k)end
function addGround1(E,C,l,p)local i=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=i;do_addGround(i,C,l,p)E[#E+1]=i end
function addJoint1(L,P,u,i)local j=newId(jointId)
_tmp_joints[#_tmp_joints+1]=j;do_addJoint(j,P,u,i)L[#L+1]=j end
function addBullet(K,h,A,v,l,o)local F=newId(bulletId)_tmp_grounds={}_tmp_joints={}
local e,T,x,Y=pcall(K,h)
if e then
bulletData[F]={controls={T},grounds=x,joints=Y,time=A or 6,callback=to_table(v),on_remove=to_table(l),callback_args=o}else for Z,t in ipairs(_tmp_joints)do removeJoint(t)end;for y,p in
ipairs(_tmp_grounds)do removeGround(p)end;freeId(bulletId,F)
error(string.format('addBullet: %s',T))end;return F end
function removeBullet(H)local f=bulletData[H]for K,A in ipairs(f.joints)do do_removeJoint(A)
freeId(jointId,A)end;for _,Q in ipairs(f.grounds)do
do_removeGround(Q)freeId(groundId,Q)end
bulletData[H]=nil;freeId(bulletId,H)end;bullet={}
bullet.rectangle=function(s)local K,P,B=s.x,s.y,s.angle;local n,v=s.width,s.height
local g,k=s.jdata,s.hitbox_data;local U,l=math.cos(B),math.sin(B)local X=n/2.0
local f={type=0,point1=string.format("%d,%d",K,P),point2=string.format("%d,%d",
K+U*n,P+l*n),color=0xFF0000,line=2.0*v+4,foreground=false}
local b={type=12,width=n,height=v,angle=math.deg(B),miceCollision=true,groundCollision=false,foreground=true,dynamic=true,restitution=255}copy(b,k)local z=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=z;do_addGround(z,K+U*X,P+l*X,b)local A={}if g then for d,r in ipairs(g)do copy(f,r)
addJoint1(A,z,z,f)end end;return z,{z},A end
bullet.circle=function(H)local c,v,x=H.x,H.y,H.R;local q,t=H.jdata,H.hitbox_data
local O=string.format('%d,%d',c,v+1)local G={type=0,point2=O,color=0x0000FF,line=2*x,foreground=false}
local z={type=13,width=x,height=x,miceCollision=true,groundCollision=false,dynamic=true,restitution=255}copy(z,t)local N=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=N;do_addGround(N,c,v,z)local a={}if q then for P,l in ipairs(q)do copy(G,l)
addJoint1(a,N,N,G)end end;return N,{N},a end
bullet.butterfly=function(j)local I,q,a,P=j.x,j.y,j.angle,j.R;local S,U=j.center_jdata,j.wing_jdata
local Z=j.hitbox_data;local K=make_star(5,2)
local b={type=0,color=0xFF00FF,alpha=0.25,line=K.l*P*2,foreground=false}
local u={type=0,point1=string.format('%d,%d',I,q),point2=string.format('%d,%d',I,q+1),color=0x0000FF,line=P*2,foreground=false}
local X={type=13,width=P,height=P,dynamic=true,miceCollision=true,groundCollision=false,restitution=255}copy(b,U)copy(X,Z)local o={}local F={}local O,R
local Y,H=math.cos(a),math.sin(a)local T;local V=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=V;do_addGround(V,I,q,X)
for i=2,5 do T=K.points[i]O,R=T[1]*Y-T[2]*H,T[1]*H+
T[2]*Y;O,R=I+P*O,q+P*R
b.point1=string.format('%d,%d',O,R)b.point2=string.format('%d,%d',O,R+1)
addJoint1(o,V,V,b)end;copy(u,S)addJoint1(o,V,V,u)return V,{V},o end
bullet.jstar=function(b)local t,G,o,g=b.x,b.y,b.angle,b.R;local M,O=b.points,b.step
local x,i=b.line_jdata,b.center_jdata;local w=b.hitbox_data;local S=make_star(M,O)
local r={type=0,color=0xFFFFFF,line=5,foreground=true}local V=g*S.r
local X={type=0,point1=string.format('%d,%d',t,G),point2=string.format('%d,%d',t,G+1),color=0xFFFFFF,line=V*2,foreground=true}
local D={type=13,width=V,height=V,dynamic=true,miceCollision=true,groundCollision=false,restitution=255}copy(r,x)copy(D,w)local K={}local j={}local _,I
local C,Q=math.cos(o),math.sin(o)
for H,U in ipairs(S.points)do _,I=U[1]*C-U[2]*Q,U[1]*Q+U[2]*C;j[#j+1]=string.format('%d,%d',
t+g*_,G+g*I)end;local f=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=f;do_addGround(f,t,G,D)for i=1,M do r.point1=j[i]
r.point2=j[1+ (i+O-1)%M]addJoint1(K,f,f,r)end
if i then for z,E in ipairs(i)do
copy(X,E)addJoint1(K,f,f,X)end end;return f,{f},K end
bullet.star=function(B)local _,k,S,M=B.x,B.y,B.angle,B.R;local z,T,Y=B.points,B.step,B.do_cap
local X,H=B.line_data,B.center_data;local o=B.cap_data;local d=make_star(z,T)
local U={type=12,height=1,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}local E=M*d.r
local N={type=13,width=E,height=E,color=0xFFFFFF,groundCollision=false,miceCollision=true,dynamic=true,foreground=true,restitution=255}
local f={type=13,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}E=string.format('%d,%d',_,k)
local l={type=3,point1=E,point2=E,ratio=1,limit1=0,limit2=0}local y={type=0,frequency=10}copy(U,X)copy(N,H)copy(f,o)
local t,e,Z={},{},{}local J,P;local B=math.deg(S)local u,w=math.cos(S),math.sin(S)
for s,R in
ipairs(d.lines)do U.angle=R.angle+B;U.width=R.width*M
J,P=R.x*u-R.y*w,R.x*w+R.y*u;addGround1(t,_+M*J,k+M*P,U)end;if Y then
for O,s in ipairs(d.points)do J,P=s[1]*u-s[2]*w,s[1]*w+s[2]*u;addGround1(e,
_+M*J,k+M*P,f)end end
local D=newId(groundId)_tmp_grounds[#_tmp_grounds+1]=D
do_addGround(D,_,k,N)
if U.dynamic then local L,x=nil,nil;for s,W in ipairs(t)do addJoint1(Z,W,D,l)if L~=nil then
addJoint1(Z,W,L,y)else x=W end;L=W end
addJoint1(Z,x,L,y)elseif N.dynamic then for F,i in ipairs(t)do addJoint1(Z,i,D,l)end end
if Y then
if f.dynamic then local a,A=nil,nil
for i=1,z do addJoint1(Z,e[i],t[i],l)if a~=nil then
addJoint1(Z,e[i],a,y)else A=e[i]end;a=e[i]end;addJoint1(Z,A,a,y)elseif U.dynamic then
for i=1,z do addJoint1(Z,e[i],t[i],l)end end end;append(t,e)t[#t+1]=D;return D,t,Z end
function bomb(u,Y)
if Y.bomb_cd==0 and not Y.bombing then
if Y.bombs>=Y.bomb.cost then Y.bombs=Y.bombs-
Y.bomb.cost;Y.bombing=true;Y.bombTime=Y.bomb.time
local p,f=pcall(Y.bomb.func,u,Y)addBomb(u,Y)updateTextAreas(u,Y)if not p then
addError(string.format("bomb: %s: %s",u,f))end else
alert(string.format('bombs &lt; %d',Y.bomb.cost),u)end end end
function addBomb(j,A)local C=bombs.top+1
local J=string.format('<TI><font color="#%X">%s <font color="#5F5F8D">|</font> %s</font>',A.color,j,A.bomb.name)A.bomb_id=C;bombs.top=C;bombs.val[C]=J;setShamanName(J)end
function removeBomb(B,D)local X=D.bomb_id;D.bomb_id=nil;bombs.val[X]=nil
if X==bombs.top then X=X-1;while
bombs.val[X]==nil and X>0 do X=X-1 end;bombs.top=X;if X>0 then
X=bombs.val[X]else X=''end;setShamanName(X)end end;function do_addControl(e,O)e[#e+1]=O end;function do_removeControl(r,Q)
while r[Q]do r[Q]=nil;Q=Q+1 end end;function motionEnd(X,J)
do_removeControl(J.callback_args._controls,J.callback_args._idx)end
function addControl(h,...)local F=#h+1
local o=addGround(...)local r=groundData[o]
if r.callback_args==nil then
r.callback_args={_controls=h,_idx=F}else r.callback_args._controls=h;r.callback_args._idx=F end;if r.on_remove==nil then r.on_remove={motionEnd}else
r.on_remove[#r.on_remove+1]=motionEnd end;h[#h+1]=o;return o end;function addControl1(v,...)return addGround(...)end
function addMotion(l,d,J,o)local Q;local e;if J then
Q=bulletData[d].controls;e=addControl else Q={d}e=addControl1 end
local a,u=pcall(l,e,Q,o)if not a then
error(string.format("addMotion: %s",u))end end;motion={}
motion.fix=function(o,w,C)local Z=0;local j=w[#w]local d={type=0,frequency=10}
copy(d,C.jdata)if not C.last then
Z=o(w,C.x or 0,C.y or 0,CONTROL,C.ttl or 3)end;addJoint(j,Z,d,C.ttl or 3)end
motion.line=function(p,O,W)local R=W.x or 0;local l=W.y or 0;local P=W.ttl or 3;local u=0;local k
local t={type=1,axis='-1,0',angle=0,forceMotor=255,speedMotor=1}copy(t,W.jdata)if W.free_angle then
motion.fix(p,O,{ttl=P,x=R,y=l})end;k=O[#O]
if not W.last then u=p(O,R,l,CONTROL,P)end;addJoint(k,u,t,P)end
motion.circle=function(Q,J,F)local o=0;local z=J[#J]local P={type=3,forceMotor=255,speedMotor=1}
copy(P,F.jdata)if not F.last then
o=Q(J,F.x or 0,F.y or 0,CONTROL,F.ttl or 3)end;if F.x and F.y then
P.point1=string.format('%d,%d',F.x,F.y)end;addJoint(z,o,P,F.ttl or 3)end
motion.spiral=function(L,p,x)local o=x.last;x.last=false;x.jdata=x.tjoint
motion.line(L,p,x)x.last=o;x.jdata=rjoint;motion.circle(L,p,x)end
function addBombTimer(J,x,P,O,q)local s=P.bombTime*q+2
local p={type=13,angle=0,color=0xFF0000,foreground=false,friction=0.0,restitution=2.0,width=s,height=s,miceCollision=false,groundCollision=O,dynamic=false}
addGround(x.x,x.y,p,P.bombTime,moveBombTimer,nil,{player=J,pdata=P,offset=2,scale=q,obj=p})s=s-2
p={type=13,angle=0,color=0x6A7495,foreground=false,friction=0.0,restitution=2.0,width=s,height=s,miceCollision=false,groundCollision=O,dynamic=false}
addGround(x.x,x.y,p,P.bombTime,moveBombTimer,nil,{player=J,pdata=P,offset=0,scale=q,obj=p})end
function moveBombTimer(c,A)local X=A.callback_args
local k=tfm.get.room.playerList[X.player]local x=X.pdata.bombTime*X.scale+X.offset
X.obj.width=x;X.obj.height=x;do_addGround(c,k.x,k.y,X.obj)end
function defaultBombCallback(r,h)local b=tfm.get.room.playerList[r]
local D=b.y+b.vy;local q;local d,s;local y=h.bombCallbackArgs;local o=4;local _=4;local K=0;local x={ax=64,ay=0}_=y*_
x.ax=y*x.ax;q=b.x+y*h.bombTime*5+10
for off=20,120,20 do s=off*y
d=q+s*1.5
addObject(objcode.anvil,d,D-s,0,_,-K*y,false,o,accelerate,nil,x)
addObject(objcode.anvil,d,D+s,0,_,K*y,false,o,accelerate,nil,x)K=K+1 end end
function defaultBomb(y,i)local g=tfm.get.room.playerList[y]
if
not g.isFacingRight then i.bombCallbackArgs=-1 else i.bombCallbackArgs=1 end;addBombTimer(y,g,i,true,5)end
function bomb2(f,d)local F=tfm.get.room.playerList[f]local u,N=F.x,F.y
local O=string.format('%d,%d',u,N)
local z={type=12,color=0xFFFFFF,foreground=true,width=512,height=8,dynamic=true,mass=8,restitution=255,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=true}
local p={type=13,color=0xFFFFFF,width=32,height=32,dynamic=false,groundCollision=false,miceCollision=false,foreground=true}local C={type=3,point1=O,point2=nil,forceMotor=255,speedMotor=2}
local o={type=3,point1=O,point2=O,ratio=1,limit1=0,limit2=8}local e={type=0,frequency=10}local I;local t;local W,k;local w,a
local Y=32.0+z.width/2.0;local M=20;local E=nil;local s=nil;local X,i;addBombTimer(f,F,d,true,5)
i=addGround(u,N,p,M)
for I=0,359,120 do t=math.rad(I)W,k=math.cos(t),math.sin(t)
w,a=u+Y*W,N+Y*k;z.angle=I;X=addGround(w,a,z,M)addJoint(X,i,C,M)if s~=nil then
addJoint(X,s,o,M)addJoint(X,s,e,M)else E=X end;s=X end;addJoint(E,X,o,M)addJoint(E,X,e,M)end
function bomb3(B,I)local C=tfm.get.room.playerList[B]local F,Q=C.x,C.y
local j=string.format('%d,%d',F,Q)
local t={type=13,color=0xFFFFFF,width=64,height=64,dynamic=true,mass=1,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=false,foreground=true}
local s={type=1,axis='-1,0',forceMotor=255,speedMotor=2,limit1=0,limit2=5}local M;local _;local R,i;local y,S;local v=64.0+t.width;local h=5;local N;local z
addBombTimer(B,C,I,true,10)
local n={[0]=0.15,[60]=0.13,[120]=0.11,[180]=0.075,[240]=0.05,[300]=0}
for M=0,359,60 do _=math.rad(M)y,S=math.cos(_),math.sin(_)
R,i=F+v*y,Q+v*S
z={x=F+math.cos(_+n[M])*280,y=Q+
math.sin(_+n[M])*280,power=127,distance=3*t.width,miceOnly=false,p1=particles.red_spirit,p2=nil}N=addGround(R,i,t,h,nil,explode,z)
s.angle=2.0*math.pi-_;addJoint(N,0,s,h)end end
function pattern(n,c,g,K,e)local S=c.patterns[g][K]
if S~=nil then local M=#S.points+1
if M>=
S.type.points then local N=os.time()
if N-S.lastTime>=S.type.cd then S.lastTime=N
S.points[M]=e;local x,m=pcall(addPattern,n,c,S.type,S.points)S.points={}if not x then
addError(string.format("pattern: %s: %s",n,m))end end else S.points[M]=e end end end
function bind(P,N,f,g)local c=playerData[P]local F=c.patterns[N]if F[f]~=nil then
do_unbind(c,F[f],N,f)end
F[f]={id=g,type=patternTypes[g],points={},lastTime=0}F=c.pattern_data[g]
if N=='key'then bindKey(P,f,true,true)end
if F==nil then c.pattern_data[g]={binds=1}else F.binds=F.binds+1 end end
function do_unbind(g,m,K,C)local r=g.pattern_data[m.id]if r.binds<=1 then
g.pattern_data[m.id]=nil else r.binds=r.binds-1 end;g.patterns[K][C]=
nil end
function unbind(r,u,A)local M=playerData[r]
if u==nil then M.patterns={key={},obj={},objend={}}
M.pattern_data={}elseif A==nil then local Z={}
for o,S in pairs(M.patterns[u])do Z[#Z+1]={o,S}end;for z,Y in ipairs(Z)do do_unbind(M,Y[2],u,Y[1])end else
local Z=M.patterns[u][A]if Z~=nil then do_unbind(M,Z,u,A)end end end
function testPattern(A,o,y,p)local R=p[1]local D=6;local W=48;local L=math.random(2,8)local Q,v,g
local c=math.rad(R.angle)for i=0,D-1 do Q=c+2.0*math.pi*i/D
v,g=math.cos(Q),math.sin(Q)
addObject(R.type,R.x+W*v,R.y+W*g,R.angle+360*i/D,L*v,L*g,false,9)end end
function testPattern1(b,P,B,M)local d=M[1]local i=math.random(8,16)local m,O,H;local x;local B
local Z={angle=0.25-math.pi/2.0,R=16,center_jdata={},wing_jdata={line=24,alpha=0.5},hitbox_data={width=0,height=0,color=0xFFFFFF,mass=1}}local c={ttl=2,last=true,jdata={}}
for i=1,i do x=math.random(64,96)m=
math.random()*2.0*math.pi
O,H=math.cos(m),math.sin(m)Z.x=d.x+x*O;Z.y=d.y+x*H
Z.center_jdata.color=randomColor()Z.wing_jdata.color=randomColor()
c.jdata.speedMotor=math.random(2,6)c.jdata.angle=2*math.pi-m
B=addBullet(bullet.butterfly,Z,8)addMotion(motion.line,B,true,c)end end
function testPattern2(h,M,G,n)local U=n[1]
local z={x=U.x,y=U.y,angle=math.rad(U.angle),width=math.random(400,800),height=13,jdata={{color=randomColor()},{color=0xFFFFFF,line=16}},hitbox_data={dynamic=true,mass=1,linearDamping=255,angularDamping=255}}addBullet(bullet.rectangle,z,8)end
function testPattern3(i,j,b,P)local G=P[1]local O=randomColor()
local A,U=to_axis(math.rad(-G.angle))
local D={x=G.x,y=G.y,angle=U,R=36,points=math.random(5,8),step=2,line_jdata={color=O},center_jdata={{foreground=false,color=O,line=76},{color=0x6A7495,line=70}},hitbox_data={dynamic=true,miceCollision=false}}
local n={cd=0,btype=bullet.rectangle,bttl=10,bdata={x=G.x,y=G.y,angle=-U,width=128,height=13,jdata={{color=randomColor(),foreground=false},{color=0xFFFFFF,line=16,foreground=true}},hitbox_data={dynamic=true,fixedRotation=true,mass=1}},mtype=motion.line,mdata={x=G.x,y=G.y,ttl=1,last=true,free_angle=true,jdata={speedMotor=8,axis=A}}}local b=addBullet(bullet.jstar,D,32,shoot_bullet,nil,n)
addMotion(motion.circle,b,true,{last=true,ttl=2,jdata={speedMotor=4}})end
function shoot(Q,O)
if O.shot_cd==0 then
if O.bombing and O.bomb.shot~=nil then
O.shot_cd=O.bomb.shot.cd;local U,N=pcall(O.bomb.shot.func,Q,O)if not U then
addError(string.format("shoot(bombing): %s: %s",Q,N))end else O.shot_cd=O.shot.cd
local o,v=pcall(O.shot.func,Q,O)if not o then
addError(string.format("shoot: %s: %s",Q,v))end end end end
function defaultShot(Y,u)local R=tfm.get.room.playerList[Y]local X,q=R.x,R.y;local B;if
R.isFacingRight then B=-1 else B=1 end;local H=math.random()*math.pi
local D={x=X+64*
math.cos(H),y=q+64*math.sin(H),angle=0,R=16,points=5,step=2,line_jdata={color=randomColor()},center_jdata={{}}}
local v={last=true,ttl=math.random(1,4),x=X,y=q,jdata={speedMotor=4*B}}local t=addBullet(bullet.jstar,D,8)H=
math.random()*math.pi+math.pi
D.x=X+64*math.cos(H)D.y=q+64*math.sin(H)
D.line_jdata.color=randomColor()local A=addBullet(bullet.jstar,D,8)
addMotion(motion.circle,t,true,v)v.ttl=math.random(1,4)v.jdata.speedMotor=-4*B
addMotion(motion.circle,A,true,v)end
function homingShot(W,V)
local s=randomKey1(tfm.get.room.playerList,W,false)local h=tfm.get.room.playerList[W]local L=h.x;local _=h.y;local w=2
local A=2;local p=false;if not h.isFacingRight then w=-w end;L=L+16*w
local k={target=s,x=L,y=_+32,v=128}
addObject(objcode.anvil,L+w,_+A,0,w,A,p,10,moveHoming,nil,k)local k={target=s,x=L,y=_-32,v=128}
addObject(objcode.anvil,L+w,_-A,0,w,-A,p,10,moveHoming,nil,k)end
function initPlayer(K)
local c={color=randomColor(),shooting=false,bombing=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},spawn={200,200},vx=0,lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}if playerConfig[K]==nil then playerConfig[K]={}end
copy(c,playerConfig[K])playerData[K]=c;for o,L in pairs(playerKeys)do bindKey(K,L,true,true)
bindKey(K,L,false,true)end
ui.addTextArea(1,getText(c),K,5,25,151,40,nil,nil,0.5,true)
ui.addTextArea(104,'<TI><a href="event:help">?</a>',K,145,25,11,20,nil,nil,0.0,true)
ui.addTextArea(ERROR_TA,table.concat(_errors),K,805,5,200,590,nil,nil,0.5,true)do_respawn(K)setShaman(K)
setNameColor(K,playerData[K].color)end
function resetPlayer(E)
local g={shooting=false,bombing=false,bombTime=nil,lives=5,bombs=3,shot_cd=0,bomb_cd=0,vx=0,bomb_id=nil}local d=playerData[E]copy(d,g)updateTextAreas(E,d)
do_respawn(E)setShaman(E)setNameColor(E,d.color)end;function deletePlayer(k)local l=playerData[k]if l.bombing then removeBomb(k,l)end;playerData[k]=
nil end
function respawn(c)
do_respawn(c)setNameColor(c,playerData[c].color)end;playerData={}objectData={}groundData={}jointData={}patternData={}bulletData={}
MAX_ID=400;MAX_ERRORS=7
CONTROL={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}playerKeys={32,83,40,100,101,102,104,65,68,69,81,37,39}
reservedKeys=invert(playerKeys,true)eventCode={key=keycode,obj=objcode,objend=objcode}
defaultMap='<C><P defilante="0,0,0,1" L="1600" H="800" G="0,0" /><Z><S /><D><DS Y="200" X="200" /></D><O /></Z></C>'maxLives=8;maxBombs=6
shotTypes={{func=defaultShot,cd=1},{func=homingShot,cd=2}}
bombTypes={{name='default bomb',func=defaultBomb,callback=defaultBombCallback,shot={func=nop,cd=1},cost=1,time=20,cd=0},{name='',func=bomb2,callback=
nil,shot={func=nop,cd=1},cost=1,time=20,cd=5},{name='',func=bomb3,callback=nil,shot={func=nop,cd=1},cost=1,time=6,cd=5}}
patternTypes={{func=testPattern,time=0,callback=nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern1,time=0,callback=
nil,cd=500,points=1,maxBinds=3,restrict={key=nil,obj=nil,objend=nil}},{func=testPattern2,time=0,callback=
nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern3,time=32,callback=
nil,cd=250,points=1,maxBinds=2,restrict={key={},obj=nil,objend=nil}}}
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
]]}
MODULE_HELP_CLOSE='<TI><a href="event:help_close"><p align="center">X</p></a>'
do
local J=function(h,H)local d={'<font face="mono" size="15">'}
for A,y in ipairs(h)do
if y.name then
d[#d+1]=string.format('%d - %s\n',A,y.name)else d[#d+1]=string.format('%d\n',A)end
if y.cost then d[#d+1]=string.format('    Cost: %d\n',y.cost)end;if y.time then
d[#d+1]=string.format('    Duration: %fs\n',y.time/2.0)end;if y.cd then
d[#d+1]=string.format('    Cooldown: %fs\n',y.cd/H)end;if y.maxBinds then
d[#d+1]=string.format('    Max. binds: %d\n',y.maxBinds)end;d[#d+1]='\n'end;return table.concat(d)end;MODULE_HELP['Shot types']=J(shotTypes,2.0)
MODULE_HELP['Bomb types']=J(bombTypes,2.0)MODULE_HELP['Pattern types']=J(patternTypes,1000.0)end
do
local E=function(Y,O)local D={'<font face="mono" size="15">'}local I;for y,R in ipairs(keys1(Y))do
I=O-#R;if I>0 then y=R..string.rep(' ',I)else y=R end
D[#D+1]=string.format('%s = %4d\n',y,Y[R])end
D[#D+1]='</font>'return table.concat(D)end;MODULE_HELP['Shaman objects']=E(objcode,15)end
MODULE_CHAT_COMMAND={['help']=help,['clear']=clear,['color']=function(c,n,E)E=string.upper(E)
if E==''or E=='RANDOM'or E==
'RND'then setColor(c,randomColor())playerConfig[c].color=
nil else local b=tonumber(E)if b~=nil then if b>0xFFFFFF then b=0xFFFFFF end
setColor(c,E)playerConfig[c].color=E else
alert('Invalid color: '..E,c)end end end,['reset']=function(N,F,y)
y=string.lower(y)if y==''or y=='map'then setMap(defaultMap)else
parsePlayerNames(N,y,resetPlayer)end end,['init']=function(O,t,M)local s=function(O)
deletePlayer(O)initPlayer(O)end
parsePlayerNames(O,M,s)end,['respawn']=function(b,w,t)
parsePlayerNames(b,t,respawn)end,['shot']=function(j,S,G)local i=tonumber(G)if i==nil then
alert('Invalid shot type: '..G,j)return end;i=shotTypes[i]
if i~=nil then
playerData[j].shot=i else alert('Invalid shot type: '..G,j)end end,['bomb']=function(e,Q,b)
local L=tonumber(b)
if L==nil then alert('Invalid bomb type: '..b,e)return end;L=bombTypes[L]if L~=nil then playerData[e].bomb=L else
alert('Invalid bomb type: '..b,e)end end,['bind']=function(A,w,C)
C=split(C)if#C<3 then alert('Too few arguments',A)return elseif#C>3 then
alert('Too many arguments',A)return end
i=tonumber(C[1])local J=patternTypes[i]if i==nil or J==nil then
alert('Invalid pattern: '..C[1],A)return end;j=C[2]
if j~='key'and j~='obj'and
j~='objend'then alert('Invalid event: '..j,A)return end;local l=tonumber(C[3])
if l==nil then l=eventCode[j][C[3]]if l==nil then
alert(string.format('Invalid %s name/code: %s',j,C[3]),A)return end end;if
J.restrict[j]~=nil and J.restrict[j][l]==nil then
alert(string.format('Can\'t bind pattern %d to %s %d: restricted',i,j,l),A)return end;if
j=='key'and reservedKeys[l]then
alert(string.format('Can\'t bind pattern %d to %s %d: reserved',i,j,l),A)return end
local o=playerData[A]local B=o.pattern_data[i]if B~=nil and J.maxBinds<=B.binds then
alert(string.format('Can\'t bind pattern %d to more than %d events',i,J.maxBinds),A)return end
bind(A,j,l,i)end,['unbind']=function(G,k,K)
K=split(K)if#K>2 then alert('Too many arguments',G)return end
i=K[1]
if i=='all'or i==nil then unbind(G)elseif
i~='key'and i~='obj'and i~='objend'then alert('Invalid event: '..i,G)return else
if K[2]==nil then
unbind(G,i)else j=tonumber(K[2])
if j==nil then j=eventCode[i][K[2]]if j==nil then
alert(string.format('Invalid %s name/code: %s',i,K[2]),G)return end end;unbind(G,i,j)end end end,['map']=function(S,g,F)if
F==''then F=defaultMap end;setMap(F)end}
MODULE_CHAT_COMMAND_1=function(l,Q,a)alert('Invalid command: '..Q,l)end;eventNewPlayer=initPlayer;eventPlayerLeft=deletePlayer
eventTextAreaCallback=helpTextAreaCallback
function eventNewGame()initTimers()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)tfm.exec.setGameTime(0)objectData={}groundData={}
jointData={}patternData={}bulletData={}bombs={top=0,val={}}groundId={max=0,free={}}
jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}for z,y in
pairs(tfm.get.room.playerList)do resetPlayer(z)end
setMapName('<TI>')setShamanName('')
do_addGround(0,0,0,{type=13,width=10,height=10,color=0xFFFFFF,dynamic=false,miceCollision=false,groundCollision=false})end
function eventKeyboard(K,p,w,a,F)
if reservedKeys[p]then
if p==65 then local R=playerData[K]if w then bomb(K,R)end elseif p==69 then
local c=playerData[K]c.shooting=w;if w then shoot(K,c)end else local u=0;local e=0
if not w then
if

p==32 or p==104 or p==83 or p==40 or p==53 or p==101 then movePlayer(K,0,0,true,0,1,false)
movePlayer(K,0,0,true,0,-1,true)else movePlayer(K,0,0,true,1,0,false)
movePlayer(K,0,0,true,-1,0,true)playerData[K].vx=0 end else
if p==32 or p==104 or p==87 then u=-50 elseif p==83 or p==40 or p==101 then u=50 elseif p==
100 or p==37 or p==81 then e=-50 elseif p==102 or p==39 or p==68 then e=50 end;if e~=0 then playerData[K].vx=e elseif p==83 or p==40 then
e=playerData[K].vx end;if e~=0 or u~=0 then
movePlayer(K,0,0,true,e,u,false)end end end elseif w then local s=playerData[K]pattern(K,s,'key',p,{x=a,y=F})end end;function eventSummoningStart(n,h,L,Z,E)local W={x=L,y=Z,angle=E,type=h}
pattern(n,playerData[n],'obj',h,W)end
function eventSummoningEnd(Q,M,H,k,s,q,N,T,A)
objectData[T.id]={time=3}local v={x=H,y=k,angle=s,type=M,vx=q,vy=N,data=T,other=A}
pattern(Q,playerData[Q],'objend',M,v)end
function eventMouse(E,T,D)local k=tfm.get.room.playerList[E]end
function eventPlayerDied(u)local T=playerData[u]
if T~=nil then
if T.bombing then respawn(u)else T.shot_cd=0
T.bomb_cd=0;T.shooting=false;T.lives=T.lives-1;if T.lives>0 then T.bombs=T.resetBombs
updateTextAreas(u,T)respawn(u)else
alert(string.format('playerData["%s"].lives &lt;= 0',u),u)end end end end
function eventLoop(n,z)local O,M,g,f,Q,t,h,v;clearT(1)
for Y,G in pairs(playerData)do
O=tfm.get.room.playerList[Y]
if not O.isDead then M=O.x;g=O.y;if M<0 then M=10 elseif M>4800 then M=4790 end;if g<0 then g=10 elseif g>1600 then
g=1590 end;G.spawn[0]=M;G.spawn[1]=g;f=-O.vx;Q=-O.vy;t=-
O.vx/10;h=-O.vy/10
for v=1,math.random(8,16)do
addParticle(particles.purple,M+
math.random(-4,4),g+math.random(-4,4),
(f+math.random()*2-1)/v,(Q+math.random()*2-1)/v,t,h)end end;if G.shot_cd>0 then G.shot_cd=G.shot_cd-1 end;if G.bomb_cd>0 then G.bomb_cd=
G.bomb_cd-1 end
if G.shooting then shoot(Y,G)end
if G.bombing then G.bombTime=G.bombTime-1
if G.bombTime<=0 then G.bombing=false
G.bomb_cd=G.bomb.cd;removeBomb(Y,G)else if G.bomb.callback then
local D,d=pcall(G.bomb.callback,Y,G)
if not D then addError('bomb.callback: '..d)end end end end end end
for Y,h in pairs(tfm.get.room.playerList)do initPlayer(Y)end;setMap(defaultMap)