TIME=os.time()TIMER_RES=250;_timerId={max=0,free={}}_timerData={}
function initTimers()
TIME=os.time()_timerId={max=0,free={}}_timerData={}end
function timer()local a=os.time()while TIME+TIMER_RES<=a do eventTimer()
TIME=TIME+TIMER_RES end end
function timers()local X=os.time()local f,d,v
for A,K in ipairs(_timerData)do f=K.time;v=true
while f+K.res<=X do
f=f+K.res;d,v=pcall(K.func,A,K)if not d then
addError(nil,string.format('timer %d: %s',A,v))v=false end;if not v then break end end;if v then K.time=f else removeTimer(A)end end end;function addTimer(g,G,r)local M=newId(_timerId)
_timerData[M]={func=g,args=G,res=r,time=os.time()}end;function removeTimer(i)
freeId(_timerId,i)end;MAX_ID=499
function tbl_name(Z)return'&lt;table&gt;'end
function newId(w)local n=w.free;local i,j=pairs(n)(n)
if i then n[i]=nil;return i else if w.max==MAX_ID then
error(string.format("newId: %s.max == MAX_ID",tbl_name(w)))end;w.max=w.max+1;return w.max end end
function freeId(I,u)local Q=I.free;if u==I.max then local D=I.max-1;while Q[D]do Q[D]=nil;D=D-1 end;I.max=D else
Q[u]=true end end;_errors={'<TI><p align="center">Errors</p>'}ERROR_TA=3
MAX_ERRORS=7;function alert(I,d)
ui.addPopup(0,0,string.format('<font face="mono" size="15">%s</font>',I),d,200,150,400,true)end
function addError(O)
O=string.format("• %s\n",O)for i=3,#_errors+1 do _errors[i]=_errors[i-1]end
_errors[2]=O;_errors[MAX_ERRORS+1]=nil;ui.updateTextArea(ERROR_TA,table.concat(_errors),
nil)end
dump_func={['function']=function(...)return'&lt;function&gt;'end,['userdata']=function(...)
return'&lt;userdata&gt;'end,['thread']=function(...)return'&lt;thread&gt;'end,['nil']=function(...)return'nil'end,['number']=function(C,...)return
tostring(C)end,['boolean']=function(U,...)return tostring(U)end,['string']=function(Y,...)
for _,S in
ipairs({{'&','&amp;'},{'<','&lt;'},{'>','&gt;'}})do Y=string.gsub(Y,S[1],S[2])end;return string.format('%q',Y)end,['table']=function(w,a)if
a==nil then a=''end;local u={"{\n"}local H=a..' '
for m,g in pairs(w)do u[#u+1]=H..'['
u[#u+1]=dump_func[type(m)](m,H)u[#u+1]='] = 'u[#u+1]=dump_func[type(g)](g,H)u[
#u+1]=',\n'end;local q=#u;if q>1 then u[q]='\n'end;u[#u+1]=a..'}'
return table.concat(u)end}function dump(w)return dump_func[type(w)](w)end
function help(g)
ui.addTextArea(100,MODULE_HELP[MODULE_HELP_START],g,258,78,421,284,
nil,nil,nil,true)
ui.addTextArea(101,string.format('<p align="center"><font face="mono" size="15">%s</font></p>',MODULE_HELP_START),g,258,50,398,20,
nil,nil,nil,true)
ui.addTextArea(102,MODULE_HELP_CONTENTS,g,100,50,150,312,nil,nil,nil,true)
ui.addTextArea(103,MODULE_HELP_CLOSE,g,664,50,15,20,nil,nil,nil,true)end
function helpTextAreaCallback(C,c,H)
if H=='help'then help(c)elseif H=='help_close'and C==103 then
ui.removeTextArea(100,c)ui.removeTextArea(101,c)ui.removeTextArea(102,c)
ui.removeTextArea(103,c)else local L=MODULE_HELP[H]
if L~=nil then ui.updateTextArea(100,L,c)
ui.updateTextArea(101,string.format('<font face="mono" size="15"><p align="center">%s</p></font>',H),c)else return false end end;return true end;function nop()end
function randomColor()return math.random(0x000000,0xFFFFFF)end;function to_table(d)
if d==nil or type(d)=='table'then return d else return{d}end end
_axis={'-1,0','-1,1','0,1','1,1','1,0','1,-1','0,-1','-1,-1'}_axis_step=math.pi/4.0
function to_axis(v)
local R=(math.floor(v/_axis_step)%#_axis)return _axis[R+1],_axis_step*R end
function rotate(n,w,T,A,p,c)n,w=n-T,w-A;n,w=n*p-w*c,n*c+w*p;return T+n,A+w end
function length1(L)return math.sqrt(L.x*L.x+L.y*L.y)end
function cache2(R)local W={}return
function(N,D)local m=W[N]local c=nil;if m==nil then m={}W[N]=m else c=m[D]end;if c==nil then
c=R(N,D)m[D]=c end;return c end end;function split(z)local G={}for e in string.gmatch(z,'[^%s]+')do G[#G+1]=e end
return G end
function parsePlayerNames(Z,g,w)local p={}local e
for E,B in
ipairs(split(string.lower(g)))do
if string.sub(B,1,1)=='!'then B=string.sub(B,2)e=nil else e=true end
if B=='me'then p[Z]=e elseif B=='all'then for E,B in pairs(playerData)do p[E]=e end else
B=string.gsub(B,'^%l',string.upper)if playerData[B]==nil then
alert('Invalid player: '..B,Z)return else p[B]=e end end end;for b,j in pairs(p)do w(b)end end;unescape_map={a='\a',b='\b',f='\f',n='\n',r='\r',t='\t'}
function do_unescape(H,h)local i=tonumber(
H..h)if i==nil then
return(unescape_map[H]or H)..h else return string.char(i)end end
function unescape(L)return string.gsub(L,'\\(.)(%d?%d?)',do_unescape)end;function do_unpack(l,O,B)
if O<=B then return l[O],do_unpack(l,O+1,B)else return nil end end;function unpack(x,s)if s==nil then s=#x end;return
do_unpack(x,1,s)end;function length(K)local D=0
for c in pairs(K)do D=D+1 end;return D end;function copy(L,l)if l~=nil then
for n,y in pairs(l)do L[n]=y end end end;function append(o,z)for B,C in ipairs(z)do o[#o+
1]=C end end;function invert(s,l)local v={}
if l==nil then for M,S in
pairs(s)do v[S]=M end else for n,I in pairs(s)do v[I]=l end end;return v end
function keys(x)
local i={}for V,u in pairs(x)do i[#i+1]=V end;return i end;function keys1(G)local f=keys(G)table.sort(f)return f end
function randomKey1(J,B,S)
local P,G={},1;for r,V in pairs(J)do if r~=B then P[G]=r;G=G+1 end end
if G>1 then return P[math.random(1,#
P)]elseif S then return nil else return B end end;function randomValue1(O,v,Y)local U=randomKey1(O,v,Y)
if U~=nil then return O[U]else return nil end end
do_addObject=tfm.exec.addShamanObject;do_removeObject=tfm.exec.removeObject
do_addGround=tfm.exec.addPhysicObject;do_removeGround=tfm.exec.removePhysicObject
do_addJoint=tfm.exec.addJoint;do_removeJoint=tfm.exec.removeJoint
do_respawn=tfm.exec.respawnPlayer;do_addExplosion=tfm.exec.explosion
addParticle=tfm.exec.displayParticle;setShaman=tfm.exec.setShaman
setShamanName=tfm.exec.setUIShamanName;setMapName=tfm.exec.setUIMapName
setNameColor=tfm.exec.setNameColor;movePlayer=tfm.exec.movePlayer;moveObject=tfm.exec.moveObject
setMap=tfm.exec.newGame;bindKey=tfm.exec.bindKeyboard;kill=tfm.exec.killPlayer
function eventChatCommand(q,g)
local _,b;local l,X;for H,D in ipairs({{'&lt;','<'},{'&amp;','&'}})do
g=string.gsub(g,D[1],D[2])end
while true do
_,b=string.find(g,'%s+')
if _==nil then l=g;X=''break elseif _==1 then g=string.sub(g,b+1)if g==''then l=''X=''break end else l=string.sub(g,1,
_-1)X=string.sub(g,b+1)break end end;local h=string.lower(l)local Z=MODULE_CHAT_COMMAND[h]if Z~=nil then
Z(q,h,X)else MODULE_CHAT_COMMAND_1(q,l,X)end end
function split1(t,D,O,j)if j==nil then j='%s'end;O=O-#j+2;local U=#t;if U<=O then return
{string.format(j,t)}end;local d={}local h=1;local R,n
local E,w=string.find(t,D)
while E~=nil do
if E-h>O then if R~=nil and R>h then
d[#d+1]=string.format(j,string.sub(t,h,R-1))h=n+1 end
while E-h>O do d[#d+1]=string.format(j,string.sub(t,h,
h+O-1))h=h+O end end;R,n=E,w;E,w=string.find(t,D,w+1)
if E==nil and n<U then E,w=U,U end end;if h<U then
d[#d+1]=string.format(j,string.sub(t,h,U))end;return d end
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
do_showLongString(g,T)else return false end;return true end;defaultMap='0'curMap=defaultMap;playerData={}
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