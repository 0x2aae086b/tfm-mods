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
freeId(_timerId,r)end
dump_func={['function']=function(...)return'&lt;function&gt;'end,['userdata']=function(...)return
'&lt;userdata&gt;'end,['thread']=function(...)return'&lt;thread&gt;'end,['nil']=function(...)return
'nil'end,['number']=function(V,...)return tostring(V)end,['boolean']=function(O,...)return
tostring(O)end,['string']=function(v,...)
for Y,U in
ipairs({{'&','&amp;'},{'<','&lt;'},{'>','&gt;'}})do v=string.gsub(v,U[1],U[2])end;return string.format('%q',v)end,['table']=function(q,g)if
g==nil then g=''end;local _={"{\n"}local b=g..' '
for X,h in pairs(q)do _[#_+1]=b..'['
_[#_+1]=dump_func[type(X)](X,b)_[#_+1]='] = '_[#_+1]=dump_func[type(h)](h,b)_[
#_+1]=',\n'end;local l=#_;if l>1 then _[l]='\n'end;_[#_+1]=g..'}'
return table.concat(_)end}function dump(Z)return dump_func[type(Z)](Z)end
function split1(H,D,t,O)if
O==nil then O='%s'end;t=t-#O+2;local U=#H;if U<=t then
return{string.format(O,H)}end;local d={}local h=1;local R,n;local E,w=string.find(H,D)
while E~=nil do
if
E-h>t then if R~=nil and R>h then
d[#d+1]=string.format(O,string.sub(H,h,R-1))h=n+1 end
while E-h>t do d[#d+1]=string.format(O,string.sub(H,h,
h+t-1))h=h+t end end;R,n=E,w;E,w=string.find(H,D,w+1)
if E==nil and n<U then E,w=U,U end end;if h<U then
d[#d+1]=string.format(O,string.sub(H,h,U))end;return d end
function do_showLongString(P,D)
ui.addTextArea(P.id,P.pages[P.page],D,100,80,579,284,nil,nil,P.alpha,true)
ui.addTextArea(P.id+1,string.format('<a href="event:lsalpha%s"><p align="center"><font face="mono" size="15">%s</font></p></a>',D,P.title),D,100,50,400,22,
nil,nil,P.alpha,true)
ui.addTextArea(P.id+2,string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> %d/%d <a href="event:next">&gt;</a></font></p>',P.page,P.maxPage),D,508,50,148,22,
nil,nil,P.alpha,true)
ui.addTextArea(P.id+3,'<TI><a href="event:lsclose"><p align="center">X</p></a>',D,664,50,15,22,nil,nil,P.alpha,true)end
function showLongString(d,j,o,m)if m==nil then m=1 end
local i=split1(j,'\n',2000,'<font face="mono" size="15">%s</font>')local g=#i;ls={id=200,title=d,pages=i,page=1,alpha=m,maxPage=g}if playerData[o]==
nil then playerData[o]={}end
playerData[o].longString=ls;do_showLongString(ls,o)end
function updateLongString(T,I)
ui.updateTextArea(I.id,I.pages[I.page],T)
ui.updateTextArea(I.id+2,string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> %d/%d <a href="event:next">&gt;</a></font></p>',I.page,I.maxPage),T)end
function lsTextAreaCallback(w,T,R)
if R=='next'then local A=playerData[T].longString;local N=A.page;if
N<A.maxPage then A.page=N+1 end;updateLongString(T,A)elseif R=='prev'then
local s=playerData[T].longString;local t=s.page;if t>1 then s.page=t-1 end;updateLongString(T,s)elseif
R=='lsclose'then ui.removeTextArea(w-3,T)ui.removeTextArea(w-2,T)ui.removeTextArea(
w-1,T)ui.removeTextArea(w,T)playerData[T].longString=
nil elseif string.sub(R,1,7)=='lsalpha'then
local T=string.sub(R,8)local g=playerData[T].longString;g.alpha=1.0-g.alpha
do_showLongString(g,T)else return false end;return true end;defaultMap='90'curMap=defaultMap;playerData={}
function getfield(E,O)local _=_G
for A,c in
string.gmatch(E,'([[.]?)([^][.]+)')do if type(_)~='table'then
if O then error('Invalid field: '..E)else return nil end end
if A=='['then
c=do_parse_arg(c,nil)if c==nil then
if O then error('Invalid field: '..E)else return nil end end end;_=_[c]end;return _ end
function do_parse_arg(U,_)
if U=='true'then return true elseif U=='false'then return false elseif U=='nil'then return nil elseif U=='{'then if _~=nil then
return parse_arg(_,U)else return nil end else local E=string.sub(U,1,1)
if
E=='"'or E=="'"then return unescape(string.sub(U,2,-2))else E=tonumber(U)if
E~=nil then return E else return getfield(U,true)end end end end
function do_parse_key(x)local R
while true do
if x=='true'then return true elseif x=='false'then return false else local R=string.sub(x,1,1)
if
R=='"'or R=="'"then return unescape(string.sub(x,2,-2))elseif
R=='['then x=string.sub(x,2,-2)else R=tonumber(x)if R~=nil then return R else
return unescape(x)end end end end end
function parse_arg(Q,v)local y;local P,O;if v==nil then v=Q()end
if v==nil then return nil,true elseif v=='{'then y={}v=Q()
while
v~=nil and v~='}'do P,O=string.gmatch(v,'(.+)=(.+)')()
if P==nil then
y[#y+1]=do_parse_arg(v,Q)else y[do_parse_key(P)]=do_parse_arg(O,Q)end;v=Q()end;return y,v==nil else return do_parse_arg(v),false end end
function call(X,v,s)local Z={}local r=0;local t=string.gmatch(v,'[^%s]+')
local B,l=parse_arg(t)while not l do r=r+1;Z[r]=B;B,l=parse_arg(t)end;if s then return{X,Z,r}else return
X(unpack(Z,r))end end;MODULE_HELP_START='Commands'
MODULE_HELP_CONTENTS=[[<font face="mono" size="15"><a href="event:Commands">Commands</a></font>
]]
MODULE_HELP={['Commands']=[[<font face="mono" size="15">!help

!init

!r
!reset
    tfm.exec.newGame(curMap)

!m [&lt;map&gt;]
!map [&lt;map&gt;]
    tfm.exec.newGame()

!dir &lt;variable&gt;

!dump &lt;value&gt;

!&lt;function&gt; [&lt;value&gt;...]

!do

!end

!redo

!undo
</font>
]]}
MODULE_HELP_CLOSE='<TI><a href="event:help_close"><p align="center">X</p></a>'
MODULE_CHAT_COMMAND={['help']=help,['reset']=function()setMap(curMap)end,['map']=function(Y,e,g)
if g==''then g=defaultMap end;setMap(g)curMap=g end,['init']=function()defaultMap='0'
curMap=defaultMap;playerData={}for J,_ in pairs(tfm.get.room.playerList)do
eventNewPlayer(J)end;setMap(curMap)end,['dir']=function(t,x,h)
local i=''local W,a=pcall(getfield,h)
if W then if type(a)=='table'then
for b,m in pairs(a)do i=i..b..'\n'end;showLongString(h,i,t,0.8)else
alert(h..' is not a table',t)end else
alert(a,t)end end,['dump']=function(h,c,_)
local p,q=pcall(call,dump,_)
if p then showLongString(_,q,h,0.8)else alert(q,h)end end,['do']=function(O)
local s=playerData[O]s.append=true;s.newFunction={}end,['end']=function(c,T)
local o=playerData[c]
if T=='end'then o.append=false;o.lastFunction=o.newFunction end;local F,i;for D,k in pairs(o.lastFunction)do F,i=pcall(call,k[1],k[2])if not F then
alert(i,c)break end end end,['undo']=function(J)
local K=playerData[J]K.append=false;K.newFunction={}end}
MODULE_CHAT_COMMAND['redo']=MODULE_CHAT_COMMAND['end']
MODULE_CHAT_COMMAND['r']=MODULE_CHAT_COMMAND['reset']MODULE_CHAT_COMMAND['m']=MODULE_CHAT_COMMAND['map']
MODULE_CHAT_COMMAND_1=function(D,R,i)
local S=getfield(R)local o=playerData[D]
if type(S)=='function'then if o.append then
o.newFunction[#o.newFunction+1]={S,i}else o.lastFunction={{S,i}}local w,m=pcall(call,S,i)
if not w then alert(m,D)end end else alert(
'Invalid command: '..R,D)end end
function eventNewPlayer(G)
playerData[G]={lastFunction={},newFunction={},append=false}
ui.addTextArea(104,'<TI><a href="event:help"><p align="center">Help</p></a>',G,5,25,40,22,nil,nil,nil,true)
ui.addTextArea(ERROR_TA,table.concat(_errors),G,805,5,200,590,nil,nil,0.5,true)do_respawn(G)end;function eventPlayerLeft(e)playerData[e]=nil end
function eventNewGame()
tfm.exec.disableAfkDeath(true)tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoScore(true)tfm.exec.setGameTime(0)
tfm.exec.addPhysicObject(0,0,0,{type=13,color=0xFFFFFF})end;function eventPlayerDied(j)do_respawn(j)end
function eventPlayerWon(U)do_respawn(U)end
function eventTextAreaCallback(N,y,n)if not lsTextAreaCallback(N,y,n)then
helpTextAreaCallback(N,y,n)end end
function clear()for B,K in ipairs(keys(tfm.get.room.objectList))do
do_removeObject(K)end end
for a,B in pairs(tfm.get.room.playerList)do eventNewPlayer(a)end;setMap(defaultMap)