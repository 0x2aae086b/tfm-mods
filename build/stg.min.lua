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
function parsePlayerNames(D,I,d)local O={}local C
for U,Y in
ipairs(split(string.lower(I)))do
if string.sub(Y,1,1)=='!'then Y=string.sub(Y,2)C=nil else C=true end
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
keycode={backspace=8,enter=13,shift=16,ctrl=17,alt=18,capslock=20,esc=27,space=32,['0']=48,['1']=49,['2']=50,['3']=51,['4']=52,['5']=53,['6']=54,['7']=55,['8']=56,['9']=57,a=81,b=66,c=67,d=68,e=69,f=70,g=71,h=72,i=73,j=74,k=75,l=76,m=77,n=78,o=79,p=80,q=65,r=82,s=83,t=84,u=85,v=86,w=90,x=88,y=89,z=87,[';']=186,['=']=187,[',']=188,['-']=189,['.']=190,['/']=191,['`']=192,[':']=186,['+']=187,['<']=188,['_']=189,['>']=190,['?']=191,['~']=192,['[']=219,['\\']=220,[']']=221,["'"]=222,['{']=219,['|']=220,['}']=221,['"']=222,[')']=48,['!']=49,['@']=50,['#']=51,['$']=52,['%']=53,['^']=54,['&']=55,['*']=56,['(']=57,kp0=96,kp1=97,kp2=98,kp3=99,kp4=100,kp5=101,kp6=102,kp7=103,kp8=104,kp9=105,['kp*']=106,['kp+']=107,['kp-']=109,['kp.']=110,['kp/']=111,left=37,up=38,right=39,down=40,f1=112,f2=113,f3=114,f4=115,f5=116,f6=117,f7=118,f8=119,f9=120,f10=121,f11=122,f12=123}
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
l(B,L,c)else MODULE_CHAT_COMMAND_1(B,D,c)end end;MAX_ID=1000;function tbl_name(o)return'&lt;table&gt;'end
function newId(z)local B=z.free
local C,s=pairs(B)(B)
if C then B[C]=nil;return C else if z.max==MAX_ID then
error(string.format("newId: %s.max == MAX_ID",tbl_name(z)))end;z.max=z.max+1;return z.max end end
function freeId(l,v)local M=l.free;if v==l.max then local S=l.max-1;while M[S]do M[S]=nil;S=S-1 end;l.max=S else
M[v]=true end end;_errors={'<TI><p align="center">Errors</p>'}ERROR_TA=3
MAX_ERRORS=7;function alert(n,v)
ui.addPopup(0,0,string.format('<font face="mono" size="15">%s</font>',n),v,200,150,400,true)end
function addError(I)
I=string.format("• %s\n",I)for i=#_errors+1,3,-1 do _errors[i]=_errors[i-1]end
_errors[2]=I;_errors[MAX_ERRORS+1]=nil;ui.updateTextArea(ERROR_TA,table.concat(_errors),
nil)end;TIME=os.time()TIMER_RES=250;_timerId={max=0,free={}}_timerData={}
function initTimers()
TIME=os.time()_timerId={max=0,free={}}_timerData={}end
function timer()local x=os.time()while TIME+TIMER_RES<=x do eventTimer()
TIME=TIME+TIMER_RES end end
function timers()local i=os.time()local V,u,G
for f,J in ipairs(_timerData)do V=J.time;G=true
while V+J.res<=i do
V=V+J.res;u,G=pcall(J.func,f,J)if not u then
addError(nil,string.format('timer %d: %s',f,G))G=false end;if not G then break end end;if G then J.time=V else removeTimer(f)end end end;function addTimer(B,S,P)local G=newId(_timerId)
_timerData[G]={func=B,args=S,res=P,time=os.time()}end;function removeTimer(r)
freeId(_timerId,r)end;function setColor(V,O)setNameColor(V,O)
playerData[V].color=O end
function tbl_name(v)
if v==groundId then return'groundId'elseif v==jointId then
return'jointId'elseif v==bulletId then return'bulletId'elseif v==patternId then return'patternId'elseif v==_timerId then return'_timerId'elseif v==
objectData then return'objectData'elseif v==groundData then return'groundData'elseif v==jointData then return'jointData'elseif v==
bulletData then return'bulletData'elseif v==patternData then return'patternData'elseif v==_timerData then
return'_timerData'end;return'&lt;other&gt;'end
function make_line(Y,U)local q,g=U[1]-Y[1],U[2]-Y[2]return
{width=math.sqrt(q*q+g*g),angle=math.deg(math.atan2(g,q)),x=(
Y[1]+U[1])/2,y=(Y[2]+U[2])/2}end
make_star=cache2(function(_,b)local l={}local X={}for i=1,_ do a=math.pi*2.0*i/_
l[#l+1]={math.cos(a),math.sin(a)}end;for i=1,_ do
X[#X+1]=make_line(l[i],l[1+ (i+b-1)%_])end;local h=length1(X[1])return
{lines=X,points=l,r=h,l=math.sqrt(1-h*h)}end)
function make_laser(Z,H,D,t,O,j,U,d,h,R)local n={{}}local E=math.atan2(O-D,t-H)
local w,P=math.cos(E),math.sin(E)local o,m=0,0;local i,g;local T,I;local A=2
if Z==0 then Z=2
for i=1,d do m=m+j;o=m*m*U;T,I=-m*P,m*w
i,g=o*w+T,o*P+I
n[A]={point1=string.format("%d,%d",H+i,D+g),point2=string.format("%d,%d",t+T,O+I)}A=A+1;i,g=o*w-T,o*P-I
n[A]={point1=string.format("%d,%d",H+i,D+g),point2=string.format("%d,%d",t-T,
O-I)}A=A+1 end elseif Z==1 then Z=2;for A=1,d do m=m+j;T,I=-m*P,m*w
n[A]={point2=string.format("%d,%d",t+T,O+I)}A=A+1
n[A]={point2=string.format("%d,%d",t-T,O-I)}A=A+1 end else
Z=1;h=h or 50;o=j*U;for i=1,d do h=h+j;T,I=o*w,o*P
n[A]={point1=string.format("%d,%d",H+T,D+I),line=h}A=A+1;o=o*2 end end;if R then A=0
for i=2,#n do if i%Z==0 then A=A+1 end;n[i].color=R[A]end end;return n end
function getText(N)local s=N.lives-1;local t=N.bombs
if s>=maxLives then s=maxLives-1 end;if s<0 then s=0 end;if t>maxBombs then t=maxBombs elseif t<0 then t=0 end;if N.lives<1 then
l=0 else l=N.lives end;return
string.format('<TI><N>Player  <R>%s<N>\nBomb  <VP>%s',string.rep('★',s),string.rep('★',t))end;function updateTextAreas(g,E)ui.updateTextArea(1,getText(E),g)
ui.updateTextArea(104,'<TI><a href="event:help">?</a>',g)end
function clear()for O,_ in
ipairs(keys(jointData))do removeJoint(_)end;for A,c in
ipairs(keys(tfm.get.room.objectList))do removeObject(c)end;for U,_ in
ipairs(keys(groundData))do removeGround(_)end;for E,x in
ipairs(keys(bulletData))do removeBullet(x)end;for R,Q in
ipairs(keys(patternData))do removePattern(Q)end end
function list_default(y,P,O)y[#y+1]=string.format('%d %d\n',P,O.time)end
function list_object(X,s,Z)local r=tfm.get.room.objectList[s]if r==nil then
X[#X+1]=string.format('%d &lt;invalid&gt; %d\n',s,Z.time)else
X[#X+1]=string.format('%d (%d, %d) %d\n',s,r.x,r.y,Z.time)end end;function list_bullet(B,l,Y)
B[#B+1]=string.format("%d %d %d\n",l,Y.controls[#Y.controls],Y.time)end
function step(e,g,J,_,t)local x={}local h;local i,W;if t==nil then
t=list_default end
for a,b in pairs(g)do t(_,a,b)
if b.time<=0 then
if b.on_remove then
for m,c in ipairs(b.on_remove)do
i,W=pcall(c,a,b)if not i then
addError(string.format("step(%s): on_remove[%d]: %s\n",tbl_name(g),m,W))end end end;x[#x+1]=a else b.time=b.time-e
if b.callback then
for p,q in ipairs(b.callback)do i,W=pcall(q,a,b)if
not i then
addError(string.format("step(%s): callback[%d]: %s\n",tbl_name(g),p,W))x[#x+1]=a;break end end end end end;for O,s in ipairs(x)do J(s)end end
function clearT(c)local T={'<TI>'}T[#T+1]='<p align="center">Joints</p>'
step(c,jointData,removeJoint,T)T[#T+1]='<p align="center">Objects</p>'
step(c,objectData,removeObject,T,list_object)T[#T+1]='<p align="center">Grounds</p>'
step(c,groundData,removeGround,T)T[#T+1]='<p align="center">Bullets</p>'
step(c,bulletData,removeBullet,T,list_bullet)T[#T+1]='<p align="center">Patterns</p>'
step(c,patternData,removePattern,T)
ui.addTextArea(2,table.concat(T),nil,-155,5,150,590,nil,nil,0.5,true)end
function shoot_bullet(o,F)local i=F.callback_args;if i._cd==nil then i._cd=0 end
if i._cd>0 then
i._cd=i._cd-1 else i._cd=i.cd
local o=addBullet(i.btype,i.bdata,i.bttl,i.callback,i.on_remove,i.cbargs)
if i.mtype~=nil then addMotion(i.mtype,o,true,i.mdata)end end end;function explode(D,k)local J=k.callback_args
addExplosion(J.x,J.y,J.power,J.distance,J.miceOnly,J.p1,J.p2)end
function explode1(K,D)
local R=D.callback_args
if R.t<=0 then
local i=randomKey1(tfm.get.room.playerList,D.user,true)local S,o=0,0;if i~=nil then local w=tfm.get.room.playerList[i]
S,o=w.x,w.y end
addExplosion(S,o,R.power,R.distance,R.miceOnly,R.p1,R.p2)R.t=R.cd else R.t=R.t-1 end end;function accelerate(m,G)local e=G.callback_args
moveObject(m,0,0,true,e.ax,e.ay,true)end
function moveHoming(j,U)
if
U.time<=7 and U.time>=5 then local N=U.callback_args
local y=tfm.get.room.playerList[N.target]
if y~=nil then local n=y.x;local B=y.y;local K=N.x;local a=N.y;n=n-K;B=B-a;local Q=n*n+B*B;if Q>0 then Q=N.v/
math.sqrt(Q)n=n*Q;B=B*Q end
moveObject(j,0,0,true,n,B,false)end end end
function moveHoming1(L,y)local D=y.callback_args
if D.delay>0 then D.delay=D.delay-1 else local M,J;local k=nil;if D.target then
k=tfm.get.room.playerList[D.target]end
if k then M,J=k.x-D.x,k.y-D.y elseif D.target_x then M,J=D.target_x-D.x,
D.target_y-D.y else return end
local P=math.min(math.sqrt(M*M+J*J),D.max_step)
if P>D.min_step then local u,E=to_axis(-math.atan2(J,M))D.jdata.limit2=
P/30.0;D.jdata.axis=u
D.x=D.x+P*math.cos(-E)D.y=D.y+P*math.sin(-E)
do_addJoint(D.jid,D.gid,0,D.jdata)D.delay=D.delay1 end end end
function addObject(C,l,p,i,L,P,u,j,K,h,A)local v=do_addObject(C,l,p,i,L,P,u)if j==nil then j=3 end
objectData[v]={time=j,callback=to_table(K),on_remove=to_table(h),callback_args=A}return v end
function removeObject(l)do_removeObject(l)objectData[l]=nil end
function addGround(o,F,e,T,x,l,Y)local Z=newId(groundId)do_addGround(Z,o,F,e)
if T==nil then T=3 end
groundData[Z]={time=T,callback=to_table(x),on_remove=to_table(l),callback_args=Y}return Z end;function removeGround(t)do_removeGround(t)groundData[t]=nil
freeId(groundId,t)end
function addJoint(y,p,H,f,K,A,_)local Q=newId(jointId)
do_addJoint(Q,y,p,H)if f==nil then f=-1 end;if H==nil then H={}end
jointData[Q]={time=f,callback=to_table(K),on_remove=to_table(A),callback_args=_}return Q end
function removeJoint(s)do_removeJoint(s)jointData[s]=nil;freeId(jointId,s)end
function addPattern(K,P,B,n)local v=nil;if B.time~=nil then v=newId(patternId)
patternData[v]={time=B.time,callback=B.callback,on_remove=B.on_remove}end
B.func(K,P,v,n)return v end
function removePattern(g)patternData[g]=nil;freeId(patternId,g)end
function addExplosion(k,U,l,X,f,b,v)if b~=nil then addParticle(b,k,U,0,0,0,0)end
if v~=nil then end;do_addExplosion(k,U,l,X,f)end;_tmp_grounds={}_tmp_joints={}function addGround1(z,A,d,r)local H=newId(groundId)_tmp_grounds[
#_tmp_grounds+1]=H;do_addGround(H,A,d,r)
z[#z+1]=H;return H end;function addJoint1(c,v,x,q)
local t=newId(jointId)_tmp_joints[#_tmp_joints+1]=t
do_addJoint(t,v,x,q)c[#c+1]=t end
function addBullet(O,G,z,q,N,a)
local H=newId(bulletId)local P,l,j,I=pcall(O,G)
if P then _tmp_grounds={}_tmp_joints={}
bulletData[H]={controls={l},grounds=j,joints=I,time=z or 6,callback=to_table(q),on_remove=to_table(N),callback_args=a}else for y,S in ipairs(_tmp_joints)do removeJoint(S)end;for U,Z in
ipairs(_tmp_grounds)do removeGround(Z)end;_tmp_grounds={}
_tmp_joints={}freeId(bulletId,H)
error(string.format('addBullet: %s',l))end;return H end
function removeBullet(K)local b=bulletData[K]for u,a in ipairs(b.joints)do do_removeJoint(a)
freeId(jointId,a)end;for s,q in ipairs(b.grounds)do
do_removeGround(q)freeId(groundId,q)end
bulletData[K]=nil;freeId(bulletId,K)end;bullet={}
bullet.rectangle=function(K)local X,o,u=K.x,K.y,K.angle;local F,O=K.width,K.height
local R,Y=K.jdata,K.hitbox_data;local Z,H=math.cos(u),math.sin(u)local T=F/2.0
local V={type=0,point1=string.format("%d,%d",X,o),point2=string.format("%d,%d",
X+Z*F,o+H*F),color=0xFF0000,line=2.0*O+4,foreground=false}
local b={type=12,width=F,height=O,angle=math.deg(u),miceCollision=true,groundCollision=false,foreground=true,dynamic=true,mass=1,restitution=255}copy(b,Y)local t,G={},{}local g=addGround1(t,X+Z*T,o+H*T,b)
if R then for M,x in
ipairs(R)do copy(V,x)addJoint1(G,g,g,V)end end;return g,t,G end
bullet.circle=function(i)local w,S,r=i.x,i.y,i.R;local V,s=i.jdata,i.hitbox_data
local X={type=0,point2=string.format('%d,%d',w,S+1),color=0x0000FF,line=
2*r,foreground=false}
local D={type=13,width=r,height=r,miceCollision=true,groundCollision=false,dynamic=true,mass=1,restitution=255}copy(D,s)local K,j={},{}local _=addGround1(K,w,S,D)if V then for c,I in ipairs(V)do copy(X,I)
addJoint1(j,_,_,X)end end;return _,K,j end
bullet.butterfly=function(C)local Q,f,H,U=C.x,C.y,C.angle,C.R;local z,j=C.center_jdata,C.wing_jdata
local E=C.hitbox_data;local B;local _=make_star(5,2)
local k={type=0,color=0xFF00FF,line=_.l*U*2,foreground=false}
local S={type=0,point1=string.format('%d,%d',Q,f),point2=string.format('%d,%d',Q,f+1),color=0x0000FF,line=U*2,foreground=false}
local M={type=13,width=U,height=U,dynamic=true,mass=1,miceCollision=true,groundCollision=false,restitution=255}copy(k,j)copy(M,E)local T,Y={},{}local X,o
local d,N=math.cos(H),math.sin(H)local l;local y=addGround1(T,Q,f,M)
for B=2,5 do l=_.points[B]X,o=l[1]*d-l[2]*N,
l[1]*N+l[2]*d;X,o=Q+U*X,f+U*o
k.point1=string.format('%d,%d',X,o)k.point2=string.format('%d,%d',X,o+1)
addJoint1(Y,y,y,k)end;copy(S,z)addJoint1(Y,y,y,S)return y,T,Y end
bullet.jstar=function(t)local e,Z,J,M=t.x,t.y,t.angle,t.R;local P,u=t.points,t.step
local w,y=t.line_jdata,t.center_jdata;local D=t.hitbox_data;local R;local Y=make_star(P,u)
local v={type=0,color=0xFFFFFF,line=5,foreground=true}local O=M*Y.r
local S={type=0,point1=string.format('%d,%d',e,Z),point2=string.format('%d,%d',e,Z+1),color=0xFFFFFF,line=O*2,foreground=true}
local H={type=13,width=O,height=O,dynamic=true,mass=1,miceCollision=true,groundCollision=false,restitution=255}copy(v,w)copy(H,D)local L,x={},{}local o={}local W,F
local f,i=math.cos(J),math.sin(J)
for A,p in ipairs(Y.points)do W,F=p[1]*f-p[2]*i,p[1]*i+p[2]*f;o[#o+1]=string.format('%d,%d',
e+M*W,Z+M*F)end;local a=addGround1(L,e,Z,H)for R=1,P do v.point1=o[R]
v.point2=o[1+ (R+u-1)%P]addJoint1(x,a,a,v)end
if y then for j,A in ipairs(y)do
copy(S,A)addJoint1(x,a,a,S)end end;return a,L,x end
bullet.star=function(C)local J,B,D,X=C.x,C.y,C.angle,C.R;local e,O,r=C.points,C.step,C.do_cap
local Q,h=C.line_data,C.center_data;local F=C.cap_data;local o=make_star(e,O)
local v={type=12,height=1,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}local l=X*o.r
local d={type=13,width=l,height=l,color=0xFFFFFF,groundCollision=false,miceCollision=true,dynamic=true,foreground=true,restitution=255}
local a={type=13,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}l=string.format('%d,%d',J,B)
local u={type=3,point1=l,point2=l,ratio=1,limit1=0,limit2=0}local w={type=0,frequency=10}copy(v,Q)copy(d,h)copy(a,F)
local Z,j,p={},{},{}local W,R;local C=math.deg(D)local P,k=math.cos(D),math.sin(D)
for z,L in
ipairs(o.lines)do v.angle=L.angle+C;v.width=L.width*X
W,R=L.x*P-L.y*k,L.x*k+L.y*P;addGround1(Z,J+X*W,B+X*R,v)end;if r then
for x,q in ipairs(o.points)do W,R=q[1]*P-q[2]*k,q[1]*k+q[2]*P;addGround1(j,
J+X*W,B+X*R,a)end end
local t=addGround1(j,J,B,d)
if v.dynamic then local s,c=nil,nil;for A,x in ipairs(Z)do addJoint1(p,x,t,u)if s~=nil then
addJoint1(p,x,s,w)else c=x end;s=x end
addJoint1(p,c,s,w)elseif d.dynamic then for b,q in ipairs(Z)do addJoint1(p,q,t,u)end end
if r then
if a.dynamic then local b,s=nil,nil
for i=1,e do addJoint1(p,j[i],Z[i],u)if b~=nil then
addJoint1(p,j[i],b,w)else s=j[i]end;b=j[i]end;addJoint1(p,s,b,w)elseif v.dynamic then
for i=1,e do addJoint1(p,j[i],Z[i],u)end end end;append(Z,j)return t,Z,p end
function bomb(y,o)
if o.bomb_cd==0 and not o.bombing then
if o.bombs>=o.bomb.cost then o.bombs=o.bombs-
o.bomb.cost;o.bombing=true;o.bombTime=o.bomb.time
local _,b=pcall(o.bomb.func,y,o)addBomb(y,o)updateTextAreas(y,o)if not _ then
addError(string.format("bomb: %s: %s",y,b))end else
alert(string.format('bombs &lt; %d',o.bomb.cost),y)end end end
function addBomb(K,x)local y=bombs.top+1
local i=string.format('<TI><font color="#%X">%s <font color="#5F5F8D">|</font> %s</font>',x.color,K,x.bomb.name)x.bomb_id=y;bombs.top=y;bombs.val[y]=i;setShamanName(i)end
function removeBomb(g,f)local d=f.bomb_id;f.bomb_id=nil;bombs.val[d]=nil
if d==bombs.top then d=d-1;while
bombs.val[d]==nil and d>0 do d=d-1 end;bombs.top=d;if d>0 then
d=bombs.val[d]else d=''end;setShamanName(d)end end;function do_addControl(F,u)F[#F+1]=u end;function do_removeControl(N,O)
while N[O]do N[O]=nil;O=O+1 end end;function motionEnd(d,z)
do_removeControl(z.callback_args._controls,z.callback_args._idx)end
function addControl(x,...)local p=#x+1
local C=addGround(...)local u=groundData[C]
if u.callback_args==nil then
u.callback_args={_controls=x,_idx=p}else u.callback_args._controls=x;u.callback_args._idx=p end;if u.on_remove==nil then u.on_remove={motionEnd}else
u.on_remove[#u.on_remove+1]=motionEnd end;x[#x+1]=C;return C end;function addControl1(y,...)return addGround(...)end
function addMotion(o,e,I,t)local W;local k;if I then
W=bulletData[e].controls;k=addControl else W={e}k=addControl1 end
local w,a=pcall(o,k,W,t)if not w then
error(string.format("addMotion: %s",a))end end;motion={}
motion.fix=function(w,Y,M)local E=0;local s=Y[#Y]local X={type=0,frequency=10}
copy(X,M.jdata)if not M.last then
E=w(Y,M.x or 0,M.y or 0,CONTROL,M.ttl or 3)end;addJoint(s,E,X,M.ttl or 3)end
motion.follow=function(i,B,I)I.x=I.x or 0;I.y=I.y or 0;I.ttl=I.ttl or 3
I.delay=I.delay or 0;I.delay1=I.delay1 or 0;I.max_step=I.max_step or 3000;I.min_step=I.min_step or
30;if I.target==nil then
I.target=randomKey1(tfm.get.room.playerList,I.no_target,true)end;local C=B[#B]
local F=i(B,I.x,I.y,CONTROL,I.ttl,moveHoming1,nil,I)
local Q={type=0,frequency=I.frequency or(1.0/ (1.0+I.delay1))}local j={type=1,forceMotor=255,speedMotor=127}copy(j,I.jdata)
addJoint(C,F,Q,I.ttl)I.jdata=j;I.gid=F;I.jid=addJoint(F,0,Q,I.ttl)end
motion.line=function(t,s,B)local M=B.x or 0;local _=B.y or 0;local R=B.ttl or 3;local i=0;local y
local S={type=1,axis='-1,0',angle=0,forceMotor=255,speedMotor=1}copy(S,B.jdata)if B.free_angle then
motion.fix(t,s,{ttl=R,x=M,y=_})end;y=s[#s]
if not B.last then i=t(s,M,_,CONTROL,R)end;addJoint(y,i,S,R)end
motion.circle=function(S,i,v)local h=0;local N=i[#i]local B={type=3,forceMotor=255,speedMotor=1}
copy(B,v.jdata)if not v.last then
h=S(i,v.x or 0,v.y or 0,CONTROL,v.ttl or 3)end;if v.x and v.y then
B.point1=string.format('%d,%d',v.x,v.y)end;addJoint(N,h,B,v.ttl or 3)end
motion.spiral=function(z,n,c)local g=c.last;c.last=false;c.jdata=c.tjoint
motion.line(z,n,c)c.last=g;c.jdata=c.rjoint;motion.circle(z,n,c)end
function addBombTimer(K,e,S,M)local n=S.bombTime*M+2
local N={type=13,color=0xFF0000,foreground=false,width=n,height=n,miceCollision=false}
addGround(e.x,e.y,N,S.bombTime,moveBombTimer,nil,{player=K,pdata=S,offset=2,scale=M,obj=N})n=n-2
N={type=13,color=0x6A7495,foreground=false,width=n,height=n,miceCollision=false}
addGround(e.x,e.y,N,S.bombTime,moveBombTimer,nil,{player=K,pdata=S,offset=0,scale=M,obj=N})end
function moveBombTimer(x,m)local P=m.callback_args
local N=tfm.get.room.playerList[P.player]local f=P.pdata.bombTime*P.scale+P.offset
P.obj.width=f;P.obj.height=f;do_addGround(x,N.x,N.y,P.obj)end
function bomb1(g,c)local F=20;local m=512;local K=32.0
local C=tfm.get.room.playerList[g]local r,u=C.x,C.y;local A=string.format("%d,%d",r,u)
local M={0x00FF00,0x00FFFF,0x0000FF}
local Z={x=r,y=u,R=32,hitbox_data={miceCollision=false,mass=2,angularDamping=1}}
local o={width=m,height=16,hitbox_data={mass=2,linearDamping=0.5}}local v={last=true,ttl=F,jdata={speedMotor=255}}
addBombTimer(g,C,c,5)local S=addBullet(bullet.circle,Z,F)local z=S
S=bulletData[S].controls;S=S[#S]local Y={type=3,point1=A,point2=A,ratio=1,limit1=0,limit2=0}
local p={type=0,frequency=32}local R;local D,W;local L,Q;local y,b;local P;local B
for B=1,3 do R=math.pi*B*2.0/3.0
D,W=math.cos(R),math.sin(R)L,Q=r+ (K+m)*D,u+ (K+m)*W;D,W=r+K*D,u+K*W
P=make_laser(0,D,W,L,Q,5,0.1,2,20)
P[1]={point1=string.format("%d,%d",D,W),point2=string.format("%d,%d",L,Q),color=M[B],alpha=0.25,line=20,foreground=true}o.angle=R;o.x=D;o.y=W;o.jdata=P
id=addBullet(bullet.rectangle,o,F)id=bulletData[id].controls;id=id[#id]
addJoint(id,S,Y,F)if b then addJoint(id,b,p,F)else y=id end;b=id end;addJoint(b,y,p,F)addMotion(motion.circle,z,true,v)end
function bomb2Callback(M,d)local i=d.callback_args
if i.delay==1 then
local m={last=true,ttl=i.ttl,x=i.x,y=i.y,no_target=i.no_target,delay=0,delay1=0,frequency=0.5,max_step=500}addMotion(motion.follow,M,true,m)i.delay=0 else
i.delay=i.delay-1 end end
function bomb2(O,H)local Z=20;local c=96.0;local h=tfm.get.room.playerList[O]
local M,G=h.x,h.y
local n={R=48,jdata={{foreground=false,line=128}},hitbox_data={color=0xFFFFFF}}
local U={ttl=2,last=true,jdata={speedMotor=3,color=0xFFFFFF}}local z;local j,b;local P;local A;local D;addBombTimer(O,h,H,5)
for D=1,#_axis do
z=(1-D)*_axis_step;j,b=math.cos(z),math.sin(z)n.x=M+c*j;n.y=G+c*b
n.jdata[1].color=randomColor()U.jdata.axis=_axis[D]
U.jdata.speedMotor=5-U.jdata.speedMotor;A={delay=2,ttl=Z-2,x=M+150*j,y=G+150*b}P=addBullet(bullet.circle,n,Z,bomb2Callback,
nil,A)
addMotion(motion.line,P,true,U)end end
function pattern(n,Q,O,U,N)local o=Q.patterns[O][U]
if o~=nil then local v=#o.points+1
if v>=
o.type.points then local Y=os.time()
if Y-o.lastTime>=o.type.cd then o.lastTime=Y
o.points[v]=N;local u,R=pcall(addPattern,n,Q,o.type,o.points)o.points={}if not u then
addError(string.format("pattern: %s: %s",n,R))end end else o.points[v]=N end end end
function bind(X,q,B,H)local D=playerData[X]local v=D.patterns[q]if v[B]~=nil then
do_unbind(D,v[B],q,B)end
v[B]={id=H,type=patternTypes[H],points={},lastTime=0}v=D.pattern_data[H]
if q=='key'then bindKey(X,B,true,true)end
if v==nil then D.pattern_data[H]={binds=1}else v.binds=v.binds+1 end end
function do_unbind(t,A,W,V)local s=t.pattern_data[A.id]if s.binds<=1 then
t.pattern_data[A.id]=nil else s.binds=s.binds-1 end;t.patterns[W][V]=
nil end
function unbind(h,L,_)local W=playerData[h]
if L==nil then W.patterns={key={},obj={},objend={}}
W.pattern_data={}elseif _==nil then local w={}
for A,p in pairs(W.patterns[L])do w[#w+1]={A,p}end;for K,c in ipairs(w)do do_unbind(W,c[2],L,c[1])end else
local o=W.patterns[L][_]if o~=nil then do_unbind(W,o,L,_)end end end
function testPattern(L,E,g,d)local k=d[1]local l=6;local J=48;local h=math.random(2,8)local H,A,y
local Y=math.rad(k.angle)for i=0,l-1 do H=Y+2.0*math.pi*i/l
A,y=math.cos(H),math.sin(H)
addObject(k.type,k.x+J*A,k.y+J*y,k.angle+360*i/l,h*A,h*y,false,9)end end
function testPattern1(O,D,I,y)local R=y[1]local E=math.random(8,16)local b,N,F;local t;local I
local M={angle=0.25-math.pi/2.0,R=16,center_jdata={},wing_jdata={line=24,alpha=0.5},hitbox_data={width=0,height=0,color=0xFFFFFF,mass=1}}local s={ttl=2,last=true,jdata={}}
for i=1,E do t=math.random(64,96)b=
math.random()*2.0*math.pi
N,F=math.cos(b),math.sin(b)M.x=R.x+t*N;M.y=R.y+t*F
M.center_jdata.color=randomColor()M.wing_jdata.color=randomColor()
s.jdata.speedMotor=math.random(2,6)s.jdata.angle=2*math.pi-b
I=addBullet(bullet.butterfly,M,8)addMotion(motion.line,I,true,s)end end
function testPattern2(b,w,t,j)local S=j[1]
local G={x=S.x,y=S.y,R=16,jdata={{color=randomColor(),line=32}},hitbox_data={width=0,height=0,color=0xFFFFFF,mass=1}}
local i={ttl=16,last=true,x=S.x,y=S.y,frequency=0.25,delay=2,delay1=0,max_step=1000}local t=addBullet(bullet.circle,G,16)
addMotion(motion.follow,t,true,i)end
function testPattern3(e,Q,b,L)local A=L[1]local w=randomColor()
local C,J=to_axis(math.rad(-A.angle))
local l={x=A.x,y=A.y,angle=J,R=36,points=math.random(5,8),step=2,line_jdata={color=w},center_jdata={{foreground=false,color=w,line=76},{color=0x6A7495,line=70}},hitbox_data={dynamic=true,miceCollision=false}}
local o={cd=0,btype=bullet.rectangle,bttl=10,bdata={x=A.x,y=A.y,angle=-J,width=128,height=13,jdata={{color=randomColor(),foreground=false},{color=0xFFFFFF,line=16,foreground=true}},hitbox_data={dynamic=true,fixedRotation=true,mass=1}},mtype=motion.line,mdata={x=A.x,y=A.y,ttl=1,last=true,free_angle=true,jdata={speedMotor=8,axis=C}}}local b=addBullet(bullet.jstar,l,32,shoot_bullet,nil,o)
addMotion(motion.circle,b,true,{last=true,ttl=2,jdata={speedMotor=4}})end
function shoot(B,G)
if G.shot_cd==0 then
if G.bombing and G.bomb.shot~=nil then
G.shot_cd=G.bomb.shot.cd;local k,K=pcall(G.bomb.shot.func,B,G)if not k then
addError(string.format("shoot(bombing): %s: %s",B,K))end else G.shot_cd=G.shot.cd
local S,g=pcall(G.shot.func,B,G)if not S then
addError(string.format("shoot: %s: %s",B,g))end end end end
function defaultShot(F,l)local Q=tfm.get.room.playerList[F]local z,K=Q.x,Q.y;local p;if
Q.isFacingRight then p=-1 else p=1 end;local w=math.random()*math.pi
local a={x=z+64*
math.cos(w),y=K+64*math.sin(w),angle=0,R=16,points=5,step=2,line_jdata={color=randomColor()},center_jdata={{}}}
local R={last=true,ttl=math.random(1,4),x=z,y=K,jdata={speedMotor=4*p}}local c=addBullet(bullet.jstar,a,8)w=
math.random()*math.pi+math.pi
a.x=z+64*math.cos(w)a.y=K+64*math.sin(w)
a.line_jdata.color=randomColor()local u=addBullet(bullet.jstar,a,8)
addMotion(motion.circle,c,true,R)R.ttl=math.random(1,4)R.jdata.speedMotor=-4*p
addMotion(motion.circle,u,true,R)end
function homingShot(e,s)
local n=randomKey1(tfm.get.room.playerList,e,false)local h=tfm.get.room.playerList[e]local L=h.x;local Z=h.y;local E=2
local W=2;local Q=false;if not h.isFacingRight then E=-E end;L=L+16*E
local M={target=n,x=L,y=Z+32,v=128}
addObject(objcode.anvil,L+E,Z+W,0,E,W,Q,10,moveHoming,nil,M)local M={target=n,x=L,y=Z-32,v=128}
addObject(objcode.anvil,L+E,Z-W,0,E,-W,Q,10,moveHoming,nil,M)end;do_respawn_1=do_respawn
function do_respawn(H)do_respawn_1(H)
local k=playerData[H].spawn;movePlayer(H,k[0],k[1],false,0,0,true)end
function initPlayer(s)
local q={color=randomColor(),shooting=false,bombing=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},spawn={200,200},vx=0,lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}if playerConfig[s]==nil then playerConfig[s]={}end
copy(q,playerConfig[s])playerData[s]=q;for N,T in pairs(playerKeys)do bindKey(s,T,true,true)
bindKey(s,T,false,true)end
system.bindMouse(s,true)
ui.addTextArea(1,getText(q),s,5,25,151,40,nil,nil,0.5,true)
ui.addTextArea(104,'<TI><a href="event:help">?</a>',s,145,25,11,20,nil,nil,0.0,true)
ui.addTextArea(ERROR_TA,table.concat(_errors),s,805,5,200,590,nil,nil,0.5,true)do_respawn(s)setShaman(s)
setNameColor(s,playerData[s].color)end
function resetPlayer(A)
local M={shooting=false,bombing=false,bombTime=nil,lives=5,bombs=3,shot_cd=0,bomb_cd=0,vx=0,bomb_id=nil}local v=playerData[A]copy(v,M)updateTextAreas(A,v)
do_respawn(A)setShaman(A)setNameColor(A,v.color)end;function deletePlayer(E)local T=playerData[E]if T.bombing then removeBomb(E,T)end;playerData[E]=
nil end
function respawn(D)
do_respawn(D)setNameColor(D,playerData[D].color)end;playerData={}objectData={}groundData={}jointData={}patternData={}bulletData={}
MAX_ID=400;MAX_ERRORS=7
CONTROL={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}
playerKeys={32,83,40,100,101,102,104,65,68,69,81,37,39,38,90}reservedKeys=invert(playerKeys,true)
eventCode={key=keycode,obj=objcode,objend=objcode}
defaultMap='<C><P L="1600" H="800" G="0,0" /><Z><S /><D><DS Y="200" X="200" /></D><O /></Z></C>'mapWidth=1600;mapHeight=800;maxLives=8;maxBombs=6
shotTypes={{name='default shot',func=defaultShot,cd=1},{name='homing anvils',func=homingShot,cd=2}}
bombTypes={{name='',func=bomb1,callback=nil,shot={func=nop,cd=1},cost=1,time=20,cd=5},{name='',func=bomb2,callback=nil,shot={func=nop,cd=1},cost=1,time=20,cd=5}}
patternTypes={{func=testPattern,callback=nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern1,callback=
nil,cd=500,points=1,maxBinds=3,restrict={key=nil,obj=nil,objend=nil}},{func=testPattern2,callback=
nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern3,callback=
nil,cd=16000,points=1,maxBinds=2,restrict={key={},obj=nil,objend=nil}}}
playerConfig={Cafecafe={bomb=bombTypes[1],color=0x9852B4},Rar={color=0x553399}}MODULE_HELP_START='Keys'
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
local k=function(u,T)local n={'<font face="mono" size="15">'}
for z,O in ipairs(u)do
if O.name then
n[#n+1]=string.format('%d - %s\n',z,O.name)else n[#n+1]=string.format('%d\n',z)end
if O.cost then n[#n+1]=string.format('    Cost: %d\n',O.cost)end;if O.time then
n[#n+1]=string.format('    Duration: %fs\n',O.time/2.0)end;if O.cd then
n[#n+1]=string.format('    Cooldown: %fs\n',O.cd/T)end;if O.maxBinds then
n[#n+1]=string.format('    Max. binds: %d\n',O.maxBinds)end;n[#n+1]='\n'end;return table.concat(n)end;MODULE_HELP['Shot types']=k(shotTypes,2.0)
MODULE_HELP['Bomb types']=k(bombTypes,2.0)MODULE_HELP['Pattern types']=k(patternTypes,1000.0)end
do
local M=function(g,f)local Q={'<font face="mono" size="15">'}local t;for h,v in ipairs(keys1(g))do
t=f-#v;if t>0 then h=v..string.rep(' ',t)else h=v end
Q[#Q+1]=string.format('%s = %4d\n',h,g[v])end
Q[#Q+1]='</font>'return table.concat(Q)end;MODULE_HELP['Shaman objects']=M(objcode,15)end
MODULE_CHAT_COMMAND={['help']=help,['clear']=clear,['color']=function(Y,f,n)n=string.upper(n)
if n==''or n=='RANDOM'or n==
'RND'then setColor(Y,randomColor())playerConfig[Y].color=
nil else local G=tonumber(n)if G~=nil then if G>0xFFFFFF then G=0xFFFFFF end
setColor(Y,n)playerConfig[Y].color=n else
alert('Invalid color: '..n,Y)end end end,['reset']=function(D,d,Y)
Y=string.lower(Y)if Y==''or Y=='map'then setMap(defaultMap)else
parsePlayerNames(D,Y,resetPlayer)end end,['init']=function(h,G,P)local b=function(h)
deletePlayer(h)initPlayer(h)end
parsePlayerNames(h,P,b)end,['respawn']=function(g,Y,m)
parsePlayerNames(g,m,respawn)end,['shot']=function(a,L,l)local N=tonumber(l)if N==nil then
alert('Invalid shot type: '..l,a)return end;N=shotTypes[N]
if N~=nil then
playerData[a].shot=N else alert('Invalid shot type: '..l,a)end end,['bomb']=function(B,o,K)
local y=tonumber(K)
if y==nil then alert('Invalid bomb type: '..K,B)return end;y=bombTypes[y]if y~=nil then playerData[B].bomb=y else
alert('Invalid bomb type: '..K,B)end end,['bind']=function(U,T,X)
X=split(X)if#X<3 then alert('Too few arguments',U)return elseif#X>3 then
alert('Too many arguments',U)return end
i=tonumber(X[1])local I=patternTypes[i]if i==nil or I==nil then
alert('Invalid pattern: '..X[1],U)return end;j=X[2]
if j~='key'and j~='obj'and
j~='objend'then alert('Invalid event: '..j,U)return end;local o=tonumber(X[3])
if o==nil then o=eventCode[j][X[3]]if o==nil then
alert(string.format('Invalid %s name/code: %s',j,X[3]),U)return end end;if
I.restrict[j]~=nil and I.restrict[j][o]==nil then
alert(string.format('Can\'t bind pattern %d to %s %d: restricted',i,j,o),U)return end;if
j=='key'and reservedKeys[o]then
alert(string.format('Can\'t bind pattern %d to %s %d: reserved',i,j,o),U)return end
local x=playerData[U]local t=x.pattern_data[i]if t~=nil and I.maxBinds<=t.binds then
alert(string.format('Can\'t bind pattern %d to more than %d events',i,I.maxBinds),U)return end
bind(U,j,o,i)end,['unbind']=function(S,p,e)
e=split(e)if#e>2 then alert('Too many arguments',S)return end
i=e[1]
if i=='all'or i==nil then unbind(S)elseif
i~='key'and i~='obj'and i~='objend'then alert('Invalid event: '..i,S)return else
if e[2]==nil then
unbind(S,i)else j=tonumber(e[2])
if j==nil then j=eventCode[i][e[2]]if j==nil then
alert(string.format('Invalid %s name/code: %s',i,e[2]),S)return end end;unbind(S,i,j)end end end,['map']=function(J,b,g)if
g==''then g=defaultMap end;setMap(g)end}
MODULE_CHAT_COMMAND_1=function(U,E,w)alert('Invalid command: '..E,U)end;eventNewPlayer=initPlayer;eventPlayerLeft=deletePlayer
eventTextAreaCallback=helpTextAreaCallback
function eventNewGame()initTimers()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)tfm.exec.setGameTime(0)objectData={}groundData={}
jointData={}patternData={}bulletData={}bombs={top=0,val={}}groundId={max=0,free={}}
jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}for C,S in
pairs(tfm.get.room.playerList)do resetPlayer(C)end
setMapName('<TI>')setShamanName('')
do_addGround(0,0,0,{type=13,width=10,height=10,color=0xFFFFFF,dynamic=false,miceCollision=false,groundCollision=false})end
function eventKeyboard(B,O,J,V,Q)
if reservedKeys[O]then
if O==65 then local o=playerData[B]if J then bomb(B,o)end elseif O==69 then
local U=playerData[B]U.shooting=J;if J then shoot(B,U)end else local N=0;local T=0
if not J then
if


O==32 or O==104 or O==83 or O==40 or O==53 or O==101 or O==38 or O==90 then movePlayer(B,0,0,true,0,1,false)
movePlayer(B,0,0,true,0,-1,true)else movePlayer(B,0,0,true,1,0,false)
movePlayer(B,0,0,true,-1,0,true)playerData[B].vx=0 end else
if
O==32 or O==104 or O==87 or O==38 or O==90 then N=-50 elseif O==83 or O==40 or O==101 then N=50 elseif O==100 or O==37 or O==81 then
T=-50 elseif O==102 or O==39 or O==68 then T=50 end;if T~=0 then playerData[B].vx=T elseif O==83 or O==40 then
T=playerData[B].vx end;if T~=0 or N~=0 then
movePlayer(B,0,0,true,T,N,false)end end end elseif J then local f=playerData[B]pattern(B,f,'key',O,{x=V,y=Q})end end;function eventSummoningStart(f,l,v,z,R)local E={x=v,y=z,angle=R,type=l}
pattern(f,playerData[f],'obj',l,E)end
function eventSummoningEnd(w,P,b,Y,X,y,i,k,e)
objectData[k.id]={time=3}local C={x=b,y=Y,angle=X,type=P,vx=y,vy=i,data=k,other=e}
pattern(w,playerData[w],'objend',P,C)end;function eventMouse(s,t,v)
addError(string.format('(%d; %d)',t,v))end
function eventPlayerDied(S)local f=playerData[S]
if f~=nil then
if f.bombing then
respawn(S)else f.shot_cd=0;f.bomb_cd=0;f.shooting=false;f.lives=f.lives-1;if f.lives>0 then
f.bombs=f.resetBombs;updateTextAreas(S,f)respawn(S)else
alert(string.format('playerData["%s"].lives &lt;= 0',S),S)end end end end
function eventLoop(Z,X)local Y,d,h,b,z,a,k,w;clearT(1)
for i,q in pairs(playerData)do
Y=tfm.get.room.playerList[i]
if not Y.isDead then d=Y.x;h=Y.y;if d<0 then d=0 elseif d>mapWidth then d=mapWidth end;if h<0 then
h=0 elseif h>mapHeight then h=mapHeight end;q.spawn[0]=d
q.spawn[1]=h;b=-Y.vx;z=-Y.vy;a=b/10.0;k=z/10.0
for w=1,math.random(8,16)do
addParticle(particles.purple,d+math.random(
-4,4),h+math.random(-4,4),(
b+math.random()*2-1)/w,
(z+math.random()*2-1)/w,a,k)end end;if q.shot_cd>0 then q.shot_cd=q.shot_cd-1 end;if q.bomb_cd>0 then q.bomb_cd=
q.bomb_cd-1 end
if q.shooting then shoot(i,q)end
if q.bombing then q.bombTime=q.bombTime-1
if q.bombTime<=0 then q.bombing=false
q.bomb_cd=q.bomb.cd;removeBomb(i,q)else if q.bomb.callback then
local t,p=pcall(q.bomb.callback,i,q)
if not t then addError('bomb.callback: '..p)end end end end end end
for W,g in pairs(tfm.get.room.playerList)do initPlayer(W)end;setMap(defaultMap)