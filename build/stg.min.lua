do_addObject=tfm.exec.addShamanObject
do_removeObject=tfm.exec.removeObject;do_addGround=tfm.exec.addPhysicObject
do_removeGround=tfm.exec.removePhysicObject;do_addJoint=tfm.exec.addJoint;do_removeJoint=tfm.exec.removeJoint
do_respawn=tfm.exec.respawnPlayer;do_addExplosion=tfm.exec.explosion
addParticle=tfm.exec.displayParticle;setShaman=tfm.exec.setShaman
setShamanName=tfm.exec.setUIShamanName;setMapName=tfm.exec.setUIMapName
setNameColor=tfm.exec.setNameColor;movePlayer=tfm.exec.movePlayer;moveObject=tfm.exec.moveObject
setMap=tfm.exec.newGame;bindKey=tfm.exec.bindKeyboard;kill=tfm.exec.killPlayer;function nop()end;function randomColor()return
math.random(0x000000,0xFFFFFF)end;function round(a)
local X=math.floor(a)if a-X>=0.5 then X=X+1 end;return X end;function to_table(f)
if f==
nil or type(f)=='table'then return f else return{f}end end
_axis={'-1,0','-1,1','0,1','1,1','1,0','1,-1','0,-1','-1,-1'}_axis_step=math.pi/4.0
function to_axis(d)
local v=(round(d/_axis_step)%#_axis)return _axis[v+1],_axis_step*v end
function rotate(A,K,g,G,r,M)A,K=A-g,K-G;A,K=A*r-K*M,A*M+K*r;return g+A,G+K end
function length1(i)return math.sqrt(i.x*i.x+i.y*i.y)end
function cache2(Z)local w={}return
function(n,v)local i=w[n]local j=nil;if i==nil then i={}w[n]=i else j=i[v]end;if j==nil then
j=Z(n,v)i[v]=j end;return j end end;function split(I)local u={}for Q in string.gmatch(I,'[^%s]+')do u[#u+1]=Q end
return u end
function parsePlayerNames(D,I,d)
if I==''then d(D)return end;local O={}local C
for U,Y in ipairs(split(string.lower(I)))do
if
string.sub(Y,1,1)=='!'then Y=string.sub(Y,2)C=nil else C=true end
if Y=='me'then O[D]=C elseif Y=='all'then for U,Y in pairs(playerData)do O[U]=C end else
Y=string.gsub(Y,'^%l',string.upper)if playerData[Y]==nil then
alert('Invalid player: '..Y,D)return else O[Y]=C end end end;for _,S in pairs(O)do d(_)end end;unescape_map={a='\a',b='\b',f='\f',n='\n',r='\r',t='\t'}
function do_unescape(w,a)local u=tonumber(
w..a)if u==nil then
return(unescape_map[w]or w)..a else return string.char(u)end end
function unescape(H)return string.gsub(H,'\\(.)(%d?%d?)',do_unescape)end;function do_unpack(w,q,m)
if q<=m then return w[q],do_unpack(w,q+1,m)else return nil end end;function unpack(H,g)if g==nil then g=#H end;return
do_unpack(H,1,g)end;function length(w)local g=0
for C in pairs(w)do g=g+1 end;return g end;function copy(c,H)if H~=nil then
for L,d in pairs(H)do c[L]=d end end end;function append(v,R)for n,w in ipairs(R)do v[#v+
1]=w end end;function invert(T,A)local p={}
if A==nil then for c,L in
pairs(T)do p[L]=c end else for R,W in pairs(T)do p[W]=A end end;return p end
function keys(N)
local R={}for D,m in pairs(N)do R[#R+1]=D end;return R end;function keys1(c)local z=keys(c)table.sort(z)return z end
function randomKey1(G,e,Z)
local g,w={},1;for p,E in pairs(G)do if p~=e then g[w]=p;w=w+1 end end
if w>1 then return g[math.random(1,#
g)]elseif Z then return nil else return e end end;function randomValue1(B,b,j)local H=randomKey1(B,b,j)
if H~=nil then return B[H]else return nil end end
keycode={backspace=8,enter=13,shift=16,ctrl=17,alt=18,capslock=20,esc=27,space=32,['0']=48,['1']=49,['2']=50,['3']=51,['4']=52,['5']=53,['6']=54,['7']=55,['8']=56,['9']=57,a=81,b=66,c=67,d=68,e=69,f=70,g=71,h=72,i=73,j=74,k=75,l=76,m=77,n=78,o=79,p=80,q=65,r=82,s=83,t=84,u=85,v=86,w=90,x=88,y=89,z=87,[';']=186,['=']=187,[',']=188,['-']=189,['.']=190,['/']=191,['`']=192,[':']=186,['+']=187,['<']=188,['_']=189,['>']=190,['?']=191,['~']=192,['[']=219,['\\']=220,[']']=221,["'"]=222,['{']=219,['|']=220,['}']=221,['"']=222,[')']=48,['!']=49,['@']=50,['#']=51,['$']=52,['%']=53,['^']=54,['&']=55,['*']=56,['(']=57,kp0=96,kp1=97,kp2=98,kp3=99,kp4=100,kp5=101,kp6=102,kp7=103,kp8=104,kp9=105,['kp*']=106,['kp+']=107,['kp-']=109,['kp.']=110,['kp/']=111,left=37,up=38,right=39,down=40,f1=112,f2=113,f3=114,f4=115,f5=116,f6=117,f7=118,f8=119,f9=120,f10=121,f11=122,f12=123}kc=keycode
particles={white=0,purple=1,orange=2,soft_white=4,teal=9,yellow=11,red=13,spawn=3,heart=5,red_heart=30,pink_heart=31,bubble=6,bubble1=7,bubble2=8,water=14,spirit=10,red_spirit=12,plus1=15,plus10=16,plus12=17,plus14=18,plus16=19,meep=20,red_confetti=21,green_confetti=22,blue_confetti=23,yellow_confetti=24,rain=25,wind=26,wind1=27,lightning=28,star=29,flower=32}
objcode={arrow=0,small_box=1,box=2,small_plank=3,plank=4,ball=6,trampoline=7,anvil=10,anvil1=1002,B=11,Bc=12,Bcc=13,V=14,Vc=15,Vcc=16,cannon_up=17,cannon_down=18,cannon_right=19,cannon_left=20,C=22,bomb=23,spirit=24,cheese=25,blue_portal=26,orange_portal=27,balloon1=2806,balloon=28,red_balloon=29,green_balloon=30,yellow_balloon=31,rune=32,snow=34,arrow1=35,apple=39,sheep=40,demolition=41,totem=44,ice_plank=45,choco_plank=46,cloud=57,architect=58,bubble=59,tiny_plank=60,companion_crate=61,stable_rune=62,ballon_anchor=66,windmill_anchor=88}copy(objcode,tfm.enum.shamanObject)
function help(h)
ui.addTextArea(100,MODULE_HELP[MODULE_HELP_START],h,258,78,421,284,
nil,nil,nil,true)
ui.addTextArea(101,string.format('<p align="center"><font face="mono" size="15">%s</font></p>',MODULE_HELP_START),h,258,50,398,20,
nil,nil,nil,true)
ui.addTextArea(102,MODULE_HELP_CONTENTS,h,100,50,150,312,nil,nil,nil,true)
ui.addTextArea(103,MODULE_HELP_CLOSE,h,664,50,15,20,nil,nil,nil,true)end
function helpTextAreaCallback(i,L,l)
if l=='help'then help(L)elseif l=='help_close'and i==103 then
ui.removeTextArea(100,L)ui.removeTextArea(101,L)ui.removeTextArea(102,L)
ui.removeTextArea(103,L)else local O=MODULE_HELP[l]
if O~=nil then ui.updateTextArea(100,O,L)
ui.updateTextArea(101,string.format('<font face="mono" size="15"><p align="center">%s</p></font>',l),L)else return false end end;return true end
function eventChatCommand(B,x)local s,K;local D,c;for n,y in ipairs({{'&lt;','<'},{'&amp;','&'}})do
x=string.gsub(x,y[1],y[2])end
while true do
s,K=string.find(x,'%s+')
if s==nil then D=x;c=''break elseif s==1 then x=string.sub(x,K+1)if x==''then D=''c=''break end else D=string.sub(x,1,
s-1)c=string.sub(x,K+1)break end end;local L=string.lower(D)local l=MODULE_CHAT_COMMAND[L]if l~=nil then
l(B,L,c)else MODULE_CHAT_COMMAND_1(B,D,c)end end
MODULE_CHAT_COMMAND_1=function(o,z,B)alert('Invalid command: '..z,o)end;MAX_ID=1000;function tbl_name(v)return'&lt;table&gt;'end
function newId(C)local s=C.free
local l,M=pairs(s)(s)
if l then s[l]=nil;return l else if C.max==MAX_ID then
error(string.format("newId: %s.max == MAX_ID",tbl_name(C)))end;C.max=C.max+1;return C.max end end
function freeId(S,n)local v=S.free;if n==S.max then local I=S.max-1;while v[I]do v[I]=nil;I=I-1 end;S.max=I else
v[n]=true end end;_errors={'<TI><p align="center">Errors</p>'}ERROR_TA=3
MAX_ERRORS=7;function alert(x,i)
ui.addPopup(0,0,string.format('<font face="mono" size="15">%s</font>',x),i,200,150,400,true)end
function addError(V)
V=string.format("• %s\n",V)for i=#_errors+1,3,-1 do _errors[i]=_errors[i-1]end
_errors[2]=V;_errors[MAX_ERRORS+1]=nil;ui.updateTextArea(ERROR_TA,table.concat(_errors),
nil)end;TIME=os.time()TIMER_RES=250;_timerId={max=0,free={}}_timerData={}
function initTimers()
TIME=os.time()_timerId={max=0,free={}}_timerData={}end
function timer()local u=os.time()while TIME+TIMER_RES<=u do eventTimer()
TIME=TIME+TIMER_RES end end
function timers()local G=os.time()local f,J,B
for S,P in ipairs(_timerData)do f=P.time;B=true
while f+P.res<=G do
f=f+P.res;J,B=pcall(P.func,S,P)if not J then
addError(string.format('timer %d: %s',S,B))B=false end;if not B then break end end;if B then P.time=f else removeTimer(S)end end end;function addTimer(G,r,V)local O=newId(_timerId)
_timerData[O]={func=G,args=r,res=V,time=os.time()}end;function removeTimer(v)
freeId(_timerId,v)end
function addObject(Y,U,q,g,_,b,l,X,h,Z,H)local D=do_addObject(Y,U,q,g,_,b,l)
if X==nil then X=3 end
objectData[D]={time=X,callback=to_table(h),on_remove=to_table(Z),callback_args=H}return D end
function removeObject(t)do_removeObject(t)objectData[t]=nil end
function addGround(D,O,j,U,d,h,R)local n=newId(groundId)do_addGround(n,D,O,j)
if U==nil then U=3 end
groundData[n]={time=U,callback=to_table(d),on_remove=to_table(h),callback_args=R}return n end;function removeGround(E)do_removeGround(E)groundData[E]=nil
freeId(groundId,E)end
function addJoint(w,P,D,d,j,o,m)local i=newId(jointId)
do_addJoint(i,w,P,D)if d==nil then d=-1 end;if D==nil then D={}end
jointData[i]={time=d,callback=to_table(j),on_remove=to_table(o),callback_args=m}return i end
function removeJoint(g)do_removeJoint(g)jointData[g]=nil;freeId(jointId,g)end
function addExplosion(T,I,w,R,A,N,s)if N~=nil then addParticle(N,T,I,0,0,0,0)end
if s~=nil then end;do_addExplosion(T,I,w,R,A)end
function list_default(g,E,O)g[#g+1]=string.format('%d %d\n',E,O.time)end
function step(_,A,c,U,E)local x={}local R;local Q,y;local P,O;if E==nil then E=list_default end
for P,O in pairs(A)do E(U,P,O)
if
O.time<=0 then
if O.on_remove then
for X,v in ipairs(O.on_remove)do Q,y=pcall(v,P,O)if not Q then
addError(string.format("step(%s): on_remove[%d]: %s\n",tbl_name(A),X,y))end end end;x[#x+1]=P else O.time=O.time-_
if O.callback then
for s,Z in ipairs(O.callback)do Q,y=pcall(Z,P,O)if
not Q then
addError(string.format("step(%s): callback[%d]: %s\n",tbl_name(A),s,y))x[#x+1]=P;break end end end end end;for P,O in ipairs(x)do c(O)end end
function emptyMap(r,t,B,l)local Y,e=r/2.0,t/2.0;local g,J
local _={string.format('<C><P G="0,0" L="%d" H="%d" /><Z><S>',r,t)}B=B or 256;l=l or B
for g=16,r,B do
for J=16,t,l do
_[#_+1]=string.format('<S o="%02x00%02x" L="16" Y="%d" c="4" P="0,0,0,0,0,0,0,0" T="13" X="%d" H="10" />',math.abs(
Y-g)/Y*255,math.abs(e-J)/e*255,J,g)end end;_[#_+1]='</S><D><DS X="200" Y="200" /></D><O /></Z></C>'return
table.concat(_)end
function setColor(t,x)setNameColor(t,x)playerData[t].color=x end
function tbl_name(h)
if h==groundId then return'groundId'elseif h==jointId then return'jointId'elseif h==bulletId then return'bulletId'elseif h==
patternId then return'patternId'elseif h==_timerId then return'_timerId'elseif h==objectData then return'objectData'elseif h==
groundData then return'groundData'elseif h==jointData then return'jointData'elseif h==bulletData then return'bulletData'elseif h==
patternData then return'patternData'elseif h==_timerData then return'_timerData'end;return'&lt;other&gt;'end
function make_line(i,W)local h,a=W[1]-i[1],W[2]-i[2]return
{width=math.sqrt(h*h+a*a),angle=math.deg(math.atan2(a,h)),x=(
i[1]+W[1])/2,y=(i[2]+W[2])/2}end
make_star=cache2(function(b,x)local m={}local h={}local c,_;for c=1,b do _=math.pi*2.0*c/b
m[#m+1]={math.cos(_),math.sin(_)}end;for c=1,b do
h[#h+1]=make_line(m[c],m[1+ (c+x-1)%b])end;local p=length1(h[1])return
{lines=h,points=m,r=p,l=math.sqrt(1-p*p)}end)
function make_laser(q,O,s,c,T,o,F,i,D,k)local J={{}}local K=math.atan2(T-s,c-O)
local R,S=math.cos(K),math.sin(K)local w,m=0,0;local G,e;local U,N;local y=2;local n
if q==0 then q=2
for n=1,i do m=m+o;w=m*m*F;U,N=-m*S,m*R
G,e=w*R+U,w*S+N
J[y]={point1=string.format("%d,%d",O+G,s+e),point2=string.format("%d,%d",c+U,T+N)}y=y+1;G,e=w*R-U,w*S-N
J[y]={point1=string.format("%d,%d",O+G,s+e),point2=string.format("%d,%d",c-U,
T-N)}y=y+1 end elseif q==1 then q=2;for n=1,i do m=m+o;U,N=-m*S,m*R
J[y]={point2=string.format("%d,%d",c+U,T+N)}y=y+1
J[y]={point2=string.format("%d,%d",c-U,T-N)}y=y+1 end else
q=1;D=D or 50;w=o*F;for n=1,i do D=D+o;U,N=w*R,w*S
J[y]={point1=string.format("%d,%d",O+U,s+N),line=D}y=y+1;w=w*2 end end;if k then y=0
for n=2,#J do if n%q==0 then y=y+1 end;J[n].color=k[y]end end;return J end
function getText(B)local K=B.lives-1;local a=B.bombs
if K>=maxLives then K=maxLives-1 elseif K<0 then K=0 end;if a>maxBombs then a=maxBombs elseif a<0 then a=0 end;return
string.format('<TI><N>Player  <R>%s<N>\nBomb  <VP>%s',string.rep('★',K),string.rep('★',a))end;function updateTextAreas(B,Q)ui.updateTextArea(1,getText(Q),B)
ui.updateTextArea(104,'<TI><a href="event:help">?</a>',B)end
function clear()for L,y in
ipairs(keys(jointData))do removeJoint(y)end;for a,D in
ipairs(keys(tfm.get.room.objectList))do removeObject(D)end;for p,M in
ipairs(keys(groundData))do removeGround(M)end;for M,J in
ipairs(keys(bulletData))do removeBullet(J)end;for k,P in
ipairs(keys(patternData))do removePattern(P)end end
function list_object(u,E,C)local l=tfm.get.room.objectList[E]if l==nil then
u[#u+1]=string.format('%d &lt;invalid&gt; %d\n',E,C.time)else
u[#u+1]=string.format('%d (%d, %d) %d\n',E,l.x,l.y,C.time)end end;function list_bullet(p,i,L)
p[#p+1]=string.format("%d %d %d\n",i,L.controls[#L.controls],L.time)end
function clearT(P)local u={'<TI>'}
u[#u+1]='<p align="center">Joints</p>'step(P,jointData,removeJoint,u)
u[#u+1]='<p align="center">Objects</p>'step(P,objectData,removeObject,u,list_object)
u[#u+1]='<p align="center">Grounds</p>'step(P,groundData,removeGround,u)
u[#u+1]='<p align="center">Bullets</p>'step(P,bulletData,removeBullet,u,list_bullet)
u[#u+1]='<p align="center">Patterns</p>'step(P,patternData,removePattern,u)
ui.addTextArea(2,table.concat(u),nil,
-155,5,150,590,nil,nil,0.5,true)end
function shoot_bullet(i,j)local K=j.callback_args;if K._cd==nil then K._cd=0 end
if K._cd>0 then
K._cd=K._cd-1 else K._cd=K.cd
local i=addBullet(K.btype,K.bdata,K.bttl,K.callback,K.on_remove,K.cbargs)
if K.mtype~=nil then addMotion(K.mtype,i,true,K.mdata)end end end;function explode(h,A)local v=A.callback_args
addExplosion(v.x,v.y,v.power,v.distance,v.miceOnly,v.p1,v.p2)end
function explode1(l,o)
local F=o.callback_args
if F.t<=0 then
local e=randomKey1(tfm.get.room.playerList,o.user,true)local T,x=0,0;if e~=nil then local Y=tfm.get.room.playerList[e]
T,x=Y.x,Y.y end
addExplosion(T,x,F.power,F.distance,F.miceOnly,F.p1,F.p2)F.t=F.cd else F.t=F.t-1 end end;function accelerate(Z,t)local y=t.callback_args
moveObject(Z,0,0,true,y.ax,y.ay,true)end
function moveHoming(p,H)
if
H.time<=7 and H.time>=5 then local f=H.callback_args
local K=tfm.get.room.playerList[f.target]
if K~=nil then local A=K.x;local _=K.y;local Q=f.x;local s=f.y;A=A-Q;_=_-s;local P=A*A+_*_;if P>0 then P=f.v/
math.sqrt(P)A=A*P;_=_*P end
moveObject(p,0,0,true,A,_,false)end end end
function moveHoming1(B,n)local v=n.callback_args
if v.delay>0 then v.delay=v.delay-1 else local g,k;local U=nil;if v.target then
U=tfm.get.room.playerList[v.target]end
if U then g,k=U.x-v.x,U.y-v.y elseif v.target_x then g,k=v.target_x-v.x,
v.target_y-v.y else return end
local X=math.min(math.sqrt(g*g+k*k),v.max_step)
if X>v.min_step then local f,b=to_axis(-math.atan2(k,g))v.jdata.limit2=
X/30.0;v.jdata.axis=f
v.x=v.x+X*math.cos(-b)v.y=v.y+X*math.sin(-b)
do_addJoint(v.jid,v.gid,0,v.jdata)v.delay=v.delay1 end end end;_tmp_grounds={}_tmp_joints={}function addGround1(v,z,A,d)local r=newId(groundId)_tmp_grounds[
#_tmp_grounds+1]=r;do_addGround(r,z,A,d)
v[#v+1]=r;return r end
addJoint2={function(H,c,v,x)
local q=newId(jointId)_tmp_joints[#_tmp_joints+1]=q
do_addJoint(q,0,0,x)H[#H+1]=q end,function(O,G,z,q)
local N=newId(jointId)_tmp_joints[#_tmp_joints+1]=N
do_addJoint(N,G,z,q)O[#O+1]=N end}
function addBullet(a,q,H,P,l,j)local I=newId(bulletId)local y,S
local U,Z,K,b=pcall(a,addJoint2[q.static or 2],q)
if U then _tmp_grounds={}_tmp_joints={}
bulletData[I]={controls={Z},grounds=K,joints=b,time=H or 6,callback=to_table(P),on_remove=to_table(l),callback_args=j}else for y,S in ipairs(_tmp_joints)do removeJoint(S)end;for y,S in
ipairs(_tmp_grounds)do removeGround(S)end;_tmp_grounds={}
_tmp_joints={}freeId(bulletId,I)
error(string.format('addBullet: %s',Z))end;return I end
function removeBullet(v)local u=bulletData[v]local a,s;for a,s in ipairs(u.joints)do do_removeJoint(s)
freeId(jointId,s)end;for a,s in ipairs(u.grounds)do
do_removeGround(s)freeId(groundId,s)end
bulletData[v]=nil;freeId(bulletId,v)end;bullet={}
bullet.rectangle=function(q,K)local X,o,u=K.x,K.y,K.angle;local F,O=K.width,K.height
local R,Y=K.jdata,K.hitbox_data;local Z,H=math.cos(u),math.sin(u)local T=F/2.0;local V,b
local t={type=0,point1=string.format("%d,%d",X,o),point2=string.format("%d,%d",
X+Z*F,o+H*F),color=0xFF0000,line=2*O+4,foreground=false}
local G={type=12,width=F,height=O,angle=math.deg(u),miceCollision=true,groundCollision=false,foreground=true,dynamic=true,mass=1,restitution=255}copy(G,Y)local g,M={},{}local x=addGround1(g,X+Z*T,o+H*T,G)
if R then for V,b in
ipairs(R)do copy(t,b)q(M,x,x,t)end end;return x,g,M end
bullet.circle=function(i,w)local S,r,V=w.x,w.y,w.R;local s,X=w.jdata,w.hitbox_data
local D={type=0,point2=string.format('%d,%d',S,r+1),color=0x0000FF,line=
2*V,foreground=false}
local K={type=13,width=V,height=V,miceCollision=true,groundCollision=false,dynamic=true,mass=1,restitution=255}copy(K,X)local j,_={},{}local c=addGround1(j,S,r,K)if s then for I,C in ipairs(s)do copy(D,C)
i(_,c,c,D)end end;return c,j,_ end
bullet.butterfly=function(Q,f)local H,U,z,j=f.x,f.y,f.angle,f.R;local E,B=f.center_jdata,f.wing_jdata
local _=f.hitbox_data;local k;local S=make_star(5,2)
local M={type=0,color=0xFF00FF,line=S.l*j*2,foreground=false}
local T={type=0,point1=string.format('%d,%d',H,U),point2=string.format('%d,%d',H,U+1),color=0x0000FF,line=j*2,foreground=false}
local Y={type=13,width=j,height=j,dynamic=true,mass=1,miceCollision=true,groundCollision=false,restitution=255}copy(M,B)copy(Y,_)local X,o={},{}local d,N
local l,y=math.cos(z),math.sin(z)local t;local e=addGround1(X,H,U,Y)
for k=2,5 do t=S.points[k]d,N=t[1]*l-t[2]*y,
t[1]*y+t[2]*l;d,N=H+j*d,U+j*N
M.point1=string.format('%d,%d',d,N)M.point2=string.format('%d,%d',d,N+1)Q(o,e,e,M)end;copy(T,E)Q(o,e,e,T)return e,X,o end
bullet.jstar=function(y,Z)local J,M,P,u=Z.x,Z.y,Z.angle,Z.R;local w,D=Z.points,Z.step
local R,Y=Z.line_jdata,Z.center_jdata;local O=Z.hitbox_data;local S;local H=make_star(w,D)
local L={type=0,color=0xFFFFFF,line=5,foreground=true}local x=u*H.r
local o={type=0,point1=string.format('%d,%d',J,M),point2=string.format('%d,%d',J,M+1),color=0xFFFFFF,line=x*2,foreground=true}
local W={type=13,width=x,height=x,dynamic=true,mass=1,miceCollision=true,groundCollision=false,restitution=255}copy(L,R)copy(W,O)local F,f={},{}local i={}local a,A
local p,j=math.cos(P),math.sin(P)local C,B
for C,B in ipairs(H.points)do
a,A=B[1]*p-B[2]*j,B[1]*j+B[2]*p;i[#i+1]=string.format('%d,%d',J+u*a,M+u*A)end;local X=addGround1(F,J,M,W)for S=1,w do L.point1=i[S]
L.point2=i[1+ (S+D-1)%w]y(f,X,X,L)end;if Y then for C,B in ipairs(Y)do copy(o,B)
y(f,X,X,o)end end;return X,F,f end
bullet.star=function(e,O)local r,Q,X,J=O.x,O.y,O.angle,O.R;local h,F,o=O.points,O.step,O.do_cap
local v,l=O.line_data,O.center_data;local d=O.cap_data;local a=make_star(h,F)
local u={type=12,height=1,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}local w=J*a.r
local C={type=13,width=w,height=w,color=0xFFFFFF,groundCollision=false,miceCollision=true,dynamic=true,foreground=true,restitution=255}
local Z={type=13,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}w=string.format('%d,%d',r,Q)
local j={type=3,point1=w,point2=w,ratio=1,limit1=0,limit2=0}local p={type=0,frequency=10}copy(u,v)copy(C,l)copy(Z,d)
local W,R,P={},{},{}local k,t;local O=math.deg(X)local z,L=math.cos(X),math.sin(X)
for q,s in
ipairs(a.lines)do u.angle=s.angle+O;u.width=s.width*J
k,t=s.x*z-s.y*L,s.x*L+s.y*z;addGround1(W,r+J*k,Q+J*t,u)end;if o then
for c,A in ipairs(a.points)do k,t=A[1]*z-A[2]*L,A[1]*L+A[2]*z;addGround1(R,
r+J*k,Q+J*t,Z)end end
local x=addGround1(R,r,Q,C)
if u.dynamic then local b,D=nil,nil;for q,s in ipairs(W)do e(P,s,x,j)
if b~=nil then e(P,s,b,p)else D=s end;b=s end;e(P,D,b,p)elseif C.dynamic then for y,_ in ipairs(W)do
e(P,_,x,j)end end
if o then
if Z.dynamic then local b,K=nil,nil;for i=1,h do e(P,R[i],W[i],j)
if b~=nil then e(P,R[i],b,p)else K=R[i]end;b=R[i]end;e(P,K,b,p)elseif u.dynamic then for i=1,h do
e(P,R[i],W[i],j)end end end;append(W,R)return x,W,P end
function bomb(x,y)
if y.bomb_cd==0 and not y.bombing then
if y.bombs>=y.bomb.cost then y.bombs=y.bombs-
y.bomb.cost;y.bombing=true;y.bombTime=y.bomb.time
local i,g=pcall(y.bomb.func,x,y)addBomb(x,y)updateTextAreas(x,y)if not i then
addError(string.format("bomb: %s: %s",x,g))end else
alert(string.format('bombs &lt; %d',y.bomb.cost),x)end end end
function addBomb(f,d)local F=bombs.top+1
local u=string.format('<TI><font color="#%X">%s <font color="#5F5F8D">|</font> %s</font>',d.color,f,d.bomb.name)d.bomb_id=F;bombs.top=F;bombs.val[F]=u;setShamanName(u)end
function removeBomb(N,O)local d=O.bomb_id;O.bomb_id=nil;bombs.val[d]=nil
if d==bombs.top then d=d-1;while
bombs.val[d]==nil and d>0 do d=d-1 end;bombs.top=d;if d>0 then
d=bombs.val[d]else d=''end;setShamanName(d)end end
function addBombTimer(z,x,p,C)local u=p.bombTime*C+2
local y={type=13,color=0xFF0000,foreground=false,width=u,height=u,miceCollision=false}
addGround(x.x,x.y,y,p.bombTime,moveBombTimer,nil,{player=z,pdata=p,offset=2,scale=C,obj=y})u=u-2
y={type=13,color=0x6A7495,foreground=false,width=u,height=u,miceCollision=false}
addGround(x.x,x.y,y,p.bombTime,moveBombTimer,nil,{player=z,pdata=p,offset=0,scale=C,obj=y})end
function moveBombTimer(o,e)local I=e.callback_args
local t=tfm.get.room.playerList[I.player]local W=I.pdata.bombTime*I.scale+I.offset
I.obj.width=W;I.obj.height=W;do_addGround(o,t.x,t.y,I.obj)end
function bomb1(k,w)local Y=20;local M=512;local E=32.0
local s=tfm.get.room.playerList[k]local X,B=s.x,s.y;local I=string.format("%d,%d",X,B)
local C={0x00FF00,0x00FFFF,0x0000FF}
local F={x=X,y=B,R=32,hitbox_data={miceCollision=false,mass=2,angularDamping=1}}
local Q={width=M,height=16,hitbox_data={mass=2,linearDamping=0.5}}local j={last=true,ttl=Y,jdata={speedMotor=255}}
addBombTimer(k,s,w,5)local t=addBullet(bullet.circle,F,Y)local _=t
t=bulletData[t].controls;t=t[#t]local R={type=3,point1=I,point2=I,ratio=1,limit1=0,limit2=0}
local S={type=0,frequency=32}local v;local h,N;local z,n;local c,g;local K;local e
for e=1,3 do v=math.pi*e*2.0/3.0
h,N=math.cos(v),math.sin(v)z,n=X+ (E+M)*h,B+ (E+M)*N;h,N=X+E*h,B+E*N
K=make_laser(0,h,N,z,n,5,0.1,2,20)
K[1]={point1=string.format("%d,%d",h,N),point2=string.format("%d,%d",z,n),color=C[e],alpha=0.25,line=20,foreground=true}Q.angle=v;Q.x=h;Q.y=N;Q.jdata=K
id=addBullet(bullet.rectangle,Q,Y)id=bulletData[id].controls;id=id[#id]
addJoint(id,t,R,Y)if g then addJoint(id,g,S,Y)else c=id end;g=id end;addJoint(g,c,S,Y)addMotion(motion.circle,_,true,j)end
function bomb2Callback(S,M)local n=M.callback_args
if n.delay==1 then
local N={last=true,ttl=n.ttl,x=n.x,y=n.y,no_target=n.no_target,delay=0,delay1=0,frequency=0.5,max_step=500}addMotion(motion.follow,S,true,N)n.delay=0 else
n.delay=n.delay-1 end end
function bomb2(x,m)local P=20;local N=96.0;local f=tfm.get.room.playerList[x]
local g,c=f.x,f.y
local F={R=48,jdata={{foreground=false,line=128}},hitbox_data={color=0xFFFFFF}}
local K={ttl=2,last=true,jdata={speedMotor=3,color=0xFFFFFF}}local C;local r,u;local A;local M;local Z;addBombTimer(x,f,m,5)
for Z=1,#_axis do
C=(1-Z)*_axis_step;r,u=math.cos(C),math.sin(C)F.x=g+N*r;F.y=c+N*u
F.jdata[1].color=randomColor()K.jdata.axis=_axis[Z]
K.jdata.speedMotor=5-K.jdata.speedMotor;M={delay=2,ttl=P-2,x=g+150*r,y=c+150*u,no_target=x}A=addBullet(bullet.circle,F,P,bomb2Callback,
nil,M)
addMotion(motion.line,A,true,K)end end;function do_addControl(o,v)o[#o+1]=v end;function do_removeControl(S,u)
while S[u]do S[u]=nil;u=u+1 end end;function motionEnd(z,Y)
do_removeControl(Y.callback_args._controls,Y.callback_args._idx)end
function addControl(Z,...)local A=#Z+1
local o=addGround(...)local y=groundData[o]
if y.callback_args==nil then
y.callback_args={_controls=Z,_idx=A}else y.callback_args._controls=Z;y.callback_args._idx=A end;if y.on_remove==nil then y.on_remove={motionEnd}else
y.on_remove[#y.on_remove+1]=motionEnd end;Z[#Z+1]=o;return o end;function addControl1(p,...)return addGround(...)end
function addMotion(y,R,r,D)local W;local L;if r then
W=bulletData[R].controls;L=addControl else W={R}L=addControl1 end
local Q,v=pcall(y,L,W,D)if not Q then
error(string.format("addMotion: %s",v))end end;motion={}
motion.i_f=function(y,g,c)local b=addGround(100,100,CONTROL,1)
addJoint(g[#g],b,IFJOINT,1)end
motion.i_f_1=function(P,B,M)
local d={gid=B[#B],gx=M.x,gy=M.y,jg1=B[#B],jg2=0,gdata=M.gdata,jdata=IF1JOINT}local i=addJoint(B[#B],0,IF1JOINT,M.ttl,replace,nil,d)
d.jid=i end
motion.fix=function(m,O,H)local x=0;local Z=O[#O]local c={type=0,frequency=10}copy(c,H.jdata)
if not
H.last then x=m(O,H.x or 0,H.y or 0,CONTROL,H.ttl or 3)end;addJoint(Z,x,c,H.ttl or 3)end
motion.follow=function(h,M,G)G.x=G.x or 0;G.y=G.y or 0;G.ttl=G.ttl or 3
G.delay=G.delay or 0;G.delay1=G.delay1 or 0;G.max_step=G.max_step or 3000;G.min_step=G.min_step or
30;if G.target==nil then
G.target=randomKey1(tfm.get.room.playerList,G.no_target,true)end;local n=M[#M]
local U=h(M,G.x,G.y,CONTROL,G.ttl,moveHoming1,nil,G)
local z={type=0,frequency=G.frequency or(1.0/ (1.0+G.delay1))}local i={type=1,forceMotor=255,speedMotor=127}copy(i,G.jdata)
addJoint(n,U,z,G.ttl)G.jdata=i;G.gid=U;G.jid=addJoint(U,0,z,G.ttl)end
motion.line=function(j,b,P)local G=P.x or 0;local O=P.y or 0;local A=P.ttl or 3;local i=0;local U
local D={type=1,axis='-1,0',angle=0,forceMotor=255,speedMotor=1}copy(D,P.jdata)if P.free_angle then
motion.fix(j,b,{ttl=A,x=G,y=O})end;U=b[#b]
if not P.last then i=j(b,G,O,CONTROL,A)end;addJoint(U,i,D,A)end
motion.circle=function(n,Q,O)local U=0;local N=Q[#Q]local o={type=3,forceMotor=255,speedMotor=1}
copy(o,O.jdata)if not O.last then
U=n(Q,O.x or 0,O.y or 0,CONTROL,O.ttl or 3)end;if O.x and O.y then
o.point1=string.format('%d,%d',O.x,O.y)end;addJoint(N,U,o,O.ttl or 3)end
motion.spiral=function(v,Y,u)local R=u.last;u.last=false;u.jdata=u.tjoint
motion.line(v,Y,u)u.last=R;u.jdata=u.rjoint;motion.circle(v,Y,u)end
function pattern(X,q,B,H,D)local v=q.patterns[B][H]
if v~=nil then local t=#v.points+1
if t>=
v.type.points then local A=os.time()
if A-v.lastTime>=v.type.cd then v.lastTime=A
v.points[t]=D;local W,V=pcall(addPattern,X,q,v.type,v.points)v.points={}if not W then
addError(string.format("pattern: %s: %s",X,V))end end else v.points[t]=D end end end
function bind(s,h,L,_)local W=playerData[s]local w=W.patterns[h]if w[L]~=nil then
do_unbind(W,w[L],h,L)end
w[L]={id=_,type=patternTypes[_],points={},lastTime=0}w=W.pattern_data[_]
if h=='key'then bindKey(s,L,true,true)end
if w==nil then W.pattern_data[_]={binds=1}else w.binds=w.binds+1 end end
function do_unbind(A,k,K,c)local o=A.pattern_data[k.id]if o.binds<=1 then
A.pattern_data[k.id]=nil else o.binds=o.binds-1 end;A.patterns[K][c]=
nil end
function unbind(L,E,g)local d=playerData[L]
if E==nil then d.patterns={key={},obj={},objend={}}
d.pattern_data={}elseif g==nil then local k={}
for l,c in pairs(d.patterns[E])do k[#k+1]={l,c}end;for J,h in ipairs(k)do do_unbind(d,h[2],E,h[1])end else
local H=d.patterns[E][g]if H~=nil then do_unbind(d,H,E,g)end end end
function addPattern(d,A,y,E)local Y=nil;if y.time~=nil then Y=newId(patternId)
patternData[Y]={time=y.time,callback=y.callback,on_remove=y.on_remove}end
y.func(d,A,Y,E)return Y end
function removePattern(O)patternData[O]=nil;freeId(patternId,O)end
function testPattern(D,I,y,R)local E=R[1]local b=6;local N=48;local F=math.random(2,8)local O,t,M,s
local w=math.rad(E.angle)for s=0,b-1 do O=w+2.0*math.pi*s/b
t,M=math.cos(O),math.sin(O)
addObject(E.type,E.x+N*t,E.y+N*M,E.angle+360*s/b,F*t,F*M,false,9)end end
function testPattern1(t,j,S,G)local e=G[1]local Q=math.random(8,16)local b,L,A,w;local C;local S
local J={angle=0.25-math.pi/2.0,R=16,center_jdata={},wing_jdata={line=24,alpha=0.5},hitbox_data={width=0,height=0,color=0xFFFFFF,mass=1}}local l={ttl=2,last=true,jdata={}}
for w=1,Q do C=math.random(64,96)b=
math.random()*2.0*math.pi
L,A=math.cos(b),math.sin(b)J.x=e.x+C*L;J.y=e.y+C*A
J.center_jdata.color=randomColor()J.wing_jdata.color=randomColor()
l.jdata.speedMotor=math.random(2,6)l.jdata.angle=2*math.pi-b
S=addBullet(bullet.butterfly,J,8)addMotion(motion.line,S,true,l)end end
function testPattern2(o,B,G,k)local K=k[1]
local S={x=K.x,y=K.y,R=16,jdata={{color=randomColor(),line=32}},hitbox_data={width=0,height=0,color=0xFFFFFF,mass=1}}
local g={ttl=16,last=true,x=K.x,y=K.y,frequency=0.25,delay=2,delay1=0,max_step=1000}local G=addBullet(bullet.circle,S,16)
addMotion(motion.follow,G,true,g)end
function testPattern3(F,l,Q,a)local z=a[1]local y=randomColor()
local K,p=to_axis(math.rad(-z.angle))
local w={x=z.x,y=z.y,angle=p,R=36,points=math.random(5,8),step=2,line_jdata={color=y},center_jdata={{foreground=false,color=y,line=76},{color=0x6A7495,line=70}},hitbox_data={dynamic=true,miceCollision=false}}
local R={cd=0,btype=bullet.rectangle,bttl=10,bdata={x=z.x,y=z.y,angle=-p,width=128,height=13,jdata={{color=randomColor(),foreground=false},{color=0xFFFFFF,line=16,foreground=true}},hitbox_data={dynamic=true,fixedRotation=true,mass=1}},mtype=motion.line,mdata={x=z.x,y=z.y,ttl=1,last=true,free_angle=true,jdata={speedMotor=8,axis=K}}}local Q=addBullet(bullet.jstar,w,32,shoot_bullet,nil,R)
addMotion(motion.circle,Q,true,{last=true,ttl=2,jdata={speedMotor=4}})end
function testPattern4(w,c,u,e)local s=e[1]
local n={x=s.x,y=s.y,angle=math.rad(s.angle),width=512,height=13,static=1,jdata={{color=randomColor(),foreground=true},{color=0xFFFFFF,line=16}},hitbox_data={dynamic=true,restitution=0,mass=
-1}}local u=addBullet(bullet.rectangle,n,10)
addMotion(motion.i_f,u,true)end
function shoot(h,L)
if L.shot_cd==0 then
if L.bombing and L.bomb.shot~=nil then
L.shot_cd=L.bomb.shot.cd;local Z,E=pcall(L.bomb.shot.func,h,L)if not Z then
addError(string.format("shoot(bombing): %s: %s",h,E))end else L.shot_cd=L.shot.cd
local W,Q=pcall(L.shot.func,h,L)if not W then
addError(string.format("shoot: %s: %s",h,Q))end end end end
function defaultShot(M,H)local s=tfm.get.room.playerList[M]local q,N=s.x,s.y;local T;if
s.isFacingRight then T=-1 else T=1 end;local A=math.random()*math.pi
local v={x=q+64*
math.cos(A),y=N+64*math.sin(A),angle=0,R=16,points=5,step=2,line_jdata={color=randomColor()},center_jdata={{}}}
local E={last=true,ttl=math.random(1,4),x=q,y=N,jdata={speedMotor=4*T}}local D=addBullet(bullet.jstar,v,8)A=
math.random()*math.pi+math.pi
v.x=q+64*math.cos(A)v.y=N+64*math.sin(A)
v.line_jdata.color=randomColor()local k=addBullet(bullet.jstar,v,8)
addMotion(motion.circle,D,true,E)E.ttl=math.random(1,4)E.jdata.speedMotor=-4*T
addMotion(motion.circle,k,true,E)end
function homingShot(u,T)local n=tfm.get.room.playerList[u]local z=n.x;local O=n.y
if
T.focused then
local M=randomValue1(tfm.get.room.playerList,u,false)local g,f=M.x,M.y;g,f=g-z,f-O;local Q=math.atan2(f,g)local t,h,Y,G;local D=16;for G=1,2 do Y=Q+
math.random()*0.2;t,h=math.cos(Y),math.sin(Y)
addObject(objcode.anvil,
z+20*t,O+20*h,math.deg(Y),D*t,D*h,false,10)end else
local d=randomKey1(tfm.get.room.playerList,u,false)local Y=2;local h=2;local G=false;if not n.isFacingRight then Y=-Y end;z=z+16*Y
local P={target=d,x=z,y=O+32,v=128}
addObject(objcode.anvil,z+Y,O+h,0,Y,h,G,10,moveHoming,nil,P)local P={target=d,x=z,y=O-32,v=128}
addObject(objcode.anvil,z+Y,O-h,0,Y,-h,G,10,moveHoming,nil,P)end end;do_respawn_1=do_respawn
function do_respawn(b)do_respawn_1(b)
local g=playerData[b].spawn;movePlayer(b,g[0],g[1],false,0,0,true)end
function initPlayer(Y)
local m={color=randomColor(),shooting=false,bombing=false,focused=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},spawn={200,200},speed=60,focusedSpeed=30,curSpeed=50,vx=0,vy=0,lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=
nil}if playerConfig[Y]==nil then playerConfig[Y]={}end
copy(m,playerConfig[Y])playerData[Y]=m;for a,L in ipairs(playerKeys)do bindKey(Y,L,true,true)
bindKey(Y,L,false,true)end
system.bindMouse(Y,true)
ui.addTextArea(1,getText(m),Y,5,25,151,40,nil,nil,0.5,true)
ui.addTextArea(104,'<TI><a href="event:help">?</a>',Y,145,25,11,20,nil,nil,0.0,true)
ui.addTextArea(ERROR_TA,table.concat(_errors),Y,805,5,200,590,nil,nil,0.5,true)do_respawn(Y)setShaman(Y)
setNameColor(Y,playerData[Y].color)end
function resetPlayer(l)local N=playerData[l]copy(N,RESET)updateTextAreas(l,N)
do_respawn(l)setShaman(l)setNameColor(l,N.color)end;function deletePlayer(B)local o=playerData[B]if o.bombing then removeBomb(B,o)end;playerData[B]=
nil end
function respawn(K)
do_respawn(K)setNameColor(K,playerData[K].color)end
function movePlayer1(y,U,T,X,I)
if T then
if I then U.vx=T;T=T*U.curSpeed;if U.vx>0 then U.dir=1 else U.dir=-1 end
movePlayer(y,0,0,false,T,0,false)else U.vx=0;movePlayer(y,0,0,false,1,0,false)
movePlayer(y,0,0,false,-1,0,true)end elseif X then
if I then U.vy=X;X=X*U.curSpeed
movePlayer(y,0,0,false,U.vx*U.curSpeed,X,false)else U.vy=0;movePlayer(y,0,0,false,0,-1,false)
movePlayer(y,0,0,false,0,1,true)end else return false end;return true end;playerData={}objectData={}groundData={}jointData={}patternData={}bulletData={}
MAX_ID=400;MAX_ERRORS=7
GROUND0={type=13,color=0xFFFFFF,dynamic=false,miceCollision=false,groundCollision=false}
CONTROL={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}IFJOINT={type=2,point2='0,0',point3='0,0',point4='0,0'}
IF1JOINT={type=1,axis='3,2',angle=0,forceMotor=255}
RESET={shooting=false,bombing=false,lives=5,bombs=3,shot_cd=0,bomb_cd=0,vx=0}
playerKeys={kc.space,kc.w,kc.s,kc.a,kc.d,kc.left,kc.right,kc.up,kc.down,kc.kp4,kc.kp6,kc.kp8,kc.kp5,kc.e,kc.q,kc.shift}reservedKeys=invert(playerKeys,true)
pk_vx={[kc.a]=-1,[kc.left]=-1,[kc.kp4]=-1,[kc.d]=1,[kc.right]=1,[kc.kp6]=1}
pk_vy={[kc.space]=-1,[kc.w]=-1,[kc.up]=-1,[kc.kp8]=-1,[kc.s]=1,[kc.down]=1,[kc.kp5]=1}eventCode={key=keycode,obj=objcode,objend=objcode}mapWidth=1600
mapHeight=800;defaultMap=emptyMap(mapWidth,mapHeight)X_MIN=16
X_MAX=mapWidth-16;Y_MIN=16;Y_MAX=mapHeight-16;maxLives=8;maxBombs=6
shotTypes={{name='default shot',func=defaultShot,cd=1},{name='homing anvils',func=homingShot,cd=2}}
bombTypes={{name='',func=bomb1,callback=nil,shot={func=nop,cd=1},cost=1,time=20,cd=5},{name='',func=bomb2,callback=nil,shot={func=nop,cd=1},cost=1,time=20,cd=5}}
patternTypes={{func=testPattern,callback=nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern1,callback=
nil,cd=500,points=1,maxBinds=3,restrict={key=nil,obj=nil,objend=nil}},{func=testPattern2,callback=
nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern3,callback=
nil,cd=1000,points=1,maxBinds=2,restrict={key={},obj=nil,objend=nil}},{func=testPattern4,callback=
nil,cd=250,points=1,maxBinds=2,restrict={key={},obj=nil,objend=nil}}}
playerConfig={Cafecafe={color=0xB06FFD},Rar={color=0x553399}}MODULE_HELP_START='Keys'
MODULE_HELP_CONTENTS=[[<font face="mono" size="15"><a href="event:Keys">Keys</a>
<a href="event:Commands">Commands</a>
<a href="event:Shot types">Shot types</a>
<a href="event:Bomb types">Bomb types</a>
<a href="event:Pattern types">Pattern types</a>
<a href="event:Shaman objects">Shaman objects</a>
]]
MODULE_HELP={['Keys']=[[<font face="mono" size="15">Shoot - E
Bomb  - Q
Focus - Shift
Up    - W, ↑, Space
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
local o=function(U,x)local t={'<font face="mono" size="15">'}
for S,p in ipairs(U)do
if p.name then
t[#t+1]=string.format('%d - %s\n',S,p.name)else t[#t+1]=string.format('%d\n',S)end
if p.cost then t[#t+1]=string.format('    Cost: %d\n',p.cost)end;if p.time then
t[#t+1]=string.format('    Duration: %fs\n',p.time/2.0)end;if p.cd then
t[#t+1]=string.format('    Cooldown: %fs\n',p.cd/x)end;if p.maxBinds then
t[#t+1]=string.format('    Max. binds: %d\n',p.maxBinds)end;t[#t+1]='\n'end;return table.concat(t)end;MODULE_HELP['Shot types']=o(shotTypes,2.0)
MODULE_HELP['Bomb types']=o(bombTypes,2.0)MODULE_HELP['Pattern types']=o(patternTypes,1000.0)end
do
local e=function(J,b)local g={'<font face="mono" size="15">'}local U;for E,w in ipairs(keys1(J))do
U=b-#w;if U>0 then E=w..string.rep(' ',U)else E=w end
g[#g+1]=string.format('%s = %4d\n',E,J[w])end
g[#g+1]='</font>'return table.concat(g)end;MODULE_HELP['Shaman objects']=e(objcode,15)end
MODULE_CHAT_COMMAND={['help']=help,['clear']=clear,['color']=function(C,S,B)B=string.upper(B)
if B==''or B=='RANDOM'or B==
'RND'then setColor(C,randomColor())playerConfig[C].color=
nil else local O=tonumber(B)if O~=nil then if O>0xFFFFFF then O=0xFFFFFF end
setColor(C,B)playerConfig[C].color=B else
alert('Invalid color: '..B,C)end end end,['reset']=function(J,V,Q)
Q=string.lower(Q)if Q==''or Q=='map'then setMap(defaultMap)else
parsePlayerNames(J,Q,resetPlayer)end end,['init']=function(o,U,N)local T=function(o)
deletePlayer(o)initPlayer(o)end
parsePlayerNames(o,N,T)end,['respawn']=function(f,l,v)
parsePlayerNames(f,v,respawn)end,['shot']=function(z,R,E)local w=tonumber(E)if w==nil then
alert('Invalid shot type: '..E,z)return end;w=shotTypes[w]
if w~=nil then
playerData[z].shot=w else alert('Invalid shot type: '..E,z)end end,['bomb']=function(P,b,Y)
local X=tonumber(Y)
if X==nil then alert('Invalid bomb type: '..Y,P)return end;X=bombTypes[X]if X~=nil then playerData[P].bomb=X else
alert('Invalid bomb type: '..Y,P)end end,['bind']=function(y,i,k)
k=split(k)if#k<3 then alert('Too few arguments',y)return elseif#k>3 then
alert('Too many arguments',y)return end
i=tonumber(k[1])local e=patternTypes[i]if i==nil or e==nil then
alert('Invalid pattern: '..k[1],y)return end;j=k[2]
if j~='key'and j~='obj'and
j~='objend'then alert('Invalid event: '..j,y)return end;local C=tonumber(k[3])
if C==nil then C=eventCode[j][k[3]]if C==nil then
alert(string.format('Invalid %s name/code: %s',j,k[3]),y)return end end;if
e.restrict[j]~=nil and e.restrict[j][C]==nil then
alert(string.format('Can\'t bind pattern %d to %s %d: restricted',i,j,C),y)return end;if
j=='key'and reservedKeys[C]then
alert(string.format('Can\'t bind pattern %d to %s %d: reserved',i,j,C),y)return end
local s=playerData[y]local t=s.pattern_data[i]if t~=nil and e.maxBinds<=t.binds then
alert(string.format('Can\'t bind pattern %d to more than %d events',i,e.maxBinds),y)return end
bind(y,j,C,i)end,['unbind']=function(v,S,f)
f=split(f)if#f>2 then alert('Too many arguments',v)return end
i=f[1]
if i=='all'or i==nil then unbind(v)elseif
i~='key'and i~='obj'and i~='objend'then alert('Invalid event: '..i,v)return else
if f[2]==nil then
unbind(v,i)else j=tonumber(f[2])
if j==nil then j=eventCode[i][f[2]]if j==nil then
alert(string.format('Invalid %s name/code: %s',i,f[2]),v)return end end;unbind(v,i,j)end end end,['map']=function(Z,X,Y)if
Y==''then Y=defaultMap end;setMap(Y)end}eventNewPlayer=initPlayer;eventPlayerLeft=deletePlayer
eventTextAreaCallback=helpTextAreaCallback
function eventNewGame()initTimers()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)tfm.exec.setGameTime(0)objectData={}groundData={}
jointData={}patternData={}bulletData={}bombs={top=0,val={}}groundId={max=0,free={}}
jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}for d,X in
pairs(tfm.get.room.playerList)do resetPlayer(d)end
setMapName('<TI>')setShamanName('')do_addGround(0,0,0,GROUND0)end
function eventKeyboard(h,b,z,a,k)
if reservedKeys[b]then local i=playerData[h]if
movePlayer1(h,i,pk_vx[b],pk_vy[b],z)then return end
if b==kc.q then local i=playerData[h]
if z then bomb(h,i)end elseif b==kc.e then local i=playerData[h]i.shooting=z;if z then shoot(h,i)end elseif
b==kc.shift then local i=playerData[h]i.focused=z;if z then i.curSpeed=i.focusedSpeed else
i.curSpeed=i.speed end;if i.vx~=0 or i.vy~=0 then
movePlayer(h,0,0,false,i.vx*i.curSpeed,
i.vy*i.curSpeed,false)end end elseif z then local w=playerData[h]pattern(h,w,'key',b,{x=a,y=k})end end;function eventSummoningStart(i,q,t,p,W)local g={x=t,y=p,angle=W,type=q}
pattern(i,playerData[i],'obj',q,g)end
function eventSummoningEnd(I,A,f,a,j,P,p,J,Y)
objectData[J.id]={time=3}local c={x=f,y=a,angle=j,type=A,vx=P,vy=p,data=J,other=Y}
pattern(I,playerData[I],'objend',A,c)end;function eventMouse(Y,M,G)
addError(string.format('(%d; %d)',M,G))end
function eventPlayerDied(A)local H=playerData[A]
if H~=nil then
if H.bombing then
respawn(A)else H.shot_cd=0;H.bomb_cd=0;H.shooting=false;H.lives=H.lives-1;if H.lives>0 then
H.bombs=H.resetBombs;updateTextAreas(A,H)respawn(A)else
alert(string.format('playerData["%s"].lives &lt;= 0',A),A)end end end end
function eventLoop(o,n)local S,q,f,b;local I=25.0;local H=1.5;local r=-H*H/I;local x=make_star(5,2)
clearT(1)
for D,p in pairs(playerData)do
if p.shot_cd>0 then p.shot_cd=p.shot_cd-1 end;if p.bomb_cd>0 then p.bomb_cd=p.bomb_cd-1 end
S=tfm.get.room.playerList[D]
if not S.isDead then q=S.x;f=S.y
if q==0 and f==0 then kill(D)else
if q<X_MIN then q=X_MIN elseif q>X_MAX then q=X_MAX end;if f<Y_MIN then f=Y_MIN elseif f>Y_MAX then f=Y_MAX end;p.spawn[0]=q
p.spawn[1]=f
if p.focused then local i;for b,i in ipairs(x.points)do
addParticle(particles.purple,q+I*i[1],f+I*i[2],H*i[2],-H*i[1],
r*i[1],r*i[2])end end;if p.shooting then shoot(D,p)end
if p.bombing then p.bombTime=p.bombTime-1
if
p.bombTime<=0 then p.bombing=false;p.bomb_cd=p.bomb.cd;removeBomb(D,p)else if p.bomb.callback then
local a,s=pcall(p.bomb.callback,D,p)
if not a then addError('bomb.callback: '..s)end end end end end end end end
for g,W in pairs(tfm.get.room.playerList)do initPlayer(g)end;setMap(defaultMap)