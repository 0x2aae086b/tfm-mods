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
function step(_,A,c,U,E)local x={}local R;local Q,v;if E==nil then E=list_default end
for y,P in pairs(A)do E(U,y,P)
if
P.time<=0 then
if P.on_remove then
for O,X in ipairs(P.on_remove)do Q,v=pcall(X,y,P)if not Q then
addError(string.format("step(%s): on_remove[%d]: %s\n",tbl_name(A),O,v))end end end;x[#x+1]=y else P.time=P.time-_
if P.callback then
for s,Z in ipairs(P.callback)do Q,v=pcall(Z,y,P)if
not Q then
addError(string.format("step(%s): callback[%d]: %s\n",tbl_name(A),s,v))x[#x+1]=y;break end end end end end;for r,t in ipairs(x)do c(t)end end
function emptyMap(B,l,Y,e)local g,J=B/2.0,l/2.0;local _,x
local h={string.format('<C><P G="0,0" L="%d" H="%d" /><Z><S>',B,l)}Y=Y or 256;e=e or Y
for _=16,B,Y do
for x=16,l,e do
h[#h+1]=string.format('<S o="%02x00%02x" L="16" Y="%d" c="4" P="0,0,0,0,0,0,0,0" T="13" X="%d" H="10" />',math.abs(
g-_)/g*255,math.abs(J-x)/J*255,x,_)end end;h[#h+1]='</S><D><DS X="200" Y="200" /></D><O /></Z></C>'return
table.concat(h)end
function setColor(i,W)setNameColor(i,W)playerData[i].color=W end
function tbl_name(h)
if h==groundId then return'groundId'elseif h==jointId then return'jointId'elseif h==bulletId then return'bulletId'elseif h==
patternId then return'patternId'elseif h==_timerId then return'_timerId'elseif h==objectData then return'objectData'elseif h==
groundData then return'groundData'elseif h==jointData then return'jointData'elseif h==bulletData then return'bulletData'elseif h==
patternData then return'patternData'elseif h==_timerData then return'_timerData'end;return'&lt;other&gt;'end
function make_line(a,b)local x,m=b[1]-a[1],b[2]-a[2]return
{width=math.sqrt(x*x+m*m),angle=math.deg(math.atan2(m,x)),x=(
a[1]+b[1])/2,y=(a[2]+b[2])/2}end
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
local D={type=13,width=u,height=u,dynamic=true,mass=1,miceCollision=true,groundCollision=false,restitution=255}copy(P,t)copy(D,Z)local R,Y={},{}local O={}local S,H
local L,x=math.cos(f),math.sin(f)local s,o
for s,o in ipairs(M.points)do
S,H=o[1]*L-o[2]*x,o[1]*x+o[2]*L;O[#O+1]=string.format('%d,%d',E+l*S,N+l*H)end;local W=addGround1(R,E,N,D)for J=1,B do P.point1=O[J]
P.point2=O[1+ (J+y-1)%B]addJoint1(Y,W,W,P)end
if e then for s,o in ipairs(e)do
copy(w,o)addJoint1(Y,W,W,w)end end;return W,R,Y end
bullet.star=function(F)local f,i,a,J=F.x,F.y,F.angle,F.R;local S,A,u=F.points,F.step,F.do_cap
local Y,p=F.line_data,F.center_data;local j=F.cap_data;local C=make_star(S,A)
local B={type=12,height=1,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}local D=J*C.r
local X={type=13,width=D,height=D,color=0xFFFFFF,groundCollision=false,miceCollision=true,dynamic=true,foreground=true,restitution=255}
local e={type=13,color=0xFFFFFF,groundCollision=false,miceCollision=false,dynamic=true,foreground=true,restitution=255}D=string.format('%d,%d',f,i)
local O={type=3,point1=D,point2=D,ratio=1,limit1=0,limit2=0}local r={type=0,frequency=10}copy(B,Y)copy(X,p)copy(e,j)
local Q,h,o={},{},{}local v,l;local F=math.deg(a)local d,w=math.cos(a),math.sin(a)
for W,R in
ipairs(C.lines)do B.angle=R.angle+F;B.width=R.width*J
v,l=R.x*d-R.y*w,R.x*w+R.y*d;addGround1(Q,f+J*v,i+J*l,B)end;if u then
for P,k in ipairs(C.points)do v,l=k[1]*d-k[2]*w,k[1]*w+k[2]*d;addGround1(h,
f+J*v,i+J*l,e)end end
local Z=addGround1(h,f,i,X)
if B.dynamic then local t,z=nil,nil;for P,L in ipairs(Q)do addJoint1(o,L,Z,O)if t~=nil then
addJoint1(o,L,t,r)else z=L end;t=L end
addJoint1(o,z,t,r)elseif X.dynamic then for x,P in ipairs(Q)do addJoint1(o,P,Z,O)end end
if u then
if e.dynamic then local q,s=nil,nil
for i=1,S do addJoint1(o,h[i],Q[i],O)if q~=nil then
addJoint1(o,h[i],q,r)else s=h[i]end;q=h[i]end;addJoint1(o,s,q,r)elseif B.dynamic then
for i=1,S do addJoint1(o,h[i],Q[i],O)end end end;append(Q,h)return Z,Q,o end
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
motion.i_f=function(A,M,Z)local o=addGround(100,100,CONTROL,1)
addJoint(M[#M],o,IFJOINT,1)end
motion.fix=function(v,S,u)local z=0;local Y=S[#S]local Z={type=0,frequency=10}copy(Z,u.jdata)
if not
u.last then z=v(S,u.x or 0,u.y or 0,CONTROL,u.ttl or 3)end;addJoint(Y,z,Z,u.ttl or 3)end
motion.follow=function(A,o,y)y.x=y.x or 0;y.y=y.y or 0;y.ttl=y.ttl or 3
y.delay=y.delay or 0;y.delay1=y.delay1 or 0;y.max_step=y.max_step or 3000;y.min_step=y.min_step or
30;if y.target==nil then
y.target=randomKey1(tfm.get.room.playerList,y.no_target,true)end;local p=o[#o]
local R=A(o,y.x,y.y,CONTROL,y.ttl,moveHoming1,nil,y)
local r={type=0,frequency=y.frequency or(1.0/ (1.0+y.delay1))}local D={type=1,forceMotor=255,speedMotor=127}copy(D,y.jdata)
addJoint(p,R,r,y.ttl)y.jdata=D;y.gid=R;y.jid=addJoint(R,0,r,y.ttl)end
motion.line=function(W,L,Q)local v=Q.x or 0;local g=Q.y or 0;local c=Q.ttl or 3;local b=0;local P
local B={type=1,axis='-1,0',angle=0,forceMotor=255,speedMotor=1}copy(B,Q.jdata)if Q.free_angle then
motion.fix(W,L,{ttl=c,x=v,y=g})end;P=L[#L]
if not Q.last then b=W(L,v,g,CONTROL,c)end;addJoint(P,b,B,c)end
motion.circle=function(M,d,i)local m=0;local O=d[#d]local H={type=3,forceMotor=255,speedMotor=1}
copy(H,i.jdata)if not i.last then
m=M(d,i.x or 0,i.y or 0,CONTROL,i.ttl or 3)end;if i.x and i.y then
H.point1=string.format('%d,%d',i.x,i.y)end;addJoint(O,m,H,i.ttl or 3)end
motion.spiral=function(x,Z,c)local h=c.last;c.last=false;c.jdata=c.tjoint
motion.line(x,Z,c)c.last=h;c.jdata=c.rjoint;motion.circle(x,Z,c)end
function pattern(M,G,n,U,z)local i=G.patterns[n][U]
if i~=nil then local j=#i.points+1
if j>=
i.type.points then local b=os.time()
if b-i.lastTime>=i.type.cd then i.lastTime=b
i.points[j]=z;local P,O=pcall(addPattern,M,G,i.type,i.points)i.points={}if not P then
addError(string.format("pattern: %s: %s",M,O))end end else i.points[j]=z end end end
function bind(A,i,P,U)local D=playerData[A]local n=D.patterns[i]if n[P]~=nil then
do_unbind(D,n[P],i,P)end
n[P]={id=U,type=patternTypes[U],points={},lastTime=0}n=D.pattern_data[U]
if i=='key'then bindKey(A,P,true,true)end
if n==nil then D.pattern_data[U]={binds=1}else n.binds=n.binds+1 end end
function do_unbind(Q,O,U,N)local o=Q.pattern_data[O.id]if o.binds<=1 then
Q.pattern_data[O.id]=nil else o.binds=o.binds-1 end;Q.patterns[U][N]=
nil end
function unbind(v,Y,u)local R=playerData[v]
if Y==nil then R.patterns={key={},obj={},objend={}}
R.pattern_data={}elseif u==nil then local X={}
for q,B in pairs(R.patterns[Y])do X[#X+1]={q,B}end;for H,D in ipairs(X)do do_unbind(R,D[2],Y,D[1])end else
local t=R.patterns[Y][u]if t~=nil then do_unbind(R,t,Y,u)end end end
function addPattern(A,W,V,s)local h=nil;if V.time~=nil then h=newId(patternId)
patternData[h]={time=V.time,callback=V.callback,on_remove=V.on_remove}end
V.func(A,W,h,s)return h end
function removePattern(L)patternData[L]=nil;freeId(patternId,L)end
function testPattern(_,W,w,A)local k=A[1]local K=6;local o=48;local L=math.random(2,8)local E,g,d,l
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
local C={x=w.x,y=w.y,angle=math.rad(w.angle),width=512,height=13,jdata={{color=randomColor(),foreground=true},{color=0xFFFFFF,line=16}},hitbox_data={color=0xFF0000,dynamic=true,restitution=0,mass=
-1}}local L=addBullet(bullet.rectangle,C,10)
addMotion(motion.i_f,L,true)end
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
local Q={color=randomColor(),shooting=false,bombing=false,focused=false,shot=shotTypes[1],bomb=bombTypes[1],bombTime=nil,patterns={key={},obj={},objend={}},pattern_data={},spawn={200,200},speed=50,focusedSpeed=35,curSpeed=50,vx=0,vy=0,lives=5,bombs=3,resetBombs=3,shot_cd=0,bomb_cd=0,bomb_id=
nil}if playerConfig[W]==nil then playerConfig[W]={}end
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
if v then
if T then M.vx=v;v=v*M.curSpeed;if M.vx>0 then M.dir=1 else M.dir=-1 end
movePlayer(A,0,0,false,v,0,false)else M.vx=0;movePlayer(A,0,0,false,1,0,false)
movePlayer(A,0,0,false,-1,0,true)end elseif E then
if T then M.vy=E;E=E*M.curSpeed
movePlayer(A,0,0,false,M.vx*M.curSpeed,E,false)else M.vy=0;movePlayer(A,0,0,false,0,-1,false)
movePlayer(A,0,0,false,0,1,true)end else return false end;return true end;playerData={}objectData={}groundData={}jointData={}patternData={}bulletData={}
MAX_ID=400;MAX_ERRORS=7
GROUND0={type=13,color=0xFFFFFF,dynamic=false,miceCollision=false,groundCollision=false}
CONTROL={type=13,dynamic=true,mass=1,groundCollision=false,miceCollision=false}IFJOINT={type=2,point2='0,0',point3='0,0',point4='0,0'}
RESET={shooting=false,bombing=false,lives=5,bombs=3,shot_cd=0,bomb_cd=0,vx=0}
playerKeys={kc.space,kc.w,kc.s,kc.a,kc.d,kc.left,kc.right,kc.up,kc.down,kc.e,kc.q,kc.shift}reservedKeys=invert(playerKeys,true)
pk_vx={[kc.a]=-1,[kc.left]=-1,[kc.d]=1,[kc.right]=1}
pk_vy={[kc.space]=-1,[kc.w]=-1,[kc.up]=-1,[kc.s]=1,[kc.down]=1}eventCode={key=keycode,obj=objcode,objend=objcode}mapWidth=1600
mapHeight=800;defaultMap=emptyMap(mapWidth,mapHeight)X_MIN=16
X_MAX=mapWidth-16;Y_MIN=16;Y_MAX=mapHeight-16;maxLives=8;maxBombs=6
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
if U then bomb(b,C)end elseif g==kc.e then local C=playerData[b]C.shooting=U;if U then shoot(b,C)end elseif
g==kc.shift then local C=playerData[b]C.focused=U;if U then C.curSpeed=C.focusedSpeed else
C.curSpeed=C.speed end;if C.vx~=0 or C.vy~=0 then
movePlayer(b,0,0,false,C.vx*C.curSpeed,
C.vy*C.curSpeed,false)end end elseif U then local S=playerData[b]pattern(b,S,'key',g,{x=E,y=w})end end;function eventSummoningStart(B,O,J,V,Q)local o={x=J,y=V,angle=Q,type=O}
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
function eventLoop(i,k)local e,C,s,t;local S=25.0;local f=1.5;local Z=-f*f/S;local X=make_star(5,2)
clearT(1)
for Y,d in pairs(playerData)do
if d.shot_cd>0 then d.shot_cd=d.shot_cd-1 end;if d.bomb_cd>0 then d.bomb_cd=d.bomb_cd-1 end
e=tfm.get.room.playerList[Y]
if not e.isDead then C=e.x;s=e.y
if C==0 and s==0 then kill(Y)else
if C<X_MIN then C=X_MIN elseif C>X_MAX then C=X_MAX end;if s<Y_MIN then s=Y_MIN elseif s>Y_MAX then s=Y_MAX end;d.spawn[0]=C
d.spawn[1]=s
if d.focused then local h;for t,h in ipairs(X.points)do
addParticle(particles.purple,C+S*h[1],s+S*h[2],f*h[2],-f*h[1],
Z*h[1],Z*h[2])end end;if d.shooting then shoot(Y,d)end
if d.bombing then d.bombTime=d.bombTime-1
if
d.bombTime<=0 then d.bombing=false;d.bomb_cd=d.bomb.cd;removeBomb(Y,d)else if d.bomb.callback then
local b,z=pcall(d.bomb.callback,Y,d)
if not b then addError('bomb.callback: '..z)end end end end end end end end
for a,k in pairs(tfm.get.room.playerList)do initPlayer(a)end;setMap(defaultMap)