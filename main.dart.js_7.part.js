((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,B={qE:function qE(d,e,f){this.c=d
this.d=e
this.a=f},
pr(d){if(d<0.22)return"Quiet"
if(d<0.42)return"Low"
if(d<0.62)return"Steady"
if(d<0.8)return"Rising"
return"High"},
b2F(a3,a4){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2=a3.d
if(a2<15)a2=28
x=C.i.bq(a4,1,a2)
w=A.aEv(x,a2,C.i.bq(a3.e,2,8))
v=A.aPL(x,a2)
if(w===C.aU)u=0.84
else u=w===C.bV?0.24:0.46
A:{t=C.bV!==w
if(!t||C.bt===w){s=0.82
break A}if(C.f5===w||C.f6===w){s=0.58
break A}if(C.bs===w||C.aU===w){s=0.34
break A}s=null}r=C.d.bq(0.5+A.aDL(w),0,1)
q=A.JM(w)
B:{if("High"===q){p=0.28
break B}if("Moderate"===q){p=0.5
break B}p=0.78
break B}C:{if(!t||C.bt===w){t=0.8
break C}if(C.f5===w||C.f6===w){t=0.62
break C}if(C.bs===w){t=0.36
break C}if(C.aU===w){t=0.4
break C}t=null}o=A.y(y.w,y.e)
n=a3.c
if(n)for(m=a3.dx,l=m.length,k=0;k<l;++k){j=m[k]
i=A.e0(j.a)
if(i==null||A.dR(a3,i).c!==w)continue
for(h=j.f,g=h.length,f=0;f<h.length;h.length===g||(0,A.w)(h),++f){e=h[f]
d=o.h(0,e)
o.n(0,e,(d==null?0:d)+1)}}a0=n?"These are textbook words, not your hormone levels.":"No period date is saved. These are textbook words, not your hormone levels."
if(o.a!==0){n=o.$ti.i("cI<1,2>")
a1=A.I(new A.cI(o,n),n.i("o.E"))
C.b.dE(a1,new B.aDj())
n=C.b.gN(a1)
m=C.b.gN(a1)
l=C.b.gN(a1).b===1?"time":"times"
a0=a0+" In this phase you have logged "+n.a+" "+m.b+" "+l+". That is a pattern, not a diagnosis."}n=new B.aDk()
m=v.a
l=v.b
h=v.c
g=v.d
d=y.B
return new B.an5(x,w,A.a([n.$3("Estrogen",B.pr(m),m),n.$3("Progesterone",B.pr(l),l),n.$3("Testosterone",B.pr(h),h),n.$3("Cortisol",B.pr(g),g)],d),A.a([n.$3("Cravings",B.pr(u),u),n.$3("Mood",B.pr(s),s),n.$3("Energy",B.pr(r),r),n.$3("Sleep quality",B.pr(p),p),n.$3("Recovery",B.pr(t),t)],d),a0)},
aDj:function aDj(){},
aDk:function aDk(){},
wq:function wq(d,e,f){this.a=d
this.b=e
this.c=f},
an5:function an5(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.d=f
_.e=g
_.f=h},
aZE(){return new B.Ev(null)},
Ev:function Ev(d){this.a=d},
a0u:function a0u(){this.c=this.a=this.d=null},
aB8:function aB8(d){this.a=d},
aB7:function aB7(d,e){this.a=d
this.b=e},
aB6:function aB6(d,e){this.a=d
this.b=e},
Pe:function Pe(){},
Wo:function Wo(d,e,f,g,h,i,j,k,l,m){var _=this
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
av1:function av1(d,e,f){this.a=d
this.b=e
this.c=f},
av2:function av2(d,e,f){this.a=d
this.b=e
this.c=f},
av3:function av3(){},
B7:function B7(d,e,f,g,h,i,j,k){var _=this
_.y=d
_.c=e
_.d=f
_.e=g
_.f=h
_.r=i
_.w=j
_.a=k},
Wp:function Wp(d,e){var _=this
_.d=$
_.dw$=d
_.bg$=e
_.c=_.a=null},
av4:function av4(d,e){this.a=d
this.b=e},
av_:function av_(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
av0:function av0(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
Jb:function Jb(){},
aXJ(d){var x
d.M(y.o)
x=A.N(d)
return x.aW}},D
J=c[1]
A=c[0]
C=c[2]
B=a.updateHolder(c[5],B)
D=c[10]
B.qE.prototype={
F(d){var x=null,w=A.c8(x,x,C.x,x,x,new A.b_(this.c,x,x,x,x,x,C.aO),x,8,x,x,x,x,8)
return A.bi(A.a([w,C.mB,A.k(this.d,x,x,x,x,A.l(x,x,(A.N(d).ax.a===C.q?C.w:C.v).d,x,x,x,x,x,"Outfit",x,x,12,x,x,C.e,x,1.35,!0,x,0,x,x,x,x,x,x),x,x)],y.u),C.t,C.j,C.bu,0)}}
B.wq.prototype={}
B.an5.prototype={}
B.Ev.prototype={
a7(){return new B.a0u()}}
B.a0u.prototype={
F(d){var x,w,v,u,t,s,r,q,p,o=this,n=null,m="Fraunces",l="Outfit",k=d.M(y.a).f,j=A.N(d).ax.a===C.q?C.w:C.v,i=A.fB(k.d,k.c.$0()).Q,h=k.d,g=h.r||h.x==="menopause",f=h.c||g,e=o.d
if(e==null)e=f?i.a:1
x=B.b2F(h,e)
h=j.c
w=A.k("A sketch of a cycle",n,n,n,n,A.l(n,n,h,n,n,n,n,n,m,n,n,46,n,n,C.u,n,1.05,!0,n,-0.7,n,n,n,n,n,n),n,n)
v=g?"This drawing is a textbook menstrual cycle. It is paused as a portrait of you while pregnancy or menopause is leading. Estrogen, progesterone, testosterone, and cortisol, drawn as a model. Drag across the days. Nothing here was measured in your blood.":"Estrogen, progesterone, testosterone, and cortisol, drawn as a model. Drag across the days. Nothing here was measured in your blood."
u=j.d
v=A.k(v,n,n,n,n,A.l(n,n,u,n,n,n,n,n,l,n,n,15.5,n,n,C.e,n,1.45,!0,n,0,n,n,n,n,n,n),n,n)
t=A.aPK(i.b)
s=f?i.a-1:-1
r=o.d==null?n:e-1
q=y.u
s=A.ad(A.a([A.aKM(!1,240,g?n:new B.aB8(o),r,t,s),C.o,A.k("Not a blood test. The word SKETCH is part of the drawing.",n,n,n,n,A.l(n,n,h,n,n,n,n,n,l,n,n,13,n,n,C.e,n,1.35,!0,n,0,n,n,n,n,n,n),n,n),C.o,A.bF(A.a([new B.qE(j.w,"Estrogen",n),new B.qE(j.y,"Progesterone",n),new B.qE(j.Q,"Testosterone",n),new B.qE(j.z,"Cortisol",n)],q),C.K,6,14)],q),C.r,C.j,C.k)
t=!f
if(t&&o.d==null)r="Not enough information yet"
else{r=x.b
p=""+x.a
r=f?"Textbook day "+p+" \xb7 "+A.tG(r):"Textbook day "+p+" \xb7 "+A.tG(r)}h=A.a([D.J9,C.o,w,C.P,D.IV,C.o,v,C.J,new A.bP(s,C.am,28,n,n,n),C.a9,A.k(r,n,n,n,n,A.l(n,n,h,n,n,n,n,n,m,n,n,28,n,n,C.u,n,1.05,!0,n,-0.7,n,n,n,n,n,n),n,n),C.o,A.k(x.f,n,n,n,n,A.l(n,n,u,n,n,n,n,n,l,n,n,14.5,n,n,C.e,n,1.4,!0,n,0,n,n,n,n,n,n),n,n)],q)
if(!t||o.d!=null)C.b.I(h,A.a([C.a9,o.QC(x.d),C.J,A.k("Typical associations",n,n,n,n,A.l(n,n,u,n,n,n,n,n,l,n,n,13,n,n,C.B,n,1.35,!0,n,0.5,n,n,n,n,n,n),n,n),C.o,o.QC(x.e)],q))
h.push(C.J)
h.push(A.k("Educational model. Not a diagnosis, a lab, or a reason to start or stop medication.",n,n,n,n,A.l(n,n,j.e,n,n,n,n,n,l,n,n,12.5,n,n,C.e,n,1.4,!0,n,0,n,n,n,n,n,n),n,n))
return A.hN(C.D,A.he(!1,A.h6(A.a([A.dB(new A.dC(D.D_,A.ad(h,C.r,C.j,C.k),n),n,n)],q),n,n,C.hV,C.ak),C.ap,!0))},
QC(d){var x=this.c
x.toString
return A.aGk(new B.aB6(d,A.N(x).ax.a===C.q?C.w:C.v))}}
B.Pe.prototype={}
B.Wo.prototype={
aE(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=this,l=m.y
if(l==null)l=0
x=new B.av1(m,e,d)
w=new B.av3()
v=l/e.a
u=m.d
t=u==null?null:A.z(u,0,1)
if(t!=null){s=v>0?t+w.$2(t,v):0
if(s<1)x.$3$color$endFraction$startFraction(m.b,1,s)
w=m.x
if(w!=null&&w>0)new B.av2(m,e,d).$0()
if(t>0)x.$3$color$endFraction$startFraction(m.c,t,0)
return}u=m.e
r=D.KG.ah(0,u)
q=D.Ky.ah(0,u)
p=D.Kx.ah(0,u)
o=D.Kw.ah(0,u)
if(r<1-v){s=r>0?r+w.$2(r,v):0
x.$3$color$endFraction$startFraction(m.b,1,s)}if(r-q>0)x.$3$color$endFraction$startFraction(m.c,r,q)
if(q>v){s=p>0?p+w.$2(p,v):0
n=q<1?q-w.$2(1-q,v):1
x.$3$color$endFraction$startFraction(m.b,n,s)}if(p-o>0)x.$3$color$endFraction$startFraction(m.c,p,o)
if(o>v){n=o<1?o-w.$2(1-o,v):1
x.$3$color$endFraction$startFraction(m.b,n,0)}},
ds(d){var x=this
return!d.b.j(0,x.b)||!d.c.j(0,x.c)||d.d!=x.d||d.e!==x.e||d.f!==x.f||!J.d(d.r,x.r)||!J.d(d.w,x.w)||d.x!=x.x||d.y!=x.y}}
B.B7.prototype={
a7(){return new B.Wp(null,null)}}
B.Wp.prototype={
aF(){var x,w=this
w.aS()
x=A.c3(null,D.Ht,null,null,w)
w.d!==$&&A.bc()
w.d=x
w.TA()},
aY(d){this.bh(d)
this.TA()},
l(){var x=this.d
x===$&&A.b()
x.l()
this.a4B()},
gFE(){var x,w=this
w.a.toString
w.c.vU(y.o)
w.c.Ix(y.C)
x=w.d
x===$&&A.b()
return x},
TA(){var x,w=this,v=w.a.c
A.z(v,0,1)
x=!1
if(x){v=w.d
v===$&&A.b()
v.Bp(0)}else{A.z(v,0,1)
v=w.d
v===$&&A.b()
v=v.r
v=v!=null&&v.a!=null
if(v){v=w.d
v===$&&A.b()
v.f9(0)}}},
Nc(d,e,f){var x,w,v,u,t,s,r,q,p=this,o=null,n=B.aXJ(d)
p.a.toString
A.N(d)
switch(!0){case!0:x=new B.av0(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
case!1:x=new B.av_(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
default:x=o}w=p.a
w.toString
w=w.d
v=w==null?n.b:w
if(v==null)v=x.gqX()
u=p.a.y
t=n.f
if(t==null)t=x.f
w=p.a
w.toString
x.gdg(x)
x=p.a
s=x.c
r=A.z(s,0,1)
w=A.fI(o,o,o,new B.Wo(v,w.e,r,e,f,t,o,o,o,o),C.M)
if(t!=null)A.z(s,0,1)
q=x.w
s=A.z(s,0,1)
q=""+C.d.aA(s*100)
x=x.r
return A.cc(o,new A.dC(new A.am(1/0,1/0,u,1/0),w,o),!1,o,o,!1,o,o,o,o,o,o,o,x,o,o,"100",o,"0",o,o,o,o,o,o,o,o,o,o,o,C.X3,o,o,o,o,o,o,o,q)},
F(d){var x,w=this,v=d.M(y.n).w
A.z(w.a.c,0,1)
x=w.gFE().x
x===$&&A.b()
return w.Nc(d,x,v)
return A.hx(w.gFE(),new B.av4(w,v),null)}}
B.av_.prototype={
gtS(){var x,w=this,v=w.CW
if(v===$){x=A.N(w.ch)
w.CW!==$&&A.aT()
v=w.CW=x.ax}return v},
gdg(d){return this.gtS().b},
gqX(){var x=this.gtS(),w=x.aw
return w==null?x.k2:w},
gvc(){return 4}}
B.av0.prototype={
gtS(){var x,w=this,v=w.CW
if(v===$){x=A.N(w.ch)
w.CW!==$&&A.aT()
v=w.CW=x.ax}return v},
gdg(d){return this.gtS().b},
gqX(){var x=this.gtS(),w=x.Q
return w==null?x.y:w},
gvc(){return 4}}
B.Jb.prototype={
l(){var x=this,w=x.bg$
if(w!=null)w.L(0,x.gf_())
x.bg$=null
x.aB()},
bD(){this.ci()
this.c9()
this.f0()}}
var z=a.updateTypes(["wq(m,m,K)"])
B.aDj.prototype={
$2(d,e){return C.i.bb(e.b,d.b)},
$S:43}
B.aDk.prototype={
$3(d,e,f){return new B.wq(d,"Sketch \xb7 "+e,f)},
$S:z+0}
B.aB8.prototype={
$1(d){var x=this.a
return x.U(new B.aB7(x,d))},
$S:25}
B.aB7.prototype={
$0(){return this.a.d=this.b+1},
$S:0}
B.aB6.prototype={
$2(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=null,l=e.b,k=l>640?4:2,j=(l-(k-1)*10)/k
l=y.u
x=A.a([],l)
for(w=this.a,v=w.length,u=this.b,t=u.r,s=u.w,r=u.c,u=u.d,q=0;q<w.length;w.length===v||(0,A.w)(w),++q){p=w[q]
o=A.k(p.a,m,m,m,m,new A.n(!0,u,m,"Outfit",m,m,12,C.e,m,0,m,m,1.35,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m)
n=new A.aM(99,99)
x.push(new A.ch(j,m,new A.bP(A.ad(A.a([o,C.T,A.k(p.b,m,m,m,m,new A.n(!0,r,m,"Fraunces",m,m,22,C.u,m,-0.7,m,m,1.05,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m),C.o,new A.zc(new A.c4(n,n,n,n),new B.B7(4,C.d.bq(p.c,0,1),t,s,m,m,m,m),m)],l),C.r,C.j,C.k),C.e1,20,m,m,m),m))}return A.bF(x,C.K,10,10)},
$S:597}
B.av1.prototype={
$3$color$endFraction$startFraction(d,e,f){var x,w,v,u,t,s,r,q,p
if(e-f<=0)return
x=this.a
w=x.f
v=w===C.a6
u=v?f:1-e
t=this.b
s=t.a
r=v?e:1-f
q=new A.A(u*s,0,r*s,t.b)
$.a5()
p=A.aR()
p.r=d.gt(d)
x=x.r
u=this.c
if(x!=null)u.dZ(x.a8(w).dn(q),p)
else u.f1(q,p)},
$S:598}
B.av2.prototype={
$0(){var x,w,v=this.b,u=v.b/2,t=this.a,s=t.x
s.toString
x=Math.min(s,u)
$.a5()
w=A.aR()
s=t.w
w.r=s.gt(s)
switch(t.f.a){case 0:v=new A.j(u,u)
break
case 1:v=new A.j(v.a-u,u)
break
default:v=null}this.c.fj(v,x,w)},
$S:0}
B.av3.prototype={
$2(d,e){return e*A.z(d,0,0.01)/0.01},
$S:109}
B.av4.prototype={
$2(d,e){var x=this.a,w=x.gFE().x
w===$&&A.b()
return x.Nc(d,w,this.b)},
$S:84};(function aliases(){var x=B.Jb.prototype
x.a4B=x.l})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(B.qE,A.a8)
v(A.uf,[B.aDj,B.aB6,B.av3,B.av4])
v(A.iN,[B.aDk,B.aB8,B.av1])
v(A.P,[B.wq,B.an5])
v(A.a1,[B.Ev,B.Pe])
v(A.ab,[B.a0u,B.Jb])
v(A.nt,[B.aB7,B.av2])
w(B.Wo,A.uq)
w(B.B7,B.Pe)
w(B.Wp,B.Jb)
v(A.vw,[B.av_,B.av0])
x(B.Jb,A.eH)})()
A.a0A(b.typeUniverse,JSON.parse('{"qE":{"a8":[],"e":[]},"Ev":{"a1":[],"e":[]},"a0u":{"ab":["Ev"]},"B7":{"a1":[],"e":[]},"Pe":{"a1":[],"e":[]},"Wo":{"ao":[]},"Wp":{"ab":["B7"]},"aXG":{"dE":[],"bu":[],"bg":[],"e":[]}}'))
var y={n:A.aj("i8"),a:A.aj("lU"),B:A.aj("x<wq>"),u:A.aj("x<e>"),o:A.aj("aXG"),w:A.aj("m"),C:A.aj("wj"),e:A.aj("q")};(function constants(){D.D_=new A.am(0,860,0,1/0)
D.Ht=new A.b0(18e5)
D.IV=new A.fp(84,C.le,!1,null)
D.J9=new A.m_("Hormone twin",null)
D.GF=new A.e3(0.1,0,0.45,1)
D.Kw=new A.fL(0.7038888888888889,1,D.GF)
D.GH=new A.e3(0,0,0.65,1)
D.Kx=new A.fL(0.5555555555555556,0.8705555555555555,D.GH)
D.GG=new A.e3(0.4,0,1,1)
D.Ky=new A.fL(0.185,0.6016666666666667,D.GG)
D.GJ=new A.e3(0.2,0,0.8,1)
D.KG=new A.fL(0,0.4166666666666667,D.GJ)})()};
(a=>{a["2TRBKP75FFBr0ZNK/OrC8gpuvJU="]=a.current})($__dart_deferred_initializers__);