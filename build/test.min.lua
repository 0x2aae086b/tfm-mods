
dump_func={['function']=function(...)return'&lt;function&gt;'end,['userdata']=function(...)
return'&lt;userdata&gt;'end,['thread']=function(...)return'&lt;thread&gt;'end,['nil']=function(...)return'nil'end,['number']=function(a,...)return
tostring(a)end,['boolean']=function(X,...)return tostring(X)end,['string']=function(f,...)
for d,A in
ipairs({{'&','&amp;'},{'<','&lt;'},{'>','&gt;'}})do f=string.gsub(f,A[1],A[2])end;return string.format('%q',f)end,['table']=function(K,g)if
g==nil then g=''end;local G={"{\n"}local r=g..' '
for i,Z in pairs(K)do G[#G+1]=r..'['
G[#G+1]=dump_func[type(i)](i,r)G[#G+1]='] = 'G[#G+1]=dump_func[type(Z)](Z,r)G[
#G+1]=',\n'end;local M=#G;if M>1 then G[M]='\n'end;G[#G+1]=g..'}'
return table.concat(G)end}function dump(w)return dump_func[type(w)](w)end
function help(n)
ui.addTextArea(100,MODULE_HELP[MODULE_HELP_START],n,258,78,421,284,
nil,nil,nil,true)
ui.addTextArea(101,string.format('<p align="center"><font face="mono" size="15">%s</font></p>',MODULE_HELP_START),n,258,50,398,20,
nil,nil,nil,true)
ui.addTextArea(102,MODULE_HELP_CONTENTS,n,100,50,150,312,nil,nil,nil,true)
ui.addTextArea(103,MODULE_HELP_CLOSE,n,664,50,15,20,nil,nil,nil,true)end
function helpTextAreaCallback(v,i,j)
if j=='help'then help(i)elseif j=='help_close'and v==103 then
ui.removeTextArea(100,i)ui.removeTextArea(101,i)ui.removeTextArea(102,i)
ui.removeTextArea(103,i)else local I=MODULE_HELP[j]
if I~=nil then ui.updateTextArea(100,I,i)
ui.updateTextArea(101,string.format('<font face="mono" size="15"><p align="center">%s</p></font>',j),i)else return false end end;return true end;function nop()end;function to_table(u)
if u==nil or type(u)=='table'then return u else return{u}end end;function alert(Q,D)
ui.addPopup(0,0,string.format('<font face="mono" size="15">%s</font>',Q),D,200,150,400,true)end;function randomColor()return
math.random(0x000000,0xFFFFFF)end;function rotate(I,d,O,C,U,Y)I,d=I-O,d-C;I,d=I*U-d*Y,
I*Y+d*U;return O+I,C+d end
function length1(_)return math.sqrt(
_.x*_.x+_.y*_.y)end
function cache2(S)local w={}return
function(a,u)local H=w[a]local i=nil;if H==nil then H={}w[a]=H else i=H[u]end;if i==nil then
i=S(a,u)H[u]=i end;return i end end;function split(w)local q={}for m in string.gmatch(w,'[^%s]+')do q[#q+1]=m end
return q end
function parsePlayerNames(H,g,w)local C={}local c
for L,d in
pairs(split(string.lower(g)))do
if string.sub(d,1,1)=='!'then d=string.sub(d,2)c=nil else c=true end
if d=='me'then C[H]=c elseif d=='all'then for L,d in pairs(playerData)do C[L]=c end else
d=string.gsub(d,'^%l',string.upper)if playerData[d]==nil then
alert('Invalid player: '..d,H)return else C[d]=c end end end;for R,n in pairs(C)do w(R)end end;unescape_map={a='\a',b='\b',f='\f',n='\n',r='\r',t='\t'}
function do_unescape(w,T)local A=tonumber(
w..T)if A==nil then
return(unescape_map[w]or w)..T else return string.char(A)end end
function unescape(p)return string.gsub(p,'\\(.)(%d?%d?)',do_unescape)end;function do_unpack(c,L,R)
if L<=R then return c[L],do_unpack(c,L+1,R)else return nil end end;function unpack(W,N)if N==nil then N=#W end;return
do_unpack(W,1,N)end;function length(R)local D=0
for m in pairs(R)do D=D+1 end;return D end;function copy(c,z)if z~=nil then
for G,e in pairs(z)do c[G]=e end end end;function append(Z,g)for w,p in ipairs(g)do Z[#Z+
1]=p end end;function invert(e,E)local B={}
if E==nil then for b,j in
pairs(e)do B[j]=b end else for H,h in pairs(e)do B[h]=E end end;return B end
function keys(i)
local L={}for l,O in pairs(i)do L[#L+1]=l end;return L end;function keys1(B)local x=keys(B)table.sort(x)return x end
function randomKey1(s,K,D)
local c,L={},1
for l,n in pairs(s)do if not(l==K)then c[L]=l;L=L+1 end end
if L>1 then return c[math.random(1,#c)]elseif D then return nil else return K end end;function randomValue1(y,o,z)local B=randomKey1(y,o,z)
if B~=nil then return y[B]else return nil end end
do_addObject=tfm.exec.addShamanObject;do_removeObject=tfm.exec.removeObject
do_addGround=tfm.exec.addPhysicObject;do_removeGround=tfm.exec.removePhysicObject
do_addJoint=tfm.exec.addJoint;do_removeJoint=tfm.exec.removeJoint
do_respawn=tfm.exec.respawnPlayer;do_addExplosion=tfm.exec.explosion
addParticle=tfm.exec.displayParticle;setShaman=tfm.exec.setShaman
setShamanName=tfm.exec.setUIShamanName;setMapName=tfm.exec.setUIMapName
setNameColor=tfm.exec.setNameColor;movePlayer=tfm.exec.movePlayer;moveObject=tfm.exec.moveObject
setMap=tfm.exec.newGame;bindKey=tfm.exec.bindKeyboard;kill=tfm.exec.killPlayer
function eventChatCommand(v,C)
local s,l;local M,S;for x,i in ipairs({{'&lt;','<'},{'&amp;','&'}})do
C=string.gsub(C,i[1],i[2])end
while true do
s,l=string.find(C,'%s+')
if s==nil then M=C;S=''break elseif s==1 then C=string.sub(C,l+1)if C==''then M=''S=''break end else M=string.sub(C,1,
s-1)S=string.sub(C,l+1)break end end;local n=string.lower(M)local I=MODULE_CHAT_COMMAND[n]if I~=nil then
I(v,n,S)else MODULE_CHAT_COMMAND_1(v,M,S)end end
function split1(V,u,G,f)if f==nil then f='%s'end;G=G-#f+2;local J=#V;if J<=G then return
{string.format(f,V)}end;local B={}local S=1;local P,r
local O,v=string.find(V,u)
while O~=nil do
if O-S>G then if P~=nil and P>S then
B[#B+1]=string.format(f,string.sub(V,S,P-1))S=r+1 end
while O-S>G do B[#B+1]=string.format(f,string.sub(V,S,
S+G-1))S=S+G end end;P,r=O,v;O,v=string.find(V,u,v+1)
if O==nil and r<J then O,v=J,J end end;if S<J then
B[#B+1]=string.format(f,string.sub(V,S,J))end;return B end
function do_showLongString(Y,U)
ui.addTextArea(Y.id,Y.pages[Y.page],U,100,80,579,284,nil,nil,Y.alpha,true)
ui.addTextArea(Y.id+1,string.format('<a href="event:lsalpha%s"><p align="center"><font face="mono" size="15">%s</font></p></a>',U,Y.title),U,100,50,400,22,
nil,nil,Y.alpha,true)
ui.addTextArea(Y.id+2,string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> %d/%d <a href="event:next">&gt;</a></font></p>',Y.page,Y.maxPage),U,508,50,148,22,
nil,nil,Y.alpha,true)
ui.addTextArea(Y.id+3,'<TI><a href="event:lsclose"><p align="center">X</p></a>',U,664,50,15,22,nil,nil,Y.alpha,true)end
function showLongString(q,g,_,b)if b==nil then b=1 end
local l=split1(g,'\n',2000,'<font face="mono" size="15">%s</font>')local X=#l;ls={id=200,title=q,pages=l,page=1,alpha=b,maxPage=X}if playerData[_]==
nil then playerData[_]={}end
playerData[_].longString=ls;do_showLongString(ls,_)end
function updateLongString(h,Z)
ui.updateTextArea(Z.id,Z.pages[Z.page],h)
ui.updateTextArea(Z.id+2,string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> %d/%d <a href="event:next">&gt;</a></font></p>',Z.page,Z.maxPage),h)end
function lsTextAreaCallback(H,D,t)
if t=='next'then local O=playerData[D].longString;local j=O.page;if
j<O.maxPage then O.page=j+1 end;updateLongString(D,O)elseif t=='prev'then
local U=playerData[D].longString;local d=U.page;if d>1 then U.page=d-1 end;updateLongString(D,U)elseif
t=='lsclose'then ui.removeTextArea(H-3,D)ui.removeTextArea(H-2,D)ui.removeTextArea(
H-1,D)ui.removeTextArea(H,D)playerData[D].longString=
nil elseif string.sub(t,1,7)=='lsalpha'then
local D=string.sub(t,8)local O=playerData[D].longString;O.alpha=1.0-O.alpha
do_showLongString(O,D)else return false end;return true end;defaultMap='0'curMap=defaultMap;playerData={}
function getfield(h,R)local n=_G
for E,w in
string.gmatch(h,'([[.]?)([^][.]+)')do if type(n)~='table'then
if R then error('Invalid field: '..h)else return nil end end
if E=='['then
w=do_parse_arg(w,nil)if w==nil then
if R then error('Invalid field: '..h)else return nil end end end;n=n[w]end;return n end
function do_parse_arg(P,D)
if P=='true'then return true elseif P=='false'then return false elseif P=='nil'then return nil elseif P=='{'then if D~=nil then
return parse_arg(D,P)else return nil end else local d=string.sub(P,1,1)
if
d=='"'or d=="'"then return unescape(string.sub(P,2,-2))else d=tonumber(P)if
d~=nil then return d else return getfield(P,true)end end end end
function do_parse_key(j)local o
while true do
if j=='true'then return true elseif j=='false'then return false else local o=string.sub(j,1,1)
if
o=='"'or o=="'"then return unescape(string.sub(j,2,-2))elseif
o=='['then j=string.sub(j,2,-2)else o=tonumber(j)if o~=nil then return o else
return unescape(j)end end end end end
function parse_arg(m,i)local g;local T,I;if i==nil then i=m()end
if i==nil then return nil,true elseif i=='{'then g={}i=m()
while
i~=nil and i~='}'do T,I=string.gmatch(i,'(.+)=(.+)')()
if T==nil then
g[#g+1]=do_parse_arg(i,m)else g[do_parse_key(T)]=do_parse_arg(I,m)end;i=m()end;return g,i==nil else return do_parse_arg(i),false end end
function call(w,T,R)local A={}local N=0;local s=string.gmatch(T,'[^%s]+')
local t,g=parse_arg(s)while not g do N=N+1;A[N]=t;t,g=parse_arg(s)end;if R then return{w,A,N}else return
w(unpack(A,N))end end;MODULE_HELP_START='Commands'
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
MODULE_CHAT_COMMAND={['help']=help,['reset']=function()setMap(curMap)end,['map']=function(E,O,_)
if _==''then _=defaultMap end;setMap(_)curMap=_ end,['init']=function()defaultMap='0'
curMap=defaultMap;playerData={}for A,c in pairs(tfm.get.room.playerList)do
eventNewPlayer(A)end;setMap(curMap)end,['dir']=function(U,_,E)
local x=''local R,Q=pcall(getfield,E)
if R then if type(Q)=='table'then
for y,P in pairs(Q)do x=x..y..'\n'end;showLongString(E,x,U,0.8)else
alert(E..' is not a table',U)end else
alert(Q,U)end end,['dump']=function(O,X,v)
local s,Z=pcall(call,dump,v)
if s then showLongString(v,Z,O,0.8)else alert(Z,O)end end,['do']=function(r)
local t=playerData[r]t.append=true;t.newFunction={}end,['end']=function(B,l)
local Y=playerData[B]
if l=='end'then Y.append=false;Y.lastFunction=Y.newFunction end;local e,g;for J,_ in pairs(Y.lastFunction)do e,g=pcall(call,_[1],_[2])if not e then
alert(g,B)break end end end,['undo']=function(t)
local x=playerData[t]x.append=false;x.newFunction={}end}
MODULE_CHAT_COMMAND['redo']=MODULE_CHAT_COMMAND['end']
MODULE_CHAT_COMMAND['r']=MODULE_CHAT_COMMAND['reset']MODULE_CHAT_COMMAND['m']=MODULE_CHAT_COMMAND['map']
MODULE_CHAT_COMMAND_1=function(h,i,W)
local a=getfield(i)local b=playerData[h]
if type(a)=='function'then if b.append then
b.newFunction[#b.newFunction+1]={a,W}else b.lastFunction={{a,W}}local x,m=pcall(call,a,W)
if not x then alert(m,h)end end else alert(
'Invalid command: '..i,h)end end
function eventNewPlayer(h)
playerData[h]={lastFunction={},newFunction={},append=false}
ui.addTextArea(104,'<TI><a href="event:help"><p align="center">Help</p></a>',h,5,25,40,22,nil,nil,nil,true)do_respawn(h)end;function eventPlayerLeft(c)playerData[c]=nil end
function eventNewGame()
tfm.exec.disableAfkDeath(true)tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoScore(true)tfm.exec.setGameTime(0)end;function eventPlayerDied(_)do_respawn(_)end
function eventPlayerWon(p)do_respawn(p)end
function eventTextAreaCallback(q,O,s)if not lsTextAreaCallback(q,O,s)then
helpTextAreaCallback(q,O,s)end end
function clear()for c,T in ipairs(keys(tfm.get.room.objectList))do
do_removeObject(T)end end
for o,F in pairs(tfm.get.room.playerList)do eventNewPlayer(o)end;setMap(defaultMap)