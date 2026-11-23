((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,E,F,B={qH:function qH(d,e,f){this.c=d
this.d=e
this.a=f},
pq(d){if(d<0.22)return"Quiet"
if(d<0.42)return"Low"
if(d<0.62)return"Steady"
if(d<0.8)return"Rising"
return"High"},
b30(a3,a4){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2=a3.d
if(a2<15)a2=28
x=C.i.b1(a4,1,a2)
w=A.aE5(x,a2,C.i.b1(a3.e,2,8))
v=A.aPS(x,a2)
if(w===C.aX)u=0.84
else u=w===C.bW?0.24:0.46
A:{t=C.bW!==w
if(!t||C.bv===w){s=0.82
break A}if(C.f7===w||C.f8===w){s=0.58
break A}if(C.bu===w||C.aX===w){s=0.34
break A}s=null}r=C.d.b1(0.5+A.aDc(w),0,1)
q=A.JH(w)
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
if(o.a!==0){n=o.$ti.i("cD<1,2>")
a1=A.J(new A.cD(o,n),n.i("q.E"))
C.b.d8(a1,new B.aCJ())
n=C.b.gL(a1)
m=C.b.gL(a1)
l=C.b.gL(a1).b===1?"time":"times"
a0=a0+" In this phase you have logged "+n.a+" "+m.b+" "+l+". That is a pattern, not a diagnosis."}n=new B.aCK()
m=v.a
l=v.b
h=v.c
g=v.d
d=y.B
return new B.amm(x,w,A.a([n.$3("Estrogen",B.pq(m),m),n.$3("Progesterone",B.pq(l),l),n.$3("Testosterone",B.pq(h),h),n.$3("Cortisol",B.pq(g),g)],d),A.a([n.$3("Cravings",B.pq(u),u),n.$3("Mood",B.pq(s),s),n.$3("Energy",B.pq(r),r),n.$3("Sleep quality",B.pq(p),p),n.$3("Recovery",B.pq(t),t)],d),a0)},
aCJ:function aCJ(){},
aCK:function aCK(){},
wt:function wt(d,e,f){this.a=d
this.b=e
this.c=f},
amm:function amm(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.d=f
_.e=g
_.f=h},
aZO(){return new B.Er(null)},
Er:function Er(d){this.a=d},
a06:function a06(){this.c=this.a=this.d=null},
aAu:function aAu(d){this.a=d},
aAt:function aAt(d,e){this.a=d
this.b=e},
aAs:function aAs(d,e){this.a=d
this.b=e},
OZ:function OZ(){},
W_:function W_(d,e,f,g,h,i,j,k,l,m){var _=this
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
aub:function aub(d,e,f){this.a=d
this.b=e
this.c=f},
auc:function auc(d,e,f){this.a=d
this.b=e
this.c=f},
aud:function aud(){},
B1:function B1(d,e,f,g,h,i,j,k){var _=this
_.y=d
_.c=e
_.d=f
_.e=g
_.f=h
_.r=i
_.w=j
_.a=k},
W0:function W0(d,e){var _=this
_.d=$
_.dN$=d
_.bh$=e
_.c=_.a=null},
aue:function aue(d,e){this.a=d
this.b=e},
au9:function au9(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
aua:function aua(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
J5:function J5(){},
aXV(d){var x
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
B.qH.prototype={
F(d){var x=null,w=A.c6(x,x,C.x,x,x,new A.aW(this.c,x,x,x,x,x,C.aW),x,8,x,x,x,x,8)
return A.bb(A.a([w,C.mM,A.k(this.d,x,x,x,x,A.l(x,x,(A.K(d).ax.a===C.p?C.t:C.u).d,x,x,x,x,x,"Outfit",x,x,12,x,x,C.e,x,1.35,!0,x,0,x,x,x,x,x,x),x,x)],y.u),C.v,C.j,C.bF,0)}}
B.wt.prototype={}
B.amm.prototype={}
B.Er.prototype={
a9(){return new B.a06()}}
B.a06.prototype={
F(d){var x,w,v,u,t,s,r,q=this,p=null,o="Fraunces",n="Outfit",m=d.K(y.a).f,l=A.K(d).ax.a===C.p?C.t:C.u,k=A.ff(m.d,m.c.$0()).Q,j=m.d,i=j.r||j.x==="menopause",h=j.c||i,g=q.d
if(g==null)g=h?k.a:1
x=B.b30(j,g)
j=l.c
w=y.u
v=A.bb(A.a([A.bJ(A.k("A sketch of a cycle",p,p,p,p,A.l(p,p,j,p,p,p,p,p,o,p,p,30,p,p,C.w,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),1),C.aT,F.pi],w),C.v,C.j,C.k,0)
u=A.aPR(k.b)
t=h?k.a-1:-1
s=q.d==null?p:g-1
u=A.ae(A.a([A.aKH(!1,240,i?p:new B.aAu(q),s,u,t),C.l,A.k("Not a blood test.",p,p,p,p,A.l(p,p,j,p,p,p,p,p,n,p,p,14,p,p,C.A,p,1.35,!0,p,0,p,p,p,p,p,p),p,p),C.l,A.bD(A.a([new B.qH(l.w,"Estrogen",p),new B.qH(l.y,"Progesterone",p),new B.qH(l.Q,"Testosterone",p),new B.qH(l.z,"Cortisol",p)],w),C.I,6,14)],w),C.r,C.j,C.k)
t=!h
if(t&&q.d==null)s="Not enough information yet"
else{s=x.b
r=""+x.a
s=h?"Textbook day "+r+" \xb7 "+A.tJ(s):"Textbook day "+r+" \xb7 "+A.tJ(s)}r=l.d
j=A.a([D.Kv,C.a2,v,C.L,new A.bO(u,C.ad,28,p,p,p),C.aq,A.k(s,p,p,p,p,A.l(p,p,j,p,p,p,p,p,o,p,p,28,p,p,C.w,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),C.l,A.k(x.f,p,p,p,p,A.l(p,p,r,p,p,p,p,p,n,p,p,14.5,p,p,C.e,p,1.4,!0,p,0,p,p,p,p,p,p),p,p)],w)
if(!t||q.d!=null)C.b.I(j,A.a([C.aq,q.Q4(x.d),C.L,A.k("Typical associations",p,p,p,p,A.l(p,p,r,p,p,p,p,p,n,p,p,13,p,p,C.A,p,1.35,!0,p,0.5,p,p,p,p,p,p),p,p),C.l,q.Q4(x.e)],w))
j.push(C.L)
j.push(A.k("Educational model. Not a diagnosis, a lab, or a reason to start or stop medication.",p,p,p,p,A.l(p,p,l.e,p,p,p,p,p,n,p,p,12.5,p,p,C.e,p,1.4,!0,p,0,p,p,p,p,p,p),p,p))
return A.hp(C.D,A.ho(!1,A.fX(A.a([A.dn(new A.dI(D.DQ,A.ae(j,C.r,C.j,C.k),p),p,p)],w),p,p,E.i_,C.af),C.al,!0))},
Q4(d){var x=this.c
x.toString
return A.aG8(new B.aAs(d,A.K(x).ax.a===C.p?C.t:C.u))}}
B.OZ.prototype={}
B.W_.prototype={
aC(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=this,l=m.y
if(l==null)l=0
x=new B.aub(m,e,d)
w=new B.aud()
v=l/e.a
u=m.d
t=u==null?null:A.A(u,0,1)
if(t!=null){s=v>0?t+w.$2(t,v):0
if(s<1)x.$3$color$endFraction$startFraction(m.b,1,s)
w=m.x
if(w!=null&&w>0)new B.auc(m,e,d).$0()
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
B.B1.prototype={
a9(){return new B.W0(null,null)}}
B.W0.prototype={
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
this.a3H()},
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
MH(d,e,f){var x,w,v,u,t,s,r,q,p=this,o=null,n=B.aXV(d)
p.a.toString
A.K(d)
switch(!0){case!0:x=new B.aua(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
case!1:x=new B.au9(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
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
w=A.fh(o,o,o,new B.W_(v,w.e,r,e,f,t,o,o,o,o),C.K)
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
return A.ia(w.gF9(),new B.aue(w,v),null)}}
B.au9.prototype={
gtI(){var x,w=this,v=w.CW
if(v===$){x=A.K(w.ch)
w.CW!==$&&A.aS()
v=w.CW=x.ax}return v},
gdJ(d){return this.gtI().b},
gqU(){var x=this.gtI(),w=x.aw
return w==null?x.k2:w},
gv1(){return 4}}
B.aua.prototype={
gtI(){var x,w=this,v=w.CW
if(v===$){x=A.K(w.ch)
w.CW!==$&&A.aS()
v=w.CW=x.ax}return v},
gdJ(d){return this.gtI().b},
gqU(){var x=this.gtI(),w=x.Q
return w==null?x.y:w},
gv1(){return 4}}
B.J5.prototype={
l(){var x=this,w=x.bh$
if(w!=null)w.O(0,x.gfd())
x.bh$=null
x.aA()},
bE(){this.cm()
this.cc()
this.fe()}}
var z=a.updateTypes(["wt(m,m,y)"])
B.aCJ.prototype={
$2(d,e){return C.i.b4(e.b,d.b)},
$S:40}
B.aCK.prototype={
$3(d,e,f){return new B.wt(d,"Sketch \xb7 "+e,f)},
$S:z+0}
B.aAu.prototype={
$1(d){var x=this.a
return x.V(new B.aAt(x,d))},
$S:25}
B.aAt.prototype={
$0(){return this.a.d=this.b+1},
$S:0}
B.aAs.prototype={
$2(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=null,l=e.b,k=l>640?4:2,j=(l-(k-1)*10)/k
l=y.u
x=A.a([],l)
for(w=this.a,v=w.length,u=this.b,t=u.r,s=u.w,r=u.c,u=u.d,q=0;q<w.length;w.length===v||(0,A.v)(w),++q){p=w[q]
o=A.k(p.a,m,m,m,m,new A.n(!0,u,m,"Outfit",m,m,12,C.e,m,0,m,m,1.35,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m)
n=new A.aK(99,99)
x.push(new A.ch(j,m,new A.bO(A.ae(A.a([o,C.U,A.k(p.b,m,m,m,m,new A.n(!0,r,m,"Fraunces",m,m,22,C.w,m,-0.7,m,m,1.05,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m),C.l,new A.za(new A.c8(n,n,n,n),new B.B1(4,C.d.b1(p.c,0,1),t,s,m,m,m,m),m)],l),C.r,C.j,C.k),C.kN,20,m,m,m),m))}return A.bD(x,C.I,10,10)},
$S:600}
B.aub.prototype={
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
B.auc.prototype={
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
B.aud.prototype={
$2(d,e){return e*A.A(d,0,0.01)/0.01},
$S:116}
B.aue.prototype={
$2(d,e){var x=this.a,w=x.gF9().x
w===$&&A.b()
return x.MH(d,w,this.b)},
$S:84};(function aliases(){var x=B.J5.prototype
x.a3H=x.l})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(B.qH,A.a7)
v(A.ue,[B.aCJ,B.aAs,B.aud,B.aue])
v(A.iX,[B.aCK,B.aAu,B.aub])
v(A.S,[B.wt,B.amm])
v(A.a2,[B.Er,B.OZ])
v(A.ab,[B.a06,B.J5])
v(A.np,[B.aAt,B.auc])
w(B.W_,A.uo)
w(B.B1,B.OZ)
w(B.W0,B.J5)
v(A.vy,[B.au9,B.aua])
x(B.J5,A.f9)})()
A.a0c(b.typeUniverse,JSON.parse('{"qH":{"a7":[],"e":[]},"Er":{"a2":[],"e":[]},"a06":{"ab":["Er"]},"B1":{"a2":[],"e":[]},"OZ":{"a2":[],"e":[]},"W_":{"ao":[]},"W0":{"ab":["B1"]},"aXS":{"dM":[],"bv":[],"bh":[],"e":[]}}'))
var y={n:A.ah("ie"),a:A.ah("lV"),B:A.ah("u<wt>"),u:A.ah("u<e>"),o:A.ah("aXS"),w:A.ah("m"),C:A.ah("wm"),e:A.ah("r")};(function constants(){D.DQ=new A.al(0,860,0,1/0)
D.IT=new A.b7(18e5)
D.Kv=new A.m0("Hormone twin",null)
D.I4=new A.ea(0.1,0,0.45,1)
D.LM=new A.fW(0.7038888888888889,1,D.I4)
D.I6=new A.ea(0,0,0.65,1)
D.LN=new A.fW(0.5555555555555556,0.8705555555555555,D.I6)
D.I5=new A.ea(0.4,0,1,1)
D.LO=new A.fW(0.185,0.6016666666666667,D.I5)
D.I8=new A.ea(0.2,0,0.8,1)
D.LW=new A.fW(0,0.4166666666666667,D.I8)})()};
(a=>{a["e9JmQAwUP+5qV7k6BH3p7KRAX1A="]=a.current})($__dart_deferred_initializers__);