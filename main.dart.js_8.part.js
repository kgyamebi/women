((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,E,F,B={qE:function qE(d,e,f){this.c=d
this.d=e
this.a=f},
pp(d){if(d<0.22)return"Quiet"
if(d<0.42)return"Low"
if(d<0.62)return"Steady"
if(d<0.8)return"Rising"
return"High"},
b2D(a3,a4){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2=a3.d
if(a2<15)a2=28
x=C.i.bq(a4,1,a2)
w=A.aEs(x,a2,C.i.bq(a3.e,2,8))
v=A.aPJ(x,a2)
if(w===C.aV)u=0.84
else u=w===C.bV?0.24:0.46
A:{t=C.bV!==w
if(!t||C.bt===w){s=0.82
break A}if(C.f4===w||C.f5===w){s=0.58
break A}if(C.bs===w||C.aV===w){s=0.34
break A}s=null}r=C.d.bq(0.5+A.aDI(w),0,1)
q=A.JL(w)
B:{if("High"===q){p=0.28
break B}if("Moderate"===q){p=0.5
break B}p=0.78
break B}C:{if(!t||C.bt===w){t=0.8
break C}if(C.f4===w||C.f5===w){t=0.62
break C}if(C.bs===w){t=0.36
break C}if(C.aV===w){t=0.4
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
C.b.dE(a1,new B.aDg())
n=C.b.gN(a1)
m=C.b.gN(a1)
l=C.b.gN(a1).b===1?"time":"times"
a0=a0+" In this phase you have logged "+n.a+" "+m.b+" "+l+". That is a pattern, not a diagnosis."}n=new B.aDh()
m=v.a
l=v.b
h=v.c
g=v.d
d=y.B
return new B.an3(x,w,A.a([n.$3("Estrogen",B.pp(m),m),n.$3("Progesterone",B.pp(l),l),n.$3("Testosterone",B.pp(h),h),n.$3("Cortisol",B.pp(g),g)],d),A.a([n.$3("Cravings",B.pp(u),u),n.$3("Mood",B.pp(s),s),n.$3("Energy",B.pp(r),r),n.$3("Sleep quality",B.pp(p),p),n.$3("Recovery",B.pp(t),t)],d),a0)},
aDg:function aDg(){},
aDh:function aDh(){},
wr:function wr(d,e,f){this.a=d
this.b=e
this.c=f},
an3:function an3(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.d=f
_.e=g
_.f=h},
aZC(){return new B.Eu(null)},
Eu:function Eu(d){this.a=d},
a0t:function a0t(){this.c=this.a=this.d=null},
aB5:function aB5(d){this.a=d},
aB4:function aB4(d,e){this.a=d
this.b=e},
aB3:function aB3(d,e){this.a=d
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
av_:function av_(d,e,f){this.a=d
this.b=e
this.c=f},
av0:function av0(d,e,f){this.a=d
this.b=e
this.c=f},
av1:function av1(){},
B6:function B6(d,e,f,g,h,i,j,k){var _=this
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
av2:function av2(d,e){this.a=d
this.b=e},
auY:function auY(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
auZ:function auZ(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
Ja:function Ja(){},
aXH(d){var x
d.M(y.o)
x=A.N(d)
return x.aW}},D
J=c[1]
A=c[0]
C=c[2]
E=c[8]
F=c[10]
B=a.updateHolder(c[5],B)
D=c[11]
B.qE.prototype={
F(d){var x=null,w=A.c8(x,x,C.x,x,x,new A.b3(this.c,x,x,x,x,x,C.aU),x,8,x,x,x,x,8)
return A.bf(A.a([w,C.mz,A.k(this.d,x,x,x,x,A.l(x,x,(A.N(d).ax.a===C.q?C.w:C.v).d,x,x,x,x,x,"Outfit",x,x,12,x,x,C.e,x,1.35,!0,x,0,x,x,x,x,x,x),x,x)],y.u),C.t,C.j,C.bG,0)}}
B.wr.prototype={}
B.an3.prototype={}
B.Eu.prototype={
a7(){return new B.a0t()}}
B.a0t.prototype={
F(d){var x,w,v,u,t,s,r,q,p,o=this,n=null,m="Fraunces",l="Outfit",k=d.M(y.a).f,j=A.N(d).ax.a===C.q?C.w:C.v,i=A.fA(k.d,k.c.$0()).Q,h=k.d,g=h.r||h.x==="menopause",f=h.c||g,e=o.d
if(e==null)e=f?i.a:1
x=B.b2D(h,e)
h=j.c
w=y.u
v=A.bf(A.a([A.bM(A.k("A sketch of a cycle",n,n,n,n,A.l(n,n,h,n,n,n,n,n,m,n,n,30,n,n,C.u,n,1.05,!0,n,-0.7,n,n,n,n,n,n),n,n),1),C.aR,F.oZ],w),C.t,C.j,C.k,0)
u=g?"This drawing is a textbook menstrual cycle. It is paused as a portrait of you while pregnancy or menopause is leading. Estrogen, progesterone, testosterone, and cortisol, drawn as a model. Drag across the days. Nothing here was measured in your blood.":"Estrogen, progesterone, testosterone, and cortisol, drawn as a model. Drag across the days. Nothing here was measured in your blood."
t=j.d
u=A.k(u,n,n,n,n,A.l(n,n,t,n,n,n,n,n,l,n,n,15.5,n,n,C.e,n,1.45,!0,n,0,n,n,n,n,n,n),n,n)
s=A.aPI(i.b)
r=f?i.a-1:-1
q=o.d==null?n:e-1
s=A.af(A.a([A.aKK(!1,240,g?n:new B.aB5(o),q,s,r),C.l,A.k("Not a blood test. The word SKETCH is part of the drawing.",n,n,n,n,A.l(n,n,h,n,n,n,n,n,l,n,n,13,n,n,C.e,n,1.35,!0,n,0,n,n,n,n,n,n),n,n),C.l,A.bF(A.a([new B.qE(j.w,"Estrogen",n),new B.qE(j.y,"Progesterone",n),new B.qE(j.Q,"Testosterone",n),new B.qE(j.z,"Cortisol",n)],w),C.J,6,14)],w),C.r,C.j,C.k)
r=!f
if(r&&o.d==null)q="Not enough information yet"
else{q=x.b
p=""+x.a
q=f?"Textbook day "+p+" \xb7 "+A.tH(q):"Textbook day "+p+" \xb7 "+A.tH(q)}h=A.a([D.J8,C.V,v,C.U,u,C.M,new A.bQ(s,C.am,28,n,n,n),C.au,A.k(q,n,n,n,n,A.l(n,n,h,n,n,n,n,n,m,n,n,28,n,n,C.u,n,1.05,!0,n,-0.7,n,n,n,n,n,n),n,n),C.l,A.k(x.f,n,n,n,n,A.l(n,n,t,n,n,n,n,n,l,n,n,14.5,n,n,C.e,n,1.4,!0,n,0,n,n,n,n,n,n),n,n)],w)
if(!r||o.d!=null)C.b.I(h,A.a([C.au,o.QB(x.d),C.M,A.k("Typical associations",n,n,n,n,A.l(n,n,t,n,n,n,n,n,l,n,n,13,n,n,C.C,n,1.35,!0,n,0.5,n,n,n,n,n,n),n,n),C.l,o.QB(x.e)],w))
h.push(C.M)
h.push(A.k("Educational model. Not a diagnosis, a lab, or a reason to start or stop medication.",n,n,n,n,A.l(n,n,j.e,n,n,n,n,n,l,n,n,12.5,n,n,C.e,n,1.4,!0,n,0,n,n,n,n,n,n),n,n))
return A.hO(C.D,A.he(!1,A.h6(A.a([A.dB(new A.dJ(D.D2,A.af(h,C.r,C.j,C.k),n),n,n)],w),n,n,E.hT,C.aj),C.al,!0))},
QB(d){var x=this.c
x.toString
return A.aGh(new B.aB3(d,A.N(x).ax.a===C.q?C.w:C.v))}}
B.Pe.prototype={}
B.Wo.prototype={
aE(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=this,l=m.y
if(l==null)l=0
x=new B.av_(m,e,d)
w=new B.av1()
v=l/e.a
u=m.d
t=u==null?null:A.z(u,0,1)
if(t!=null){s=v>0?t+w.$2(t,v):0
if(s<1)x.$3$color$endFraction$startFraction(m.b,1,s)
w=m.x
if(w!=null&&w>0)new B.av0(m,e,d).$0()
if(t>0)x.$3$color$endFraction$startFraction(m.c,t,0)
return}u=m.e
r=D.KH.ah(0,u)
q=D.Kz.ah(0,u)
p=D.Ky.ah(0,u)
o=D.Kx.ah(0,u)
if(r<1-v){s=r>0?r+w.$2(r,v):0
x.$3$color$endFraction$startFraction(m.b,1,s)}if(r-q>0)x.$3$color$endFraction$startFraction(m.c,r,q)
if(q>v){s=p>0?p+w.$2(p,v):0
n=q<1?q-w.$2(1-q,v):1
x.$3$color$endFraction$startFraction(m.b,n,s)}if(p-o>0)x.$3$color$endFraction$startFraction(m.c,p,o)
if(o>v){n=o<1?o-w.$2(1-o,v):1
x.$3$color$endFraction$startFraction(m.b,n,0)}},
ds(d){var x=this
return!d.b.j(0,x.b)||!d.c.j(0,x.c)||d.d!=x.d||d.e!==x.e||d.f!==x.f||!J.d(d.r,x.r)||!J.d(d.w,x.w)||d.x!=x.x||d.y!=x.y}}
B.B6.prototype={
a7(){return new B.Wp(null,null)}}
B.Wp.prototype={
aF(){var x,w=this
w.aS()
x=A.c3(null,D.Hz,null,null,w)
w.d!==$&&A.bc()
w.d=x
w.Tz()},
aY(d){this.bh(d)
this.Tz()},
l(){var x=this.d
x===$&&A.b()
x.l()
this.a4A()},
gFD(){var x,w=this
w.a.toString
w.c.vU(y.o)
w.c.Iw(y.C)
x=w.d
x===$&&A.b()
return x},
Tz(){var x,w=this,v=w.a.c
A.z(v,0,1)
x=!1
if(x){v=w.d
v===$&&A.b()
v.Bq(0)}else{A.z(v,0,1)
v=w.d
v===$&&A.b()
v=v.r
v=v!=null&&v.a!=null
if(v){v=w.d
v===$&&A.b()
v.f9(0)}}},
Nc(d,e,f){var x,w,v,u,t,s,r,q,p=this,o=null,n=B.aXH(d)
p.a.toString
A.N(d)
switch(!0){case!0:x=new B.auZ(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
case!1:x=new B.auY(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
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
w=A.fI(o,o,o,new B.Wo(v,w.e,r,e,f,t,o,o,o,o),C.L)
if(t!=null)A.z(s,0,1)
q=x.w
s=A.z(s,0,1)
q=""+C.d.aA(s*100)
x=x.r
return A.cc(o,new A.dJ(new A.am(1/0,1/0,u,1/0),w,o),!1,o,o,!1,o,o,o,o,o,o,o,x,o,o,"100",o,"0",o,o,o,o,o,o,o,o,o,o,o,C.X3,o,o,o,o,o,o,o,q)},
F(d){var x,w=this,v=d.M(y.n).w
A.z(w.a.c,0,1)
x=w.gFD().x
x===$&&A.b()
return w.Nc(d,x,v)
return A.hx(w.gFD(),new B.av2(w,v),null)}}
B.auY.prototype={
gtS(){var x,w=this,v=w.CW
if(v===$){x=A.N(w.ch)
w.CW!==$&&A.aT()
v=w.CW=x.ax}return v},
gdg(d){return this.gtS().b},
gqX(){var x=this.gtS(),w=x.aw
return w==null?x.k2:w},
gvc(){return 4}}
B.auZ.prototype={
gtS(){var x,w=this,v=w.CW
if(v===$){x=A.N(w.ch)
w.CW!==$&&A.aT()
v=w.CW=x.ax}return v},
gdg(d){return this.gtS().b},
gqX(){var x=this.gtS(),w=x.Q
return w==null?x.y:w},
gvc(){return 4}}
B.Ja.prototype={
l(){var x=this,w=x.bg$
if(w!=null)w.L(0,x.gf_())
x.bg$=null
x.aB()},
bD(){this.ci()
this.c9()
this.f0()}}
var z=a.updateTypes(["wr(m,m,K)"])
B.aDg.prototype={
$2(d,e){return C.i.bb(e.b,d.b)},
$S:43}
B.aDh.prototype={
$3(d,e,f){return new B.wr(d,"Sketch \xb7 "+e,f)},
$S:z+0}
B.aB5.prototype={
$1(d){var x=this.a
return x.U(new B.aB4(x,d))},
$S:25}
B.aB4.prototype={
$0(){return this.a.d=this.b+1},
$S:0}
B.aB3.prototype={
$2(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=null,l=e.b,k=l>640?4:2,j=(l-(k-1)*10)/k
l=y.u
x=A.a([],l)
for(w=this.a,v=w.length,u=this.b,t=u.r,s=u.w,r=u.c,u=u.d,q=0;q<w.length;w.length===v||(0,A.w)(w),++q){p=w[q]
o=A.k(p.a,m,m,m,m,new A.n(!0,u,m,"Outfit",m,m,12,C.e,m,0,m,m,1.35,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m)
n=new A.aM(99,99)
x.push(new A.ch(j,m,new A.bQ(A.af(A.a([o,C.U,A.k(p.b,m,m,m,m,new A.n(!0,r,m,"Fraunces",m,m,22,C.u,m,-0.7,m,m,1.05,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m),C.l,new A.zd(new A.c4(n,n,n,n),new B.B6(4,C.d.bq(p.c,0,1),t,s,m,m,m,m),m)],l),C.r,C.j,C.k),C.hS,20,m,m,m),m))}return A.bF(x,C.J,10,10)},
$S:597}
B.av_.prototype={
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
B.av0.prototype={
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
B.av1.prototype={
$2(d,e){return e*A.z(d,0,0.01)/0.01},
$S:109}
B.av2.prototype={
$2(d,e){var x=this.a,w=x.gFD().x
w===$&&A.b()
return x.Nc(d,w,this.b)},
$S:84};(function aliases(){var x=B.Ja.prototype
x.a4A=x.l})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(B.qE,A.a8)
v(A.uh,[B.aDg,B.aB3,B.av1,B.av2])
v(A.iN,[B.aDh,B.aB5,B.av_])
v(A.P,[B.wr,B.an3])
v(A.a1,[B.Eu,B.Pe])
v(A.ab,[B.a0t,B.Ja])
v(A.nt,[B.aB4,B.av0])
w(B.Wo,A.ur)
w(B.B6,B.Pe)
w(B.Wp,B.Ja)
v(A.vx,[B.auY,B.auZ])
x(B.Ja,A.eG)})()
A.a0z(b.typeUniverse,JSON.parse('{"qE":{"a8":[],"e":[]},"Eu":{"a1":[],"e":[]},"a0t":{"ab":["Eu"]},"B6":{"a1":[],"e":[]},"Pe":{"a1":[],"e":[]},"Wo":{"ao":[]},"Wp":{"ab":["B6"]},"aXE":{"dE":[],"bu":[],"bh":[],"e":[]}}'))
var y={n:A.aj("i8"),a:A.aj("lU"),B:A.aj("x<wr>"),u:A.aj("x<e>"),o:A.aj("aXE"),w:A.aj("m"),C:A.aj("wk"),e:A.aj("q")};(function constants(){D.D2=new A.am(0,860,0,1/0)
D.Hz=new A.b_(18e5)
D.J8=new A.m_("Hormone twin",null)
D.GL=new A.e2(0.1,0,0.45,1)
D.Kx=new A.fM(0.7038888888888889,1,D.GL)
D.GN=new A.e2(0,0,0.65,1)
D.Ky=new A.fM(0.5555555555555556,0.8705555555555555,D.GN)
D.GM=new A.e2(0.4,0,1,1)
D.Kz=new A.fM(0.185,0.6016666666666667,D.GM)
D.GP=new A.e2(0.2,0,0.8,1)
D.KH=new A.fM(0,0.4166666666666667,D.GP)})()};
(a=>{a["nXcCd+srIqv8y46FRMbmqx0IWU0="]=a.current})($__dart_deferred_initializers__);