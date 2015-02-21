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
dump_func={['function']=function(...)return'&lt;function&gt;'end,['userdata']=function(...)return
'&lt;userdata&gt;'end,['thread']=function(...)return'&lt;thread&gt;'end,['nil']=function(...)return
'nil'end,['number']=function(t,...)return tostring(t)end,['boolean']=function(D,...)return
tostring(D)end,['string']=function(O,...)
for j,U in
ipairs({{'&','&amp;'},{'<','&lt;'},{'>','&gt;'}})do O=string.gsub(O,U[1],U[2])end;return string.format('%q',O)end,['table']=function(d,O)if
O==nil then O=''end;local h={"{\n"}local R=O..' '
for E,w in pairs(d)do h[#h+1]=R..'['
h[#h+1]=dump_func[type(E)](E,R)h[#h+1]='] = 'h[#h+1]=dump_func[type(w)](w,R)h[
#h+1]=',\n'end;local n=#h;if n>1 then h[n]='\n'end;h[#h+1]=O..'}'
return table.concat(h)end}function dump(P)return dump_func[type(P)](P)end
function split1(D,d,j,o)if
o==nil then o='%s'end;j=j-#o+2;local m=#D;if m<=j then
return{string.format(o,D)}end;local g={}local T=1;local I,w;local R,A=string.find(D,d)
while R~=nil do
if
R-T>j then if I~=nil and I>T then
g[#g+1]=string.format(o,string.sub(D,T,I-1))T=w+1 end
while R-T>j do g[#g+1]=string.format(o,string.sub(D,T,
T+j-1))T=T+j end end;I,w=R,A;R,A=string.find(D,d,A+1)
if R==nil and w<m then R,A=m,m end end;if T<m then
g[#g+1]=string.format(o,string.sub(D,T,m))end;return g end
function do_showLongString(N,s)
ui.addTextArea(N.id,N.pages[N.page],s,100,80,579,284,nil,nil,N.alpha,true)
ui.addTextArea(N.id+1,string.format('<a href="event:lsalpha%s"><p align="center"><font face="mono" size="15">%s</font></p></a>',s,N.title),s,100,50,400,22,
nil,nil,N.alpha,true)
ui.addTextArea(N.id+2,string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> %d/%d <a href="event:next">&gt;</a></font></p>',N.page,N.maxPage),s,508,50,148,22,
nil,nil,N.alpha,true)
ui.addTextArea(N.id+3,'<TI><a href="event:lsclose"><p align="center">X</p></a>',s,664,50,15,22,nil,nil,N.alpha,true)end
function showLongString(t,g,E,O)if O==nil then O=1 end
local _=split1(g,'\n',2000,'<font face="mono" size="15">%s</font>')local A=#_;ls={id=200,title=t,pages=_,page=1,alpha=O,maxPage=A}if playerData[E]==
nil then playerData[E]={}end
playerData[E].longString=ls;do_showLongString(ls,E)end
function updateLongString(c,U)
ui.updateTextArea(U.id,U.pages[U.page],c)
ui.updateTextArea(U.id+2,string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> %d/%d <a href="event:next">&gt;</a></font></p>',U.page,U.maxPage),c)end
function lsTextAreaCallback(_,E,x)
if x=='next'then local R=playerData[E].longString;local Q=R.page;if
Q<R.maxPage then R.page=Q+1 end;updateLongString(E,R)elseif x=='prev'then
local v=playerData[E].longString;local y=v.page;if y>1 then v.page=y-1 end;updateLongString(E,v)elseif
x=='lsclose'then ui.removeTextArea(_-3,E)ui.removeTextArea(_-2,E)ui.removeTextArea(
_-1,E)ui.removeTextArea(_,E)playerData[E].longString=
nil elseif string.sub(x,1,7)=='lsalpha'then
local E=string.sub(x,8)local P=playerData[E].longString;P.alpha=1.0-P.alpha
do_showLongString(P,E)else return false end;return true end
function addObject(O,X,v,s,Z,r,t,B,l,Y,e)local g=do_addObject(O,X,v,s,Z,r,t)if B==nil then B=3 end
objectData[g]={time=B,callback=to_table(l),on_remove=to_table(Y),callback_args=e}return g end
function removeObject(J)do_removeObject(J)objectData[J]=nil end
function addGround(_,t,x,h,i,W,a)local b=newId(groundId)do_addGround(b,_,t,x)
if h==nil then h=3 end
groundData[b]={time=h,callback=to_table(i),on_remove=to_table(W),callback_args=a}return b end;function removeGround(x)do_removeGround(x)groundData[x]=nil
freeId(groundId,x)end
function addJoint(a,m,h,c,_,p,q)local O=newId(jointId)
do_addJoint(O,a,m,h)if c==nil then c=-1 end;if h==nil then h={}end
jointData[O]={time=c,callback=to_table(_),on_remove=to_table(p),callback_args=q}return O end
function removeJoint(s)do_removeJoint(s)jointData[s]=nil;freeId(jointId,s)end
function addExplosion(c,T,o,F,i,D,k)if D~=nil then addParticle(D,c,T,0,0,0,0)end
if k~=nil then end;do_addExplosion(c,T,o,F,i)end
function list_default(J,K,D)J[#J+1]=string.format('%d %d\n',K,D.time)end
function step(R,i,S,o,w)local m={}local G;local e,j;if w==nil then w=list_default end
for U,N in pairs(i)do w(o,U,N)
if
N.time<=0 then
if N.on_remove then
for y,n in ipairs(N.on_remove)do e,j=pcall(n,U,N)if not e then
addError(string.format("step(%s): on_remove[%d]: %s\n",tbl_name(i),y,j))end end end;m[#m+1]=U else N.time=N.time-R
if N.callback then
for B,K in ipairs(N.callback)do e,j=pcall(K,U,N)if
not e then
addError(string.format("step(%s): callback[%d]: %s\n",tbl_name(i),B,j))m[#m+1]=U;break end end end end end;for a,B in ipairs(m)do S(B)end end;defaultMap='90'UI_DEFAULT=false;MTYPE=0;curMap=defaultMap;playerData={}
objectData={}groundData={}jointData={}
function getfield(Q,L)local y=_G
for a,D in string.gmatch(Q,'([[.]?)([^][.]+)')do if
type(y)~='table'then
if L then error('Invalid field: '..Q)else return nil end end
if a=='['then
D=do_parse_arg(D,nil)if D==nil then
if L then error('Invalid field: '..Q)else return nil end end end;y=y[D]end;return y end
function do_parse_arg(p,M)
if p=='true'then return true elseif p=='false'then return false elseif p=='nil'then return nil elseif p=='{'then if M~=nil then
return parse_arg(M,p)else return nil end else local J=string.sub(p,1,1)
if
J=='"'or J=="'"then return unescape(string.sub(p,2,-2))else J=tonumber(p)if
J~=nil then return J else return getfield(p,true)end end end end
function do_parse_key(k)local P
while true do
if k=='true'then return true elseif k=='false'then return false else local P=string.sub(k,1,1)
if
P=='"'or P=="'"then return unescape(string.sub(k,2,-2))elseif
P=='['then k=string.sub(k,2,-2)else P=tonumber(k)if P~=nil then return P else
return unescape(k)end end end end end
function parse_arg(u,E)local C;local l,p;if E==nil then E=u()end
if E==nil then return nil,true elseif E=='{'then C={}E=u()
while
E~=nil and E~='}'do l,p=string.gmatch(E,'(.+)=(.+)')()
if l==nil then
C[#C+1]=do_parse_arg(E,u)else C[do_parse_key(l)]=do_parse_arg(p,u)end;E=u()end;return C,E==nil else return do_parse_arg(E),false end end
function call(i,L,P)local u={}local j=0;local K=string.gmatch(L,'[^%s]+')
local h,A=parse_arg(K)while not A do j=j+1;u[j]=h;h,A=parse_arg(K)end;if P then return{i,u,j}else return
i(unpack(u,j))end end;MODULE_HELP_START='Commands'
MODULE_HELP_CONTENTS=[[<font face="mono" size="15"><a href="event:Commands">Commands</a></font>
]]
MODULE_HELP={['Commands']=[[<font face="mono" size="15">!help

!init

!s &lt;command&gt;

!ui [!]me|all|&lt;name&gt;...

!r
!reset
    tfm.exec.newGame(curMap)

!m [&lt;map&gt;]
!map [&lt;map&gt;]
    tfm.exec.newGame()

!mtype 0|1|2

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
function changeUI(v)local l=playerData[v]l.ui=not l.ui
if l.ui then
ui.addTextArea(104,'<TI><a href="event:help"><p align="center">Help</p></a>',v,5,25,40,22,
nil,nil,nil,true)
ui.addTextArea(ERROR_TA,table.concat(_errors),v,805,5,200,590,nil,nil,0.5,true)else ui.removeTextArea(104,v)
ui.removeTextArea(ERROR_TA,v)end end
MODULE_CHAT_COMMAND={['help']=help,['s']=function(o,F,e)eventChatCommand(o,e)end,['ui']=function(T,F,x)
parsePlayerNames(T,x,changeUI)end,['mtype']=function(l,T,Y)local Z=tonumber(Y)
if Z==nil or Z<0 or Z>2 then alert(
'Invalid value for MTYPE: '..Y,l)end;MTYPE=Z end,['control']=function(t,y,p)
p=string.lower(p)p=string.gsub(p,'^%l',string.upper)
playerData[t].cntl={name=p,obj=objcode.anvil,off=32,da=0}end,['reset']=function()
setMap(curMap)end,['map']=function(H,f,K)if K==''then K=defaultMap end;setMap(K)curMap=K end,['init']=function()
defaultMap='0'curMap=defaultMap;playerData={}for A,_ in pairs(tfm.get.room.playerList)do
eventNewPlayer(A)end;setMap(curMap)end,['dir']=function(Q,s,K)
local P=''local B,n=pcall(getfield,K)
if B then if type(n)=='table'then
for g,k in pairs(n)do P=P..g..'\n'end;showLongString(K,P,Q,0.8)else
alert(K..' is not a table',Q)end else
alert(n,Q)end end,['dump']=function(U,l,X)
local f,b=pcall(call,dump,X)
if f then showLongString(X,b,U,0.8)else alert(b,U)end end,['do']=function(v)
local z=playerData[v]z.append=true;z.newFunction={}end,['end']=function(A,d)
local r=playerData[A]
if d=='end'then r.append=false;r.lastFunction=r.newFunction end;local H,c;for v,x in pairs(r.lastFunction)do H,c=pcall(call,x[1],x[2])if not H then
alert(c,A)break end end end,['undo']=function(q)
local t=playerData[q]t.append=false;t.newFunction={}end}
MODULE_CHAT_COMMAND['redo']=MODULE_CHAT_COMMAND['end']
MODULE_CHAT_COMMAND['r']=MODULE_CHAT_COMMAND['reset']MODULE_CHAT_COMMAND['m']=MODULE_CHAT_COMMAND['map']
MODULE_CHAT_COMMAND_1=function(O,G,z)
local q=getfield(G)local N=playerData[O]
if type(q)=='function'then if N.append then
N.newFunction[#N.newFunction+1]={q,z}else N.lastFunction={{q,z}}local a,H=pcall(call,q,z)
if not a then alert(H,O)end end else alert(
'Invalid command: '..G,O)end end;system.disableChatCommandDisplay('s',true)
playerKeys={kc.w,kc.s,kc.a,kc.d,kc.space,kc.left,kc.right,kc.up,kc.down,kc.kp7,kc.kp8,kc.kp4,kc.kp5,kc.kp6,kc.kp1}
pk_vx={[kc.a]=-30,[kc.left]=-30,[kc.d]=30,[kc.right]=30}
pk_vy={[kc.space]=-30,[kc.w]=-30,[kc.up]=-30,[kc.s]=30,[kc.down]=30}pkc_vx={[kc.kp4]=-30,[kc.kp6]=30}
pkc_vy={[kc.kp8]=-30,[kc.kp2]=30}
function movePlayer1(P,l,j,I,y)if MTYPE==0 then return false end
if j then
if y then l.vx=j
if l.vx>0 then l.dir=1 else l.dir=-1 end;movePlayer(P,0,0,false,j,l.vy,false)else
movePlayer(P,0,0,false,1,0,false)movePlayer(P,0,0,false,-1,0,true)l.vx=0 end elseif I then
if y then l.vy=I;movePlayer(P,0,0,false,l.vx,I,false)elseif MTYPE==2 then
movePlayer(P,0,0,false,0,-1,false)movePlayer(P,0,0,false,0,1,true)l.vy=0 else l.vy=0 end else return false end;return true end
function eventNewPlayer(q)
playerData[q]={lastFunction={},newFunction={},append=false,ui=UI_DEFAULT,vx=0,vy=0,cntl={name=nil,obj=nil,off=nil}}
if UI_DEFAULT then
ui.addTextArea(104,'<TI><a href="event:help"><p align="center">Help</p></a>',q,5,25,40,22,nil,nil,nil,true)
ui.addTextArea(ERROR_TA,table.concat(_errors),q,805,5,200,590,nil,nil,0.5,true)end;for a,j in ipairs(playerKeys)do bindKey(q,j,true,true)
bindKey(q,j,false,true)end
system.bindMouse(q,true)do_respawn(q)end;function eventPlayerLeft(P)playerData[P]=nil end
function eventNewGame()
initTimers()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)tfm.exec.disableAutoScore(true)
tfm.exec.setGameTime(0)objectData={}groundData={}jointData={}
do_addGround(0,0,0,{type=13})end;function eventPlayerDied(S)do_respawn(S)end
function eventPlayerWon(q)do_respawn(q)end
function eventTextAreaCallback(U,I,Z)if not lsTextAreaCallback(U,I,Z)then
helpTextAreaCallback(U,I,Z)end end
function eventKeyboard(K,b,v)local u=playerData[K]
if movePlayer1(K,u,pk_vx[b],pk_vy[b],v)then return end;local a=u.cntl;local s=a.name
if s then local q=playerData[s]if
movePlayer1(s,q,pkc_vx[b],pkc_vy[b],v)then return end
if v then
if b==kc.kp7 then
t=tfm.get.room.playerList[s]
if t then local X;local o=math.random(16,32)local F,O;a.da=(a.da+10)%60;for X=a.da,359+
a.da,60 do F=math.rad(X)O=math.sin(F)F=math.cos(F)
addObject(a.obj,t.x+F*
a.off,t.y+O*a.off,X,o*F,o*O,false,10)end end elseif b==kc.kp5 then t=tfm.get.room.playerList[s]if t then local R,Y;R=t.x+
a.off*q.dir;Y=math.random(16,32)*q.dir
addObject(a.obj,R,t.y,0,Y,0,false,10)end end end end end
function eventLoop(o,Z)step(1,objectData,removeObject,nil,nop)if MTYPE==1 then
for H,K in
pairs(playerData)do if K.vx~=0 or K.vy~=0 then
movePlayer(H,0,0,false,K.vx,K.vy,false)end end end end
function clear()for T,V in ipairs(keys(tfm.get.room.objectList))do
do_removeObject(V)end end
function map1(b,t,G)local o=emptyMap(b,t,G)setMap(o)curMap=o end
for g,M in pairs(tfm.get.room.playerList)do eventNewPlayer(g)end;setMap(defaultMap)