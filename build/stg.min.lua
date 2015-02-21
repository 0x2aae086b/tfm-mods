do_addObject=tfm.exec.addShamanObject
do_removeObject=tfm.exec.removeObject;do_addGround=tfm.exec.addPhysicObject
do_removeGround=tfm.exec.removePhysicObject;do_addJoint=tfm.exec.addJoint;do_removeJoint=tfm.exec.removeJoint
do_respawn=tfm.exec.respawnPlayer;do_addExplosion=tfm.exec.explosion
addParticle=tfm.exec.displayParticle;setShaman=tfm.exec.setShaman
setShamanName=tfm.exec.setUIShamanName;setMapName=tfm.exec.setUIMapName
setNameColor=tfm.exec.setNameColor;movePlayer=tfm.exec.movePlayer;moveObject=tfm.exec.moveObject
setMap=tfm.exec.newGame;bindKey=tfm.exec.bindKeyboard;kill=tfm.exec.killPlayer;function nop()end;function randomColor()return
math.random(0x000000,0xFFFFFF)end;function round(a)
local X=math.floor(a)if a-X>=0.5 then X=X+1.0 end;return X end;function to_table(f)
if
f==nil or type(f)=='table'then return f else return{f}end end
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
function emptyMap(i,L,l,O)local B,s=i/2.0,L/2.0
local K,D
local c={string.format('<C><P G="0,0" L="%d" H="%d" /><Z><S>',i,L)}l=l or 256;O=O or l
for K=16,i,l do
for D=16,L,O do
c[#c+1]=string.format('<S o="%02x00%02x" L="16" Y="%d" c="4" P="0,0,0,0,0,0,0,0" T="13" X="%d" H="10" />',math.abs(
B-K)/B*255,math.abs(s-D)/s*255,D,K)end end;c[#c+1]='</S><D><DS X="200" Y="200" /></D><O /></Z></C>'return
table.concat(c)end
keycode={backspace=8,enter=13,shift=16,ctrl=17,alt=18,capslock=20,esc=27,space=32,['0']=48,['1']=49,['2']=50,['3']=51,['4']=52,['5']=53,['6']=54,['7']=55,['8']=56,['9']=57,a=81,b=66,c=67,d=68,e=69,f=70,g=71,h=72,i=73,j=74,k=75,l=76,m=77,n=78,o=79,p=80,q=65,r=82,s=83,t=84,u=85,v=86,w=90,x=88,y=89,z=87,[';']=186,['=']=187,[',']=188,['-']=189,['.']=190,['/']=191,['`']=192,[':']=186,['+']=187,['<']=188,['_']=189,['>']=190,['?']=191,['~']=192,['[']=219,['\\']=220,[']']=221,["'"]=222,['{']=219,['|']=220,['}']=221,['"']=222,[')']=48,['!']=49,['@']=50,['#']=51,['$']=52,['%']=53,['^']=54,['&']=55,['*']=56,['(']=57,kp0=96,kp1=97,kp2=98,kp3=99,kp4=100,kp5=101,kp6=102,kp7=103,kp8=104,kp9=105,['kp*']=106,['kp+']=107,['kp-']=109,['kp.']=110,['kp/']=111,left=37,up=38,right=39,down=40,f1=112,f2=113,f3=114,f4=115,f5=116,f6=117,f7=118,f8=119,f9=120,f10=121,f11=122,f12=123}kc=keycode
particles={white=0,purple=1,orange=2,soft_white=4,teal=9,yellow=11,red=13,spawn=3,heart=5,red_heart=30,pink_heart=31,bubble=6,bubble1=7,bubble2=8,water=14,spirit=10,red_spirit=12,plus1=15,plus10=16,plus12=17,plus14=18,plus16=19,meep=20,red_confetti=21,green_confetti=22,blue_confetti=23,yellow_confetti=24,rain=25,wind=26,wind1=27,lightning=28,star=29,flower=32}
objcode={arrow=0,small_box=1,box=2,small_plank=3,plank=4,ball=6,trampoline=7,anvil=10,anvil1=1002,B=11,Bc=12,Bcc=13,V=14,Vc=15,Vcc=16,cannon_up=17,cannon_down=18,cannon_right=19,cannon_left=20,C=22,bomb=23,spirit=24,cheese=25,blue_portal=26,orange_portal=27,balloon1=2806,balloon=28,red_balloon=29,green_balloon=30,yellow_balloon=31,rune=32,snow=34,arrow1=35,apple=39,sheep=40,demolition=41,totem=44,ice_plank=45,choco_plank=46,cloud=57,architect=58,bubble=59,tiny_plank=60,companion_crate=61,stable_rune=62,ballon_anchor=66,windmill_anchor=88}copy(objcode,tfm.enum.shamanObject)
function help(L)
ui.addTextArea(100,MODULE_HELP[MODULE_HELP_START],L,258,78,421,284,
nil,nil,nil,true)
ui.addTextArea(101,string.format('<p align="center"><font face="mono" size="15">%s</font></p>',MODULE_HELP_START),L,258,50,398,20,
nil,nil,nil,true)
ui.addTextArea(102,MODULE_HELP_CONTENTS,L,100,50,150,312,nil,nil,nil,true)
ui.addTextArea(103,MODULE_HELP_CLOSE,L,664,50,15,20,nil,nil,nil,true)end
function helpTextAreaCallback(l,n,y)
if y=='help'then help(n)elseif y=='help_close'and l==103 then
ui.removeTextArea(100,n)ui.removeTextArea(101,n)ui.removeTextArea(102,n)
ui.removeTextArea(103,n)else local o=MODULE_HELP[y]
if o~=nil then ui.updateTextArea(100,o,n)
ui.updateTextArea(101,string.format('<font face="mono" size="15"><p align="center">%s</p></font>',y),n)else return false end end;return true end
function eventChatCommand(z,B)local v,C;local s,l;for n,I in ipairs({{'&lt;','<'},{'&amp;','&'}})do
B=string.gsub(B,I[1],I[2])end
while true do
v,C=string.find(B,'%s+')
if v==nil then s=B;l=''break elseif v==1 then B=string.sub(B,C+1)if B==''then s=''l=''break end else s=string.sub(B,1,
v-1)l=string.sub(B,C+1)break end end;local M=string.lower(s)local S=MODULE_CHAT_COMMAND[M]if S~=nil then
S(z,M,l)else MODULE_CHAT_COMMAND_1(z,s,l)end end
MODULE_CHAT_COMMAND_1=function(x,i,V)alert('Invalid command: '..i,x)end;MAX_ID=1000;function tbl_name(u)return'&lt;table&gt;'end
function newId(G)local f=G.free
local J,B=pairs(f)(f)
if J then f[J]=nil;return J else if G.max==MAX_ID then
error(string.format("newId: %s.max == MAX_ID",tbl_name(G)))end;G.max=G.max+1;return G.max end end
function freeId(S,P)local G=S.free;if P==S.max then local r=S.max-1;while G[r]do G[r]=nil;r=r-1 end;S.max=r else
G[P]=true end end;_errors={'<TI><p align="center">Errors</p>'}ERROR_TA=3
MAX_ERRORS=7;function alert(V,O)
ui.addPopup(0,0,string.format('<font face="mono" size="15">%s</font>',V),O,200,150,400,true)end
function addError(v)
v=string.format("• %s\n",v)for i=#_errors+1,3,-1 do _errors[i]=_errors[i-1]end
_errors[2]=v;_errors[MAX_ERRORS+1]=nil;ui.updateTextArea(ERROR_TA,table.concat(_errors),
nil)end;TIME=os.time()TIMER_RES=250;_timerId={max=0,free={}}_timerData={}
function initTimers()
TIME=os.time()_timerId={max=0,free={}}_timerData={}end
function timer()local Y=os.time()while TIME+TIMER_RES<=Y do eventTimer()
TIME=TIME+TIMER_RES end end
function timers()local U=os.time()local q,g,_
for b,l in ipairs(_timerData)do q=l.time;_=true
while q+l.res<=U do
q=q+l.res;g,_=pcall(l.func,b,l)if not g then
addError(nil,string.format('timer %d: %s',b,_))_=false end;if not _ then break end end;if _ then l.time=q else removeTimer(b)end end end;function addTimer(X,h,Z)local H=newId(_timerId)
_timerData[H]={func=X,args=h,res=Z,time=os.time()}end;function removeTimer(D)
freeId(_timerId,D)end
function addObject(t,D,O,j,U,d,h,R,n,E,w)local P=do_addObject(t,D,O,j,U,d,h)
if R==nil then R=3 end
objectData[P]={time=R,callback=to_table(n),on_remove=to_table(E),callback_args=w}return P end
function removeObject(D)do_removeObject(D)objectData[D]=nil end
function addGround(d,j,o,m,i,g,T)local I=newId(groundId)do_addGround(I,d,j,o)
if m==nil then m=3 end
groundData[I]={time=m,callback=to_table(i),on_remove=to_table(g),callback_args=T}return I end;function removeGround(w)do_removeGround(w)groundData[w]=nil
freeId(groundId,w)end
function addJoint(T,R,A,N,s,t,g)local E=newId(jointId)
do_addJoint(E,T,R,A)if N==nil then N=-1 end;if A==nil then A={}end
jointData[E]={time=N,callback=to_table(s),on_remove=to_table(t),callback_args=g}return E end
function removeJoint(O)do_removeJoint(O)jointData[O]=nil;freeId(jointId,O)end
function addExplosion(_,A,c,U,E,x,R)if x~=nil then addParticle(x,_,A,0,0,0,0)end
if R~=nil then end;do_addExplosion(_,A,c,U,E)end
function list_default(Q,y,P)Q[#Q+1]=string.format('%d %d\n',y,P.time)end
function step(O,X,v,s,Z)local r={}local t;local B,l;if Z==nil then Z=list_default end
for Y,e in pairs(X)do Z(s,Y,e)
if
e.time<=0 then
if e.on_remove then
for g,J in ipairs(e.on_remove)do B,l=pcall(J,Y,e)if not B then
addError(string.format("step(%s): on_remove[%d]: %s\n",tbl_name(X),g,l))end end end;r[#r+1]=Y else e.time=e.time-O
if e.callback then
for _,x in ipairs(e.callback)do B,l=pcall(x,Y,e)if
not B then
addError(string.format("step(%s): callback[%d]: %s\n",tbl_name(X),_,l))r[#r+1]=Y;break end end end end end;for h,i in ipairs(r)do v(i)end end
function setColor(W,h)setNameColor(W,h)playerData[W].color=h end
function tbl_name(a)
if a==groundId then return'groundId'elseif a==jointId then return'jointId'elseif a==bulletId then return'bulletId'elseif a==
patternId then return'patternId'elseif a==_timerId then return'_timerId'elseif a==objectData then return'objectData'elseif a==
groundData then return'groundData'elseif a==jointData then return'jointData'elseif a==bulletData then return'bulletData'elseif a==
patternData then return'patternData'elseif a==_timerData then return'_timerData'end;return'&lt;other&gt;'end
function make_line(b,x)local a,m=x[1]-b[1],x[2]-b[2]return
{width=math.sqrt(a*a+m*m),angle=math.deg(math.atan2(m,a)),x=(
b[1]+x[1])/2,y=(b[2]+x[2])/2}end
make_star=cache2(function(h,c)local _={}local p={}local q;for q=1,h do a=math.pi*2.0*q/h
_[#_+1]={math.cos(a),math.sin(a)}end;for q=1,h do
p[#p+1]=make_line(_[q],_[1+ (q+c-1)%h])end;local O=length1(p[1])return
{lines=p,points=_,r=O,l=math.sqrt(1-O*O)}end)
function make_laser(s,c,T,o,F,i,D,k,J,K)local R={{}}local S=math.atan2(F-T,o-c)
local w,m=math.cos(S),math.sin(S)local G,e=0,0;local U,N;local y,n;local B=2;local a
if s==0 then s=2
for a=1,k do e=e+i;G=e*e*D;y,n=-e*m,e*w
U,N=G*w+y,G*m+n
R[B]={point1=string.format("%d,%d",c+U,T+N),point2=string.format("%d,%d",o+y,F+n)}B=B+1;U,N=G*w-y,G*m-n
R[B]={point1=string.format("%d,%d",c+U,T+N),point2=string.format("%d,%d",o-y,
F-n)}B=B+1 end elseif s==1 then s=2;for a=1,k do e=e+i;y,n=-e*m,e*w
R[B]={point2=string.format("%d,%d",o+y,F+n)}B=B+1
R[B]={point2=string.format("%d,%d",o-y,F-n)}B=B+1 end else
s=1;J=J or 50;G=i*D;for a=1,k do J=J+i;y,n=G*w,G*m
R[B]={point1=string.format("%d,%d",c+y,T+n),line=J}B=B+1;G=G*2 end end;if K then B=0
for a=2,#R do if a%s==0 then B=B+1 end;R[a].color=K[B]end end;return R end
function getText(B)local Q=B.lives-1;local L=B.bombs
if Q>=maxLives then Q=maxLives-1 elseif Q<0 then Q=0 end;if L>maxBombs then L=maxBombs elseif L<0 then L=0 end;return
string.format('<TI><N>Player  <R>%s<N>\nBomb  <VP>%s',string.rep('★',Q),string.rep('★',L))end;function updateTextAreas(y,a)ui.updateTextArea(1,getText(a),y)
ui.updateTextArea(104,'<TI><a href="event:help">?</a>',y)end
function clear()for D,p in
ipairs(keys(jointData))do removeJoint(p)end;for M,J in
ipairs(keys(tfm.get.room.objectList))do removeObject(J)end;for k,P in
ipairs(keys(groundData))do removeGround(P)end;for u,E in
ipairs(keys(bulletData))do removeBullet(E)end;for C,l in
ipairs(keys(patternData))do removePattern(l)end end
function list_object(p,i,L)local P=tfm.get.room.objectList[i]if P==nil then
p[#p+1]=string.format('%d &lt;invalid&gt; %d\n',i,L.time)else
p[#p+1]=string.format('%d (%d, %d) %d\n',i,P.x,P.y,L.time)end end;function list_bullet(u,i,j)
u[#u+1]=string.format("%d %d %d\n",i,j.controls[#j.controls],j.time)end
function clearT(K)local h={'<TI>'}
h[#h+1]='<p align="center">Joints</p>'step(K,jointData,removeJoint,h)
h[#h+1]='<p align="center">Objects</p>'step(K,objectData,removeObject,h,list_object)
h[#h+1]='<p align="center">Grounds</p>'step(K,groundData,removeGround,h)
h[#h+1]='<p align="center">Bullets</p>'step(K,bulletData,removeBullet,h,list_bullet)
h[#h+1]='<p align="center">Patterns</p>'step(K,patternData,removePattern,h)
ui.addTextArea(2,table.concat(h),nil,
-155,5,150,590,nil,nil,0.5,true)end
function shoot_bullet(A,v)local l=v.callback_args;if l._cd==nil then l._cd=0 end
if l._cd>0 then
l._cd=l._cd-1 else l._cd=l.cd
local A=addBullet(l.btype,l.bdata,l.bttl,l.callback,l.on_remove,l.cbargs)
if l.mtype~=nil then addMotion(l.mtype,A,true,l.mdata)end end end;function explode(o,F)local e=F.callback_args
addExplosion(e.x,e.y,e.power,e.distance,e.miceOnly,e.p1,e.p2)end
function explode1(T,F)
local x=F.callback_args
if x.t<=0 then
local l=randomKey1(tfm.get.room.playerList,F.user,true)local Y,Z=0,0;if l~=nil then local t=tfm.get.room.playerList[l]
Y,Z=t.x,t.y end
addExplosion(Y,Z,x.power,x.distance,x.miceOnly,x.p1,x.p2)x.t=x.cd else x.t=x.t-1 end end;function accelerate(y,p)local H=p.callback_args
moveObject(y,0,0,true,H.ax,H.ay,true)end
function moveHoming(f,H)
if
H.time<=7 and H.time>=5 then local K=H.callback_args
local A=tfm.get.room.playerList[K.target]
if A~=nil then local _=A.x;local Q=A.y;local s=K.x;local P=K.y;_=_-s;Q=Q-P;local B=_*_+Q*Q;if B>0 then B=K.v/
math.sqrt(B)_=_*B;Q=Q*B end
moveObject(f,0,0,true,_,Q,false)end end end
function moveHoming1(n,v)local g=v.callback_args
if g.delay>0 then g.delay=g.delay-1 else local k,U;local X=nil;if g.target then
X=tfm.get.room.playerList[g.target]end
if X then k,U=X.x-g.x,X.y-g.y elseif g.target_x then k,U=g.target_x-g.x,
g.target_y-g.y else return end
local f=math.min(math.sqrt(k*k+U*U),g.max_step)
if f>g.min_step then local b,z=to_axis(-math.atan2(U,k))g.jdata.limit2=
f/30.0;g.jdata.axis=b
g.x=g.x+f*math.cos(-z)g.y=g.y+f*math.sin(-z)
do_addJoint(g.jid,g.gid,0,g.jdata)g.delay=g.delay1 end end end;_tmp_grounds={}_tmp_joints={}function addGround1(A,d,r,H)local c=newId(groundId)_tmp_grounds[
#_tmp_grounds+1]=c;do_addGround(c,d,r,H)
A[#A+1]=c;return c end;function addJoint1(v,x,q,t)
local O=newId(jointId)_tmp_joints[#_tmp_joints+1]=O
do_addJoint(O,x,q,t)v[#v+1]=O end
function addBullet(G,z,q,N,a,H)
local P=newId(bulletId)local l,j;local I,y,S,U=pcall(G,z)
if I then _tmp_grounds={}_tmp_joints={}
bulletData[P]={controls={y},grounds=S,joints=U,time=q or 6,callback=to_table(N),on_remove=to_table(a),callback_args=H}else for l,j in ipairs(_tmp_joints)do removeJoint(j)end;for l,j in
ipairs(_tmp_grounds)do removeGround(j)end;_tmp_grounds={}
_tmp_joints={}freeId(bulletId,P)
error(string.format('addBullet: %s',y))end;return P end
function removeBullet(I)local Z=bulletData[I]local K,b;for K,b in ipairs(Z.joints)do do_removeJoint(b)
freeId(jointId,b)end;for K,b in ipairs(Z.grounds)do
do_removeGround(b)freeId(groundId,b)end
bulletData[I]=nil;freeId(bulletId,I)end;bullet={}
bullet.rectangle=function(v)local u,a,s=v.x,v.y,v.angle;local q,K=v.width,v.height
local X,o=v.jdata,v.hitbox_data;local F,O=math.cos(s),math.sin(s)local R=q/2.0;local Y,Z
local H={type=0,point1=string.format("%d,%d",u,a),point2=string.format("%d,%d",
u+F*q,a+O*q),color=0xFF0000,line=2.0*K+4,foreground=false}
local T={type=12,width=q,height=K,angle=math.deg(s),miceCollision=true,groundCollision=false,foreground=true,dynamic=true,mass=1,restitution=255}copy(T,o)local V,b={},{}local t=addGround1(V,u+F*R,a+O*R,T)
if X then for Y,Z in
ipairs(X)do copy(H,Z)addJoint1(b,t,t,H)end end;return t,V,b end
bullet.circle=function(G)local o,g,M=G.x,G.y,G.R;local O,x=G.jdata,G.hitbox_data
local i={type=0,point2=string.format('%d,%d',o,g+1),color=0x0000FF,line=
2*M,foreground=false}
local w={type=13,width=M,height=M,miceCollision=true,groundCollision=false,dynamic=true,mass=1,restitution=255}copy(w,x)local S,r={},{}local V=addGround1(S,o,g,w)if O then for s,X in ipairs(O)do copy(i,X)
addJoint1(r,V,V,i)end end;return V,S,r end
bullet.butterfly=function(D)local K,j,_,I=D.x,D.y,D.angle,D.R;local C,Q=D.center_jdata,D.wing_jdata
local f=D.hitbox_data;local H;local U=make_star(5,2)
local z={type=0,color=0xFF00FF,line=U.l*I*2,foreground=false}
local E={type=0,point1=string.format('%d,%d',K,j),point2=string.format('%d,%d',K,j+1),color=0x0000FF,line=I*2,foreground=false}
local B={type=13,width=I,height=I,dynamic=true,mass=1,miceCollision=true,groundCollision=false,restitution=255}copy(z,Q)copy(B,f)local k,S={},{}local M,T
local Y,X=math.cos(_),math.sin(_)local o;local d=addGround1(k,K,j,B)
for H=2,5 do o=U.points[H]M,T=o[1]*Y-o[2]*X,
o[1]*X+o[2]*Y;M,T=K+I*M,j+I*T
z.point1=string.format('%d,%d',M,T)z.point2=string.format('%d,%d',M,T+1)
addJoint1(S,d,d,z)end;copy(E,C)addJoint1(S,d,d,E)return d,k,S end
bullet.jstar=function(U)local E,N,f,l=U.x,U.y,U.angle,U.R;local B,y=U.points,U.step
local t,e=U.line_jdata,U.center_jdata;local Z=U.hitbox_data;local J;local M=make_star(B,y)
local P={type=0,color=0xFFFFFF,line=5,foreground=true}local u=l*M.r
local w={type=0,point1=string.format('%d,%d',E,N),point2=string.format('%d,%d',E,N+1),color=0xFFFFFF,line=u*2,foreground=true}
local D={type=13,width=u,height=u,dynamic=true,mass=1,miceCollision=true,groundCollision=false,restitution=255}copy(P,t)copy(D,Z)local R,Y={},{}local v={}local O,S
local H,L=math.cos(f),math.sin(f)
for s,o in ipairs(M.points)do O,S=o[1]*H-o[2]*L,o[1]*L+o[2]*H;v[#v+1]=string.format('%d,%d',
E+l*O,N+l*S)end;local x=addGround1(R,E,N,D)for J=1,B do P.point1=v[J]
P.point2=v[1+ (J+y-1)%B]addJoint1(Y,x,x,P)end
if e then for W,F in ipairs(e)do
copy(w,F)addJoint1(Y,x,x,w)end end;return x,R,Y end
bullet.star=function(f)local i,a,J,S=f.x,f.y,f.angle,f.R;local A,u,Y=f.points,f.step,f.do_cap
local p,j=f.line_data,f.center_data;local C=f.cap_data;local B=make_star(A,u)
local D={type=12,height=1,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}local X=S*B.r
local e={type=13,width=X,height=X,color=0xFFFFFF,groundCollision=false,miceCollision=true,dynamic=true,foreground=true,restitution=255}
local O={type=13,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}X=string.format('%d,%d',i,a)
local r={type=3,point1=X,point2=X,ratio=1,limit1=0,limit2=0}local Q={type=0,frequency=10}copy(D,p)copy(e,j)copy(O,C)
local h,F,o={},{},{}local v,l;local f=math.deg(J)local d,w=math.cos(J),math.sin(J)
for W,R in
ipairs(B.lines)do D.angle=R.angle+f;D.width=R.width*S
v,l=R.x*d-R.y*w,R.x*w+R.y*d;addGround1(h,i+S*v,a+S*l,D)end;if Y then
for P,k in ipairs(B.points)do v,l=k[1]*d-k[2]*w,k[1]*w+k[2]*d;addGround1(F,
i+S*v,a+S*l,O)end end
local Z=addGround1(F,i,a,e)
if D.dynamic then local t,z=nil,nil;for P,L in ipairs(h)do addJoint1(o,L,Z,r)if t~=nil then
addJoint1(o,L,t,Q)else z=L end;t=L end
addJoint1(o,z,t,Q)elseif e.dynamic then for x,P in ipairs(h)do addJoint1(o,P,Z,r)end end
if Y then
if O.dynamic then local q,s=nil,nil
for i=1,A do addJoint1(o,F[i],h[i],r)if q~=nil then
addJoint1(o,F[i],q,Q)else s=F[i]end;q=F[i]end;addJoint1(o,s,q,Q)elseif D.dynamic then
for i=1,A do addJoint1(o,F[i],h[i],r)end end end;append(h,F)return Z,h,o end
function bomb(p,c)
if c.bomb_cd==0 and not c.bombing then
if c.bombs>=c.bomb.cost then c.bombs=c.bombs-
c.bomb.cost;c.bombing=true;c.bombTime=c.bomb.time
local A,X=pcall(c.bomb.func,p,c)addBomb(p,c)updateTextAreas(p,c)if not A then
addError(string.format("bomb: %s: %s",p,X))end else
alert(string.format('bombs &lt; %d',c.bomb.cost),p)end end end
function addBomb(k,x)local r=bombs.top+1
local h=string.format('<TI><font color="#%X">%s <font color="#5F5F8D">|</font> %s</font>',x.color,k,x.bomb.name)x.bomb_id=r;bombs.top=r;bombs.val[r]=h;setShamanName(h)end
function removeBomb(b,D)local r=D.bomb_id;D.bomb_id=nil;bombs.val[r]=nil
if r==bombs.top then r=r-1;while
bombs.val[r]==nil and r>0 do r=r-1 end;bombs.top=r;if r>0 then
r=bombs.val[r]else r=''end;setShamanName(r)end end
function addBombTimer(b,q,r,d)local s=r.bombTime*d+2
local y={type=13,color=0xFF0000,foreground=false,width=s,height=s,miceCollision=false}
addGround(q.x,q.y,y,r.bombTime,moveBombTimer,nil,{player=b,pdata=r,offset=2,scale=d,obj=y})s=s-2
y={type=13,color=0x6A7495,foreground=false,width=s,height=s,miceCollision=false}
addGround(q.x,q.y,y,r.bombTime,moveBombTimer,nil,{player=b,pdata=r,offset=0,scale=d,obj=y})end
function moveBombTimer(o,_)local b=_.callback_args
local K=tfm.get.room.playerList[b.player]local x=b.pdata.bombTime*b.scale+b.offset
b.obj.width=x;b.obj.height=x;do_addGround(o,K.x,K.y,b.obj)end
function bomb1(y,i)local g=20;local f=512;local d=32.0
local F=tfm.get.room.playerList[y]local u,N=F.x,F.y;local O=string.format("%d,%d",u,N)
local z={0x00FF00,0x00FFFF,0x0000FF}
local p={x=u,y=N,R=32,hitbox_data={miceCollision=false,mass=2,angularDamping=1}}
local C={width=f,height=16,hitbox_data={mass=2,linearDamping=0.5}}local o={last=true,ttl=g,jdata={speedMotor=255}}
addBombTimer(y,F,i,5)local e=addBullet(bullet.circle,p,g)local I=e
e=bulletData[e].controls;e=e[#e]local t={type=3,point1=O,point2=O,ratio=1,limit1=0,limit2=0}
local W={type=0,frequency=32}local k;local w,a;local Y,M;local E,s;local X;local B
for B=1,3 do k=math.pi*B*2.0/3.0
w,a=math.cos(k),math.sin(k)Y,M=u+ (d+f)*w,N+ (d+f)*a;w,a=u+d*w,N+d*a
X=make_laser(0,w,a,Y,M,5,0.1,2,20)
X[1]={point1=string.format("%d,%d",w,a),point2=string.format("%d,%d",Y,M),color=z[B],alpha=0.25,line=20,foreground=true}C.angle=k;C.x=w;C.y=a;C.jdata=X
id=addBullet(bullet.rectangle,C,g)id=bulletData[id].controls;id=id[#id]
addJoint(id,e,t,g)if s then addJoint(id,s,W,g)else E=id end;s=id end;addJoint(s,E,W,g)addMotion(motion.circle,I,true,o)end
function bomb2Callback(I,C)local F=C.callback_args
if F.delay==1 then
local Q={last=true,ttl=F.ttl,x=F.x,y=F.y,no_target=F.no_target,delay=0,delay1=0,frequency=0.5,max_step=500}addMotion(motion.follow,I,true,Q)F.delay=0 else
F.delay=F.delay-1 end end
function bomb2(j,t)local s=20;local B=96.0;local M=tfm.get.room.playerList[j]
local _,R=M.x,M.y
local S={R=48,jdata={{foreground=false,line=128}},hitbox_data={color=0xFFFFFF}}
local v={ttl=2,last=true,jdata={speedMotor=3,color=0xFFFFFF}}local h;local N,z;local n;local c;local g;addBombTimer(j,M,t,5)
for g=1,#_axis do
h=(1-g)*_axis_step;N,z=math.cos(h),math.sin(h)S.x=_+B*N;S.y=R+B*z
S.jdata[1].color=randomColor()v.jdata.axis=_axis[g]
v.jdata.speedMotor=5-v.jdata.speedMotor;c={delay=2,ttl=s-2,x=_+150*N,y=R+150*z,no_target=j}n=addBullet(bullet.circle,S,s,bomb2Callback,
nil,c)
addMotion(motion.line,n,true,v)end end;function do_addControl(K,e)K[#K+1]=e end;function do_removeControl(S,M)
while S[M]do S[M]=nil;M=M+1 end end;function motionEnd(n,N)
do_removeControl(N.callback_args._controls,N.callback_args._idx)end
function addControl(x,...)local m=#x+1
local P=addGround(...)local N=groundData[P]
if N.callback_args==nil then
N.callback_args={_controls=x,_idx=m}else N.callback_args._controls=x;N.callback_args._idx=m end;if N.on_remove==nil then N.on_remove={motionEnd}else
N.on_remove[#N.on_remove+1]=motionEnd end;x[#x+1]=P;return P end;function addControl1(f,...)return addGround(...)end
function addMotion(g,c,F,m)local K;local C;if F then
K=bulletData[c].controls;C=addControl else K={c}C=addControl1 end
local r,u=pcall(g,C,K,m)if not r then
error(string.format("addMotion: %s",u))end end;motion={}
motion.invalid_friction=function(A,M,Z)
local o={type=2,point2="0,0",point3="0,0",point4="0,0"}local v=addGround(100,100,CONTROL,1)addJoint(M[#M],v,o,1)end
motion.fix=function(S,u,z)local Y=0;local Z=u[#u]local A={type=0,frequency=10}copy(A,z.jdata)
if not
z.last then Y=S(u,z.x or 0,z.y or 0,CONTROL,z.ttl or 3)end;addJoint(Z,Y,A,z.ttl or 3)end
motion.follow=function(o,y,p)p.x=p.x or 0;p.y=p.y or 0;p.ttl=p.ttl or 3
p.delay=p.delay or 0;p.delay1=p.delay1 or 0;p.max_step=p.max_step or 3000;p.min_step=p.min_step or
30;if p.target==nil then
p.target=randomKey1(tfm.get.room.playerList,p.no_target,true)end;local R=y[#y]
local r=o(y,p.x,p.y,CONTROL,p.ttl,moveHoming1,nil,p)
local D={type=0,frequency=p.frequency or(1.0/ (1.0+p.delay1))}local W={type=1,forceMotor=255,speedMotor=127}copy(W,p.jdata)
addJoint(R,r,D,p.ttl)p.jdata=W;p.gid=r;p.jid=addJoint(r,0,D,p.ttl)end
motion.line=function(L,Q,v)local g=v.x or 0;local c=v.y or 0;local b=v.ttl or 3;local P=0;local B
local M={type=1,axis='-1,0',angle=0,forceMotor=255,speedMotor=1}copy(M,v.jdata)if v.free_angle then
motion.fix(L,Q,{ttl=b,x=g,y=c})end;B=Q[#Q]
if not v.last then P=L(Q,g,c,CONTROL,b)end;addJoint(B,P,M,b)end
motion.circle=function(d,i,m)local O=0;local H=i[#i]local x={type=3,forceMotor=255,speedMotor=1}
copy(x,m.jdata)if not m.last then
O=d(i,m.x or 0,m.y or 0,CONTROL,m.ttl or 3)end;if m.x and m.y then
x.point1=string.format('%d,%d',m.x,m.y)end;addJoint(H,O,x,m.ttl or 3)end
motion.spiral=function(Z,c,h)local M=h.last;h.last=false;h.jdata=h.tjoint
motion.line(Z,c,h)h.last=M;h.jdata=h.rjoint;motion.circle(Z,c,h)end
function pattern(G,n,U,z,i)local j=n.patterns[U][z]
if j~=nil then local b=#j.points+1
if b>=
j.type.points then local P=os.time()
if P-j.lastTime>=j.type.cd then j.lastTime=P
j.points[b]=i;local O,A=pcall(addPattern,G,n,j.type,j.points)j.points={}if not O then
addError(string.format("pattern: %s: %s",G,A))end end else j.points[b]=i end end end
function bind(i,P,U,D)local n=playerData[i]local Q=n.patterns[P]if Q[U]~=nil then
do_unbind(n,Q[U],P,U)end
Q[U]={id=D,type=patternTypes[D],points={},lastTime=0}Q=n.pattern_data[D]
if P=='key'then bindKey(i,U,true,true)end
if Q==nil then n.pattern_data[D]={binds=1}else Q.binds=Q.binds+1 end end
function do_unbind(O,U,N,o)local v=O.pattern_data[U.id]if v.binds<=1 then
O.pattern_data[U.id]=nil else v.binds=v.binds-1 end;O.patterns[N][o]=
nil end
function unbind(Y,u,R)local X=playerData[Y]
if u==nil then X.patterns={key={},obj={},objend={}}
X.pattern_data={}elseif R==nil then local q={}
for B,H in pairs(X.patterns[u])do q[#q+1]={B,H}end;for D,t in ipairs(q)do do_unbind(X,t[2],u,t[1])end else
local A=X.patterns[u][R]if A~=nil then do_unbind(X,A,u,R)end end end
function addPattern(W,V,s,h)local L=nil;if s.time~=nil then L=newId(patternId)
patternData[L]={time=s.time,callback=s.callback,on_remove=s.on_remove}end
s.func(W,V,L,h)return L end
function removePattern(_)patternData[_]=nil;freeId(patternId,_)end
function testPattern(W,w,A,p)local k=p[1]local K=6;local o=48;local L=math.random(2,8)local E,g,d,l
local c=math.rad(k.angle)for l=0,K-1 do E=c+2.0*math.pi*l/K
g,d=math.cos(E),math.sin(E)
addObject(k.type,k.x+o*g,k.y+o*d,k.angle+360*l/K,L*g,L*d,false,9)end end
function testPattern1(J,h,H,d)local A=d[1]local y=math.random(8,16)local E,Y,O,D;local I;local H
local R={angle=0.25-math.pi/2.0,R=16,center_jdata={},wing_jdata={line=24,alpha=0.5},hitbox_data={width=0,height=0,color=0xFFFFFF,mass=1}}local c={ttl=2,last=true,jdata={}}
for D=1,y do I=math.random(64,96)E=
math.random()*2.0*math.pi
Y,O=math.cos(E),math.sin(E)R.x=A.x+I*Y;R.y=A.y+I*O
R.center_jdata.color=randomColor()R.wing_jdata.color=randomColor()
c.jdata.speedMotor=math.random(2,6)c.jdata.angle=2*math.pi-E
H=addBullet(bullet.butterfly,R,8)addMotion(motion.line,H,true,c)end end
function testPattern2(n,E,b,N)local F=N[1]
local y={x=F.x,y=F.y,R=16,jdata={{color=randomColor(),line=32}},hitbox_data={width=0,height=0,color=0xFFFFFF,mass=1}}
local O={ttl=16,last=true,x=F.x,y=F.y,frequency=0.25,delay=2,delay1=0,max_step=1000}local b=addBullet(bullet.circle,y,16)
addMotion(motion.follow,b,true,O)end
function testPattern3(t,M,s,b)local w=b[1]local j=randomColor()
local S,G=to_axis(math.rad(-w.angle))
local i={x=w.x,y=w.y,angle=G,R=36,points=math.random(5,8),step=2,line_jdata={color=j},center_jdata={{foreground=false,color=j,line=76},{color=0x6A7495,line=70}},hitbox_data={dynamic=true,miceCollision=false}}
local e={cd=0,btype=bullet.rectangle,bttl=10,bdata={x=w.x,y=w.y,angle=-G,width=128,height=13,jdata={{color=randomColor(),foreground=false},{color=0xFFFFFF,line=16,foreground=true}},hitbox_data={dynamic=true,fixedRotation=true,mass=1}},mtype=motion.line,mdata={x=w.x,y=w.y,ttl=1,last=true,free_angle=true,jdata={speedMotor=8,axis=S}}}local s=addBullet(bullet.jstar,i,32,shoot_bullet,nil,e)
addMotion(motion.circle,s,true,{last=true,ttl=2,jdata={speedMotor=4}})end
function testPattern4(Q,b,L,A)local w=A[1]
local C={x=w.x,y=w.y,angle=math.rad(w.angle),width=512,height=13,jdata={{color=randomColor(),foreground=true},{color=0xFFFFFF,line=16}},hitbox_data={dynamic=true,restitution=0,mass=
-1}}local L=addBullet(bullet.rectangle,C,10)
addMotion(motion.invalid_friction,L,true)end
function shoot(J,l)
if l.shot_cd==0 then
if l.bombing and l.bomb.shot~=nil then
l.shot_cd=l.bomb.shot.cd;local o,B=pcall(l.bomb.shot.func,J,l)if not o then
addError(string.format("shoot(bombing): %s: %s",J,B))end else l.shot_cd=l.shot.cd
local G,k=pcall(l.shot.func,J,l)if not G then
addError(string.format("shoot: %s: %s",J,k))end end end end
function defaultShot(K,S)local g=tfm.get.room.playerList[K]local F,l=g.x,g.y;local Q;if
g.isFacingRight then Q=-1 else Q=1 end;local z=math.random()*math.pi
local y={x=F+64*
math.cos(z),y=l+64*math.sin(z),angle=0,R=16,points=5,step=2,line_jdata={color=randomColor()},center_jdata={{}}}
local p={last=true,ttl=math.random(1,4),x=F,y=l,jdata={speedMotor=4*Q}}local w=addBullet(bullet.jstar,y,8)z=
math.random()*math.pi+math.pi
y.x=F+64*math.cos(z)y.y=l+64*math.sin(z)
y.line_jdata.color=randomColor()local a=addBullet(bullet.jstar,y,8)
addMotion(motion.circle,w,true,p)p.ttl=math.random(1,4)p.jdata.speedMotor=-4*Q
addMotion(motion.circle,a,true,p)end
function homingShot(F,R)
local w=randomKey1(tfm.get.room.playerList,F,false)local c=tfm.get.room.playerList[F]local u=c.x;local e=c.y;local s=2
local n=2;local h=false;if not c.isFacingRight then s=-s end;u=u+16*s
local L={target=w,x=u,y=e+32,v=128}
addObject(objcode.anvil,u+s,e+n,0,s,n,h,10,moveHoming,nil,L)local L={target=w,x=u,y=e-32,v=128}
addObject(objcode.anvil,u+s,e-n,0,s,-n,h,10,moveHoming,nil,L)end;do_respawn_1=do_respawn
function do_respawn(Z)do_respawn_1(Z)
local E=playerData[Z].spawn;movePlayer(Z,E[0],E[1],false,0,0,true)end
function initPlayer(W)
local Q={color=randomColor(),shooting=false,bombing=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},spawn={200,200},speed=35,vx=0,lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}if playerConfig[W]==nil then playerConfig[W]={}end
copy(Q,playerConfig[W])playerData[W]=Q;for M,H in ipairs(playerKeys)do bindKey(W,H,true,true)
bindKey(W,H,false,true)end
system.bindMouse(W,true)
ui.addTextArea(1,getText(Q),W,5,25,151,40,nil,nil,0.5,true)
ui.addTextArea(104,'<TI><a href="event:help">?</a>',W,145,25,11,20,nil,nil,0.0,true)
ui.addTextArea(ERROR_TA,table.concat(_errors),W,805,5,200,590,nil,nil,0.5,true)do_respawn(W)setShaman(W)
setNameColor(W,playerData[W].color)end
function resetPlayer(k)local s=playerData[k]copy(s,RESET)updateTextAreas(k,s)
do_respawn(k)setShaman(k)setNameColor(k,s.color)end;function deletePlayer(q)local N=playerData[q]if N.bombing then removeBomb(q,N)end;playerData[q]=
nil end
function respawn(T)
do_respawn(T)setNameColor(T,playerData[T].color)end
function movePlayer1(A,M,v,E,T)
if v then v=v*M.speed
if T then M.vx=v;if M.vx>0 then M.dir=1 else M.dir=-1 end
movePlayer(A,0,0,false,v,0,false)else movePlayer(A,0,0,false,1,0,false)
movePlayer(A,0,0,false,-1,0,true)M.vx=0 end elseif E then E=E*M.speed;if T then movePlayer(A,0,0,false,M.vx,E,false)else movePlayer(A,0,0,false,0,
-1,false)
movePlayer(A,0,0,false,0,1,true)end else return false end;return true end;playerData={}objectData={}groundData={}jointData={}patternData={}bulletData={}
MAX_ID=400;MAX_ERRORS=7
GROUND0={type=13,color=0xFFFFFF,dynamic=false,miceCollision=false,groundCollision=false}
CONTROL={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}
RESET={shooting=false,bombing=false,lives=5,bombs=3,shot_cd=0,bomb_cd=0,vx=0}
playerKeys={kc.space,kc.w,kc.s,kc.a,kc.d,kc.left,kc.right,kc.up,kc.down,kc.e,kc.q}reservedKeys=invert(playerKeys,true)
pk_vx={[kc.a]=-1,[kc.left]=-1,[kc.d]=1,[kc.right]=1}
pk_vy={[kc.space]=-1,[kc.w]=-1,[kc.up]=-1,[kc.s]=1,[kc.down]=1}eventCode={key=keycode,obj=objcode,objend=objcode}mapWidth=1600
mapHeight=800;defaultMap=emptyMap(mapWidth,mapHeight)maxLives=8;maxBombs=6
shotTypes={{name='default shot',func=defaultShot,cd=1},{name='homing anvils',func=homingShot,cd=2}}
bombTypes={{name='',func=bomb1,callback=nil,shot={func=nop,cd=1},cost=1,time=20,cd=5},{name='',func=bomb2,callback=nil,shot={func=nop,cd=1},cost=1,time=20,cd=5}}
patternTypes={{func=testPattern,callback=nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern1,callback=
nil,cd=500,points=1,maxBinds=3,restrict={key=nil,obj=nil,objend=nil}},{func=testPattern2,callback=
nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern3,callback=
nil,cd=16000,points=1,maxBinds=2,restrict={key={},obj=nil,objend=nil}},{func=testPattern4,callback=
nil,cd=250,points=1,maxBinds=2,restrict={key={},obj=nil,objend=nil}}}
playerConfig={Cafecafe={color=0x9852B4},Rar={color=0x553399}}MODULE_HELP_START='Keys'
MODULE_HELP_CONTENTS=[[<font face="mono" size="15"><a href="event:Keys">Keys</a>
<a href="event:Commands">Commands</a>
<a href="event:Shot types">Shot types</a>
<a href="event:Bomb types">Bomb types</a>
<a href="event:Pattern types">Pattern types</a>
<a href="event:Shaman objects">Shaman objects</a>
]]
MODULE_HELP={['Keys']=[[<font face="mono" size="15">Shoot - E
Bomb  - Q
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
local D=function(k,u)local T={'<font face="mono" size="15">'}
for n,z in ipairs(k)do
if z.name then
T[#T+1]=string.format('%d - %s\n',n,z.name)else T[#T+1]=string.format('%d\n',n)end
if z.cost then T[#T+1]=string.format('    Cost: %d\n',z.cost)end;if z.time then
T[#T+1]=string.format('    Duration: %fs\n',z.time/2.0)end;if z.cd then
T[#T+1]=string.format('    Cooldown: %fs\n',z.cd/u)end;if z.maxBinds then
T[#T+1]=string.format('    Max. binds: %d\n',z.maxBinds)end;T[#T+1]='\n'end;return table.concat(T)end;MODULE_HELP['Shot types']=D(shotTypes,2.0)
MODULE_HELP['Bomb types']=D(bombTypes,2.0)MODULE_HELP['Pattern types']=D(patternTypes,1000.0)end
do
local O=function(M,g)local f={'<font face="mono" size="15">'}local Q;for t,h in ipairs(keys1(M))do
Q=g-#h;if Q>0 then t=h..string.rep(' ',Q)else t=h end
f[#f+1]=string.format('%s = %4d\n',t,M[h])end
f[#f+1]='</font>'return table.concat(f)end;MODULE_HELP['Shaman objects']=O(objcode,15)end
MODULE_CHAT_COMMAND={['help']=help,['clear']=clear,['color']=function(h,v,Y)Y=string.upper(Y)
if Y==''or Y=='RANDOM'or Y==
'RND'then setColor(h,randomColor())playerConfig[h].color=
nil else local f=tonumber(Y)if f~=nil then if f>0xFFFFFF then f=0xFFFFFF end
setColor(h,Y)playerConfig[h].color=Y else
alert('Invalid color: '..Y,h)end end end,['reset']=function(n,Y,G)
G=string.lower(G)if G==''or G=='map'then setMap(defaultMap)else
parsePlayerNames(n,G,resetPlayer)end end,['init']=function(D,d,Y)local h=function(D)
deletePlayer(D)initPlayer(D)end
parsePlayerNames(D,Y,h)end,['respawn']=function(G,P,b)
parsePlayerNames(G,b,respawn)end,['shot']=function(g,Y,m)local a=tonumber(m)if a==nil then
alert('Invalid shot type: '..m,g)return end;a=shotTypes[a]
if a~=nil then
playerData[g].shot=a else alert('Invalid shot type: '..m,g)end end,['bomb']=function(L,l,N)
local B=tonumber(N)
if B==nil then alert('Invalid bomb type: '..N,L)return end;B=bombTypes[B]if B~=nil then playerData[L].bomb=B else
alert('Invalid bomb type: '..N,L)end end,['bind']=function(o,K,y)
y=split(y)if#y<3 then alert('Too few arguments',o)return elseif#y>3 then
alert('Too many arguments',o)return end
i=tonumber(y[1])local U=patternTypes[i]if i==nil or U==nil then
alert('Invalid pattern: '..y[1],o)return end;j=y[2]
if j~='key'and j~='obj'and
j~='objend'then alert('Invalid event: '..j,o)return end;local T=tonumber(y[3])
if T==nil then T=eventCode[j][y[3]]if T==nil then
alert(string.format('Invalid %s name/code: %s',j,y[3]),o)return end end;if
U.restrict[j]~=nil and U.restrict[j][T]==nil then
alert(string.format('Can\'t bind pattern %d to %s %d: restricted',i,j,T),o)return end;if
j=='key'and reservedKeys[T]then
alert(string.format('Can\'t bind pattern %d to %s %d: reserved',i,j,T),o)return end
local X=playerData[o]local I=X.pattern_data[i]if I~=nil and U.maxBinds<=I.binds then
alert(string.format('Can\'t bind pattern %d to more than %d events',i,U.maxBinds),o)return end
bind(o,j,T,i)end,['unbind']=function(o,U,x)
x=split(x)if#x>2 then alert('Too many arguments',o)return end
i=x[1]
if i=='all'or i==nil then unbind(o)elseif
i~='key'and i~='obj'and i~='objend'then alert('Invalid event: '..i,o)return else
if x[2]==nil then
unbind(o,i)else j=tonumber(x[2])
if j==nil then j=eventCode[i][x[2]]if j==nil then
alert(string.format('Invalid %s name/code: %s',i,x[2]),o)return end end;unbind(o,i,j)end end end,['map']=function(t,S,p)if
p==''then p=defaultMap end;setMap(p)end}eventNewPlayer=initPlayer;eventPlayerLeft=deletePlayer
eventTextAreaCallback=helpTextAreaCallback
function eventNewGame()initTimers()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)tfm.exec.setGameTime(0)objectData={}groundData={}
jointData={}patternData={}bulletData={}bombs={top=0,val={}}groundId={max=0,free={}}
jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}for e,J in
pairs(tfm.get.room.playerList)do resetPlayer(e)end
setMapName('<TI>')setShamanName('')do_addGround(0,0,0,GROUND0)end
function eventKeyboard(b,g,U,E,w)
if reservedKeys[g]then local C=playerData[b]if
movePlayer1(b,C,pk_vx[g],pk_vy[g],U)then return end
if g==kc.q then local C=playerData[b]
if U then bomb(b,C)end elseif g==kc.e then local C=playerData[b]C.shooting=U;if U then shoot(b,C)end end elseif U then local S=playerData[b]pattern(b,S,'key',g,{x=E,y=w})end end;function eventSummoningStart(B,O,J,V,Q)local o={x=J,y=V,angle=Q,type=O}
pattern(B,playerData[B],'obj',O,o)end
function eventSummoningEnd(U,N,T,f,l,v,z,R,E)
objectData[R.id]={time=3}local w={x=T,y=f,angle=l,type=N,vx=v,vy=z,data=R,other=E}
pattern(U,playerData[U],'objend',N,w)end;function eventMouse(P,b,Y)
addError(string.format('(%d; %d)',b,Y))end
function eventPlayerDied(X)local y=playerData[X]
if y~=nil then
if y.bombing then
respawn(X)else y.shot_cd=0;y.bomb_cd=0;y.shooting=false;y.lives=y.lives-1;if y.lives>0 then
y.bombs=y.resetBombs;updateTextAreas(X,y)respawn(X)else
alert(string.format('playerData["%s"].lives &lt;= 0',X),X)end end end end
function eventLoop(i,k)local e,C,s,t,v,S,f,Z;clearT(1)
for X,Y in pairs(playerData)do
e=tfm.get.room.playerList[X]
if not e.isDead then C=e.x;s=e.y;if C<0 then C=0 elseif C>mapWidth then C=mapWidth end;if s<0 then
s=0 elseif s>mapHeight then s=mapHeight end;Y.spawn[0]=C
Y.spawn[1]=s;t=-e.vx;v=-e.vy;S=t/10.0;f=v/10.0
for Z=1,math.random(8,16)do
addParticle(particles.purple,C+math.random(
-4,4),s+math.random(-4,4),(
t+math.random()*2-1)/Z,
(v+math.random()*2-1)/Z,S,f)end end;if Y.shot_cd>0 then Y.shot_cd=Y.shot_cd-1 end;if Y.bomb_cd>0 then Y.bomb_cd=
Y.bomb_cd-1 end
if Y.shooting then shoot(X,Y)end
if Y.bombing then Y.bombTime=Y.bombTime-1
if Y.bombTime<=0 then Y.bombing=false
Y.bomb_cd=Y.bomb.cd;removeBomb(X,Y)else if Y.bomb.callback then
local d,h=pcall(Y.bomb.callback,X,Y)
if not d then addError('bomb.callback: '..h)end end end end end end
for b,z in pairs(tfm.get.room.playerList)do initPlayer(b)end;setMap(defaultMap)