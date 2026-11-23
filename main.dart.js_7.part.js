((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,E,F,B={qG:function qG(d,e,f){this.c=d
this.d=e
this.a=f},
pp(d){if(d<0.22)return"Quiet"
if(d<0.42)return"Low"
if(d<0.62)return"Steady"
if(d<0.8)return"Rising"
return"High"},
b2V(a3,a4){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2=a3.d
if(a2<15)a2=28
x=C.i.b1(a4,1,a2)
w=A.aE0(x,a2,C.i.b1(a3.e,2,8))
v=A.aPM(x,a2)
if(w===C.aX)u=0.84
else u=w===C.bW?0.24:0.46
A:{t=C.bW!==w
if(!t||C.bv===w){s=0.82
break A}if(C.f7===w||C.f8===w){s=0.58
break A}if(C.bu===w||C.aX===w){s=0.34
break A}s=null}r=C.d.b1(0.5+A.aD7(w),0,1)
q=A.JG(w)
B:{if("High"===q){p=0.28
break B}if("Moderate"===q){p=0.5
break B}p=0.78
break B}C:{if(!t||C.bv===w){t=0.8
break C}if(C.f7===w||C.f8===w){t=0.62
break C}if(C.bu===w){t=0.36
break C}if(C.aX===w){t=0.4
break C}t=null}o=A.z(y.w,y.e)
n=a3.c
if(n)for(m=a3.dx,l=m.length,k=0;k<l;++k){j=m[k]
i=A.dv(j.a)
if(i==null||A.dR(a3,i).c!==w)continue
for(h=j.f,g=h.length,f=0;f<h.length;h.length===g||(0,A.v)(h),++f){e=h[f]
d=o.h(0,e)
o.n(0,e,(d==null?0:d)+1)}}a0=n?"These are textbook words, not your hormone levels.":"No period date is saved. These are textbook words, not your hormone levels."
if(o.a!==0){n=o.$ti.i("cC<1,2>")
a1=A.J(new A.cC(o,n),n.i("q.E"))
C.b.d8(a1,new B.aCF())
n=C.b.gM(a1)
m=C.b.gM(a1)
l=C.b.gM(a1).b===1?"time":"times"
a0=a0+" In this phase you have logged "+n.a+" "+m.b+" "+l+". That is a pattern, not a diagnosis."}n=new B.aCG()
m=v.a
l=v.b
h=v.c
g=v.d
d=y.B
return new B.ami(x,w,A.a([n.$3("Estrogen",B.pp(m),m),n.$3("Progesterone",B.pp(l),l),n.$3("Testosterone",B.pp(h),h),n.$3("Cortisol",B.pp(g),g)],d),A.a([n.$3("Cravings",B.pp(u),u),n.$3("Mood",B.pp(s),s),n.$3("Energy",B.pp(r),r),n.$3("Sleep quality",B.pp(p),p),n.$3("Recovery",B.pp(t),t)],d),a0)},
aCF:function aCF(){},
aCG:function aCG(){},
ws:function ws(d,e,f){this.a=d
this.b=e
this.c=f},
ami:function ami(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.d=f
_.e=g
_.f=h},
aZI(){return new B.Eq(null)},
Eq:function Eq(d){this.a=d},
a04:function a04(){this.c=this.a=this.d=null},
aAq:function aAq(d){this.a=d},
aAp:function aAp(d,e){this.a=d
this.b=e},
aAo:function aAo(d,e){this.a=d
this.b=e},
OX:function OX(){},
VY:function VY(d,e,f,g,h,i,j,k,l,m){var _=this
_.b=d
_.c=e
_.d=f
_.e=g
_.f=h
_.r=i
_.w=j
_.x=k
_.y=l
_.a=m},
au7:function au7(d,e,f){this.a=d
this.b=e
this.c=f},
au8:function au8(d,e,f){this.a=d
this.b=e
this.c=f},
au9:function au9(){},
B0:function B0(d,e,f,g,h,i,j,k){var _=this
_.y=d
_.c=e
_.d=f
_.e=g
_.f=h
_.r=i
_.w=j
_.a=k},
VZ:function VZ(d,e){var _=this
_.d=$
_.dN$=d
_.bh$=e
_.c=_.a=null},
aua:function aua(d,e){this.a=d
this.b=e},
au5:function au5(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
_.ch=d
_.CW=$
_.a=e
_.b=f
_.c=g
_.d=h
_.e=i
_.f=j
_.r=k
_.w=l
_.x=m
_.y=n
_.z=o
_.Q=p
_.as=q
_.at=r
_.ax=s
_.ay=t},
au6:function au6(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
_.ch=d
_.CW=$
_.a=e
_.b=f
_.c=g
_.d=h
_.e=i
_.f=j
_.r=k
_.w=l
_.x=m
_.y=n
_.z=o
_.Q=p
_.as=q
_.at=r
_.ax=s
_.ay=t},
J4:function J4(){},
aXP(d){var x
d.K(y.o)
x=A.K(d)
return x.aY}},D
J=c[1]
A=c[0]
C=c[2]
E=c[8]
F=c[10]
B=a.updateHolder(c[5],B)
D=c[11]
B.qG.prototype={
F(d){var x=null,w=A.c6(x,x,C.x,x,x,new A.aW(this.c,x,x,x,x,x,C.aV),x,8,x,x,x,x,8)
return A.bb(A.a([w,C.mM,A.k(this.d,x,x,x,x,A.l(x,x,(A.K(d).ax.a===C.p?C.t:C.u).d,x,x,x,x,x,"Outfit",x,x,12,x,x,C.e,x,1.35,!0,x,0,x,x,x,x,x,x),x,x)],y.u),C.v,C.j,C.bF,0)}}
B.ws.prototype={}
B.ami.prototype={}
B.Eq.prototype={
a9(){return new B.a04()}}
B.a04.prototype={
F(d){var x,w,v,u,t,s,r,q=this,p=null,o="Fraunces",n="Outfit",m=d.K(y.a).f,l=A.K(d).ax.a===C.p?C.t:C.u,k=A.ff(m.d,m.c.$0()).Q,j=m.d,i=j.r||j.x==="menopause",h=j.c||i,g=q.d
if(g==null)g=h?k.a:1
x=B.b2V(j,g)
j=l.c
w=y.u
v=A.bb(A.a([A.bJ(A.k("A sketch of a cycle",p,p,p,p,A.l(p,p,j,p,p,p,p,p,o,p,p,30,p,p,C.w,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),1),C.aS,F.pi],w),C.v,C.j,C.k,0)
u=A.aPL(k.b)
t=h?k.a-1:-1
s=q.d==null?p:g-1
u=A.ae(A.a([A.aKC(!1,240,i?p:new B.aAq(q),s,u,t),C.l,A.k("Not a blood test.",p,p,p,p,A.l(p,p,j,p,p,p,p,p,n,p,p,14,p,p,C.A,p,1.35,!0,p,0,p,p,p,p,p,p),p,p),C.l,A.bD(A.a([new B.qG(l.w,"Estrogen",p),new B.qG(l.y,"Progesterone",p),new B.qG(l.Q,"Testosterone",p),new B.qG(l.z,"Cortisol",p)],w),C.I,6,14)],w),C.r,C.j,C.k)
t=!h
if(t&&q.d==null)s="Not enough information yet"
else{s=x.b
r=""+x.a
s=h?"Textbook day "+r+" \xb7 "+A.tI(s):"Textbook day "+r+" \xb7 "+A.tI(s)}r=l.d
j=A.a([D.Kv,C.a2,v,C.L,new A.bO(u,C.ad,28,p,p,p),C.aq,A.k(s,p,p,p,p,A.l(p,p,j,p,p,p,p,p,o,p,p,28,p,p,C.w,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),C.l,A.k(x.f,p,p,p,p,A.l(p,p,r,p,p,p,p,p,n,p,p,14.5,p,p,C.e,p,1.4,!0,p,0,p,p,p,p,p,p),p,p)],w)
if(!t||q.d!=null)C.b.I(j,A.a([C.aq,q.Q4(x.d),C.L,A.k("Typical associations",p,p,p,p,A.l(p,p,r,p,p,p,p,p,n,p,p,13,p,p,C.A,p,1.35,!0,p,0.5,p,p,p,p,p,p),p,p),C.l,q.Q4(x.e)],w))
j.push(C.L)
j.push(A.k("Educational model. Not a diagnosis, a lab, or a reason to start or stop medication.",p,p,p,p,A.l(p,p,l.e,p,p,p,p,p,n,p,p,12.5,p,p,C.e,p,1.4,!0,p,0,p,p,p,p,p,p),p,p))
return A.hp(C.D,A.ho(!1,A.fX(A.a([A.dn(new A.dI(D.DQ,A.ae(j,C.r,C.j,C.k),p),p,p)],w),p,p,E.i_,C.af),C.al,!0))},
Q4(d){var x=this.c
x.toString
return A.aG3(new B.aAo(d,A.K(x).ax.a===C.p?C.t:C.u))}}
B.OX.prototype={}
B.VY.prototype={
aC(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=this,l=m.y
if(l==null)l=0
x=new B.au7(m,e,d)
w=new B.au9()
v=l/e.a
u=m.d
t=u==null?null:A.A(u,0,1)
if(t!=null){s=v>0?t+w.$2(t,v):0
if(s<1)x.$3$color$endFraction$startFraction(m.b,1,s)
w=m.x
if(w!=null&&w>0)new B.au8(m,e,d).$0()
if(t>0)x.$3$color$endFraction$startFraction(m.c,t,0)
return}u=m.e
r=D.LW.ah(0,u)
q=D.LO.ah(0,u)
p=D.LN.ah(0,u)
o=D.LM.ah(0,u)
if(r<1-v){s=r>0?r+w.$2(r,v):0
x.$3$color$endFraction$startFraction(m.b,1,s)}if(r-q>0)x.$3$color$endFraction$startFraction(m.c,r,q)
if(q>v){s=p>0?p+w.$2(p,v):0
n=q<1?q-w.$2(1-q,v):1
x.$3$color$endFraction$startFraction(m.b,n,s)}if(p-o>0)x.$3$color$endFraction$startFraction(m.c,p,o)
if(o>v){n=o<1?o-w.$2(1-o,v):1
x.$3$color$endFraction$startFraction(m.b,n,0)}},
di(d){var x=this
return!d.b.j(0,x.b)||!d.c.j(0,x.c)||d.d!=x.d||d.e!==x.e||d.f!==x.f||!J.d(d.r,x.r)||!J.d(d.w,x.w)||d.x!=x.x||d.y!=x.y}}
B.B0.prototype={
a9(){return new B.VZ(null,null)}}
B.VZ.prototype={
aI(){var x,w=this
w.aV()
x=A.c9(null,D.IT,null,null,w)
w.d!==$&&A.bc()
w.d=x
w.SW()},
b_(d){this.bk(d)
this.SW()},
l(){var x=this.d
x===$&&A.b()
x.l()
this.a3I()},
gF9(){var x,w=this
w.a.toString
w.c.BD(y.o)
w.c.I1(y.C)
x=w.d
x===$&&A.b()
return x},
SW(){var x,w=this,v=w.a.c
A.A(v,0,1)
x=!1
if(x){v=w.d
v===$&&A.b()
v.Jw(0)}else{A.A(v,0,1)
v=w.d
v===$&&A.b()
v=v.r
v=v!=null&&v.a!=null
if(v){v=w.d
v===$&&A.b()
v.f6(0)}}},
MH(d,e,f){var x,w,v,u,t,s,r,q,p=this,o=null,n=B.aXP(d)
p.a.toString
A.K(d)
switch(!0){case!0:x=new B.au6(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
case!1:x=new B.au5(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
default:x=o}w=p.a
w.toString
w=w.d
v=w==null?n.b:w
if(v==null)v=x.gqU()
u=p.a.y
t=n.f
if(t==null)t=x.f
w=p.a
w.toString
x.gdJ(x)
x=p.a
s=x.c
r=A.A(s,0,1)
w=A.fh(o,o,o,new B.VY(v,w.e,r,e,f,t,o,o,o,o),C.K)
if(t!=null)A.A(s,0,1)
q=x.w
s=A.A(s,0,1)
q=""+C.d.aE(s*100)
x=x.r
return A.c_(o,new A.dI(new A.al(1/0,1/0,u,1/0),w,o),!1,o,o,!1,o,o,o,o,o,o,x,o,o,"100",o,"0",o,o,o,o,o,o,o,o,o,o,o,C.a12,o,o,o,o,o,o,o,o,q)},
F(d){var x,w=this,v=d.K(y.n).w
A.A(w.a.c,0,1)
x=w.gF9().x
x===$&&A.b()
return w.MH(d,x,v)
return A.ia(w.gF9(),new B.aua(w,v),null)}}
B.au5.prototype={
gtI(){var x,w=this,v=w.CW
if(v===$){x=A.K(w.ch)
w.CW!==$&&A.aR()
v=w.CW=x.ax}return v},
gdJ(d){return this.gtI().b},
gqU(){var x=this.gtI(),w=x.aw
return w==null?x.k2:w},
gv1(){return 4}}
B.au6.prototype={
gtI(){var x,w=this,v=w.CW
if(v===$){x=A.K(w.ch)
w.CW!==$&&A.aR()
v=w.CW=x.ax}return v},
gdJ(d){return this.gtI().b},
gqU(){var x=this.gtI(),w=x.Q
return w==null?x.y:w},
gv1(){return 4}}
B.J4.prototype={
l(){var x=this,w=x.bh$
if(w!=null)w.O(0,x.gfd())
x.bh$=null
x.aA()},
bE(){this.cm()
this.cc()
this.fe()}}
var z=a.updateTypes(["ws(m,m,y)"])
B.aCF.prototype={
$2(d,e){return C.i.b4(e.b,d.b)},
$S:40}
B.aCG.prototype={
$3(d,e,f){return new B.ws(d,"Sketch \xb7 "+e,f)},
$S:z+0}
B.aAq.prototype={
$1(d){var x=this.a
return x.V(new B.aAp(x,d))},
$S:25}
B.aAp.prototype={
$0(){return this.a.d=this.b+1},
$S:0}
B.aAo.prototype={
$2(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=null,l=e.b,k=l>640?4:2,j=(l-(k-1)*10)/k
l=y.u
x=A.a([],l)
for(w=this.a,v=w.length,u=this.b,t=u.r,s=u.w,r=u.c,u=u.d,q=0;q<w.length;w.length===v||(0,A.v)(w),++q){p=w[q]
o=A.k(p.a,m,m,m,m,new A.o(!0,u,m,"Outfit",m,m,12,C.e,m,0,m,m,1.35,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m)
n=new A.aK(99,99)
x.push(new A.ch(j,m,new A.bO(A.ae(A.a([o,C.U,A.k(p.b,m,m,m,m,new A.o(!0,r,m,"Fraunces",m,m,22,C.w,m,-0.7,m,m,1.05,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m),C.l,new A.z9(new A.c8(n,n,n,n),new B.B0(4,C.d.b1(p.c,0,1),t,s,m,m,m,m),m)],l),C.r,C.j,C.k),C.kN,20,m,m,m),m))}return A.bD(x,C.I,10,10)},
$S:600}
B.au7.prototype={
$3$color$endFraction$startFraction(d,e,f){var x,w,v,u,t,s,r,q,p
if(e-f<=0)return
x=this.a
w=x.f
v=w===C.a7
u=v?f:1-e
t=this.b
s=t.a
r=v?e:1-f
q=new A.E(u*s,0,r*s,t.b)
$.a4()
p=A.aF()
p.r=d.gq(d)
x=x.r
u=this.c
if(x!=null)u.e_(x.ac(w).dr(q),p)
else u.eZ(q,p)},
$S:601}
B.au8.prototype={
$0(){var x,w,v=this.b,u=v.b/2,t=this.a,s=t.x
s.toString
x=Math.min(s,u)
$.a4()
w=A.aF()
s=t.w
w.r=s.gq(s)
switch(t.f.a){case 0:v=new A.i(u,u)
break
case 1:v=new A.i(v.a-u,u)
break
default:v=null}this.c.dv(v,x,w)},
$S:0}
B.au9.prototype={
$2(d,e){return e*A.A(d,0,0.01)/0.01},
$S:116}
B.aua.prototype={
$2(d,e){var x=this.a,w=x.gF9().x
w===$&&A.b()
return x.MH(d,w,this.b)},
$S:84};(function aliases(){var x=B.J4.prototype
x.a3I=x.l})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(B.qG,A.a7)
v(A.ud,[B.aCF,B.aAo,B.au9,B.aua])
v(A.iX,[B.aCG,B.aAq,B.au7])
v(A.S,[B.ws,B.ami])
v(A.a2,[B.Eq,B.OX])
v(A.ab,[B.a04,B.J4])
v(A.np,[B.aAp,B.au8])
w(B.VY,A.un)
w(B.B0,B.OX)
w(B.VZ,B.J4)
v(A.vx,[B.au5,B.au6])
x(B.J4,A.f9)})()
A.a0a(b.typeUniverse,JSON.parse('{"qG":{"a7":[],"e":[]},"Eq":{"a2":[],"e":[]},"a04":{"ab":["Eq"]},"B0":{"a2":[],"e":[]},"OX":{"a2":[],"e":[]},"VY":{"ao":[]},"VZ":{"ab":["B0"]},"aXM":{"dM":[],"bv":[],"bh":[],"e":[]}}'))
var y={n:A.ah("ie"),a:A.ah("lV"),B:A.ah("u<ws>"),u:A.ah("u<e>"),o:A.ah("aXM"),w:A.ah("m"),C:A.ah("wl"),e:A.ah("r")};(function constants(){D.DQ=new A.al(0,860,0,1/0)
D.IT=new A.b7(18e5)
D.Kv=new A.m0("Hormone twin",null)
D.I4=new A.e9(0.1,0,0.45,1)
D.LM=new A.fW(0.7038888888888889,1,D.I4)
D.I6=new A.e9(0,0,0.65,1)
D.LN=new A.fW(0.5555555555555556,0.8705555555555555,D.I6)
D.I5=new A.e9(0.4,0,1,1)
D.LO=new A.fW(0.185,0.6016666666666667,D.I5)
D.I8=new A.e9(0.2,0,0.8,1)
D.LW=new A.fW(0,0.4166666666666667,D.I8)})()};
(a=>{a["YAetAbpCDPSRU7BXFci+dHUfMJE="]=a.current})($__dart_deferred_initializers__);