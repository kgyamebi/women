((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,E,B={rQ:function rQ(d,e,f){this.c=d
this.d=e
this.a=f},
qs(d){if(d<0.22)return"Quiet"
if(d<0.42)return"Low"
if(d<0.62)return"Steady"
if(d<0.8)return"Rising"
return"High"},
bco(a3,a4){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2=a3.d
if(a2<15)a2=28
x=C.k.aV(a4,1,a2)
w=A.aMh(x,a2,C.k.aV(a3.e,2,8))
v=A.aYC(x,a2)
if(w===C.bi)u=0.84
else u=w===C.ci?0.24:0.46
A:{t=C.ci!==w
if(!t||C.bP===w){s=0.82
break A}if(C.fK===w||C.fL===w){s=0.58
break A}if(C.bO===w||C.bi===w){s=0.34
break A}s=null}r=C.d.aV(0.5+A.aLm(w),0,1)
q=A.M9(w)
B:{if("High"===q){p=0.28
break B}if("Moderate"===q){p=0.5
break B}p=0.78
break B}C:{if(!t||C.bP===w){t=0.8
break C}if(C.fK===w||C.fL===w){t=0.62
break C}if(C.bO===w){t=0.36
break C}if(C.bi===w){t=0.4
break C}t=null}o=A.A(y.w,y.e)
n=a3.c
if(n)for(m=a3.dx,l=m.length,k=0;k<l;++k){j=m[k]
i=A.dr(j.a)
if(i==null||A.ea(a3,i).c!==w)continue
for(h=j.f,g=h.length,f=0;f<h.length;h.length===g||(0,A.w)(h),++f){e=h[f]
d=o.h(0,e)
o.n(0,e,(d==null?0:d)+1)}}a0=n?"These are textbook words, not your hormone levels.":"No period date is saved. These are textbook words, not your hormone levels."
if(o.a!==0){n=o.$ti.i("d0<1,2>")
a1=A.J(new A.d0(o,n),n.i("t.E"))
C.b.dB(a1,new B.aKV())
n=C.b.gO(a1)
m=C.b.gO(a1)
l=C.b.gO(a1).b===1?"time":"times"
a0=a0+" In this phase you have logged "+n.a+" "+m.b+" "+l+". That is a pattern, not a diagnosis."}n=new B.aKW()
m=v.a
l=v.b
h=v.c
g=v.d
d=y.B
return new B.arh(x,w,A.a([n.$3("Estrogen",B.qs(m),m),n.$3("Progesterone",B.qs(l),l),n.$3("Testosterone",B.qs(h),h),n.$3("Cortisol",B.qs(g),g)],d),A.a([n.$3("Cravings",B.qs(u),u),n.$3("Mood",B.qs(s),s),n.$3("Energy",B.qs(r),r),n.$3("Sleep quality",B.qs(p),p),n.$3("Recovery",B.qs(t),t)],d),a0)},
aKV:function aKV(){},
aKW:function aKW(){},
y0:function y0(d,e,f){this.a=d
this.b=e
this.c=f},
arh:function arh(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.d=f
_.e=g
_.f=h},
b7R(){return new B.Go(null)},
Go:function Go(d){this.a=d},
a3B:function a3B(){this.c=this.a=this.d=null},
aIy:function aIy(d){this.a=d},
aIx:function aIx(d,e){this.a=d
this.b=e},
aIw:function aIw(d,e){this.a=d
this.b=e},
Hs:function Hs(d,e){this.c=d
this.a=e},
WL:function WL(d,e){var _=this
_.d=$
_.dv$=d
_.ba$=e
_.c=_.a=null},
awr:function awr(d){this.a=d},
awq:function awq(d){this.a=d},
Lm:function Lm(){},
RC:function RC(){},
Zb:function Zb(d,e,f,g,h,i,j,k,l,m){var _=this
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
aBC:function aBC(d,e,f){this.a=d
this.b=e
this.c=f},
aBD:function aBD(d,e,f){this.a=d
this.b=e
this.c=f},
aBE:function aBE(){},
CY:function CY(d,e,f,g,h,i,j,k){var _=this
_.y=d
_.c=e
_.d=f
_.e=g
_.f=h
_.r=i
_.w=j
_.a=k},
Zc:function Zc(d,e){var _=this
_.d=$
_.dv$=d
_.ba$=e
_.c=_.a=null},
aBF:function aBF(d,e){this.a=d
this.b=e},
aBA:function aBA(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
aBB:function aBB(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
Lv:function Lv(){},
b5W(d){var x
d.K(y.o)
x=A.C(d)
return x.b4}},D
J=c[1]
A=c[0]
C=c[2]
E=c[9]
B=a.updateHolder(c[5],B)
D=c[10]
B.rQ.prototype={
B(d){var x=null,w=A.bO(x,x,C.x,x,x,new A.aP(this.c,x,x,x,x,x,C.b3),x,8,x,x,x,x,x,8)
return A.aS(A.a([w,C.nJ,A.h(this.d,x,x,x,x,A.j(x,x,(A.C(d).ax.a===C.p?C.w:C.v).d,x,x,x,x,x,"Outfit",x,x,12,x,x,C.f,x,1.35,!0,x,0,x,x,x,x,x,x),x,x)],y.u),C.q,C.i,C.b6,0)}}
B.y0.prototype={}
B.arh.prototype={}
B.Go.prototype={
a6(){return new B.a3B()}}
B.a3B.prototype={
B(d){var x,w,v,u,t,s,r,q=this,p=null,o="Fraunces",n="Outfit",m=d.K(y.a).f,l=A.C(d).ax.a===C.p?C.w:C.v,k=A.fG(m.d,m.c.$0()).Q,j=m.d,i=j.r||j.x==="menopause",h=j.c||i,g=q.d
if(g==null)g=h?k.a:1
x=B.bco(j,g)
j=l.c
w=y.u
v=A.aS(A.a([A.bp(A.h("A sketch of a cycle",p,p,p,p,A.j(p,p,j,p,p,p,p,p,o,p,p,30,p,p,C.y,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),1),C.aX,E.qL],w),C.q,C.i,C.j,0)
u=A.aYB(k.b)
t=h?k.a-1:-1
s=q.d==null?p:g-1
u=A.a([new B.Hs(A.aTi(!1,240,i?p:new B.aIy(q),s,u,t),p),C.l,A.h("A sketch, not a lab.",p,p,p,p,A.j(p,p,j,p,p,p,p,p,n,p,p,14,p,p,C.A,p,1.35,!0,p,0,p,p,p,p,p,p),p,p),C.a8,A.h("Not a blood test.",p,p,p,p,A.j(p,p,j,p,p,p,p,p,n,p,p,14,p,p,C.E,p,1.35,!0,p,0,p,p,p,p,p,p),p,p)],w)
if(!A.Ma(m.d)){t=m.d.c?"A teal estimate stays off until a pattern is saved.":"Example. Save a period date to place this sketch on your cycle."
u.push(new A.ak(C.iB,A.h(t,p,p,p,p,A.j(p,p,j,p,p,p,p,p,n,p,p,14,p,p,C.f,p,1.35,!0,p,0,p,p,p,p,p,p),p,p),p))}else u.push(new A.ak(C.iB,A.h(A.a5L(m.d,m.c.$0()).w+" "+C.b.aM(A.aYA(A.a5L(m.d,m.c.$0()).w),", ")+". These are not measurements. Estimate. Not contraception.",p,p,p,p,A.j(p,p,j,p,p,p,p,p,n,p,p,14,p,p,C.f,p,1.35,!0,p,0,p,p,p,p,p,p),p,p),p))
u.push(C.l)
u.push(A.bN(C.N,A.a([new B.rQ(l.w,"Estrogen",p),new B.rQ(l.y,"Progesterone",p),new B.rQ(l.Q,"Testosterone",p),new B.rQ(l.z,"Cortisol",p)],w),C.S,6,14))
u=A.a0(u,C.t,p,C.i,C.j)
t=!h
if(t&&q.d==null)s="Not enough information yet"
else{s=x.b
r=""+x.a
s=h?"Textbook day "+r+" \xb7 "+A.v2(s):"Textbook day "+r+" \xb7 "+A.v2(s)}r=l.d
j=A.a([D.O8,C.a8,v,C.U,new A.bR(u,C.M,20,p,p,p),C.aD,A.h(s,p,p,p,p,A.j(p,p,j,p,p,p,p,p,o,p,p,28,p,p,C.y,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),C.l,A.h(x.f,p,p,p,p,A.j(p,p,r,p,p,p,p,p,n,p,p,14.5,p,p,C.f,p,1.4,!0,p,0,p,p,p,p,p,p),p,p)],w)
if(!t||q.d!=null)C.b.I(j,A.a([C.aD,q.Ti(x.d),C.U,A.h("Typical associations",p,p,p,p,A.j(p,p,r,p,p,p,p,p,n,p,p,13,p,p,C.E,p,1.35,!0,p,0.5,p,p,p,p,p,p),p,p),C.l,q.Ti(x.e)],w))
j.push(C.U)
j.push(A.h("Educational model. Not a diagnosis, a lab, or a reason to start or stop medication.",p,p,p,p,A.j(p,p,l.e,p,p,p,p,p,n,p,p,12.5,p,p,C.f,p,1.4,!0,p,0,p,p,p,p,p,p),p,p))
return A.fQ(p,C.C,A.fb(!1,A.eq(A.a([A.ct(new A.de(D.FS,A.a0(j,C.t,p,C.i,C.j),p),p,p)],w),p,p,C.bZ,C.fU,p,p,C.aa),C.a3,!0))},
Ti(d){var x=this.c
x.toString
return A.aOp(new B.aIw(d,A.C(x).ax.a===C.p?C.w:C.v))}}
B.Hs.prototype={
a6(){return new B.WL(null,null)}}
B.WL.prototype={
aA(){var x,w=this
w.aO()
x=A.bQ(null,D.Lt,null,null,w)
w.d!==$&&A.b8()
w.d=x
$.ab.ok$.push(new B.awr(w))},
l(){var x=this.d
x===$&&A.b()
x.l()
this.a84()},
B(d){var x=this.d
x===$&&A.b()
return A.fI(x,new B.awq(this),this.a.c)}}
B.Lm.prototype={
l(){var x=this,w=x.ba$
if(w!=null)w.N(0,x.gf1())
x.ba$=null
x.ar()},
bC(){this.cj()
this.c7()
this.f2()}}
B.RC.prototype={}
B.Zb.prototype={
aE(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=this,l=m.y
if(l==null)l=0
x=new B.aBC(m,e,d)
w=new B.aBE()
v=l/e.a
u=m.d
t=u==null?null:A.B(u,0,1)
if(t!=null){s=v>0?t+w.$2(t,v):0
if(s<1)x.$3$color$endFraction$startFraction(m.b,1,s)
w=m.x
if(w!=null&&w>0)new B.aBD(m,e,d).$0()
if(t>0)x.$3$color$endFraction$startFraction(m.c,t,0)
return}u=m.e
r=D.Qm.ac(0,u)
q=D.Qe.ac(0,u)
p=D.Qd.ac(0,u)
o=D.Qc.ac(0,u)
if(r<1-v){s=r>0?r+w.$2(r,v):0
x.$3$color$endFraction$startFraction(m.b,1,s)}if(r-q>0)x.$3$color$endFraction$startFraction(m.c,r,q)
if(q>v){s=p>0?p+w.$2(p,v):0
n=q<1?q-w.$2(1-q,v):1
x.$3$color$endFraction$startFraction(m.b,n,s)}if(p-o>0)x.$3$color$endFraction$startFraction(m.c,p,o)
if(o>v){n=o<1?o-w.$2(1-o,v):1
x.$3$color$endFraction$startFraction(m.b,n,0)}},
d4(d){var x=this
return!d.b.j(0,x.b)||!d.c.j(0,x.c)||d.d!=x.d||d.e!==x.e||d.f!==x.f||!J.d(d.r,x.r)||!J.d(d.w,x.w)||d.x!=x.x||d.y!=x.y}}
B.CY.prototype={
a6(){return new B.Zc(null,null)}}
B.Zc.prototype={
aA(){var x,w=this
w.aO()
x=A.bQ(null,D.Lh,null,null,w)
w.d!==$&&A.b8()
w.d=x
w.Wp()},
aQ(d){this.b9(d)
this.Wp()},
l(){var x=this.d
x===$&&A.b()
x.l()
this.a8e()},
gHa(){var x,w=this
w.a.toString
w.c.DF(y.o)
w.c.Kj(y.C)
x=w.d
x===$&&A.b()
return x},
Wp(){var x,w=this,v=w.a.c
A.B(v,0,1)
x=!1
if(x){v=w.d
v===$&&A.b()
v.M_(0)}else{A.B(v,0,1)
v=w.d
v===$&&A.b()
v=v.r
v=v!=null&&v.a!=null
if(v){v=w.d
v===$&&A.b()
v.ft(0)}}},
PB(d,e,f){var x,w,v,u,t,s,r,q,p=this,o=null,n=B.b5W(d)
p.a.toString
A.C(d)
switch(!0){case!0:x=new B.aBB(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
case!1:x=new B.aBA(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
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
x.ge0(x)
x=p.a
s=x.c
r=A.B(s,0,1)
w=A.ez(o,o,o,new B.Zb(v,w.e,r,e,f,t,o,o,o,o),C.T)
if(t!=null)A.B(s,0,1)
q=x.w
s=A.B(s,0,1)
q=""+C.d.aF(s*100)
x=x.r
return A.bz(o,o,new A.de(new A.am(1/0,1/0,u,1/0),w,o),!1,o,o,o,!1,o,o,o,o,o,o,o,x,o,o,"100",o,"0",o,o,o,o,o,o,o,o,o,o,o,C.a6v,o,o,o,o,o,o,o,o,o,C.I,q)},
B(d){var x,w=this,v=d.K(y.n).w
A.B(w.a.c,0,1)
x=w.gHa().x
x===$&&A.b()
return w.PB(d,x,v)
return A.fI(w.gHa(),new B.aBF(w,v),null)}}
B.aBA.prototype={
gv0(){var x,w=this,v=w.CW
if(v===$){x=A.C(w.ch)
w.CW!==$&&A.aT()
v=w.CW=x.ax}return v},
ge0(d){return this.gv0().b},
gt3(){var x=this.gv0(),w=x.au
return w==null?x.k2:w},
gwH(){return 4}}
B.aBB.prototype={
gv0(){var x,w=this,v=w.CW
if(v===$){x=A.C(w.ch)
w.CW!==$&&A.aT()
v=w.CW=x.ax}return v},
ge0(d){return this.gv0().b},
gt3(){var x=this.gv0(),w=x.Q
return w==null?x.y:w},
gwH(){return 4}}
B.Lv.prototype={
l(){var x=this,w=x.ba$
if(w!=null)w.N(0,x.gf1())
x.ba$=null
x.ar()},
bC(){this.cj()
this.c7()
this.f2()}}
var z=a.updateTypes(["y0(m,m,v)"])
B.aKV.prototype={
$2(d,e){return C.k.bc(e.b,d.b)},
$S:44}
B.aKW.prototype={
$3(d,e,f){return new B.y0(d,"Sketch \xb7 "+e,f)},
$S:z+0}
B.aIy.prototype={
$1(d){var x=this.a
return x.R(new B.aIx(x,d))},
$S:13}
B.aIx.prototype={
$0(){return this.a.d=this.b+1},
$S:0}
B.aIw.prototype={
$2(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=null,l=e.b,k=l>640?4:2,j=(l-(k-1)*10)/k
l=y.u
x=A.a([],l)
for(w=this.a,v=w.length,u=this.b,t=u.r,s=u.w,r=u.c,u=u.d,q=0;q<w.length;w.length===v||(0,A.w)(w),++q){p=w[q]
o=A.h(p.a,m,m,m,m,new A.o(!0,u,m,"Outfit",m,m,12,C.f,m,0,m,m,1.35,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m)
n=new A.aF(99,99)
x.push(new A.ch(j,m,new A.bR(A.a0(A.a([o,C.a_,A.h(p.b,m,m,m,m,new A.o(!0,r,m,"Fraunces",m,m,22,C.y,m,-0.7,m,m,1.05,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m),C.l,new A.AU(new A.bW(n,n,n,n),new B.CY(4,C.d.aV(p.c,0,1),t,s,m,m,m,m),m)],l),C.t,m,C.i,C.j),C.fT,20,m,m,m),m))}return A.bN(C.N,x,C.S,10,10)},
$S:655}
B.awr.prototype={
$1(d){var x=this.a,w=x.c
if(w==null)return
w=A.aU(w,C.b2,y.x).w
x=x.d
if(w.ax){x===$&&A.b()
x.sp(0,1)}else{x===$&&A.b()
x.bu(0)}},
$S:3}
B.awq.prototype={
$2(d,e){var x,w=this.a.d
w===$&&A.b()
w=w.x
w===$&&A.b()
if(w<=0)x=0.01
else x=w
return A.Nr(new A.d4(C.aY,x,null,e,null),C.B)},
$S:222}
B.aBC.prototype={
$3$color$endFraction$startFraction(d,e,f){var x,w,v,u,t,s,r,q,p
if(e-f<=0)return
x=this.a
w=x.f
v=w===C.ab
u=v?f:1-e
t=this.b
s=t.a
r=v?e:1-f
q=new A.E(u*s,0,r*s,t.b)
$.a1()
p=A.ai()
p.r=d.gp(d)
x=x.r
u=this.c
if(x!=null)u.dt(x.a7(w).dc(q),p)
else u.fk(q,p)},
$S:656}
B.aBD.prototype={
$0(){var x,w,v=this.b,u=v.b/2,t=this.a,s=t.x
s.toString
x=Math.min(s,u)
$.a1()
w=A.ai()
s=t.w
w.r=s.gp(s)
switch(t.f.a){case 0:v=new A.f(u,u)
break
case 1:v=new A.f(v.a-u,u)
break
default:v=null}this.c.c_(v,x,w)},
$S:0}
B.aBE.prototype={
$2(d,e){return e*A.B(d,0,0.01)/0.01},
$S:93}
B.aBF.prototype={
$2(d,e){var x=this.a,w=x.gHa().x
w===$&&A.b()
return x.PB(d,w,this.b)},
$S:70};(function aliases(){var x=B.Lm.prototype
x.a84=x.l
x=B.Lv.prototype
x.a8e=x.l})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(B.rQ,A.Y)
v(A.vH,[B.aKV,B.aIw,B.awq,B.aBE,B.aBF])
v(A.jp,[B.aKW,B.aIy,B.awr,B.aBC])
v(A.X,[B.y0,B.arh])
v(A.R,[B.Go,B.Hs,B.RC])
v(A.Z,[B.a3B,B.Lm,B.Lv])
v(A.oq,[B.aIx,B.aBD])
w(B.WL,B.Lm)
w(B.Zb,A.vS)
w(B.CY,B.RC)
w(B.Zc,B.Lv)
v(A.x8,[B.aBA,B.aBB])
x(B.Lm,A.eW)
x(B.Lv,A.eW)})()
A.a3H(b.typeUniverse,JSON.parse('{"rQ":{"Y":[],"e":[]},"Go":{"R":[],"e":[]},"Hs":{"R":[],"e":[]},"a3B":{"Z":["Go"]},"WL":{"Z":["Hs"]},"CY":{"R":[],"e":[]},"RC":{"R":[],"e":[]},"Zb":{"ao":[]},"Zc":{"Z":["CY"]},"b5T":{"dv":[],"br":[],"bd":[],"e":[]}}'))
var y={n:A.aj("hE"),a:A.aj("mM"),B:A.aj("x<y0>"),u:A.aj("x<e>"),x:A.aj("ip"),o:A.aj("b5T"),w:A.aj("m"),C:A.aj("ud"),e:A.aj("r")};(function constants(){D.FS=new A.am(0,860,0,1/0)
D.Lh=new A.b1(18e5)
D.Lt=new A.b1(8e5)
D.O8=new A.mS("Hormone twin",null)
D.Kg=new A.e1(0.1,0,0.45,1)
D.Qc=new A.ho(0.7038888888888889,1,D.Kg)
D.Ki=new A.e1(0,0,0.65,1)
D.Qd=new A.ho(0.5555555555555556,0.8705555555555555,D.Ki)
D.Kh=new A.e1(0.4,0,1,1)
D.Qe=new A.ho(0.185,0.6016666666666667,D.Kh)
D.Kk=new A.e1(0.2,0,0.8,1)
D.Qm=new A.ho(0,0.4166666666666667,D.Kk)})()};
(a=>{a["iOJiCx2HT/tvb/lCQWQgkfWg/Nc="]=a.current})($__dart_deferred_initializers__);