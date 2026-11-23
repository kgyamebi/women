((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,E,B={rL:function rL(d,e,f){this.c=d
this.d=e
this.a=f},
qp(d){if(d<0.22)return"Quiet"
if(d<0.42)return"Low"
if(d<0.62)return"Steady"
if(d<0.8)return"Rising"
return"High"},
bck(a3,a4){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2=a3.d
if(a2<15)a2=28
x=C.k.aV(a4,1,a2)
w=A.aMb(x,a2,C.k.aV(a3.e,2,8))
v=A.aYw(x,a2)
if(w===C.bh)u=0.84
else u=w===C.ch?0.24:0.46
A:{t=C.ch!==w
if(!t||C.bO===w){s=0.82
break A}if(C.fI===w||C.fJ===w){s=0.58
break A}if(C.bN===w||C.bh===w){s=0.34
break A}s=null}r=C.d.aV(0.5+A.aLf(w),0,1)
q=A.M7(w)
B:{if("High"===q){p=0.28
break B}if("Moderate"===q){p=0.5
break B}p=0.78
break B}C:{if(!t||C.bO===w){t=0.8
break C}if(C.fI===w||C.fJ===w){t=0.62
break C}if(C.bN===w){t=0.36
break C}if(C.bh===w){t=0.4
break C}t=null}o=A.A(y.w,y.e)
n=a3.c
if(n)for(m=a3.dx,l=m.length,k=0;k<l;++k){j=m[k]
i=A.dx(j.a)
if(i==null||A.ea(a3,i).c!==w)continue
for(h=j.f,g=h.length,f=0;f<h.length;h.length===g||(0,A.v)(h),++f){e=h[f]
d=o.h(0,e)
o.n(0,e,(d==null?0:d)+1)}}a0=n?"These are textbook words, not your hormone levels.":"No period date is saved. These are textbook words, not your hormone levels."
if(o.a!==0){n=o.$ti.i("d1<1,2>")
a1=A.J(new A.d1(o,n),n.i("t.E"))
C.b.dA(a1,new B.aKO())
n=C.b.gP(a1)
m=C.b.gP(a1)
l=C.b.gP(a1).b===1?"time":"times"
a0=a0+" In this phase you have logged "+n.a+" "+m.b+" "+l+". That is a pattern, not a diagnosis."}n=new B.aKP()
m=v.a
l=v.b
h=v.c
g=v.d
d=y.B
return new B.arc(x,w,A.a([n.$3("Estrogen",B.qp(m),m),n.$3("Progesterone",B.qp(l),l),n.$3("Testosterone",B.qp(h),h),n.$3("Cortisol",B.qp(g),g)],d),A.a([n.$3("Cravings",B.qp(u),u),n.$3("Mood",B.qp(s),s),n.$3("Energy",B.qp(r),r),n.$3("Sleep quality",B.qp(p),p),n.$3("Recovery",B.qp(t),t)],d),a0)},
aKO:function aKO(){},
aKP:function aKP(){},
y_:function y_(d,e,f){this.a=d
this.b=e
this.c=f},
arc:function arc(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.d=f
_.e=g
_.f=h},
b7O(){return new B.Gn(null)},
Gn:function Gn(d){this.a=d},
a3A:function a3A(){this.c=this.a=this.d=null},
aIr:function aIr(d){this.a=d},
aIq:function aIq(d,e){this.a=d
this.b=e},
aIp:function aIp(d,e){this.a=d
this.b=e},
Hr:function Hr(d,e){this.c=d
this.a=e},
WJ:function WJ(d,e){var _=this
_.d=$
_.dv$=d
_.ba$=e
_.c=_.a=null},
awn:function awn(d){this.a=d},
awm:function awm(d){this.a=d},
Lk:function Lk(){},
RA:function RA(){},
Za:function Za(d,e,f,g,h,i,j,k,l,m){var _=this
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
aBy:function aBy(d,e,f){this.a=d
this.b=e
this.c=f},
aBz:function aBz(d,e,f){this.a=d
this.b=e
this.c=f},
aBA:function aBA(){},
CX:function CX(d,e,f,g,h,i,j,k){var _=this
_.y=d
_.c=e
_.d=f
_.e=g
_.f=h
_.r=i
_.w=j
_.a=k},
Zb:function Zb(d,e){var _=this
_.d=$
_.dv$=d
_.ba$=e
_.c=_.a=null},
aBB:function aBB(d,e){this.a=d
this.b=e},
aBw:function aBw(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
aBx:function aBx(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
Lt:function Lt(){},
b5T(d){var x
d.K(y.o)
x=A.C(d)
return x.b4}},D
J=c[1]
A=c[0]
C=c[2]
E=c[9]
B=a.updateHolder(c[5],B)
D=c[10]
B.rL.prototype={
B(d){var x=null,w=A.bN(x,x,C.x,x,x,new A.aP(this.c,x,x,x,x,x,C.b2),x,8,x,x,x,x,x,8)
return A.aS(A.a([w,C.nG,A.f(this.d,x,x,x,x,A.j(x,x,(A.C(d).ax.a===C.p?C.w:C.v).d,x,x,x,x,x,"Outfit",x,x,12,x,x,C.f,x,1.35,!0,x,0,x,x,x,x,x,x),x,x)],y.u),C.q,C.i,C.b5,0)}}
B.y_.prototype={}
B.arc.prototype={}
B.Gn.prototype={
a6(){return new B.a3A()}}
B.a3A.prototype={
B(d){var x,w,v,u,t,s,r,q=this,p=null,o="Fraunces",n="Outfit",m=d.K(y.a).f,l=A.C(d).ax.a===C.p?C.w:C.v,k=A.fI(m.d,m.c.$0()).Q,j=m.d,i=j.r||j.x==="menopause",h=j.c||i,g=q.d
if(g==null)g=h?k.a:1
x=B.bck(j,g)
j=l.c
w=y.u
v=A.aS(A.a([A.bp(A.f("A sketch of a cycle",p,p,p,p,A.j(p,p,j,p,p,p,p,p,o,p,p,30,p,p,C.y,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),1),C.aW,E.qJ],w),C.q,C.i,C.j,0)
u=A.aYv(k.b)
t=h?k.a-1:-1
s=q.d==null?p:g-1
u=A.a([new B.Hr(A.aTc(!1,240,i?p:new B.aIr(q),s,u,t),p),C.l,A.f("A sketch, not a lab.",p,p,p,p,A.j(p,p,j,p,p,p,p,p,n,p,p,14,p,p,C.C,p,1.35,!0,p,0,p,p,p,p,p,p),p,p),C.a8,A.f("Not a blood test.",p,p,p,p,A.j(p,p,j,p,p,p,p,p,n,p,p,14,p,p,C.E,p,1.35,!0,p,0,p,p,p,p,p,p),p,p)],w)
if(!A.M8(m.d)){t=m.d.c?"A teal estimate stays off until a pattern is saved.":"Example. Save a period date to place this sketch on your cycle."
u.push(new A.aj(C.iy,A.f(t,p,p,p,p,A.j(p,p,j,p,p,p,p,p,n,p,p,14,p,p,C.f,p,1.35,!0,p,0,p,p,p,p,p,p),p,p),p))}else u.push(new A.aj(C.iy,A.f(A.zK(m.d,m.c.$0()).w+" "+C.b.aM(A.aYu(A.zK(m.d,m.c.$0()).w),", ")+". These are not measurements. Estimate. Not contraception.",p,p,p,p,A.j(p,p,j,p,p,p,p,p,n,p,p,14,p,p,C.f,p,1.35,!0,p,0,p,p,p,p,p,p),p,p),p))
u.push(C.l)
u.push(A.bM(C.N,A.a([new B.rL(l.w,"Estrogen",p),new B.rL(l.y,"Progesterone",p),new B.rL(l.Q,"Testosterone",p),new B.rL(l.z,"Cortisol",p)],w),C.R,6,14))
u=A.a0(u,C.t,p,C.i,C.j)
t=!h
if(t&&q.d==null)s="Not enough information yet"
else{s=x.b
r=""+x.a
s=h?"Textbook day "+r+" \xb7 "+A.v_(s):"Textbook day "+r+" \xb7 "+A.v_(s)}r=l.d
j=A.a([D.Ol,C.a8,v,C.T,new A.bS(u,C.M,20,p,p,p),C.aD,A.f(s,p,p,p,p,A.j(p,p,j,p,p,p,p,p,o,p,p,28,p,p,C.y,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),C.l,A.f(x.f,p,p,p,p,A.j(p,p,r,p,p,p,p,p,n,p,p,14.5,p,p,C.f,p,1.4,!0,p,0,p,p,p,p,p,p),p,p)],w)
if(!t||q.d!=null)C.b.I(j,A.a([C.aD,q.T7(x.d),C.T,A.f("Typical associations",p,p,p,p,A.j(p,p,r,p,p,p,p,p,n,p,p,13,p,p,C.E,p,1.35,!0,p,0.5,p,p,p,p,p,p),p,p),C.l,q.T7(x.e)],w))
j.push(C.T)
j.push(A.f("Educational model. Not a diagnosis, a lab, or a reason to start or stop medication.",p,p,p,p,A.j(p,p,l.e,p,p,p,p,p,n,p,p,12.5,p,p,C.f,p,1.4,!0,p,0,p,p,p,p,p,p),p,p))
return A.fQ(p,C.B,A.fc(!1,A.eq(A.a([A.cs(new A.dg(D.FP,A.a0(j,C.t,p,C.i,C.j),p),p,p)],w),p,p,C.bY,C.fS,p,p,C.aa),C.a3,!0))},
T7(d){var x=this.c
x.toString
return A.aOi(new B.aIp(d,A.C(x).ax.a===C.p?C.w:C.v))}}
B.Hr.prototype={
a6(){return new B.WJ(null,null)}}
B.WJ.prototype={
aA(){var x,w=this
w.aO()
x=A.bR(null,D.LG,null,null,w)
w.d!==$&&A.b6()
w.d=x
$.ab.ok$.push(new B.awn(w))},
l(){var x=this.d
x===$&&A.b()
x.l()
this.a7W()},
B(d){var x=this.d
x===$&&A.b()
return A.fJ(x,new B.awm(this),this.a.c)}}
B.Lk.prototype={
l(){var x=this,w=x.ba$
if(w!=null)w.N(0,x.gf1())
x.ba$=null
x.ar()},
bC(){this.ci()
this.c6()
this.f2()}}
B.RA.prototype={}
B.Za.prototype={
aE(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=this,l=m.y
if(l==null)l=0
x=new B.aBy(m,e,d)
w=new B.aBA()
v=l/e.a
u=m.d
t=u==null?null:A.B(u,0,1)
if(t!=null){s=v>0?t+w.$2(t,v):0
if(s<1)x.$3$color$endFraction$startFraction(m.b,1,s)
w=m.x
if(w!=null&&w>0)new B.aBz(m,e,d).$0()
if(t>0)x.$3$color$endFraction$startFraction(m.c,t,0)
return}u=m.e
r=D.Qz.ac(0,u)
q=D.Qr.ac(0,u)
p=D.Qq.ac(0,u)
o=D.Qp.ac(0,u)
if(r<1-v){s=r>0?r+w.$2(r,v):0
x.$3$color$endFraction$startFraction(m.b,1,s)}if(r-q>0)x.$3$color$endFraction$startFraction(m.c,r,q)
if(q>v){s=p>0?p+w.$2(p,v):0
n=q<1?q-w.$2(1-q,v):1
x.$3$color$endFraction$startFraction(m.b,n,s)}if(p-o>0)x.$3$color$endFraction$startFraction(m.c,p,o)
if(o>v){n=o<1?o-w.$2(1-o,v):1
x.$3$color$endFraction$startFraction(m.b,n,0)}},
d4(d){var x=this
return!d.b.j(0,x.b)||!d.c.j(0,x.c)||d.d!=x.d||d.e!==x.e||d.f!==x.f||!J.d(d.r,x.r)||!J.d(d.w,x.w)||d.x!=x.x||d.y!=x.y}}
B.CX.prototype={
a6(){return new B.Zb(null,null)}}
B.Zb.prototype={
aA(){var x,w=this
w.aO()
x=A.bR(null,D.Lu,null,null,w)
w.d!==$&&A.b6()
w.d=x
w.We()},
aP(d){this.b9(d)
this.We()},
l(){var x=this.d
x===$&&A.b()
x.l()
this.a85()},
gH4(){var x,w=this
w.a.toString
w.c.DC(y.o)
w.c.Kc(y.C)
x=w.d
x===$&&A.b()
return x},
We(){var x,w=this,v=w.a.c
A.B(v,0,1)
x=!1
if(x){v=w.d
v===$&&A.b()
v.LT(0)}else{A.B(v,0,1)
v=w.d
v===$&&A.b()
v=v.r
v=v!=null&&v.a!=null
if(v){v=w.d
v===$&&A.b()
v.ft(0)}}},
Pr(d,e,f){var x,w,v,u,t,s,r,q,p=this,o=null,n=B.b5T(d)
p.a.toString
A.C(d)
switch(!0){case!0:x=new B.aBx(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
case!1:x=new B.aBw(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
default:x=o}w=p.a
w.toString
w=w.d
v=w==null?n.b:w
if(v==null)v=x.gt3()
u=p.a.y
t=n.f
if(t==null)t=x.f
w=p.a
w.toString
x.ge_(x)
x=p.a
s=x.c
r=A.B(s,0,1)
w=A.ey(o,o,o,new B.Za(v,w.e,r,e,f,t,o,o,o,o),C.S)
if(t!=null)A.B(s,0,1)
q=x.w
s=A.B(s,0,1)
q=""+C.d.aF(s*100)
x=x.r
return A.by(o,o,new A.dg(new A.al(1/0,1/0,u,1/0),w,o),!1,o,o,o,!1,o,o,o,o,o,o,o,x,o,o,"100",o,"0",o,o,o,o,o,o,o,o,o,o,o,C.a6M,o,o,o,o,o,o,o,o,o,C.I,q)},
B(d){var x,w=this,v=d.K(y.n).w
A.B(w.a.c,0,1)
x=w.gH4().x
x===$&&A.b()
return w.Pr(d,x,v)
return A.fJ(w.gH4(),new B.aBB(w,v),null)}}
B.aBw.prototype={
gv0(){var x,w=this,v=w.CW
if(v===$){x=A.C(w.ch)
w.CW!==$&&A.aT()
v=w.CW=x.ax}return v},
ge_(d){return this.gv0().b},
gt3(){var x=this.gv0(),w=x.au
return w==null?x.k2:w},
gwH(){return 4}}
B.aBx.prototype={
gv0(){var x,w=this,v=w.CW
if(v===$){x=A.C(w.ch)
w.CW!==$&&A.aT()
v=w.CW=x.ax}return v},
ge_(d){return this.gv0().b},
gt3(){var x=this.gv0(),w=x.Q
return w==null?x.y:w},
gwH(){return 4}}
B.Lt.prototype={
l(){var x=this,w=x.ba$
if(w!=null)w.N(0,x.gf1())
x.ba$=null
x.ar()},
bC(){this.ci()
this.c6()
this.f2()}}
var z=a.updateTypes(["y_(m,m,w)"])
B.aKO.prototype={
$2(d,e){return C.k.bc(e.b,d.b)},
$S:46}
B.aKP.prototype={
$3(d,e,f){return new B.y_(d,"Sketch \xb7 "+e,f)},
$S:z+0}
B.aIr.prototype={
$1(d){var x=this.a
return x.R(new B.aIq(x,d))},
$S:12}
B.aIq.prototype={
$0(){return this.a.d=this.b+1},
$S:0}
B.aIp.prototype={
$2(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=null,l=e.b,k=l>640?4:2,j=(l-(k-1)*10)/k
l=y.u
x=A.a([],l)
for(w=this.a,v=w.length,u=this.b,t=u.r,s=u.w,r=u.c,u=u.d,q=0;q<w.length;w.length===v||(0,A.v)(w),++q){p=w[q]
o=A.f(p.a,m,m,m,m,new A.o(!0,u,m,"Outfit",m,m,12,C.f,m,0,m,m,1.35,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m)
n=new A.aF(99,99)
x.push(new A.cg(j,m,new A.bS(A.a0(A.a([o,C.a_,A.f(p.b,m,m,m,m,new A.o(!0,r,m,"Fraunces",m,m,22,C.y,m,-0.7,m,m,1.05,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m),C.l,new A.AT(new A.bW(n,n,n,n),new B.CX(4,C.d.aV(p.c,0,1),t,s,m,m,m,m),m)],l),C.t,m,C.i,C.j),C.fR,20,m,m,m),m))}return A.bM(C.N,x,C.R,10,10)},
$S:652}
B.awn.prototype={
$1(d){var x=this.a,w=x.c
if(w==null)return
w=A.aU(w,C.b1,y.x).w
x=x.d
if(w.ax){x===$&&A.b()
x.sp(0,1)}else{x===$&&A.b()
x.bu(0)}},
$S:3}
B.awm.prototype={
$2(d,e){var x,w=this.a.d
w===$&&A.b()
w=w.x
w===$&&A.b()
if(w<=0)x=0.01
else x=w
return A.Np(new A.d5(C.aX,x,null,e,null),C.A)},
$S:136}
B.aBy.prototype={
$3$color$endFraction$startFraction(d,e,f){var x,w,v,u,t,s,r,q,p
if(e-f<=0)return
x=this.a
w=x.f
v=w===C.ab
u=v?f:1-e
t=this.b
s=t.a
r=v?e:1-f
q=new A.F(u*s,0,r*s,t.b)
$.a7()
p=A.ax()
p.r=d.gp(d)
x=x.r
u=this.c
if(x!=null)u.dt(x.a7(w).dc(q),p)
else u.fk(q,p)},
$S:653}
B.aBz.prototype={
$0(){var x,w,v=this.b,u=v.b/2,t=this.a,s=t.x
s.toString
x=Math.min(s,u)
$.a7()
w=A.ax()
s=t.w
w.r=s.gp(s)
switch(t.f.a){case 0:v=new A.h(u,u)
break
case 1:v=new A.h(v.a-u,u)
break
default:v=null}this.c.cJ(v,x,w)},
$S:0}
B.aBA.prototype={
$2(d,e){return e*A.B(d,0,0.01)/0.01},
$S:104}
B.aBB.prototype={
$2(d,e){var x=this.a,w=x.gH4().x
w===$&&A.b()
return x.Pr(d,w,this.b)},
$S:73};(function aliases(){var x=B.Lk.prototype
x.a7W=x.l
x=B.Lt.prototype
x.a85=x.l})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(B.rL,A.Y)
v(A.vF,[B.aKO,B.aIp,B.awm,B.aBA,B.aBB])
v(A.jm,[B.aKP,B.aIr,B.awn,B.aBy])
v(A.X,[B.y_,B.arc])
v(A.R,[B.Gn,B.Hr,B.RA])
v(A.Z,[B.a3A,B.Lk,B.Lt])
v(A.oo,[B.aIq,B.aBz])
w(B.WJ,B.Lk)
w(B.Za,A.vQ)
w(B.CX,B.RA)
w(B.Zb,B.Lt)
v(A.x7,[B.aBw,B.aBx])
x(B.Lk,A.eW)
x(B.Lt,A.eW)})()
A.a3G(b.typeUniverse,JSON.parse('{"rL":{"Y":[],"e":[]},"Gn":{"R":[],"e":[]},"Hr":{"R":[],"e":[]},"a3A":{"Z":["Gn"]},"WJ":{"Z":["Hr"]},"CX":{"R":[],"e":[]},"RA":{"R":[],"e":[]},"Za":{"an":[]},"Zb":{"Z":["CX"]},"b5Q":{"dv":[],"br":[],"bd":[],"e":[]}}'))
var y={n:A.ai("hE"),a:A.ai("mK"),B:A.ai("x<y_>"),u:A.ai("x<e>"),x:A.ai("io"),o:A.ai("b5Q"),w:A.ai("m"),C:A.ai("ua"),e:A.ai("r")};(function constants(){D.FP=new A.al(0,860,0,1/0)
D.Lu=new A.b1(18e5)
D.LG=new A.b1(8e5)
D.Ol=new A.mQ("Hormone twin",null)
D.Kt=new A.e1(0.1,0,0.45,1)
D.Qp=new A.ho(0.7038888888888889,1,D.Kt)
D.Kv=new A.e1(0,0,0.65,1)
D.Qq=new A.ho(0.5555555555555556,0.8705555555555555,D.Kv)
D.Ku=new A.e1(0.4,0,1,1)
D.Qr=new A.ho(0.185,0.6016666666666667,D.Ku)
D.Kx=new A.e1(0.2,0,0.8,1)
D.Qz=new A.ho(0,0.4166666666666667,D.Kx)})()};
(a=>{a["NxiymP/zbOB74FR00d4pAF54Y+Y="]=a.current})($__dart_deferred_initializers__);