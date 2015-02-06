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
l(B,L,c)else MODULE_CHAT_COMMAND_1(B,D,c)end end;MAX_ID=499;function tbl_name(o)return'&lt;table&gt;'end
function newId(z)local B=z.free
local C,s=pairs(B)(B)
if C then B[C]=nil;return C else if z.max==MAX_ID then
error(string.format("newId: %s.max == MAX_ID",tbl_name(z)))end;z.max=z.max+1;return z.max end end
function freeId(l,v)local M=l.free;if v==l.max then local S=l.max-1;while M[S]do M[S]=nil;S=S-1 end;l.max=S else
M[v]=true end end;_errors={'<TI><p align="center">Errors</p>'}ERROR_TA=3
MAX_ERRORS=7;function alert(n,v)
ui.addPopup(0,0,string.format('<font face="mono" size="15">%s</font>',n),v,200,150,400,true)end
function addError(I)
I=string.format("• %s\n",I)for i=3,#_errors+1 do _errors[i]=_errors[i-1]end
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
function getText(Z)local H=Z.lives-1;local D=Z.bombs
if H>=maxLives then H=maxLives-1 end;if H<0 then H=0 end;if D>maxBombs then D=maxBombs elseif D<0 then D=0 end;if Z.lives<1 then
l=0 else l=Z.lives end;return
string.format('<TI><N>Player  <R>%s<N>\nBomb  <VP>%s',string.rep('★',H),string.rep('★',D))end;function updateTextAreas(t,D)ui.updateTextArea(1,getText(D),t)
ui.updateTextArea(104,'<TI><a href="event:help">?</a>',t)end
function clear()for O,j in
ipairs(keys(jointData))do removeJoint(j)end;for U,d in
ipairs(keys(tfm.get.room.objectList))do removeObject(d)end;for O,h in
ipairs(keys(groundData))do removeGround(h)end;for R,n in
ipairs(keys(bulletData))do removeBullet(n)end;for E,w in
ipairs(keys(patternData))do removePattern(w)end end
function list_default(P,D,d)P[#P+1]=string.format('%d %d\n',D,d.time)end
function list_object(j,o,m)local i=tfm.get.room.objectList[o]if i==nil then
j[#j+1]=string.format('%d &lt;invalid&gt; %d\n',o,m.time)else
j[#j+1]=string.format('%d (%d, %d) %d\n',o,i.x,i.y,m.time)end end;function list_bullet(g,T,I)
g[#g+1]=string.format("%d %d %d\n",T,I.controls[#I.controls],I.time)end
function step(w,T,R,A,N)local s={}local t;local g,E;if N==nil then
N=list_default end
for O,_ in pairs(T)do N(A,O,_)
if _.time<=0 then
if _.on_remove then
for c,U in ipairs(_.on_remove)do
g,E=pcall(U,O,_)if not g then
addError(string.format("step(%s): on_remove[%d]: %s\n",tbl_name(T),c,E))end end end;s[#s+1]=O else _.time=_.time-w
if _.callback then
for x,Q in ipairs(_.callback)do g,E=pcall(Q,O,_)if
not g then
addError(string.format("step(%s): callback[%d]: %s\n",tbl_name(T),x,E))s[#s+1]=O;break end end end end end;for y,P in ipairs(s)do R(P)end end
function clearT(O)local X={'<TI>'}X[#X+1]='<p align="center">Joints</p>'
step(O,jointData,removeJoint,X)X[#X+1]='<p align="center">Objects</p>'
step(O,objectData,removeObject,X,list_object)X[#X+1]='<p align="center">Grounds</p>'
step(O,groundData,removeGround,X)X[#X+1]='<p align="center">Bullets</p>'
step(O,bulletData,removeBullet,X,list_bullet)X[#X+1]='<p align="center">Patterns</p>'
step(O,patternData,removePattern,X)
ui.addTextArea(2,table.concat(X),nil,-155,5,150,590,nil,nil,0.5,true)end
function shoot_bullet(v,s)local Z=s.callback_args;if Z._cd==nil then Z._cd=0 end
if Z._cd>0 then
Z._cd=Z._cd-1 else Z._cd=Z.cd
local v=addBullet(Z.btype,Z.bdata,Z.bttl,Z.callback,Z.on_remove,Z.cbargs)
if Z.mtype~=nil then addMotion(Z.mtype,v,true,Z.mdata)end end end;function explode(r,t)local B=t.callback_args
addExplosion(B.x,B.y,B.power,B.distance,B.miceOnly,B.p1,B.p2)end
function explode1(l,Y)
local e=Y.callback_args
if e.t<=0 then
local g=randomKey1(tfm.get.room.playerList,Y.user,true)local J,_=0,0;if g~=nil then local t=tfm.get.room.playerList[g]
J,_=t.x,t.y end
addExplosion(J,_,e.power,e.distance,e.miceOnly,e.p1,e.p2)e.t=e.cd else e.t=e.t-1 end end;function accelerate(x,h)local i=h.callback_args
moveObject(x,0,0,true,i.ax,i.ay,true)end
function moveHoming(W,h)
if
h.time<=7 and h.time>=5 then local b=h.callback_args
local x=tfm.get.room.playerList[b.target]
if x~=nil then local a=x.x;local m=x.y;local c=b.x;local _=b.y;a=a-c;m=m-_;local p=a*a+m*m;if p>0 then p=b.v/
math.sqrt(p)a=a*p;m=m*p end
moveObject(W,0,0,true,a,m,false)end end end
function moveHoming1(q,O)local s=O.callback_args
if s.delay>0 then s.delay=s.delay-1 else local c,T;local o=nil;if s.target then
o=tfm.get.room.playerList[s.target]end
if o then c,T=o.x-s.x,o.y-s.y elseif s.target_x then c,T=s.target_x-s.x,
s.target_y-s.y else return end
local F=math.min(math.sqrt(c*c+T*T),s.max_step)
if F>s.min_step then local i,D=to_axis(-math.atan2(T,c))s.jdata.limit2=
F/30.0;s.jdata.axis=i
s.x=s.x+F*math.cos(-D)s.y=s.y+F*math.sin(-D)
do_addJoint(s.jid,s.gid,0,s.jdata)s.delay=s.delay1 end end end
function addObject(k,J,K,D,R,i,S,o,w,m,G)local e=do_addObject(k,J,K,D,R,i,S)if o==nil then o=3 end
objectData[e]={time=o,callback=to_table(w),on_remove=to_table(m),callback_args=G}return e end
function removeObject(j)do_removeObject(j)objectData[j]=nil end
function addGround(U,N,y,n,B,K,a)local Q=newId(groundId)do_addGround(Q,U,N,y)
if n==nil then n=3 end
groundData[Q]={time=n,callback=to_table(B),on_remove=to_table(K),callback_args=a}return Q end;function removeGround(L)do_removeGround(L)groundData[L]=nil
freeId(groundId,L)end
function addJoint(y,a,D,p,M,J,k)local P=newId(jointId)
do_addJoint(P,y,a,D)if p==nil then p=-1 end;if D==nil then D={}end
jointData[P]={time=p,callback=to_table(M),on_remove=to_table(J),callback_args=k}return P end
function removeJoint(u)do_removeJoint(u)jointData[u]=nil;freeId(jointId,u)end
function addPattern(E,C,l,p)local i=nil;if l.time~=nil then i=newId(patternId)
patternData[i]={time=l.time,callback=l.callback,on_remove=l.on_remove}end
l.func(E,C,i,p)return i end
function removePattern(L)patternData[L]=nil;freeId(patternId,L)end
function addExplosion(P,u,i,j,K,h,A)if h~=nil then addParticle(h,P,u,0,0,0,0)end
if A~=nil then end;do_addExplosion(P,u,i,j,K)end
function addGround1(v,l,o,F)local e=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=e;do_addGround(e,l,o,F)v[#v+1]=e end
function addJoint1(T,F,x,l)local Y=newId(jointId)
_tmp_joints[#_tmp_joints+1]=Y;do_addJoint(Y,F,x,l)T[#T+1]=Y end
function addBullet(Z,t,y,p,H,f)local K=newId(bulletId)_tmp_grounds={}_tmp_joints={}
local A,_,Q,s=pcall(Z,t)
if A then
bulletData[K]={controls={_},grounds=Q,joints=s,time=y or 6,callback=to_table(p),on_remove=to_table(H),callback_args=f}else for P,B in ipairs(_tmp_joints)do removeJoint(B)end;for n,g in
ipairs(_tmp_grounds)do removeGround(g)end;freeId(bulletId,K)
error(string.format('addBullet: %s',_))end;return K end
function removeBullet(k)local U=bulletData[k]for l,X in ipairs(U.joints)do do_removeJoint(X)
freeId(jointId,X)end;for f,b in ipairs(U.grounds)do
do_removeGround(b)freeId(groundId,b)end
bulletData[k]=nil;freeId(bulletId,k)end;bullet={}
bullet.rectangle=function(v)local z,A,d=v.x,v.y,v.angle;local r,H=v.width,v.height
local c,x=v.jdata,v.hitbox_data;local q,t=math.cos(d),math.sin(d)local O=r/2.0
local G={type=0,point1=string.format("%d,%d",z,A),point2=string.format("%d,%d",
z+q*r,A+t*r),color=0xFF0000,line=2.0*H+4,foreground=false}
local N={type=12,width=r,height=H,angle=math.deg(d),miceCollision=true,groundCollision=false,foreground=true,dynamic=true,restitution=255}copy(N,x)local a=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=a;do_addGround(a,z+q*O,A+t*O,N)local P={}if c then for l,j in ipairs(c)do copy(G,j)
addJoint1(P,a,a,G)end end;return a,{a},P end
bullet.circle=function(I)local q,a,j=I.x,I.y,I.R;local P,S=I.jdata,I.hitbox_data
local U=string.format('%d,%d',q,a+1)local Z={type=0,point2=U,color=0x0000FF,line=2*j,foreground=false}
local K={type=13,width=j,height=j,miceCollision=true,groundCollision=false,dynamic=true,restitution=255}copy(K,S)local b=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=b;do_addGround(b,q,a,K)local v={}if P then for u,s in ipairs(P)do copy(Z,s)
addJoint1(v,b,b,Z)end end;return b,{b},v end
bullet.butterfly=function(q)local K,X,o,u=q.x,q.y,q.angle,q.R;local F,O=q.center_jdata,q.wing_jdata
local R=q.hitbox_data;local Y=make_star(5,2)
local Z={type=0,color=0xFF00FF,alpha=0.25,line=Y.l*u*2,foreground=false}
local H={type=0,point1=string.format('%d,%d',K,X),point2=string.format('%d,%d',K,X+1),color=0x0000FF,line=u*2,foreground=false}
local T={type=13,width=u,height=u,dynamic=true,miceCollision=true,groundCollision=false,restitution=255}copy(Z,O)copy(T,R)local V={}local b={}local t,G
local g,M=math.cos(o),math.sin(o)local x;local i=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=i;do_addGround(i,K,X,T)
for i=2,5 do x=Y.points[i]t,G=x[1]*g-x[2]*M,x[1]*M+
x[2]*g;t,G=K+u*t,X+u*G
Z.point1=string.format('%d,%d',t,G)Z.point2=string.format('%d,%d',t,G+1)
addJoint1(V,i,i,Z)end;copy(H,F)addJoint1(V,i,i,H)return i,{i},V end
bullet.jstar=function(w)local S,r,V,X=w.x,w.y,w.angle,w.R;local D,K=w.points,w.step
local j,i=w.line_jdata,w.center_jdata;local _=w.hitbox_data;local I=make_star(D,K)
local C={type=0,color=0xFFFFFF,line=5,foreground=true}local Q=X*I.r
local f={type=0,point1=string.format('%d,%d',S,r),point2=string.format('%d,%d',S,r+1),color=0xFFFFFF,line=Q*2,foreground=true}
local H={type=13,width=Q,height=Q,dynamic=true,miceCollision=true,groundCollision=false,restitution=255}copy(C,j)copy(H,_)local U={}local z={}local E,B
local k,M=math.cos(V),math.sin(V)
for Y,o in ipairs(I.points)do E,B=o[1]*k-o[2]*M,o[1]*M+o[2]*k;z[#z+1]=string.format('%d,%d',
S+X*E,r+X*B)end;local T=newId(groundId)
_tmp_grounds[#_tmp_grounds+1]=T;do_addGround(T,S,r,H)for i=1,D do C.point1=z[i]
C.point2=z[1+ (i+K-1)%D]addJoint1(U,T,T,C)end
if i then for d,N in ipairs(i)do
copy(f,N)addJoint1(U,T,T,f)end end;return T,{T},U end
bullet.star=function(f)local l,B,U,y=f.x,f.y,f.angle,f.R;local t,e,Z=f.points,f.step,f.do_cap
local J,M=f.line_data,f.center_data;local P=f.cap_data;local u=make_star(t,e)
local w={type=12,height=1,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}local D=y*u.r
local R={type=13,width=D,height=D,color=0xFFFFFF,groundCollision=false,miceCollision=true,dynamic=true,foreground=true,restitution=255}
local Y={type=13,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}D=string.format('%d,%d',l,B)
local v={type=3,point1=D,point2=D,ratio=1,limit1=0,limit2=0}local O={type=0,frequency=10}copy(w,J)copy(R,M)copy(Y,P)
local S,H,L={},{},{}local x,o;local f=math.deg(U)local W,F=math.cos(U),math.sin(U)
for a,A in
ipairs(u.lines)do w.angle=A.angle+f;w.width=A.width*y
x,o=A.x*W-A.y*F,A.x*F+A.y*W;addGround1(S,l+y*x,B+y*o,w)end;if Z then
for p,j in ipairs(u.points)do x,o=j[1]*W-j[2]*F,j[1]*F+j[2]*W;addGround1(H,
l+y*x,B+y*o,Y)end end
local i=newId(groundId)_tmp_grounds[#_tmp_grounds+1]=i
do_addGround(i,l,B,R)
if w.dynamic then local A,C=nil,nil;for X,r in ipairs(S)do addJoint1(L,r,i,v)if A~=nil then
addJoint1(L,r,A,O)else C=r end;A=r end
addJoint1(L,C,A,O)elseif R.dynamic then for Q,X in ipairs(S)do addJoint1(L,X,i,v)end end
if Z then
if Y.dynamic then local X,h=nil,nil
for i=1,t do addJoint1(L,H[i],S[i],v)if X~=nil then
addJoint1(L,H[i],X,O)else h=H[i]end;X=H[i]end;addJoint1(L,h,X,O)elseif w.dynamic then
for i=1,t do addJoint1(L,H[i],S[i],v)end end end;append(S,H)S[#S+1]=i;return i,S,L end
function bomb(F,o)
if o.bomb_cd==0 and not o.bombing then
if o.bombs>=o.bomb.cost then o.bombs=o.bombs-
o.bomb.cost;o.bombing=true;o.bombTime=o.bomb.time
local r,v=pcall(o.bomb.func,F,o)addBomb(F,o)updateTextAreas(F,o)if not r then
addError(string.format("bomb: %s: %s",F,v))end else
alert(string.format('bombs &lt; %d',o.bomb.cost),F)end end end
function addBomb(l,d)local J=bombs.top+1
local o=string.format('<TI><font color="#%X">%s <font color="#5F5F8D">|</font> %s</font>',d.color,l,d.bomb.name)d.bomb_id=J;bombs.top=J;bombs.val[J]=o;setShamanName(o)end
function removeBomb(Q,e)local a=e.bomb_id;e.bomb_id=nil;bombs.val[a]=nil
if a==bombs.top then a=a-1;while
bombs.val[a]==nil and a>0 do a=a-1 end;bombs.top=a;if a>0 then
a=bombs.val[a]else a=''end;setShamanName(a)end end;function do_addControl(u,o)u[#u+1]=o end;function do_removeControl(w,C)
while w[C]do w[C]=nil;C=C+1 end end;function motionEnd(Z,j)
do_removeControl(j.callback_args._controls,j.callback_args._idx)end
function addControl(d,...)local p=#d+1
local O=addGround(...)local W=groundData[O]
if W.callback_args==nil then
W.callback_args={_controls=d,_idx=p}else W.callback_args._controls=d;W.callback_args._idx=p end;if W.on_remove==nil then W.on_remove={motionEnd}else
W.on_remove[#W.on_remove+1]=motionEnd end;d[#d+1]=O;return O end;function addControl1(R,...)return addGround(...)end
function addMotion(l,P,u,k)local t;local Q;if u then
t=bulletData[P].controls;Q=addControl else t={P}Q=addControl1 end
local J,F=pcall(l,Q,t,k)if not J then
error(string.format("addMotion: %s",F))end end;motion={}
motion.fix=function(o,z,P)local L=0;local p=z[#z]local x={type=0,frequency=10}
copy(x,P.jdata)if not P.last then
L=o(z,P.x or 0,P.y or 0,CONTROL,P.ttl or 3)end;addJoint(p,L,x,P.ttl or 3)end
motion.follow=function(o,J,x)x.x=x.x or 0;x.y=x.y or 0;x.ttl=x.ttl or 3
x.delay=x.delay or 0;x.delay1=x.delay1 or 0;x.max_step=x.max_step or 3000;x.min_step=x.min_step or
30;if x.target==nil then
x.target=randomKey1(tfm.get.room.playerList,x.no_target,true)end;local P=J[#J]
local O=o(J,x.x,x.y,CONTROL,x.ttl,moveHoming1,nil,x)
local q={type=0,frequency=x.frequency or(1.0/ (1.0+x.delay1))}local s={type=1,forceMotor=255,speedMotor=127}copy(s,x.jdata)
addJoint(P,O,q,x.ttl)x.jdata=s;x.gid=O;x.jid=addJoint(O,0,q,x.ttl)end
motion.line=function(p,c,A)local X=A.x or 0;local k=A.y or 0;local x=A.ttl or 3;local r=0;local h
local b={type=1,axis='-1,0',angle=0,forceMotor=255,speedMotor=1}copy(b,A.jdata)if A.free_angle then
motion.fix(p,c,{ttl=x,x=X,y=k})end;h=c[#c]
if not A.last then r=p(c,X,k,CONTROL,x)end;addJoint(h,r,b,x)end
motion.circle=function(D,b,r)local q=0;local d=b[#b]local s={type=3,forceMotor=255,speedMotor=1}
copy(s,r.jdata)if not r.last then
q=D(b,r.x or 0,r.y or 0,CONTROL,r.ttl or 3)end;if r.x and r.y then
s.point1=string.format('%d,%d',r.x,r.y)end;addJoint(d,q,s,r.ttl or 3)end
motion.spiral=function(y,o,_)local b=_.last;_.last=false;_.jdata=_.tjoint
motion.line(y,o,_)_.last=b;_.jdata=rjoint;motion.circle(y,o,_)end
function addBombTimer(K,x,y,i,g)local f=y.bombTime*g+2
local d={type=13,angle=0,color=0xFF0000,foreground=false,friction=0.0,restitution=2.0,width=f,height=f,miceCollision=false,groundCollision=i,dynamic=false}
addGround(x.x,x.y,d,y.bombTime,moveBombTimer,nil,{player=K,pdata=y,offset=2,scale=g,obj=d})f=f-2
d={type=13,angle=0,color=0x6A7495,foreground=false,friction=0.0,restitution=2.0,width=f,height=f,miceCollision=false,groundCollision=i,dynamic=false}
addGround(x.x,x.y,d,y.bombTime,moveBombTimer,nil,{player=K,pdata=y,offset=0,scale=g,obj=d})end
function moveBombTimer(F,u)local N=u.callback_args
local O=tfm.get.room.playerList[N.player]local d=N.pdata.bombTime*N.scale+N.offset
N.obj.width=d;N.obj.height=d;do_addGround(F,O.x,O.y,N.obj)end
function defaultBombCallback(z,x)local p=tfm.get.room.playerList[z]
local C=p.y+p.vy;local u;local o,e;local I=x.bombCallbackArgs;local t=4;local W=4;local k=0;local w={ax=64,ay=0}W=I*W
w.ax=I*w.ax;u=p.x+I*x.bombTime*5+10
for off=20,120,20 do e=off*I
o=u+e*1.5
addObject(objcode.anvil,o,C-e,0,W,-k*I,false,t,accelerate,nil,w)
addObject(objcode.anvil,o,C+e,0,W,k*I,false,t,accelerate,nil,w)k=k+1 end end
function defaultBomb(a,w)local Y=tfm.get.room.playerList[a]
if
not Y.isFacingRight then w.bombCallbackArgs=-1 else w.bombCallbackArgs=1 end;addBombTimer(a,Y,w,true,5)end
function bomb2(M,w)local E=tfm.get.room.playerList[M]local s,X=E.x,E.y
local i=string.format('%d,%d',s,X)
local B={type=12,color=0xFFFFFF,foreground=true,width=512,height=8,dynamic=true,mass=8,restitution=255,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=true}
local I={type=13,color=0xFFFFFF,width=32,height=32,dynamic=false,groundCollision=false,miceCollision=false,foreground=true}local C={type=3,point1=i,point2=nil,forceMotor=255,speedMotor=2}
local F={type=3,point1=i,point2=i,ratio=1,limit1=0,limit2=8}local Q={type=0,frequency=10}local j;local t;local _,R;local S,v
local h=32.0+B.width/2.0;local N=20;local z=nil;local n=nil;local c,g;addBombTimer(M,E,w,true,5)
g=addGround(s,X,I,N)
for j=0,359,120 do t=math.rad(j)_,R=math.cos(t),math.sin(t)
S,v=s+h*_,X+h*R;B.angle=j;c=addGround(S,v,B,N)addJoint(c,g,C,N)if n~=nil then
addJoint(c,n,F,N)addJoint(c,n,Q,N)else z=c end;n=c end;addJoint(z,c,F,N)addJoint(z,c,Q,N)end
function bomb3(K,e)local S=tfm.get.room.playerList[K]local M,n=S.x,S.y
local N=string.format('%d,%d',M,n)
local m={type=13,color=0xFFFFFF,width=64,height=64,dynamic=true,mass=1,linearDamping=0,angularDamping=0,groundCollision=false,miceCollision=false,foreground=true}
local P={type=1,axis='-1,0',forceMotor=255,speedMotor=2,limit1=0,limit2=5}local f;local g;local c,F;local C,r;local u=64.0+m.width;local A=5;local Z;local o
addBombTimer(K,S,e,true,10)
local v={[0]=0.15,[60]=0.13,[120]=0.11,[180]=0.075,[240]=0.05,[300]=0}
for f=0,359,60 do g=math.rad(f)C,r=math.cos(g),math.sin(g)
c,F=M+u*C,n+u*r
o={x=M+math.cos(g+v[f])*280,y=n+
math.sin(g+v[f])*280,power=127,distance=3*m.width,miceOnly=false,p1=particles.red_spirit,p2=nil}Z=addGround(c,F,m,A,nil,explode,o)
P.angle=2.0*math.pi-g;addJoint(Z,0,P,A)end end
function pattern(S,u,z,Y,Z)local A=u.patterns[z][Y]
if A~=nil then local o=#A.points+1
if o>=
A.type.points then local y=os.time()
if y-A.lastTime>=A.type.cd then A.lastTime=y
A.points[o]=Z;local p,R=pcall(addPattern,S,u,A.type,A.points)A.points={}if not p then
addError(string.format("pattern: %s: %s",S,R))end end else A.points[o]=Z end end end
function bind(r,D,W,L)local Q=playerData[r]local v=Q.patterns[D]if v[W]~=nil then
do_unbind(Q,v[W],D,W)end
v[W]={id=L,type=patternTypes[L],points={},lastTime=0}v=Q.pattern_data[L]
if D=='key'then bindKey(r,W,true,true)end
if v==nil then Q.pattern_data[L]={binds=1}else v.binds=v.binds+1 end end
function do_unbind(y,g,c,b)local P=y.pattern_data[g.id]if P.binds<=1 then
y.pattern_data[g.id]=nil else P.binds=P.binds-1 end;y.patterns[c][b]=
nil end
function unbind(B,M,d)local i=playerData[B]
if M==nil then i.patterns={key={},obj={},objend={}}
i.pattern_data={}elseif d==nil then local m={}
for O,H in pairs(i.patterns[M])do m[#m+1]={O,H}end;for x,Z in ipairs(m)do do_unbind(i,Z[2],M,Z[1])end else
local c=i.patterns[M][d]if c~=nil then do_unbind(i,c,M,d)end end end
function testPattern(h,M,G,n)local U=n[1]local z=6;local i=48;local j=math.random(2,8)local b,P,O
local A=math.rad(U.angle)for i=0,z-1 do b=A+2.0*math.pi*i/z
P,O=math.cos(b),math.sin(b)
addObject(U.type,U.x+i*P,U.y+i*O,U.angle+360*i/z,j*P,j*O,false,9)end end
function testPattern1(i,P,U,D)local Q=D[1]local O=math.random(8,16)local N,o,v;local Y;local U
local u={angle=0.25-math.pi/2.0,R=16,center_jdata={},wing_jdata={line=24,alpha=0.5},hitbox_data={width=0,height=0,color=0xFFFFFF,mass=1}}local R={ttl=2,last=true,jdata={}}
for i=1,O do Y=math.random(64,96)N=
math.random()*2.0*math.pi
o,v=math.cos(N),math.sin(N)u.x=Q.x+Y*o;u.y=Q.y+Y*v
u.center_jdata.color=randomColor()u.wing_jdata.color=randomColor()
R.jdata.speedMotor=math.random(2,6)R.jdata.angle=2*math.pi-N
U=addBullet(bullet.butterfly,u,8)addMotion(motion.line,U,true,R)end end
function testPattern2(X,q,B,H)local D=H[1]
local v={x=D.x,y=D.y,R=16,jdata={{color=randomColor(),line=32}},hitbox_data={width=0,height=0,color=0xFFFFFF,mass=1}}local t={ttl=8,last=true,x=D.x,y=D.y,delay=2,delay1=1,max_step=1000}
local B=addBullet(bullet.circle,v,8)addMotion(motion.follow,B,true,t)end
function testPattern3(A,W,V,s)local h=s[1]local L=randomColor()
local _,w=to_axis(math.rad(-h.angle))
local p={x=h.x,y=h.y,angle=w,R=36,points=math.random(5,8),step=2,line_jdata={color=L},center_jdata={{foreground=false,color=L,line=76},{color=0x6A7495,line=70}},hitbox_data={dynamic=true,miceCollision=false}}
local k={cd=0,btype=bullet.rectangle,bttl=10,bdata={x=h.x,y=h.y,angle=-w,width=128,height=13,jdata={{color=randomColor(),foreground=false},{color=0xFFFFFF,line=16,foreground=true}},hitbox_data={dynamic=true,fixedRotation=true,mass=1}},mtype=motion.line,mdata={x=h.x,y=h.y,ttl=1,last=true,free_angle=true,jdata={speedMotor=8,axis=_}}}local V=addBullet(bullet.jstar,p,32,shoot_bullet,nil,k)
addMotion(motion.circle,V,true,{last=true,ttl=2,jdata={speedMotor=4}})end
function shoot(K,c)
if c.shot_cd==0 then
if c.bombing and c.bomb.shot~=nil then
c.shot_cd=c.bomb.shot.cd;local o,L=pcall(c.bomb.shot.func,K,c)if not o then
addError(string.format("shoot(bombing): %s: %s",K,L))end else c.shot_cd=c.shot.cd
local E,g=pcall(c.shot.func,K,c)if not E then
addError(string.format("shoot: %s: %s",K,g))end end end end
function defaultShot(d,k)local l=tfm.get.room.playerList[d]local c,J=l.x,l.y;local h;if
l.isFacingRight then h=-1 else h=1 end;local H=math.random()*math.pi
local A={x=c+64*
math.cos(H),y=J+64*math.sin(H),angle=0,R=16,points=5,step=2,line_jdata={color=randomColor()},center_jdata={{}}}
local y={last=true,ttl=math.random(1,4),x=c,y=J,jdata={speedMotor=4*h}}local E=addBullet(bullet.jstar,A,8)H=
math.random()*math.pi+math.pi
A.x=c+64*math.cos(H)A.y=J+64*math.sin(H)
A.line_jdata.color=randomColor()local Y=addBullet(bullet.jstar,A,8)
addMotion(motion.circle,E,true,y)y.ttl=math.random(1,4)y.jdata.speedMotor=-4*h
addMotion(motion.circle,Y,true,y)end
function homingShot(O,D)
local I=randomKey1(tfm.get.room.playerList,O,false)local R=tfm.get.room.playerList[O]local c=R.x;local n=R.y;local E=2
local b=2;local N=false;if not R.isFacingRight then E=-E end;c=c+16*E
local F={target=I,x=c,y=n+32,v=128}
addObject(objcode.anvil,c+E,n+b,0,E,b,N,10,moveHoming,nil,F)local F={target=I,x=c,y=n-32,v=128}
addObject(objcode.anvil,c+E,n-b,0,E,-b,N,10,moveHoming,nil,F)end
function initPlayer(y)
local O={color=randomColor(),shooting=false,bombing=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},spawn={200,200},vx=0,lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=nil}if playerConfig[y]==nil then playerConfig[y]={}end
copy(O,playerConfig[y])playerData[y]=O;for t,M in pairs(playerKeys)do bindKey(y,M,true,true)
bindKey(y,M,false,true)end
ui.addTextArea(1,getText(O),y,5,25,151,40,nil,nil,0.5,true)
ui.addTextArea(104,'<TI><a href="event:help">?</a>',y,145,25,11,20,nil,nil,0.0,true)
ui.addTextArea(ERROR_TA,table.concat(_errors),y,805,5,200,590,nil,nil,0.5,true)do_respawn(y)setShaman(y)
setNameColor(y,playerData[y].color)end
function resetPlayer(s)
local b={shooting=false,bombing=false,bombTime=nil,lives=5,bombs=3,shot_cd=0,bomb_cd=0,vx=0,bomb_id=nil}local w=playerData[s]copy(w,b)updateTextAreas(s,w)
do_respawn(s)setShaman(s)setNameColor(s,w.color)end;function deletePlayer(t)local j=playerData[t]if j.bombing then removeBomb(t,j)end;playerData[t]=
nil end
function respawn(S)
do_respawn(S)setNameColor(S,playerData[S].color)end;playerData={}objectData={}groundData={}jointData={}patternData={}bulletData={}
MAX_ID=400;MAX_ERRORS=7
CONTROL={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}playerKeys={32,83,40,100,101,102,104,65,68,69,81,37,39}
reservedKeys=invert(playerKeys,true)eventCode={key=keycode,obj=objcode,objend=objcode}
defaultMap='<C><P defilante="0,0,0,1" L="1600" H="800" G="0,0" /><Z><S /><D><DS Y="200" X="200" /></D><O /></Z></C>'maxLives=8;maxBombs=6
shotTypes={{name='default shot',func=defaultShot,cd=1},{name='homing anvils',func=homingShot,cd=2}}
bombTypes={{name='default bomb',func=defaultBomb,callback=defaultBombCallback,shot={func=nop,cd=1},cost=1,time=20,cd=0},{name='',func=bomb2,callback=
nil,shot={func=nop,cd=1},cost=1,time=20,cd=5},{name='',func=bomb3,callback=nil,shot={func=nop,cd=1},cost=1,time=6,cd=5}}
patternTypes={{func=testPattern,callback=nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern1,callback=
nil,cd=500,points=1,maxBinds=3,restrict={key=nil,obj=nil,objend=nil}},{func=testPattern2,callback=
nil,cd=250,points=1,maxBinds=3,restrict={key={},obj=nil,objend=nil}},{func=testPattern3,callback=
nil,cd=16000,points=1,maxBinds=2,restrict={key={},obj=nil,objend=nil}}}
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
local G=function(i,e)local Q={'<font face="mono" size="15">'}
for b,L in ipairs(i)do
if L.name then
Q[#Q+1]=string.format('%d - %s\n',b,L.name)else Q[#Q+1]=string.format('%d\n',b)end
if L.cost then Q[#Q+1]=string.format('    Cost: %d\n',L.cost)end;if L.time then
Q[#Q+1]=string.format('    Duration: %fs\n',L.time/2.0)end;if L.cd then
Q[#Q+1]=string.format('    Cooldown: %fs\n',L.cd/e)end;if L.maxBinds then
Q[#Q+1]=string.format('    Max. binds: %d\n',L.maxBinds)end;Q[#Q+1]='\n'end;return table.concat(Q)end;MODULE_HELP['Shot types']=G(shotTypes,2.0)
MODULE_HELP['Bomb types']=G(bombTypes,2.0)MODULE_HELP['Pattern types']=G(patternTypes,1000.0)end
do
local A=function(C,J)local l={'<font face="mono" size="15">'}local o;for B,G in ipairs(keys1(C))do
o=J-#G;if o>0 then B=G..string.rep(' ',o)else B=G end
l[#l+1]=string.format('%s = %4d\n',B,C[G])end
l[#l+1]='</font>'return table.concat(l)end;MODULE_HELP['Shaman objects']=A(objcode,15)end
MODULE_CHAT_COMMAND={['help']=help,['clear']=clear,['color']=function(k,K,S)S=string.upper(S)
if S==''or S=='RANDOM'or S==
'RND'then setColor(k,randomColor())playerConfig[k].color=
nil else local g=tonumber(S)if g~=nil then if g>0xFFFFFF then g=0xFFFFFF end
setColor(k,S)playerConfig[k].color=S else
alert('Invalid color: '..S,k)end end end,['reset']=function(F,l,Q)
Q=string.lower(Q)if Q==''or Q=='map'then setMap(defaultMap)else
parsePlayerNames(F,Q,resetPlayer)end end,['init']=function(a,z,y)local K=function(a)
deletePlayer(a)initPlayer(a)end
parsePlayerNames(a,y,K)end,['respawn']=function(p,w,a)
parsePlayerNames(p,a,respawn)end,['shot']=function(F,R,w)local c=tonumber(w)if c==nil then
alert('Invalid shot type: '..w,F)return end;c=shotTypes[c]
if c~=nil then
playerData[F].shot=c else alert('Invalid shot type: '..w,F)end end,['bomb']=function(u,e,s)
local h=tonumber(s)
if h==nil then alert('Invalid bomb type: '..s,u)return end;h=bombTypes[h]if h~=nil then playerData[u].bomb=h else
alert('Invalid bomb type: '..s,u)end end,['bind']=function(L,Z,E)
E=split(E)if#E<3 then alert('Too few arguments',L)return elseif#E>3 then
alert('Too many arguments',L)return end
i=tonumber(E[1])local W=patternTypes[i]if i==nil or W==nil then
alert('Invalid pattern: '..E[1],L)return end;j=E[2]
if j~='key'and j~='obj'and
j~='objend'then alert('Invalid event: '..j,L)return end;local Q=tonumber(E[3])
if Q==nil then Q=eventCode[j][E[3]]if Q==nil then
alert(string.format('Invalid %s name/code: %s',j,E[3]),L)return end end;if
W.restrict[j]~=nil and W.restrict[j][Q]==nil then
alert(string.format('Can\'t bind pattern %d to %s %d: restricted',i,j,Q),L)return end;if
j=='key'and reservedKeys[Q]then
alert(string.format('Can\'t bind pattern %d to %s %d: reserved',i,j,Q),L)return end
local M=playerData[L]local H=M.pattern_data[i]if H~=nil and W.maxBinds<=H.binds then
alert(string.format('Can\'t bind pattern %d to more than %d events',i,W.maxBinds),L)return end
bind(L,j,Q,i)end,['unbind']=function(k,s,q)
q=split(q)if#q>2 then alert('Too many arguments',k)return end
i=q[1]
if i=='all'or i==nil then unbind(k)elseif
i~='key'and i~='obj'and i~='objend'then alert('Invalid event: '..i,k)return else
if q[2]==nil then
unbind(k,i)else j=tonumber(q[2])
if j==nil then j=eventCode[i][q[2]]if j==nil then
alert(string.format('Invalid %s name/code: %s',i,q[2]),k)return end end;unbind(k,i,j)end end end,['map']=function(N,T,A)if
A==''then A=defaultMap end;setMap(A)end}
MODULE_CHAT_COMMAND_1=function(M,v,E)alert('Invalid command: '..v,M)end;eventNewPlayer=initPlayer;eventPlayerLeft=deletePlayer
eventTextAreaCallback=helpTextAreaCallback
function eventNewGame()initTimers()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)tfm.exec.setGameTime(0)objectData={}groundData={}
jointData={}patternData={}bulletData={}bombs={top=0,val={}}groundId={max=0,free={}}
jointId={max=0,free={}}patternId={max=0,free={}}bulletId={max=0,free={}}for T,D in
pairs(tfm.get.room.playerList)do resetPlayer(T)end
setMapName('<TI>')setShamanName('')
do_addGround(0,0,0,{type=13,width=10,height=10,color=0xFFFFFF,dynamic=false,miceCollision=false,groundCollision=false})end
function eventKeyboard(k,u,T,n,z)
if reservedKeys[u]then
if u==65 then local O=playerData[k]if T then bomb(k,O)end elseif u==69 then
local M=playerData[k]M.shooting=T;if T then shoot(k,M)end else local g=0;local f=0
if not T then
if

u==32 or u==104 or u==83 or u==40 or u==53 or u==101 then movePlayer(k,0,0,true,0,1,false)
movePlayer(k,0,0,true,0,-1,true)else movePlayer(k,0,0,true,1,0,false)
movePlayer(k,0,0,true,-1,0,true)playerData[k].vx=0 end else
if u==32 or u==104 or u==87 then g=-50 elseif u==83 or u==40 or u==101 then g=50 elseif u==
100 or u==37 or u==81 then f=-50 elseif u==102 or u==39 or u==68 then f=50 end;if f~=0 then playerData[k].vx=f elseif u==83 or u==40 then
f=playerData[k].vx end;if f~=0 or g~=0 then
movePlayer(k,0,0,true,f,g,false)end end end elseif T then local Q=playerData[k]pattern(k,Q,'key',u,{x=n,y=z})end end;function eventSummoningStart(t,h,v,Y,f)local n={x=v,y=Y,angle=f,type=h}
pattern(t,playerData[t],'obj',h,n)end
function eventSummoningEnd(Y,G,D,d,h,P,b,g,m)
objectData[g.id]={time=3}local a={x=D,y=d,angle=h,type=G,vx=P,vy=b,data=g,other=m}
pattern(Y,playerData[Y],'objend',G,a)end
function eventMouse(L,l,N)local B=tfm.get.room.playerList[L]end
function eventPlayerDied(o)local K=playerData[o]
if K~=nil then
if K.bombing then respawn(o)else K.shot_cd=0
K.bomb_cd=0;K.shooting=false;K.lives=K.lives-1;if K.lives>0 then K.bombs=K.resetBombs
updateTextAreas(o,K)respawn(o)else
alert(string.format('playerData["%s"].lives &lt;= 0',o),o)end end end end
function eventLoop(y,U)local T,X,I,o,x,t,S,p;clearT(1)
for e,J in pairs(playerData)do
T=tfm.get.room.playerList[e]
if not T.isDead then X=T.x;I=T.y;if X<0 then X=10 elseif X>4800 then X=4790 end;if I<0 then I=10 elseif I>1600 then
I=1590 end;J.spawn[0]=X;J.spawn[1]=I;o=-T.vx;x=-T.vy;t=-
T.vx/10;S=-T.vy/10
for p=1,math.random(8,16)do
addParticle(particles.purple,X+
math.random(-4,4),I+math.random(-4,4),
(o+math.random()*2-1)/p,(x+math.random()*2-1)/p,t,S)end end;if J.shot_cd>0 then J.shot_cd=J.shot_cd-1 end;if J.bomb_cd>0 then J.bomb_cd=
J.bomb_cd-1 end
if J.shooting then shoot(e,J)end
if J.bombing then J.bombTime=J.bombTime-1
if J.bombTime<=0 then J.bombing=false
J.bomb_cd=J.bomb.cd;removeBomb(e,J)else if J.bomb.callback then
local b,g=pcall(J.bomb.callback,e,J)
if not b then addError('bomb.callback: '..g)end end end end end end
for U,E in pairs(tfm.get.room.playerList)do initPlayer(U)end;setMap(defaultMap)