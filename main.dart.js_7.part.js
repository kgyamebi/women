((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,E,F,B={qH:function qH(d,e,f){this.c=d
this.d=e
this.a=f},
pp(d){if(d<0.22)return"Quiet"
if(d<0.42)return"Low"
if(d<0.62)return"Steady"
if(d<0.8)return"Rising"
return"High"},
b36(a3,a4){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2=a3.d
if(a2<15)a2=28
x=C.i.b1(a4,1,a2)
w=A.aE_(x,a2,C.i.b1(a3.e,2,8))
v=A.aPM(x,a2)
if(w===C.aX)u=0.84
else u=w===C.bW?0.24:0.46
A:{t=C.bW!==w
if(!t||C.bv===w){s=0.82
break A}if(C.f7===w||C.f8===w){s=0.58
break A}if(C.bu===w||C.aX===w){s=0.34
break A}s=null}r=C.d.b1(0.5+A.aD6(w),0,1)
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
C.b.d8(a1,new B.aCE())
n=C.b.gK(a1)
m=C.b.gK(a1)
l=C.b.gK(a1).b===1?"time":"times"
a0=a0+" In this phase you have logged "+n.a+" "+m.b+" "+l+". That is a pattern, not a diagnosis."}n=new B.aCF()
m=v.a
l=v.b
h=v.c
g=v.d
d=y.B
return new B.amh(x,w,A.a([n.$3("Estrogen",B.pp(m),m),n.$3("Progesterone",B.pp(l),l),n.$3("Testosterone",B.pp(h),h),n.$3("Cortisol",B.pp(g),g)],d),A.a([n.$3("Cravings",B.pp(u),u),n.$3("Mood",B.pp(s),s),n.$3("Energy",B.pp(r),r),n.$3("Sleep quality",B.pp(p),p),n.$3("Recovery",B.pp(t),t)],d),a0)},
aCE:function aCE(){},
aCF:function aCF(){},
wt:function wt(d,e,f){this.a=d
this.b=e
this.c=f},
amh:function amh(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.d=f
_.e=g
_.f=h},
aZL(){return new B.Er(null)},
Er:function Er(d){this.a=d},
a07:function a07(){this.c=this.a=this.d=null},
aAp:function aAp(d){this.a=d},
aAo:function aAo(d,e){this.a=d
this.b=e},
aAn:function aAn(d,e){this.a=d
this.b=e},
OY:function OY(){},
VZ:function VZ(d,e,f,g,h,i,j,k,l,m){var _=this
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
au6:function au6(d,e,f){this.a=d
this.b=e
this.c=f},
au7:function au7(d,e,f){this.a=d
this.b=e
this.c=f},
au8:function au8(){},
B1:function B1(d,e,f,g,h,i,j,k){var _=this
_.y=d
_.c=e
_.d=f
_.e=g
_.f=h
_.r=i
_.w=j
_.a=k},
W_:function W_(d,e){var _=this
_.d=$
_.dN$=d
_.bh$=e
_.c=_.a=null},
au9:function au9(d,e){this.a=d
this.b=e},
au4:function au4(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
J5:function J5(){},
aXS(d){var x
d.M(y.o)
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
F(d){var x=null,w=A.c5(x,x,C.x,x,x,new A.aW(this.c,x,x,x,x,x,C.aW),x,8,x,x,x,x,8)
return A.bb(A.a([w,C.mK,A.k(this.d,x,x,x,x,A.l(x,x,(A.K(d).ax.a===C.p?C.t:C.u).d,x,x,x,x,x,"Outfit",x,x,12,x,x,C.e,x,1.35,!0,x,0,x,x,x,x,x,x),x,x)],y.u),C.v,C.j,C.bF,0)}}
B.wt.prototype={}
B.amh.prototype={}
B.Er.prototype={
a9(){return new B.a07()}}
B.a07.prototype={
F(d){var x,w,v,u,t,s,r,q=this,p=null,o="Fraunces",n="Outfit",m=d.M(y.a).f,l=A.K(d).ax.a===C.p?C.t:C.u,k=A.fg(m.d,m.c.$0()).Q,j=m.d,i=j.r||j.x==="menopause",h=j.c||i,g=q.d
if(g==null)g=h?k.a:1
x=B.b36(j,g)
j=l.c
w=y.u
v=A.bb(A.a([A.bJ(A.k("A sketch of a cycle",p,p,p,p,A.l(p,p,j,p,p,p,p,p,o,p,p,30,p,p,C.w,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),1),C.aT,F.ph],w),C.v,C.j,C.k,0)
u=A.aPL(k.b)
t=h?k.a-1:-1
s=q.d==null?p:g-1
u=A.ae(A.a([A.aKB(!1,240,i?p:new B.aAp(q),s,u,t),C.l,A.k("Not a blood test.",p,p,p,p,A.l(p,p,j,p,p,p,p,p,n,p,p,14,p,p,C.A,p,1.35,!0,p,0,p,p,p,p,p,p),p,p),C.l,A.bD(A.a([new B.qH(l.w,"Estrogen",p),new B.qH(l.y,"Progesterone",p),new B.qH(l.Q,"Testosterone",p),new B.qH(l.z,"Cortisol",p)],w),C.I,6,14)],w),C.r,C.j,C.k)
t=!h
if(t&&q.d==null)s="Not enough information yet"
else{s=x.b
r=""+x.a
s=h?"Textbook day "+r+" \xb7 "+A.tJ(s):"Textbook day "+r+" \xb7 "+A.tJ(s)}r=l.d
j=A.a([D.KC,C.X,v,C.L,new A.bK(u,C.a9,28,p,p,p),C.aq,A.k(s,p,p,p,p,A.l(p,p,j,p,p,p,p,p,o,p,p,28,p,p,C.w,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),C.l,A.k(x.f,p,p,p,p,A.l(p,p,r,p,p,p,p,p,n,p,p,14.5,p,p,C.e,p,1.4,!0,p,0,p,p,p,p,p,p),p,p)],w)
if(!t||q.d!=null)C.b.I(j,A.a([C.aq,q.Q4(x.d),C.L,A.k("Typical associations",p,p,p,p,A.l(p,p,r,p,p,p,p,p,n,p,p,13,p,p,C.A,p,1.35,!0,p,0.5,p,p,p,p,p,p),p,p),C.l,q.Q4(x.e)],w))
j.push(C.L)
j.push(A.k("Educational model. Not a diagnosis, a lab, or a reason to start or stop medication.",p,p,p,p,A.l(p,p,l.e,p,p,p,p,p,n,p,p,12.5,p,p,C.e,p,1.4,!0,p,0,p,p,p,p,p,p),p,p))
return A.hq(C.D,A.hp(!1,A.fY(A.a([A.dn(new A.dH(D.DP,A.ae(j,C.r,C.j,C.k),p),p,p)],w),p,p,E.i_,C.af),C.al,!0))},
Q4(d){var x=this.c
x.toString
return A.aG2(new B.aAn(d,A.K(x).ax.a===C.p?C.t:C.u))}}
B.OY.prototype={}
B.VZ.prototype={
aC(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=this,l=m.y
if(l==null)l=0
x=new B.au6(m,e,d)
w=new B.au8()
v=l/e.a
u=m.d
t=u==null?null:A.A(u,0,1)
if(t!=null){s=v>0?t+w.$2(t,v):0
if(s<1)x.$3$color$endFraction$startFraction(m.b,1,s)
w=m.x
if(w!=null&&w>0)new B.au7(m,e,d).$0()
if(t>0)x.$3$color$endFraction$startFraction(m.c,t,0)
return}u=m.e
r=D.M2.ah(0,u)
q=D.LV.ah(0,u)
p=D.LU.ah(0,u)
o=D.LT.ah(0,u)
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
a9(){return new B.W_(null,null)}}
B.W_.prototype={
aI(){var x,w=this
w.aV()
x=A.c8(null,D.J_,null,null,w)
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
MH(d,e,f){var x,w,v,u,t,s,r,q,p=this,o=null,n=B.aXS(d)
p.a.toString
A.K(d)
switch(!0){case!0:x=new B.au5(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
case!1:x=new B.au4(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
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
w=A.fi(o,o,o,new B.VZ(v,w.e,r,e,f,t,o,o,o,o),C.K)
if(t!=null)A.A(s,0,1)
q=x.w
s=A.A(s,0,1)
q=""+C.d.aE(s*100)
x=x.r
return A.bZ(o,new A.dH(new A.al(1/0,1/0,u,1/0),w,o),!1,o,o,!1,o,o,o,o,o,o,x,o,o,"100",o,"0",o,o,o,o,o,o,o,o,o,o,o,C.a0V,o,o,o,o,o,o,o,o,q)},
F(d){var x,w=this,v=d.M(y.n).w
A.A(w.a.c,0,1)
x=w.gF9().x
x===$&&A.b()
return w.MH(d,x,v)
return A.ib(w.gF9(),new B.au9(w,v),null)}}
B.au4.prototype={
gtI(){var x,w=this,v=w.CW
if(v===$){x=A.K(w.ch)
w.CW!==$&&A.aR()
v=w.CW=x.ax}return v},
gdJ(d){return this.gtI().b},
gqU(){var x=this.gtI(),w=x.aw
return w==null?x.k2:w},
gv1(){return 4}}
B.au5.prototype={
gtI(){var x,w=this,v=w.CW
if(v===$){x=A.K(w.ch)
w.CW!==$&&A.aR()
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
B.aCE.prototype={
$2(d,e){return C.i.b4(e.b,d.b)},
$S:40}
B.aCF.prototype={
$3(d,e,f){return new B.wt(d,"Sketch \xb7 "+e,f)},
$S:z+0}
B.aAp.prototype={
$1(d){var x=this.a
return x.V(new B.aAo(x,d))},
$S:25}
B.aAo.prototype={
$0(){return this.a.d=this.b+1},
$S:0}
B.aAn.prototype={
$2(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=null,l=e.b,k=l>640?4:2,j=(l-(k-1)*10)/k
l=y.u
x=A.a([],l)
for(w=this.a,v=w.length,u=this.b,t=u.r,s=u.w,r=u.c,u=u.d,q=0;q<w.length;w.length===v||(0,A.v)(w),++q){p=w[q]
o=A.k(p.a,m,m,m,m,new A.n(!0,u,m,"Outfit",m,m,12,C.e,m,0,m,m,1.35,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m)
n=new A.aK(99,99)
x.push(new A.ch(j,m,new A.bK(A.ae(A.a([o,C.U,A.k(p.b,m,m,m,m,new A.n(!0,r,m,"Fraunces",m,m,22,C.w,m,-0.7,m,m,1.05,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m),C.l,new A.za(new A.c7(n,n,n,n),new B.B1(4,C.d.b1(p.c,0,1),t,s,m,m,m,m),m)],l),C.r,C.j,C.k),C.kM,20,m,m,m),m))}return A.bD(x,C.I,10,10)},
$S:601}
B.au6.prototype={
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
$S:602}
B.au7.prototype={
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
B.au8.prototype={
$2(d,e){return e*A.A(d,0,0.01)/0.01},
$S:116}
B.au9.prototype={
$2(d,e){var x=this.a,w=x.gF9().x
w===$&&A.b()
return x.MH(d,w,this.b)},
$S:84};(function aliases(){var x=B.J5.prototype
x.a3H=x.l})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(B.qH,A.a7)
v(A.ue,[B.aCE,B.aAn,B.au8,B.au9])
v(A.iX,[B.aCF,B.aAp,B.au6])
v(A.T,[B.wt,B.amh])
v(A.a1,[B.Er,B.OY])
v(A.ab,[B.a07,B.J5])
v(A.np,[B.aAo,B.au7])
w(B.VZ,A.uo)
w(B.B1,B.OY)
w(B.W_,B.J5)
v(A.vy,[B.au4,B.au5])
x(B.J5,A.fa)})()
A.a0d(b.typeUniverse,JSON.parse('{"qH":{"a7":[],"e":[]},"Er":{"a1":[],"e":[]},"a07":{"ab":["Er"]},"B1":{"a1":[],"e":[]},"OY":{"a1":[],"e":[]},"VZ":{"ao":[]},"W_":{"ab":["B1"]},"aXP":{"dL":[],"bv":[],"bh":[],"e":[]}}'))
var y={n:A.ah("ig"),a:A.ah("lV"),B:A.ah("u<wt>"),u:A.ah("u<e>"),o:A.ah("aXP"),w:A.ah("m"),C:A.ah("wm"),e:A.ah("r")};(function constants(){D.DP=new A.al(0,860,0,1/0)
D.J_=new A.b7(18e5)
D.KC=new A.m0("Hormone twin",null)
D.I3=new A.ea(0.1,0,0.45,1)
D.LT=new A.fX(0.7038888888888889,1,D.I3)
D.I5=new A.ea(0,0,0.65,1)
D.LU=new A.fX(0.5555555555555556,0.8705555555555555,D.I5)
D.I4=new A.ea(0.4,0,1,1)
D.LV=new A.fX(0.185,0.6016666666666667,D.I4)
D.I7=new A.ea(0.2,0,0.8,1)
D.M2=new A.fX(0,0.4166666666666667,D.I7)})()};
(a=>{a["r+L4+NI9qw4QswsTwxJPUBH5OL0="]=a.current})($__dart_deferred_initializers__);