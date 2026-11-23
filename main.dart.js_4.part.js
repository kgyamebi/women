((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,B,C={
bc4(a1,a2){var w,v,u,t,s,r,q,p,o,n,m,l,k,j,i=null,h=A.W(A.P(a2),A.Q(a2),A.a_(a2)),g=a1.c,f=g?A.ea(a1,h):i,e=g?A.aQ9(a1):i,d=a1.cs(A.ad(h)),a0=A.aQA(d==null?i:d.x)
d=a1.cs(A.ad(h))
w=A.aQB(d==null?i:d.y)
v=A.aMh(a1,h)
u=A.aZf(a1)
t=A.a5J(a1,a2)
s=A.o9(a1,a2)
r=B.b.hx(u.b,i,new C.aKK())
d=f==null
q=d?"Waiting for a period date":"Cycle day "+f.a
if(d)d="Flo starts a cycle report when a new cycle is saved. EVA will write one after you save a period date. Nothing is estimated before that."
else{d=e.a
p=e.d
o=e.b?"That cycle length is inside 21\u201335 days.":"That cycle length is outside 21\u201335 days."
n=e.r?"The saved cycles differ by 7 days or less.":"REGULAR waits for two saved cycles within 7 days."
n="Length you saved: "+d+" days. Bleed you saved: "+p+" days. "+o+" "+n+" This is a calendar report, not a diagnosis."
d=n}p=a0.a==null?"No sleep saved":a0.gBX()+" \xb7 "+A.q(a0.b)
o=w.a
o=o==null?"No steps saved":A.q(o)+" steps"
n=u.a
m=n===0
n=m?"No symptoms saved":""+n+" saved"
m=m?"Log a symptom and the lists can be counted. EVA does not guess a condition.":"Longest educational overlap: "+r.a+", "+r.c.length+" of "+J.cE(r.b)+". A longer list is not a diagnosis."
l=s===0
k=l?"Streak has not started":"Day "+s+" \xb7 "+B.k.bB(t.ghi()*t.d,100)+" XP"
if(l)l="The count moves when you save something today. Day 3 and day 7 of each chapter open a badge. A missed day starts a new run, and the longest run stays. Game XP on this device is "+B.k.bB(t.ghi()*t.d,100)+"."
else{l=s===1?"":"s"
j=t.d
j="You have saved something "+s+" day"+l+" in a row. Chapter "+A.aMF(s).a+". Game XP is "+B.k.bB(t.ghi()*j,100)+" at "+t.gt6()+", level "+(1+B.k.bB(B.k.bB(t.ghi()*j,100),200))+". The badge is on this device. It is not a health grade."
l=j}return A.a([new C.mv("cycle-report","Cycle report",q,d,"What can you tell me about this cycle day?"),new C.mv("sleep","Sleep",p,a0.d,"How should I read the sleep hours I saved?"),new C.mv("steps","Steps",o,w.c,"What should a saved step count mean?"),new C.mv("chance","Chance",v.b,v.c,"How should I read a pregnancy chance on a calendar?"),new C.mv("overlap","Symptom overlap",n,m,"Does a symptom list mean I have a condition?"),new C.mv("streak","Streak",k,l,"What does my streak count mean?")],x.b)},
mv:function mv(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h},
aKK:function aKK(){},
Ak:function Ak(d){this.a=d},
GO:function GO(d,e){var _=this
_.d=d
_.e=e
_.c=_.a=null},
atl:function atl(d){this.a=d},
atn:function atn(d){this.a=d},
ato:function ato(d,e,f){this.a=d
this.b=e
this.c=f},
atm:function atm(d,e){this.a=d
this.b=e},
atp:function atp(d,e){this.a=d
this.b=e},
atq:function atq(d,e){this.a=d
this.b=e},
atr:function atr(d){this.a=d},
a29:function a29(d,e,f){this.c=d
this.d=e
this.a=f},
HL:function HL(d,e,f,g,h){var _=this
_.c=d
_.d=e
_.e=f
_.f=g
_.a=h},
XT:function XT(){this.d=1
this.c=this.a=null},
ayI:function ayI(d){this.a=d},
ayG:function ayG(d){this.a=d},
ayH:function ayH(d){this.a=d},
ayF:function ayF(d){this.a=d},
b2k(){return new C.B8(null)},
B8:function B8(d){this.a=d},
Wb:function Wb(d,e){var _=this
_.d=d
_.e=e
_.f=0
_.c=_.a=null},
avS:function avS(d){this.a=d},
avR:function avR(){},
avK:function avK(d){this.a=d},
avL:function avL(d,e,f){this.a=d
this.b=e
this.c=f},
avM:function avM(d){this.a=d},
avN:function avN(d,e,f){this.a=d
this.b=e
this.c=f},
avO:function avO(d,e){this.a=d
this.b=e},
avP:function avP(d,e){this.a=d
this.b=e},
avQ:function avQ(d){this.a=d},
RR:function RR(d,e,f,g,h){var _=this
_.bR=null
_.du=$
_.C=d
_.U=null
_.af=e
_.bE=null
_.E$=f
_.dy=g
_.b=_.fy=null
_.c=0
_.y=_.d=null
_.z=!0
_.Q=null
_.as=!1
_.at=null
_.ay=$
_.ch=h
_.CW=!1
_.cx=$
_.cy=!0
_.db=!1
_.dx=$},
Nm:function Nm(d,e){this.c=d
this.a=e}},D
J=c[1]
A=c[0]
B=c[2]
C=a.updateHolder(c[4],C)
D=c[7]
C.mv.prototype={}
C.Ak.prototype={
a6(){return new C.GO(new A.cQ(B.av,$.ag()),A.xl(null,!0,null,null))}}
C.GO.prototype={
l(){var w=this.d
w.L$=$.ag()
w.J$=0
this.e.l()
this.ar()},
yd(d){this.c.K(x.a).f.An(d)
this.d.fT(0,B.cS)
$.ab.ok$.push(new C.atl(this))},
B(a3){var w,v,u,t,s,r,q,p,o,n,m=this,l=null,k="Outfit",j=a3.K(x.a).f,i=A.C(a3).ax.a===B.p?B.w:B.v,h=C.bc4(j.d,j.c.$0()),g=j.d.dy,f=i.a?B.ia:D.JG,e=i.c,d=i.d,a0=x.u,a1=A.aS(A.a([A.ep(l,l,A.cI(B.rg,e,l,l),l,l,new C.atn(a3),l,l,"Back"),D.N9,B.cB,A.bp(A.a0(A.a([A.f("EVA",l,l,l,l,A.j(l,l,e,l,l,l,l,l,k,l,l,18,l,l,B.U,l,1.35,!0,l,0,l,l,l,l,l,l),l,l),A.f("Live on this device",l,l,l,l,A.j(l,l,d,l,l,l,l,l,k,l,l,12,l,l,B.f,l,1.35,!0,l,0,l,l,l,l,l,l),l,l)],a0),B.t,l,B.i,B.j),1)],a0),B.q,B.i,B.j,0),a2=A.a([],a0)
for(w=0;w<6;++w){v=h[w]
a2.push(new C.a29(v,new C.ato(m,a3,v),l))}d=A.a([A.cb(A.eq(a2,l,l,l,l,B.dE,!1,B.aO),96,l),B.l,A.f("The feed changes when you save. A heart is your like. There is no crowd and no borrowed count.",l,l,l,l,A.j(l,l,d,l,l,l,l,l,k,l,l,13,l,l,B.f,l,1.35,!0,l,0,l,l,l,l,l,l),l,l),B.G],a0)
for(w=0;w<6;++w){v=h[w]
d.push(new C.HL(v,B.b.m(j.d.cy,v.a),new C.atp(j,v),new C.atq(m,v),l))}a2=g.length
if(a2!==0){u=A.a([B.l,A.f("Thread",l,l,l,l,A.j(l,l,e,l,l,l,l,l,k,l,l,16,l,l,B.U,l,1.35,!0,l,0,l,l,l,l,l,l),l,l),B.l],a0)
for(t=i.w,s=i.as,w=0;w<a2;++w){r=g[w]
q=r.a==="you"
p=q?B.ee:B.aX
o=q?t:B.m
n=new A.aF(18,18)
q=q?s:e
u.push(new A.d5(p,l,l,A.bN(l,A.f(r.b,l,l,l,l,new A.o(!0,q,l,k,l,l,14,B.f,l,0,l,l,1.4,l,l,l,l,l,l,l,l,l,l,l,l,l),l,l),B.x,l,B.oA,new A.aP(o,l,l,new A.bW(n,n,n,n),l,l,B.K),l,l,l,B.ba,B.qq,l,l,l),l))}B.b.I(d,u)}d=A.bp(A.eq(d,m.e,l,B.bY,B.fS,l,l,B.aa),1)
a2=A.bg(24)
u=A.dQ(i.r,1)
e=A.j(l,l,e,l,l,l,l,l,k,l,l,15,l,l,B.f,l,1.35,!0,l,0,l,l,l,l,l,l)
t=i.e
return A.fQ(l,f,A.fc(!0,A.a0(A.a([new A.aj(D.MT,a1,l),d,new A.aj(D.qr,A.aS(A.a([A.bp(A.dV(A.dE(l,B.r,!1,l,!0,B.A,l,A.dN(),m.d,l,l,l,l,l,2,A.iS(l,B.c_,l,B.ev,l,l,l,l,!0,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,A.j(l,l,t,l,l,l,l,l,k,l,l,15,l,l,B.f,l,1.35,!0,l,0,l,l,l,l,l,l),"Message EVA",l,l,l,l,l,l,l,l,l,!0,!0,!1,l,l,l,l,l,l,l,l,l,l,l,l,l,l),B.z,!0,l,!0,l,!1,l,B.ao,l,l,l,l,l,l,l,l,l,4,1,l,!1,"\u2022",l,l,l,m.ga9A(),l,!1,l,l,!1,l,!0,l,B.M,l,l,l,l,l,l,l,l,l,l,l,e,!0,B.a6,l,B.aE,l,l,l,l),new A.aP(B.m,l,u,a2,l,l,B.K),B.al),1),B.aW,A.cm(l,D.a8l,B.z,!1,l,l,l,l,l,l,l,l,l,l,l,l,l,l,new C.atr(m),l,l,l)],a0),B.q,B.i,B.j,0),l),new A.aj(D.qr,A.f("Educational guidance. Not a doctor, not a diagnosis, not contraception.",l,l,l,l,A.j(l,l,t,l,l,l,l,l,k,l,l,11,l,l,B.f,l,1.35,!0,l,0,l,l,l,l,l,l),B.am,l),l)],a0),B.q,l,B.i,B.j),B.a3,!0))}}
C.a29.prototype={
B(d){var w=null,v=A.bN(w,D.Hy,B.x,w,w,new A.aP(w,w,A.dQ(B.cf,2),w,w,w,B.b2),w,62,w,w,B.qz,w,w,62)
return new A.aj(D.LU,A.cm(w,A.cb(A.a0(A.a([v,B.a8,A.f(this.c.b,1,B.ae,w,w,A.j(w,w,(A.C(d).ax.a===B.p?B.w:B.v).c,w,w,w,w,w,"Outfit",w,w,11,w,w,B.E,w,1.35,!0,w,0,w,w,w,w,w,w),w,w)],x.u),B.q,w,B.i,B.j),w,72),B.z,!1,w,w,w,w,w,w,w,w,w,w,w,w,w,w,this.d,w,w,w),w)}}
C.HL.prototype={
a6(){return new C.XT()},
azx(){return this.e.$0()}}
C.XT.prototype={
B(d){var w,v,u=this,t=null,s="Outfit",r=A.C(d).ax.a===B.p?B.w:B.v,q=A.bg(24),p=A.dQ(r.r,1),o=r.c,n=x.u,m=A.aS(A.a([D.qI,B.cB,A.bp(A.a0(A.a([A.f("EVA",t,t,t,t,A.j(t,t,o,t,t,t,t,t,s,t,t,14,t,t,B.U,t,1.35,!0,t,0,t,t,t,t,t,t),t,t),A.f(u.a.c.b,t,t,t,t,A.j(t,t,r.d,t,t,t,t,t,s,t,t,12,t,t,B.f,t,1.35,!0,t,0,t,t,t,t,t,t),t,t)],n),B.t,t,B.i,B.j),1)],n),B.q,B.i,B.j,0),l=A.f(u.a.c.c,t,t,t,t,A.j(t,t,o,t,t,t,t,t,s,t,t,18,t,t,B.U,t,1.35,!0,t,0,t,t,t,t,t,t),t,t),k=A.f(u.a.c.d,t,t,t,t,A.j(t,t,o,t,t,t,t,t,s,t,t,14,t,t,B.f,t,1.4,!0,t,0,t,t,t,t,t,t),t,t),j=u.d
j=A.cm(t,A.uf(A.cI(u.a.d?B.rm:B.rl,B.cf,t,t),j),B.z,!1,t,t,t,t,t,t,t,t,t,t,t,t,t,t,new C.ayI(u),t,t,t)
w=u.a.d?"1":"Like"
w=A.f(w,t,t,t,t,A.j(t,t,o,t,t,t,t,t,s,t,t,13,t,t,B.C,t,1.35,!0,t,0,t,t,t,t,t,t),t,t)
v=u.a.f
return new A.aj(B.ix,A.dV(new A.aj(D.Mc,A.a0(A.a([m,B.a5,l,B.a_,k,B.l,A.aS(A.a([j,B.hE,w,D.a8g,A.cm(t,A.aS(A.a([A.cI(B.rj,o,t,20),B.hE,A.f("Reply",t,t,t,t,A.j(t,t,o,t,t,t,t,t,s,t,t,13,t,t,B.C,t,1.35,!0,t,0,t,t,t,t,t,t),t,t)],n),B.q,B.i,B.j,0),B.z,!1,t,t,t,t,t,t,t,t,t,t,t,t,t,t,v,t,t,t)],n),B.q,B.i,B.j,0)],n),B.t,t,B.i,B.j),t),new A.aP(B.m,t,p,q,t,t,B.K),B.al),t)}}
C.B8.prototype={
a6(){return new C.Wb(new A.cQ(B.av,$.ag()),A.xl(null,!0,null,null))}}
C.Wb.prototype={
aA(){this.aO()
this.d.a9(0,new C.avS(this))},
b8(){var w,v
this.cl()
w=this.c.K(x.a).f
v=w.as
w.as=null
if(v!=null&&v.length!==0){w=this.d
w.shd(0,v)
w.sqn(A.m2(B.u,v.length))}},
l(){var w=this.d
w.L$=$.ag()
w.J$=0
this.e.l()
this.ar()},
B(a7){var w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0=this,a1=null,a2="Outfit",a3=a7.K(x.a).f,a4=A.C(a7).ax.a===B.p?B.w:B.v,a5=a3.d.dy,a6=a5.length
if(a6!==a0.f){a0.f=a6
$.ab.ok$.push(new C.avK(a0))}w=x.u
v=A.a([],w)
if(a6===0){a6=A.a([],w)
for(u=0;u<4;++u){t=D.Tj[u]
a6.push(new A.aW(t,!1,new C.avL(a0,a7,t),a1))}a6=A.bM(B.N,a6,B.R,8,8)
s=a4.a
r=s?B.ig:B.m
q=a4.c
p=a4.d
r=A.a([a6,B.l,A.eg(!1,B.Q,!0,A.bg(18),A.lx(!1,a1,a1,a1,!0,a1,a1,a1,!0,a1,a1,D.Nh,a1,a1,a1,a1,new C.avM(a7),!1,a1,a1,new A.dn(A.bg(18),B.J),a1,a1,a1,a1,A.f("EVA assistant",a1,a1,a1,a1,A.j(a1,a1,q,a1,a1,a1,a1,a1,a2,a1,a1,16,a1,a1,B.U,a1,1.35,!0,a1,0,a1,a1,a1,a1,a1,a1),a1,a1),A.cI(B.dp,p,a1,a1),a1),B.x,r,0,a1,a1,a1,a1,a1,B.aH),B.T,A.aS(A.a([D.Nk,B.cB,A.bp(A.f("Guided chats",a1,a1,a1,a1,A.j(a1,a1,q,a1,a1,a1,a1,a1,a2,a1,a1,20,a1,a1,B.U,a1,1.35,!0,a1,0,a1,a1,a1,a1,a1,a1),a1,a1),1)],w),B.q,B.i,B.j,0),B.a5],w)
for(u=0;u<7;++u){o=D.UL[u]
a6=s?B.ig:B.m
n=new A.aF(18,18)
m=new A.aF(18,18)
r.push(new A.aj(B.ba,new A.lA(A.lx(!1,a1,a1,a1,!0,a1,a1,a1,!0,a1,a1,D.qI,a1,a1,a1,a1,new C.avN(a0,a7,o),!1,a1,a1,new A.dn(new A.bW(m,m,m,m),B.J),a1,a1,a1,a1,A.f(o.a,a1,a1,a1,a1,new A.o(!0,q,a1,a2,a1,a1,16,B.C,a1,0,a1,a1,1.35,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1),a1,a1),A.cI(B.dp,p,a1,a1),a1),B.aH,!1,0,a6,a1,a1,a1,a1,!0,B.x,B.Q,new A.bW(n,n,n,n),a1),a1))}B.b.I(v,r)}else for(s=a4.c,r=a4.r,q=a4.f,p=a6-1,n=a4.w,m=a4.as,l=0;l<a6;++l){k=a5[l]
j=!1
if(l===p)if(k.a!=="you")j=A.iF(k.b,"An app is not the emergency service",0)
i=k.a==="you"
h=i?n:q
g=new A.aF(22,22)
f=new A.bl(i?B.B:r,1,B.P,-1)
e=i?m:s
d=A.bN(a1,A.f(k.b,a1,a1,a1,a1,new A.o(!0,e,a1,a2,a1,a1,15.5,B.f,a1,0,a1,a1,1.45,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1),a1,a1),B.x,a1,B.kv,new A.aP(h,a1,new A.ds(f,f,f,f),new A.bW(g,g,g,g),a1,a1,B.K),a1,a1,a1,B.dn,B.ev,a1,a1,a1)
k=i?B.ee:B.aX
v.push(new A.d5(k,a1,a1,j?A.by(a1,a1,d,!1,a1,a1,a1,!1,a1,a1,a1,a1,a1,a1,a1,a1,!0,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,B.I,a1):d,a1))}a6=A.bp(A.eq(v,a0.e,a1,B.bY,a1,a1,a1,B.aa),1)
v=a0.d
s=a4.c
r=A.j(a1,a1,s,a1,a1,a1,a1,a1,a2,a1,a1,15,a1,a1,B.f,a1,1.35,!0,a1,0,a1,a1,a1,a1,a1,a1)
r=A.bp(new A.bS(A.dE(a1,B.r,!1,a1,!0,B.A,a1,A.dN(),v,a1,a1,a1,a1,a1,2,A.iS(a1,B.c_,a1,a1,a1,a1,a1,a1,!0,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,A.j(a1,a1,a4.e,a1,a1,a1,a1,a1,a2,a1,a1,15,a1,a1,B.f,a1,1.35,!0,a1,0,a1,a1,a1,a1,a1,a1),"Ask EVA",a1,a1,a1,a1,a1,a1,a1,a1,a1,!0,!0,!1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1),B.z,!0,a1,!0,a1,!1,a1,B.ao,a1,a1,a1,a1,a1,a1,a1,a1,a1,4,1,a1,!1,"\u2022",a1,a1,a1,new C.avO(a0,a7),a1,!1,a1,a1,!1,a1,!0,a1,B.M,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,a1,r,!0,B.a6,a1,B.aE,a1,a1,a1,a1),B.ly,22,a1,a1,a1),1)
return A.fQ(a1,B.B,A.fc(!1,A.cs(new A.dg(B.hV,new A.aj(D.Mm,A.a0(A.a([a6,B.a5,A.aS(A.a([r,B.aW,new A.aV("Send",B.c.aY(v.a.a).length===0?a1:new C.avP(a0,a7),!0,a1)],w),B.q,B.i,B.j,0),B.l,A.cP(A.f("If this is urgent",a1,a1,a1,a1,A.j(a1,a1,s,a1,a1,a1,a1,a1,a2,a1,a1,14,a1,a1,B.C,a1,1.35,!0,a1,0,a1,a1,a1,a1,a1,a1),a1,a1),new C.avQ(a7),a1)],w),B.q,a1,B.i,B.j),a1),a1),a1,a1),B.a3,!0))},
yp(d,e){if(B.c.aY(e).length===0)return
d.K(x.a).f.An(e)
this.d.fT(0,B.cS)}}
C.RR.prototype={
gqF(){var w=this.gt(0)
return new A.F(0,0,0+w.a,0+w.b)},
cr(d,e){var w,v
this.iZ()
w=this.U
v=w.gb2()
if(new A.h((e.a-v.a)/(w.c-w.a),(e.b-v.b)/(w.d-w.b)).grw()>0.25)return!1
return this.kx(d,e)},
aE(d,e){var w,v,u,t=this,s=null,r=t.E$
if(r!=null)if(t.af!==B.x){t.iZ()
r=t.cx
r===$&&A.b()
w=t.U
if(!w.j(0,t.bR)){t.bR=w
v=new A.bO($.a7().r,B.X,s,s,A.a([],x.h))
u=t.bR
u.toString
v.ap(new A.l2(u))
t.du=v}v=t.du
v===$&&A.b()
u=t.ch
u.saB(0,d.CN(r,e,w,v,A.fb.prototype.geB.call(t),t.af,x.s.a(u.a)))}else{d.dl(r,e)
t.ch.saB(0,s)}else t.ch.saB(0,s)}}
C.Nm.prototype={
aK(d){var w=new C.RR(null,B.ce,null,new A.aZ(),A.at())
w.aI()
w.sb0(null)
return w},
aN(d,e){e.sno(null)
e.sj7(B.ce)},
w0(d){d.sno(null)}}
var z=a.updateTypes(["~(m)"])
C.aKK.prototype={
$2(d,e){if(d==null||e.c.length>d.c.length)return e
return d},
$S:654}
C.atl.prototype={
$1(d){var w,v=this.a
if(v.c==null||v.e.f.length===0)return
v=v.e
w=B.b.gcA(v.f).Q
w.toString
v.iy(w,B.aY,B.cH)},
$S:3}
C.atn.prototype={
$0(){return A.bs(this.a,!1).d9()},
$S:0}
C.ato.prototype={
$0(){var w=this.c
return A.cw(this.b,w.d,new A.aV("Ask about this",new C.atm(this.a,w),!0,null),w.c)},
$S:0}
C.atm.prototype={
$0(){return this.a.yd(this.b.e)},
$S:0}
C.atp.prototype={
$0(){var w=this.a,v=this.b.a,u=A.J(w.d.cy,x.w)
if(B.b.m(u,v))B.b.H(u,v)
else u.push(v)
w.d=w.d.ask(u)
w.b5()
return null},
$S:0}
C.atq.prototype={
$0(){return this.a.yd(this.b.e)},
$S:0}
C.atr.prototype={
$0(){var w=this.a
return w.yd(w.d.a.a)},
$S:0}
C.ayI.prototype={
$0(){var w=this.a
w.R(new C.ayG(w))
w.a.azx()
A.P3(B.lp,new C.ayH(w),x.v)},
$S:0}
C.ayG.prototype={
$0(){return this.a.d=1.25},
$S:0}
C.ayH.prototype={
$0(){var w=this.a
if(w.c!=null)w.R(new C.ayF(w))},
$S:42}
C.ayF.prototype={
$0(){return this.a.d=1},
$S:0}
C.avS.prototype={
$0(){var w=this.a
if(w.c!=null)w.R(new C.avR())},
$S:0}
C.avR.prototype={
$0(){},
$S:0}
C.avK.prototype={
$1(d){var w,v=this.a
if(v.c==null||v.e.f.length===0)return
v=v.e
w=B.b.gcA(v.f).Q
w.toString
v.iy(w,B.aY,B.cH)},
$S:3}
C.avL.prototype={
$0(){return this.a.yp(this.b,this.c)},
$S:0}
C.avM.prototype={
$0(){return A.bs(this.a,!1).ct(A.dH(D.ES,x.m))},
$S:0}
C.avN.prototype={
$0(){return this.a.yp(this.b,this.c.b)},
$S:0}
C.avO.prototype={
$1(d){return this.a.yp(this.b,d)},
$S:6}
C.avP.prototype={
$0(){var w=this.a
return w.yp(this.b,w.d.a.a)},
$S:0}
C.avQ.prototype={
$0(){return A.cw(this.a,"If this is an emergency, call local emergency services. In the US or Canada, call or text 988. Outside the US and Canada, use a local crisis line. A directory of local lines is at findahelpline.com. This app is not the emergency service.",null,"If this is urgent")},
$S:0};(function installTearOffs(){var w=a._instance_1u
w(C.GO.prototype,"ga9A","yd",0)})();(function inheritance(){var w=a.inherit,v=a.inheritMany
w(C.mv,A.X)
w(C.aKK,A.vF)
v(A.R,[C.Ak,C.HL,C.B8])
v(A.Z,[C.GO,C.XT,C.Wb])
v(A.jm,[C.atl,C.avK,C.avO])
v(A.oo,[C.atn,C.ato,C.atm,C.atp,C.atq,C.atr,C.ayI,C.ayG,C.ayH,C.ayF,C.avS,C.avR,C.avL,C.avM,C.avN,C.avP,C.avQ])
w(C.a29,A.Y)
w(C.RR,A.uK)
w(C.Nm,A.bn)})()
A.a3G(b.typeUniverse,JSON.parse('{"Ak":{"R":[],"e":[]},"HL":{"R":[],"e":[]},"GO":{"Z":["Ak"]},"a29":{"Y":[],"e":[]},"XT":{"Z":["HL"]},"B8":{"R":[],"e":[]},"Wb":{"Z":["B8"]},"RR":{"G":[],"aY":["G"],"y":[],"az":[]},"Nm":{"bn":[],"aE":[],"e":[]}}'))
var y={a:"Why do I always get headaches before my period?"}
var x={a:A.ai("mK"),b:A.ai("x<mv>"),h:A.ai("x<dl>"),u:A.ai("x<e>"),w:A.ai("m"),m:A.ai("@"),s:A.ai("vA?"),v:A.ai("~")};(function constants(){var w=a.makeConstList
D.ES=new C.Ak(null)
D.Ne=new A.f5(54,B.cI,!0,null,null)
D.Hy=new C.Nm(D.Ne,null)
D.JG=new A.n(1,0.9647058823529412,0.9568627450980393,0.9647058823529412,B.h)
D.LU=new A.a9(0,0,12,0)
D.Mc=new A.a9(14,14,14,10)
D.qr=new A.a9(16,0,16,8)
D.Mm=new A.a9(16,6,16,8)
D.MT=new A.a9(8,4,16,0)
D.qI=new A.f5(40,B.ew,!0,null,null)
D.N9=new A.f5(42,B.ew,!0,null,null)
D.Nh=new A.f5(40,B.cI,!0,null,null)
D.Nk=new A.f5(64,B.ew,!1,"listening clear",null)
D.Tj=w([y.a,"Can PCOS cause weight gain?","What does this blood test mean?","What does this discharge color indicate?"],A.ai("x<m>"))
D.a2k=new A.K("Luteal phase","What is a luteal phase?")
D.a3I=new A.K("Cramps",y.a)
D.a3B=new A.K("Mental health","I feel low today")
D.a2x=new A.K("PMS or not","What is PMS?")
D.a4e=new A.K("Sex check-in","How should I read a sex note I logged?")
D.a2h=new A.K("Acne","Can cycle changes show up on skin?")
D.a3v=new A.K("Discharge","What does this discharge color indicate?")
D.UL=w([D.a2k,D.a3I,D.a3B,D.a2x,D.a4e,D.a2h,D.a3v],A.ai("x<+(m,m)>"))
D.a8g=new A.cg(16,null,null,null)
D.Ph=new A.ba(983367,"MaterialIcons",!0)
D.PT=new A.ce(D.Ph,20,B.m,null,null)
D.L7=new A.iI(B.oC,B.al,D.PT,null)
D.a8l=new A.cg(48,48,D.L7,null)})()};
(a=>{a["UcCDXOrXztNaE9/s/+4SQ2RwuPI="]=a.current})($__dart_deferred_initializers__);