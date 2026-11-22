((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,B={qy:function qy(d,e,f){this.c=d
this.d=e
this.a=f},
pm(d){if(d<0.22)return"Quiet"
if(d<0.42)return"Low"
if(d<0.62)return"Steady"
if(d<0.8)return"Rising"
return"High"},
b1R(a3,a4){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2=a3.d
if(a2<15)a2=28
x=C.i.bp(a4,1,a2)
w=A.aDK(x,a2,C.i.bp(a3.e,2,8))
v=A.aOZ(x,a2)
if(w===C.aT)u=0.84
else u=w===C.bT?0.24:0.46
A:{t=C.bT!==w
if(!t||C.bo===w){s=0.82
break A}if(C.eY===w||C.eZ===w){s=0.58
break A}if(C.bn===w||C.aT===w){s=0.34
break A}s=null}r=C.d.bp(0.5+A.aD_(w),0,1)
q=A.Jx(w)
B:{if("High"===q){p=0.28
break B}if("Moderate"===q){p=0.5
break B}p=0.78
break B}C:{if(!t||C.bo===w){t=0.8
break C}if(C.eY===w||C.eZ===w){t=0.62
break C}if(C.bn===w){t=0.36
break C}if(C.aT===w){t=0.4
break C}t=null}o=A.y(y.w,y.e)
n=a3.c
if(n)for(m=a3.ch,l=m.length,k=0;k<l;++k){j=m[k]
i=A.er(j.a)
if(i==null||A.dW(a3,i).c!==w)continue
for(h=j.f,g=h.length,f=0;f<h.length;h.length===g||(0,A.w)(h),++f){e=h[f]
d=o.h(0,e)
o.n(0,e,(d==null?0:d)+1)}}a0=n?"These are textbook words, not your hormone levels.":"No period date is saved. These are textbook words, not your hormone levels."
if(o.a!==0){n=o.$ti.i("cF<1,2>")
a1=A.L(new A.cF(o,n),n.i("o.E"))
C.b.dE(a1,new B.aCy())
n=C.b.gN(a1)
m=C.b.gN(a1)
l=C.b.gN(a1).b===1?"time":"times"
a0=a0+" In this phase you have logged "+n.a+" "+m.b+" "+l+". That is a pattern, not a diagnosis."}n=new B.aCz()
m=v.a
l=v.b
h=v.c
g=v.d
d=y.B
return new B.amD(x,w,A.a([n.$3("Estrogen",B.pm(m),m),n.$3("Progesterone",B.pm(l),l),n.$3("Testosterone",B.pm(h),h),n.$3("Cortisol",B.pm(g),g)],d),A.a([n.$3("Cravings",B.pm(u),u),n.$3("Mood",B.pm(s),s),n.$3("Energy",B.pm(r),r),n.$3("Sleep quality",B.pm(p),p),n.$3("Recovery",B.pm(t),t)],d),a0)},
aCy:function aCy(){},
aCz:function aCz(){},
wg:function wg(d,e,f){this.a=d
this.b=e
this.c=f},
amD:function amD(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.d=f
_.e=g
_.f=h},
aYS(){return new B.Ek(null)},
Ek:function Ek(d){this.a=d},
a08:function a08(){this.c=this.a=this.d=null},
aAs:function aAs(d){this.a=d},
aAr:function aAr(d,e){this.a=d
this.b=e},
aAq:function aAq(d,e){this.a=d
this.b=e},
OZ:function OZ(){},
W3:function W3(d,e,f,g,h,i,j,k,l,m){var _=this
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
aun:function aun(d,e,f){this.a=d
this.b=e
this.c=f},
auo:function auo(d,e,f){this.a=d
this.b=e
this.c=f},
aup:function aup(){},
AZ:function AZ(d,e,f,g,h,i,j,k){var _=this
_.y=d
_.c=e
_.d=f
_.e=g
_.f=h
_.r=i
_.w=j
_.a=k},
W4:function W4(d,e){var _=this
_.d=$
_.du$=d
_.bd$=e
_.c=_.a=null},
auq:function auq(d,e){this.a=d
this.b=e},
aul:function aul(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
aum:function aum(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
IX:function IX(){},
aWX(d){var x
d.M(y.o)
x=A.O(d)
return x.aW}},D
J=c[1]
A=c[0]
C=c[2]
B=a.updateHolder(c[5],B)
D=c[10]
B.qy.prototype={
G(d){var x=null,w=A.cI(x,x,C.z,x,x,new A.bk(this.c,x,x,x,x,x,C.aR),x,8,x,x,x,x,8)
return A.bA(A.a([w,C.AJ,A.k(this.d,x,x,x,x,A.n(x,x,(A.O(d).ax.a===C.q?C.v:C.u).d,x,x,x,x,x,"Outfit",x,x,12,x,x,C.e,x,1.35,!0,x,0,x,x,x,x,x,x),x,x)],y.u),C.w,C.j,C.bL,0)}}
B.wg.prototype={}
B.amD.prototype={}
B.Ek.prototype={
aa(){return new B.a08()}}
B.a08.prototype={
G(d){var x,w,v,u,t,s,r,q,p,o=this,n=null,m="Fraunces",l="Outfit",k=d.M(y.a).f,j=A.O(d).ax.a===C.q?C.v:C.u,i=A.fA(k.d,k.c.$0()).Q,h=k.d,g=h.r||h.x==="menopause",f=h.c||g,e=o.d
if(e==null)e=f?i.a:1
x=B.b1R(h,e)
h=j.c
w=A.k("A sketch of a cycle",n,n,n,n,A.n(n,n,h,n,n,n,n,n,m,n,n,46,n,n,C.t,n,1.05,!0,n,-0.7,n,n,n,n,n,n),n,n)
v=g?"This drawing is a textbook menstrual cycle. It is paused as a portrait of you while pregnancy or menopause is leading. Estrogen, progesterone, testosterone, and cortisol, drawn as a model. Drag across the days. Nothing here was measured in your blood.":"Estrogen, progesterone, testosterone, and cortisol, drawn as a model. Drag across the days. Nothing here was measured in your blood."
u=j.d
v=A.k(v,n,n,n,n,A.n(n,n,u,n,n,n,n,n,l,n,n,15.5,n,n,C.e,n,1.45,!0,n,0,n,n,n,n,n,n),n,n)
t=A.aOY(i.b)
s=f?i.a-1:-1
r=o.d==null?n:e-1
q=y.u
s=A.aj(A.a([A.aK0(!1,240,g?n:new B.aAs(o),r,t,s),C.o,A.k("Not a blood test. The word SKETCH is part of the drawing.",n,n,n,n,A.n(n,n,h,n,n,n,n,n,l,n,n,13,n,n,C.e,n,1.35,!0,n,0,n,n,n,n,n,n),n,n),C.o,A.bK(A.a([new B.qy(j.w,"Estrogen",n),new B.qy(j.y,"Progesterone",n),new B.qy(j.Q,"Testosterone",n),new B.qy(j.z,"Cortisol",n)],q),C.K,6,14)],q),C.r,C.j,C.k)
t=!f
if(t&&o.d==null)r="Not enough information yet"
else{r=x.b
p=""+x.a
r=f?"Textbook day "+p+" \xb7 "+A.tz(r):"Textbook day "+p+" \xb7 "+A.tz(r)}h=A.a([D.Ip,C.o,w,C.P,D.Ia,C.o,v,C.J,new A.bN(s,C.ah,28,n,n,n),C.a9,A.k(r,n,n,n,n,A.n(n,n,h,n,n,n,n,n,m,n,n,28,n,n,C.t,n,1.05,!0,n,-0.7,n,n,n,n,n,n),n,n),C.o,A.k(x.f,n,n,n,n,A.n(n,n,u,n,n,n,n,n,l,n,n,14.5,n,n,C.e,n,1.4,!0,n,0,n,n,n,n,n,n),n,n)],q)
if(!t||o.d!=null)C.b.I(h,A.a([C.a9,o.Qr(x.d),C.J,A.k("Typical associations",n,n,n,n,A.n(n,n,u,n,n,n,n,n,l,n,n,13,n,n,C.D,n,1.35,!0,n,0.5,n,n,n,n,n,n),n,n),C.o,o.Qr(x.e)],q))
h.push(C.J)
h.push(A.k("Educational model. Not a diagnosis, a lab, or a reason to start or stop medication.",n,n,n,n,A.n(n,n,j.e,n,n,n,n,n,l,n,n,12.5,n,n,C.e,n,1.4,!0,n,0,n,n,n,n,n,n),n,n))
return A.ir(C.C,A.hH(!1,A.ii(A.a([A.dH(new A.dy(D.CC,A.aj(h,C.r,C.j,C.k),n),n,n)],q),n,n,C.hN,C.ak),C.ao,!0))},
Qr(d){var x=this.c
x.toString
return A.aFx(new B.aAq(d,A.O(x).ax.a===C.q?C.v:C.u))}}
B.OZ.prototype={}
B.W3.prototype={
aC(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=this,l=m.y
if(l==null)l=0
x=new B.aun(m,e,d)
w=new B.aup()
v=l/e.a
u=m.d
t=u==null?null:A.z(u,0,1)
if(t!=null){s=v>0?t+w.$2(t,v):0
if(s<1)x.$3$color$endFraction$startFraction(m.b,1,s)
w=m.x
if(w!=null&&w>0)new B.auo(m,e,d).$0()
if(t>0)x.$3$color$endFraction$startFraction(m.c,t,0)
return}u=m.e
r=D.JY.ah(0,u)
q=D.JQ.ah(0,u)
p=D.JP.ah(0,u)
o=D.JO.ah(0,u)
if(r<1-v){s=r>0?r+w.$2(r,v):0
x.$3$color$endFraction$startFraction(m.b,1,s)}if(r-q>0)x.$3$color$endFraction$startFraction(m.c,r,q)
if(q>v){s=p>0?p+w.$2(p,v):0
n=q<1?q-w.$2(1-q,v):1
x.$3$color$endFraction$startFraction(m.b,n,s)}if(p-o>0)x.$3$color$endFraction$startFraction(m.c,p,o)
if(o>v){n=o<1?o-w.$2(1-o,v):1
x.$3$color$endFraction$startFraction(m.b,n,0)}},
dD(d){var x=this
return!d.b.j(0,x.b)||!d.c.j(0,x.c)||d.d!=x.d||d.e!==x.e||d.f!==x.f||!J.d(d.r,x.r)||!J.d(d.w,x.w)||d.x!=x.x||d.y!=x.y}}
B.AZ.prototype={
aa(){return new B.W4(null,null)}}
B.W4.prototype={
aD(){var x,w=this
w.aS()
x=A.c1(null,D.GR,null,null,w)
w.d!==$&&A.bb()
w.d=x
w.To()},
aY(d){this.bh(d)
this.To()},
l(){var x=this.d
x===$&&A.b()
x.l()
this.a4u()},
gFv(){var x,w=this
w.a.toString
w.c.vP(y.o)
w.c.Io(y.C)
x=w.d
x===$&&A.b()
return x},
To(){var x,w=this,v=w.a.c
A.z(v,0,1)
x=!1
if(x){v=w.d
v===$&&A.b()
v.Bi(0)}else{A.z(v,0,1)
v=w.d
v===$&&A.b()
v=v.r
v=v!=null&&v.a!=null
if(v){v=w.d
v===$&&A.b()
v.f9(0)}}},
N0(d,e,f){var x,w,v,u,t,s,r,q,p=this,o=null,n=B.aWX(d)
p.a.toString
A.O(d)
switch(!0){case!0:x=new B.aum(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
case!1:x=new B.aul(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
default:x=o}w=p.a
w.toString
w=w.d
v=w==null?n.b:w
if(v==null)v=x.gqT()
u=p.a.y
t=n.f
if(t==null)t=x.f
w=p.a
w.toString
x.gdd(x)
x=p.a
s=x.c
r=A.z(s,0,1)
w=A.fY(o,o,o,new B.W3(v,w.e,r,e,f,t,o,o,o,o),C.M)
if(t!=null)A.z(s,0,1)
q=x.w
s=A.z(s,0,1)
q=""+C.d.aw(s*100)
x=x.r
return A.c9(o,new A.dy(new A.ak(1/0,1/0,u,1/0),w,o),!1,o,o,!1,o,o,o,o,o,o,o,x,o,o,"100",o,"0",o,o,o,o,o,o,o,o,o,o,o,C.Wf,o,o,o,o,o,o,o,q)},
G(d){var x,w=this,v=d.M(y.n).w
A.z(w.a.c,0,1)
x=w.gFv().x
x===$&&A.b()
return w.N0(d,x,v)
return A.hY(w.gFv(),new B.auq(w,v),null)}}
B.aul.prototype={
gtL(){var x,w=this,v=w.CW
if(v===$){x=A.O(w.ch)
w.CW!==$&&A.aS()
v=w.CW=x.ax}return v},
gdd(d){return this.gtL().b},
gqT(){var x=this.gtL(),w=x.aI
return w==null?x.k2:w},
gv7(){return 4}}
B.aum.prototype={
gtL(){var x,w=this,v=w.CW
if(v===$){x=A.O(w.ch)
w.CW!==$&&A.aS()
v=w.CW=x.ax}return v},
gdd(d){return this.gtL().b},
gqT(){var x=this.gtL(),w=x.Q
return w==null?x.y:w},
gv7(){return 4}}
B.IX.prototype={
l(){var x=this,w=x.bd$
if(w!=null)w.L(0,x.gf_())
x.bd$=null
x.az()},
by(){this.cd()
this.c7()
this.f0()}}
var z=a.updateTypes(["wg(l,l,J)"])
B.aCy.prototype={
$2(d,e){return C.i.b6(e.b,d.b)},
$S:43}
B.aCz.prototype={
$3(d,e,f){return new B.wg(d,"Sketch \xb7 "+e,f)},
$S:z+0}
B.aAs.prototype={
$1(d){var x=this.a
return x.U(new B.aAr(x,d))},
$S:24}
B.aAr.prototype={
$0(){return this.a.d=this.b+1},
$S:0}
B.aAq.prototype={
$2(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=null,l=e.b,k=l>640?4:2,j=(l-(k-1)*10)/k
l=y.u
x=A.a([],l)
for(w=this.a,v=w.length,u=this.b,t=u.r,s=u.w,r=u.c,u=u.d,q=0;q<w.length;w.length===v||(0,A.w)(w),++q){p=w[q]
o=A.k(p.a,m,m,m,m,new A.m(!0,u,m,"Outfit",m,m,12,C.e,m,0,m,m,1.35,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m)
n=new A.aP(99,99)
x.push(new A.cA(j,m,new A.bN(A.aj(A.a([o,C.R,A.k(p.b,m,m,m,m,new A.m(!0,r,m,"Fraunces",m,m,22,C.t,m,-0.7,m,m,1.05,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m),C.o,new A.z2(new A.c7(n,n,n,n),new B.AZ(4,C.d.bp(p.c,0,1),t,s,m,m,m,m),m)],l),C.r,C.j,C.k),C.dY,20,m,m,m),m))}return A.bK(x,C.K,10,10)},
$S:593}
B.aun.prototype={
$3$color$endFraction$startFraction(d,e,f){var x,w,v,u,t,s,r,q,p
if(e-f<=0)return
x=this.a
w=x.f
v=w===C.a4
u=v?f:1-e
t=this.b
s=t.a
r=v?e:1-f
q=new A.A(u*s,0,r*s,t.b)
$.a5()
p=A.aY()
p.r=d.gu(d)
x=x.r
u=this.c
if(x!=null)u.dY(x.a7(w).dl(q),p)
else u.f1(q,p)},
$S:594}
B.auo.prototype={
$0(){var x,w,v=this.b,u=v.b/2,t=this.a,s=t.x
s.toString
x=Math.min(s,u)
$.a5()
w=A.aY()
s=t.w
w.r=s.gu(s)
switch(t.f.a){case 0:v=new A.j(u,u)
break
case 1:v=new A.j(v.a-u,u)
break
default:v=null}this.c.fh(v,x,w)},
$S:0}
B.aup.prototype={
$2(d,e){return e*A.z(d,0,0.01)/0.01},
$S:108}
B.auq.prototype={
$2(d,e){var x=this.a,w=x.gFv().x
w===$&&A.b()
return x.N0(d,w,this.b)},
$S:78};(function aliases(){var x=B.IX.prototype
x.a4u=x.l})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(B.qy,A.aa)
v(A.z7,[B.aCy,B.aAq,B.aup,B.auq])
v(A.iK,[B.aCz,B.aAs,B.aun])
v(A.Q,[B.wg,B.amD])
v(A.a1,[B.Ek,B.OZ])
v(A.ab,[B.a08,B.IX])
v(A.no,[B.aAr,B.auo])
w(B.W3,A.uh)
w(B.AZ,B.OZ)
w(B.W4,B.IX)
v(A.vm,[B.aul,B.aum])
x(B.IX,A.eD)})()
A.a0e(b.typeUniverse,JSON.parse('{"qy":{"aa":[],"e":[]},"Ek":{"a1":[],"e":[]},"a08":{"ab":["Ek"]},"AZ":{"a1":[],"e":[]},"OZ":{"a1":[],"e":[]},"W3":{"ap":[]},"W4":{"ab":["AZ"]},"aWU":{"dA":[],"bt":[],"bf":[],"e":[]}}'))
var y={n:A.am("i2"),a:A.am("lQ"),B:A.am("x<wg>"),u:A.am("x<e>"),o:A.am("aWU"),w:A.am("l"),C:A.am("w9"),e:A.am("q")};(function constants(){D.CC=new A.ak(0,860,0,1/0)
D.GR=new A.aZ(18e5)
D.Ia=new A.hw(84,C.l6,!1,null)
D.Ip=new A.lW("Hormone twin",null)
D.G5=new A.dY(0.1,0,0.45,1)
D.JO=new A.fJ(0.7038888888888889,1,D.G5)
D.G7=new A.dY(0,0,0.65,1)
D.JP=new A.fJ(0.5555555555555556,0.8705555555555555,D.G7)
D.G6=new A.dY(0.4,0,1,1)
D.JQ=new A.fJ(0.185,0.6016666666666667,D.G6)
D.G9=new A.dY(0.2,0,0.8,1)
D.JY=new A.fJ(0,0.4166666666666667,D.G9)})()};
(a=>{a["+d0HXnLT82VNoW5pyChiQHzBorc="]=a.current})($__dart_deferred_initializers__);