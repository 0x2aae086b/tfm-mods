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
dump_func={['function']=function(...)return'&lt;function&gt;'end,['userdata']=function(...)return
'&lt;userdata&gt;'end,['thread']=function(...)return'&lt;thread&gt;'end,['nil']=function(...)return
'nil'end,['number']=function(Y,...)return tostring(Y)end,['boolean']=function(U,...)return
tostring(U)end,['string']=function(q,...)
for g,_ in
ipairs({{'&','&amp;'},{'<','&lt;'},{'>','&gt;'}})do q=string.gsub(q,_[1],_[2])end;return string.format('%q',q)end,['table']=function(b,l)if
l==nil then l=''end;local X={"{\n"}local h=l..' '
for H,D in pairs(b)do X[#X+1]=h..'['
X[#X+1]=dump_func[type(H)](H,h)X[#X+1]='] = 'X[#X+1]=dump_func[type(D)](D,h)X[
#X+1]=',\n'end;local Z=#X;if Z>1 then X[Z]='\n'end;X[#X+1]=l..'}'
return table.concat(X)end}function dump(t)return dump_func[type(t)](t)end
function split1(D,O,j,U)if
U==nil then U='%s'end;j=j-#U+2;local d=#D;if d<=j then
return{string.format(U,D)}end;local h={}local R=1;local n,E;local w,P=string.find(D,O)
while w~=nil do
if
w-R>j then if n~=nil and n>R then
h[#h+1]=string.format(U,string.sub(D,R,n-1))R=E+1 end
while w-R>j do h[#h+1]=string.format(U,string.sub(D,R,
R+j-1))R=R+j end end;n,E=w,P;w,P=string.find(D,O,P+1)
if w==nil and E<d then w,P=d,d end end;if R<d then
h[#h+1]=string.format(U,string.sub(D,R,d))end;return h end
function do_showLongString(D,d)
ui.addTextArea(D.id,D.pages[D.page],d,100,80,579,284,nil,nil,D.alpha,true)
ui.addTextArea(D.id+1,string.format('<a href="event:lsalpha%s"><p align="center"><font face="mono" size="15">%s</font></p></a>',d,D.title),d,100,50,400,22,
nil,nil,D.alpha,true)
ui.addTextArea(D.id+2,string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> %d/%d <a href="event:next">&gt;</a></font></p>',D.page,D.maxPage),d,508,50,148,22,
nil,nil,D.alpha,true)
ui.addTextArea(D.id+3,'<TI><a href="event:lsclose"><p align="center">X</p></a>',d,664,50,15,22,nil,nil,D.alpha,true)end
function showLongString(j,o,m,i)if i==nil then i=1 end
local g=split1(o,'\n',2000,'<font face="mono" size="15">%s</font>')local T=#g;ls={id=200,title=j,pages=g,page=1,alpha=i,maxPage=T}if playerData[m]==
nil then playerData[m]={}end
playerData[m].longString=ls;do_showLongString(ls,m)end
function updateLongString(I,w)
ui.updateTextArea(w.id,w.pages[w.page],I)
ui.updateTextArea(w.id+2,string.format('<p align="center"><font face="mono" size="15"><a href="event:prev">&lt;</a> %d/%d <a href="event:next">&gt;</a></font></p>',w.page,w.maxPage),I)end
function lsTextAreaCallback(T,R,A)
if A=='next'then local N=playerData[R].longString;local s=N.page;if
s<N.maxPage then N.page=s+1 end;updateLongString(R,N)elseif A=='prev'then
local t=playerData[R].longString;local g=t.page;if g>1 then t.page=g-1 end;updateLongString(R,t)elseif
A=='lsclose'then ui.removeTextArea(T-3,R)ui.removeTextArea(T-2,R)ui.removeTextArea(
T-1,R)ui.removeTextArea(T,R)playerData[R].longString=
nil elseif string.sub(A,1,7)=='lsalpha'then
local R=string.sub(A,8)local E=playerData[R].longString;E.alpha=1.0-E.alpha
do_showLongString(E,R)else return false end;return true end
function addObject(O,_,A,c,U,E,x,R,Q,v,y)local P=do_addObject(O,_,A,c,U,E,x)if R==nil then R=3 end
objectData[P]={time=R,callback=to_table(Q),on_remove=to_table(v),callback_args=y}return P end
function removeObject(O)do_removeObject(O)objectData[O]=nil end
function addGround(X,v,s,Z,r,t,B)local l=newId(groundId)do_addGround(l,X,v,s)
if Z==nil then Z=3 end
groundData[l]={time=Z,callback=to_table(r),on_remove=to_table(t),callback_args=B}return l end;function removeGround(Y)do_removeGround(Y)groundData[Y]=nil
freeId(groundId,Y)end
function addJoint(e,g,J,_,t,x,h)local i=newId(jointId)
do_addJoint(i,e,g,J)if _==nil then _=-1 end;if J==nil then J={}end
jointData[i]={time=_,callback=to_table(t),on_remove=to_table(x),callback_args=h}return i end
function removeJoint(W)do_removeJoint(W)jointData[W]=nil;freeId(jointId,W)end
function addExplosion(h,a,b,x,m,c,_)if c~=nil then addParticle(c,h,a,0,0,0,0)end
if _~=nil then end;do_addExplosion(h,a,b,x,m)end
function list_default(p,q,O)p[#p+1]=string.format('%d %d\n',q,O.time)end
function step(s,c,T,o,F)local i={}local D;local J,K;local R,S;if F==nil then F=list_default end
for R,S in pairs(c)do F(o,R,S)
if
S.time<=0 then
if S.on_remove then
for w,m in ipairs(S.on_remove)do J,K=pcall(m,R,S)if not J then
addError(string.format("step(%s): on_remove[%d]: %s\n",tbl_name(c),w,K))end end end;i[#i+1]=R else S.time=S.time-s
if S.callback then
for G,e in ipairs(S.callback)do J,K=pcall(e,R,S)if
not J then
addError(string.format("step(%s): callback[%d]: %s\n",tbl_name(c),G,K))i[#i+1]=R;break end end end end end;for R,S in ipairs(i)do T(S)end end
function emptyMap(j,U,N,y)local n,B=j/2.0,U/2.0;local K,a
local Q={string.format('<C><P G="0,0" L="%d" H="%d" /><Z><S>',j,U)}N=N or 256;y=y or N
for K=16,j,N do
for a=16,U,y do
Q[#Q+1]=string.format('<S o="%02x00%02x" L="16" Y="%d" c="4" P="0,0,0,0,0,0,0,0" T="13" X="%d" H="10" />',math.abs(
n-K)/n*255,math.abs(B-a)/B*255,a,K)end end;Q[#Q+1]='</S><D><DS X="200" Y="200" /></D><O /></Z></C>'return
table.concat(Q)end;defaultMap='90'UI_DEFAULT=false;MTYPE=0;curMap=defaultMap;playerData={}
objectData={}groundData={}jointData={}
function getfield(L,y)local a=_G
for D,p in string.gmatch(L,'([[.]?)([^][.]+)')do if
type(a)~='table'then
if y then error('Invalid field: '..L)else return nil end end
if D=='['then
p=do_parse_arg(p,nil)if p==nil then
if y then error('Invalid field: '..L)else return nil end end end;a=a[p]end;return a end
function do_parse_arg(M,J)
if M=='true'then return true elseif M=='false'then return false elseif M=='nil'then return nil elseif M=='{'then if J~=nil then
return parse_arg(J,M)else return nil end else local k=string.sub(M,1,1)
if
k=='"'or k=="'"then return unescape(string.sub(M,2,-2))else k=tonumber(M)if
k~=nil then return k else return getfield(M,true)end end end end
function do_parse_key(P)local u
while true do
if P=='true'then return true elseif P=='false'then return false else local u=string.sub(P,1,1)
if
u=='"'or u=="'"then return unescape(string.sub(P,2,-2))elseif
u=='['then P=string.sub(P,2,-2)else u=tonumber(P)if u~=nil then return u else
return unescape(P)end end end end end
function parse_arg(E,C)local l;local p,i;if C==nil then C=E()end
if C==nil then return nil,true elseif C=='{'then l={}C=E()
while
C~=nil and C~='}'do p,i=string.gmatch(C,'(.+)=(.+)')()
if p==nil then
l[#l+1]=do_parse_arg(C,E)else l[do_parse_key(p)]=do_parse_arg(i,E)end;C=E()end;return l,C==nil else return do_parse_arg(C),false end end
function call(L,P,u)local i={}local j=0;local K=string.gmatch(P,'[^%s]+')
local h,A=parse_arg(K)while not A do j=j+1;i[j]=h;h,A=parse_arg(K)end;if u then return{L,i,j}else return
L(unpack(i,j))end end;MODULE_HELP_START='Commands'
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
setMap(curMap)end,['map']=function(H,f,K)if K==''then K=defaultMap end;setMap(K)curMap=K end,['play']=function(A,_,Q)
MAPS=split(Q)CUR_MAP=1;setMap(MAPS[CUR_MAP])end,['init']=function()
defaultMap='0'curMap=defaultMap;playerData={}for s,K in pairs(tfm.get.room.playerList)do
eventNewPlayer(s)end;setMap(curMap)end,['dir']=function(P,B,n)
local v=''local g,k=pcall(getfield,n)
if g then if type(k)=='table'then
for U,l in pairs(k)do v=v..U..'\n'end;showLongString(n,v,P,0.8)else
alert(n..' is not a table',P)end else
alert(k,P)end end,['dump']=function(X,f,b)
local v,z=pcall(call,dump,b)
if v then showLongString(b,z,X,0.8)else alert(z,X)end end,['do']=function(A)
local d=playerData[A]d.append=true;d.newFunction={}end,['end']=function(r,H)
local c=playerData[r]
if H=='end'then c.append=false;c.lastFunction=c.newFunction end;local v,x;for q,t in pairs(c.lastFunction)do v,x=pcall(call,t[1],t[2])if not v then
alert(x,r)break end end end,['undo']=function(O)
local G=playerData[O]G.append=false;G.newFunction={}end}
MODULE_CHAT_COMMAND['redo']=MODULE_CHAT_COMMAND['end']
MODULE_CHAT_COMMAND['r']=MODULE_CHAT_COMMAND['reset']MODULE_CHAT_COMMAND['m']=MODULE_CHAT_COMMAND['map']
MODULE_CHAT_COMMAND_1=function(z,q,N)
local a=getfield(q)local H=playerData[z]
if type(a)=='function'then if H.append then
H.newFunction[#H.newFunction+1]={a,N}else H.lastFunction={{a,N}}local P,l=pcall(call,a,N)
if not P then alert(l,z)end end else alert(
'Invalid command: '..q,z)end end;system.disableChatCommandDisplay('s',true)
playerKeys={kc.w,kc.s,kc.a,kc.d,kc.space,kc.left,kc.right,kc.up,kc.down,kc.kp7,kc.kp8,kc.kp4,kc.kp5,kc.kp6,kc.kp1}
pk_vx={[kc.a]=-30,[kc.left]=-30,[kc.d]=30,[kc.right]=30}
pk_vy={[kc.space]=-30,[kc.w]=-30,[kc.up]=-30,[kc.s]=30,[kc.down]=30}pkc_vx={[kc.kp4]=-30,[kc.kp6]=30}
pkc_vy={[kc.kp8]=-30,[kc.kp2]=30}
function movePlayer1(j,I,y,q,a)if MTYPE==0 then return false end
if y then
if a then I.vx=y
if I.vx>0 then I.dir=1 else I.dir=-1 end;movePlayer(j,0,0,false,y,I.vy,false)else
movePlayer(j,0,0,false,1,0,false)movePlayer(j,0,0,false,-1,0,true)I.vx=0 end elseif q then
if a then I.vy=q;movePlayer(j,0,0,false,I.vx,q,false)elseif MTYPE==2 then
movePlayer(j,0,0,false,0,-1,false)movePlayer(j,0,0,false,0,1,true)I.vy=0 else I.vy=0 end else return false end;return true end
function eventNewPlayer(j)
playerData[j]={lastFunction={},newFunction={},append=false,ui=UI_DEFAULT,vx=0,vy=0,cntl={name=nil,obj=nil,off=nil}}
if UI_DEFAULT then
ui.addTextArea(104,'<TI><a href="event:help"><p align="center">Help</p></a>',j,5,25,40,22,nil,nil,nil,true)
ui.addTextArea(ERROR_TA,table.concat(_errors),j,805,5,200,590,nil,nil,0.5,true)end;for P,S in ipairs(playerKeys)do bindKey(j,S,true,true)
bindKey(j,S,false,true)end
system.bindMouse(j,true)if MAPS==nil then do_respawn(j)end end
function eventPlayerLeft(q)playerData[q]=nil;if MAPS then playerDied()end end
function eventNewGame()initTimers()tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)objectData={}groundData={}jointData={}
if MAPS==nil then
tfm.exec.disableAutoScore(true)tfm.exec.setGameTime(0)
do_addGround(0,0,0,{type=13})else PLAYERS=length(tfm.get.room.playerList)end end;function newMap()end;function playerDied()PLAYERS=PLAYERS-1;if PLAYERS<=0 then
tfm.exec.setGameTime(0)end end
function eventPlayerDied(U)if
MAPS==nil then do_respawn(U)else playerDied()end end;function eventPlayerWon(I)
if MAPS==nil then do_respawn(I)else playerDied()end end;function eventPlayerRespawn(Z)
if PLAYERS then PLAYERS=PLAYERS+1 end end
function eventTextAreaCallback(K,b,v)if
not lsTextAreaCallback(K,b,v)then helpTextAreaCallback(K,b,v)end end
function eventKeyboard(u,a,s)local q=playerData[u]
if movePlayer1(u,q,pk_vx[a],pk_vy[a],s)then return end;local K=q.cntl;local X=K.name
if X then local o=playerData[X]if
movePlayer1(X,o,pkc_vx[a],pkc_vy[a],s)then return end
if s then
if a==kc.kp7 then
t=tfm.get.room.playerList[X]
if t then local F;local O=math.random(16,32)local R,Y;K.da=(K.da+10)%60;for F=K.da,359+
K.da,60 do R=math.rad(F)Y=math.sin(R)R=math.cos(R)
addObject(K.obj,t.x+R*
K.off,t.y+Y*K.off,F,O*R,O*Y,false,10)end end elseif a==kc.kp5 then t=tfm.get.room.playerList[X]if t then local Z,H;Z=t.x+
K.off*o.dir;H=math.random(16,32)*o.dir
addObject(K.obj,Z,t.y,0,H,0,false,10)end end end end end
function eventLoop(K,T)step(1,objectData,removeObject,nil,nop)if MTYPE==1 then
for V,b in
pairs(playerData)do if b.vx~=0 or b.vy~=0 then
movePlayer(V,0,0,false,b.vx,b.vy,false)end end end
if
CUR_MAP and T<=0 then CUR_MAP=CUR_MAP+1;if MAPS[CUR_MAP]then setMap(MAPS[CUR_MAP])else
MAPS=nil;CUR_MAP=nil;setMap(curMap)end end end
function clear()for t,G in ipairs(keys(tfm.get.room.objectList))do
do_removeObject(G)end end
function map1(o,g,M)local O=emptyMap(o,g,M)setMap(O)curMap=O end
for x,i in pairs(tfm.get.room.playerList)do eventNewPlayer(x)end;setMap(defaultMap)