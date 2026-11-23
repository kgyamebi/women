((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,E,F,B={qs:function qs(d,e,f){this.c=d
this.d=e
this.a=f},
pc(d){if(d<0.22)return"Quiet"
if(d<0.42)return"Low"
if(d<0.62)return"Steady"
if(d<0.8)return"Rising"
return"High"},
b1m(a3,a4){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2=a3.d
if(a2<15)a2=28
x=C.i.bo(a4,1,a2)
w=A.aDc(x,a2,C.i.bo(a3.e,2,8))
v=A.aOw(x,a2)
if(w===C.aW)u=0.84
else u=w===C.bW?0.24:0.46
A:{t=C.bW!==w
if(!t||C.bu===w){s=0.82
break A}if(C.f5===w||C.f6===w){s=0.58
break A}if(C.bt===w||C.aW===w){s=0.34
break A}s=null}r=C.d.bo(0.5+A.aCr(w),0,1)
q=A.Jm(w)
B:{if("High"===q){p=0.28
break B}if("Moderate"===q){p=0.5
break B}p=0.78
break B}C:{if(!t||C.bu===w){t=0.8
break C}if(C.f5===w||C.f6===w){t=0.62
break C}if(C.bt===w){t=0.36
break C}if(C.aW===w){t=0.4
break C}t=null}o=A.y(y.w,y.e)
n=a3.c
if(n)for(m=a3.dx,l=m.length,k=0;k<l;++k){j=m[k]
i=A.dY(j.a)
if(i==null||A.dL(a3,i).c!==w)continue
for(h=j.f,g=h.length,f=0;f<h.length;h.length===g||(0,A.w)(h),++f){e=h[f]
d=o.h(0,e)
o.n(0,e,(d==null?0:d)+1)}}a0=n?"These are textbook words, not your hormone levels.":"No period date is saved. These are textbook words, not your hormone levels."
if(o.a!==0){n=o.$ti.i("cH<1,2>")
a1=A.J(new A.cH(o,n),n.i("p.E"))
C.b.dE(a1,new B.aC0())
n=C.b.gM(a1)
m=C.b.gM(a1)
l=C.b.gM(a1).b===1?"time":"times"
a0=a0+" In this phase you have logged "+n.a+" "+m.b+" "+l+". That is a pattern, not a diagnosis."}n=new B.aC1()
m=v.a
l=v.b
h=v.c
g=v.d
d=y.B
return new B.alQ(x,w,A.a([n.$3("Estrogen",B.pc(m),m),n.$3("Progesterone",B.pc(l),l),n.$3("Testosterone",B.pc(h),h),n.$3("Cortisol",B.pc(g),g)],d),A.a([n.$3("Cravings",B.pc(u),u),n.$3("Mood",B.pc(s),s),n.$3("Energy",B.pc(r),r),n.$3("Sleep quality",B.pc(p),p),n.$3("Recovery",B.pc(t),t)],d),a0)},
aC0:function aC0(){},
aC1:function aC1(){},
wc:function wc(d,e,f){this.a=d
this.b=e
this.c=f},
alQ:function alQ(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.d=f
_.e=g
_.f=h},
aYn(){return new B.E7(null)},
E7:function E7(d){this.a=d},
a_K:function a_K(){this.c=this.a=this.d=null},
azR:function azR(d){this.a=d},
azQ:function azQ(d,e){this.a=d
this.b=e},
azP:function azP(d,e){this.a=d
this.b=e},
OE:function OE(){},
VF:function VF(d,e,f,g,h,i,j,k,l,m){var _=this
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
atD:function atD(d,e,f){this.a=d
this.b=e
this.c=f},
atE:function atE(d,e,f){this.a=d
this.b=e
this.c=f},
atF:function atF(){},
AK:function AK(d,e,f,g,h,i,j,k){var _=this
_.y=d
_.c=e
_.d=f
_.e=g
_.f=h
_.r=i
_.w=j
_.a=k},
VG:function VG(d,e){var _=this
_.d=$
_.dN$=d
_.bg$=e
_.c=_.a=null},
atG:function atG(d,e){this.a=d
this.b=e},
atB:function atB(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
atC:function atC(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
IM:function IM(){},
aWu(d){var x
d.K(y.o)
x=A.I(d)
return x.aY}},D
J=c[1]
A=c[0]
C=c[2]
E=c[8]
F=c[10]
B=a.updateHolder(c[5],B)
D=c[11]
B.qs.prototype={
F(d){var x=null,w=A.c4(x,x,C.x,x,x,new A.aW(this.c,x,x,x,x,x,C.aU),x,8,x,x,x,x,8)
return A.ba(A.a([w,C.mF,A.k(this.d,x,x,x,x,A.l(x,x,(A.I(d).ax.a===C.q?C.t:C.u).d,x,x,x,x,x,"Outfit",x,x,12,x,x,C.e,x,1.35,!0,x,0,x,x,x,x,x,x),x,x)],y.u),C.v,C.j,C.bF,0)}}
B.wc.prototype={}
B.alQ.prototype={}
B.E7.prototype={
a8(){return new B.a_K()}}
B.a_K.prototype={
F(d){var x,w,v,u,t,s,r,q=this,p=null,o="Fraunces",n="Outfit",m=d.K(y.a).f,l=A.I(d).ax.a===C.q?C.t:C.u,k=A.f4(m.d,m.c.$0()).Q,j=m.d,i=j.r||j.x==="menopause",h=j.c||i,g=q.d
if(g==null)g=h?k.a:1
x=B.b1m(j,g)
j=l.c
w=y.u
v=A.ba(A.a([A.bK(A.k("A sketch of a cycle",p,p,p,p,A.l(p,p,j,p,p,p,p,p,o,p,p,30,p,p,C.w,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),1),C.aR,F.p9],w),C.v,C.j,C.k,0)
u=A.aOv(k.b)
t=h?k.a-1:-1
s=q.d==null?p:g-1
u=A.ad(A.a([A.aJx(!1,240,i?p:new B.azR(q),s,u,t),C.l,A.k("Not a blood test.",p,p,p,p,A.l(p,p,j,p,p,p,p,p,n,p,p,14,p,p,C.B,p,1.35,!0,p,0,p,p,p,p,p,p),p,p),C.l,A.bE(A.a([new B.qs(l.w,"Estrogen",p),new B.qs(l.y,"Progesterone",p),new B.qs(l.Q,"Testosterone",p),new B.qs(l.z,"Cortisol",p)],w),C.I,6,14)],w),C.r,C.j,C.k)
t=!h
if(t&&q.d==null)s="Not enough information yet"
else{s=x.b
r=""+x.a
s=h?"Textbook day "+r+" \xb7 "+A.tv(s):"Textbook day "+r+" \xb7 "+A.tv(s)}r=l.d
j=A.a([D.Jv,C.a3,v,C.L,new A.bL(u,C.ad,28,p,p,p),C.aq,A.k(s,p,p,p,p,A.l(p,p,j,p,p,p,p,p,o,p,p,28,p,p,C.w,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),C.l,A.k(x.f,p,p,p,p,A.l(p,p,r,p,p,p,p,p,n,p,p,14.5,p,p,C.e,p,1.4,!0,p,0,p,p,p,p,p,p),p,p)],w)
if(!t||q.d!=null)C.b.I(j,A.a([C.aq,q.PY(x.d),C.L,A.k("Typical associations",p,p,p,p,A.l(p,p,r,p,p,p,p,p,n,p,p,13,p,p,C.B,p,1.35,!0,p,0.5,p,p,p,p,p,p),p,p),C.l,q.PY(x.e)],w))
j.push(C.L)
j.push(A.k("Educational model. Not a diagnosis, a lab, or a reason to start or stop medication.",p,p,p,p,A.l(p,p,l.e,p,p,p,p,p,n,p,p,12.5,p,p,C.e,p,1.4,!0,p,0,p,p,p,p,p,p),p,p))
return A.hg(C.C,A.hf(!1,A.fM(A.a([A.dj(new A.dB(D.Dd,A.ad(j,C.r,C.j,C.k),p),p,p)],w),p,p,E.hW,C.af),C.al,!0))},
PY(d){var x=this.c
x.toString
return A.aF2(new B.azP(d,A.I(x).ax.a===C.q?C.t:C.u))}}
B.OE.prototype={}
B.VF.prototype={
aC(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=this,l=m.y
if(l==null)l=0
x=new B.atD(m,e,d)
w=new B.atF()
v=l/e.a
u=m.d
t=u==null?null:A.z(u,0,1)
if(t!=null){s=v>0?t+w.$2(t,v):0
if(s<1)x.$3$color$endFraction$startFraction(m.b,1,s)
w=m.x
if(w!=null&&w>0)new B.atE(m,e,d).$0()
if(t>0)x.$3$color$endFraction$startFraction(m.c,t,0)
return}u=m.e
r=D.KO.ag(0,u)
q=D.KG.ag(0,u)
p=D.KF.ag(0,u)
o=D.KE.ag(0,u)
if(r<1-v){s=r>0?r+w.$2(r,v):0
x.$3$color$endFraction$startFraction(m.b,1,s)}if(r-q>0)x.$3$color$endFraction$startFraction(m.c,r,q)
if(q>v){s=p>0?p+w.$2(p,v):0
n=q<1?q-w.$2(1-q,v):1
x.$3$color$endFraction$startFraction(m.b,n,s)}if(p-o>0)x.$3$color$endFraction$startFraction(m.c,p,o)
if(o>v){n=o<1?o-w.$2(1-o,v):1
x.$3$color$endFraction$startFraction(m.b,n,0)}},
di(d){var x=this
return!d.b.j(0,x.b)||!d.c.j(0,x.c)||d.d!=x.d||d.e!==x.e||d.f!==x.f||!J.d(d.r,x.r)||!J.d(d.w,x.w)||d.x!=x.x||d.y!=x.y}}
B.AK.prototype={
a8(){return new B.VG(null,null)}}
B.VG.prototype={
aH(){var x,w=this
w.aV()
x=A.c7(null,D.HV,null,null,w)
w.d!==$&&A.bd()
w.d=x
w.SP()},
b_(d){this.bj(d)
this.SP()},
l(){var x=this.d
x===$&&A.b()
x.l()
this.a3x()},
gF7(){var x,w=this
w.a.toString
w.c.BA(y.o)
w.c.HY(y.C)
x=w.d
x===$&&A.b()
return x},
SP(){var x,w=this,v=w.a.c
A.z(v,0,1)
x=!1
if(x){v=w.d
v===$&&A.b()
v.Js(0)}else{A.z(v,0,1)
v=w.d
v===$&&A.b()
v=v.r
v=v!=null&&v.a!=null
if(v){v=w.d
v===$&&A.b()
v.f6(0)}}},
MB(d,e,f){var x,w,v,u,t,s,r,q,p=this,o=null,n=B.aWu(d)
p.a.toString
A.I(d)
switch(!0){case!0:x=new B.atC(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
case!1:x=new B.atB(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
default:x=o}w=p.a
w.toString
w=w.d
v=w==null?n.b:w
if(v==null)v=x.gqP()
u=p.a.y
t=n.f
if(t==null)t=x.f
w=p.a
w.toString
x.gdJ(x)
x=p.a
s=x.c
r=A.z(s,0,1)
w=A.f7(o,o,o,new B.VF(v,w.e,r,e,f,t,o,o,o,o),C.K)
if(t!=null)A.z(s,0,1)
q=x.w
s=A.z(s,0,1)
q=""+C.d.aF(s*100)
x=x.r
return A.bZ(o,new A.dB(new A.al(1/0,1/0,u,1/0),w,o),!1,o,o,!1,o,o,o,o,o,o,x,o,o,"100",o,"0",o,o,o,o,o,o,o,o,o,o,o,C.Xq,o,o,o,o,o,o,o,o,q)},
F(d){var x,w=this,v=d.K(y.n).w
A.z(w.a.c,0,1)
x=w.gF7().x
x===$&&A.b()
return w.MB(d,x,v)
return A.i3(w.gF7(),new B.atG(w,v),null)}}
B.atB.prototype={
gtE(){var x,w=this,v=w.CW
if(v===$){x=A.I(w.ch)
w.CW!==$&&A.aR()
v=w.CW=x.ax}return v},
gdJ(d){return this.gtE().b},
gqP(){var x=this.gtE(),w=x.aw
return w==null?x.k2:w},
guX(){return 4}}
B.atC.prototype={
gtE(){var x,w=this,v=w.CW
if(v===$){x=A.I(w.ch)
w.CW!==$&&A.aR()
v=w.CW=x.ax}return v},
gdJ(d){return this.gtE().b},
gqP(){var x=this.gtE(),w=x.Q
return w==null?x.y:w},
guX(){return 4}}
B.IM.prototype={
l(){var x=this,w=x.bg$
if(w!=null)w.N(0,x.gfd())
x.bg$=null
x.aB()},
bE(){this.ck()
this.cb()
this.fe()}}
var z=a.updateTypes(["wc(m,m,L)"])
B.aC0.prototype={
$2(d,e){return C.i.b8(e.b,d.b)},
$S:45}
B.aC1.prototype={
$3(d,e,f){return new B.wc(d,"Sketch \xb7 "+e,f)},
$S:z+0}
B.azR.prototype={
$1(d){var x=this.a
return x.U(new B.azQ(x,d))},
$S:25}
B.azQ.prototype={
$0(){return this.a.d=this.b+1},
$S:0}
B.azP.prototype={
$2(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=null,l=e.b,k=l>640?4:2,j=(l-(k-1)*10)/k
l=y.u
x=A.a([],l)
for(w=this.a,v=w.length,u=this.b,t=u.r,s=u.w,r=u.c,u=u.d,q=0;q<w.length;w.length===v||(0,A.w)(w),++q){p=w[q]
o=A.k(p.a,m,m,m,m,new A.n(!0,u,m,"Outfit",m,m,12,C.e,m,0,m,m,1.35,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m)
n=new A.aF(99,99)
x.push(new A.cf(j,m,new A.bL(A.ad(A.a([o,C.U,A.k(p.b,m,m,m,m,new A.n(!0,r,m,"Fraunces",m,m,22,C.w,m,-0.7,m,m,1.05,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m),C.l,new A.yU(new A.c6(n,n,n,n),new B.AK(4,C.d.bo(p.c,0,1),t,s,m,m,m,m),m)],l),C.r,C.j,C.k),C.kJ,20,m,m,m),m))}return A.bE(x,C.I,10,10)},
$S:584}
B.atD.prototype={
$3$color$endFraction$startFraction(d,e,f){var x,w,v,u,t,s,r,q,p
if(e-f<=0)return
x=this.a
w=x.f
v=w===C.a7
u=v?f:1-e
t=this.b
s=t.a
r=v?e:1-f
q=new A.C(u*s,0,r*s,t.b)
$.a5()
p=A.aH()
p.r=d.gq(d)
x=x.r
u=this.c
if(x!=null)u.d9(x.ab(w).dr(q),p)
else u.eZ(q,p)},
$S:585}
B.atE.prototype={
$0(){var x,w,v=this.b,u=v.b/2,t=this.a,s=t.x
s.toString
x=Math.min(s,u)
$.a5()
w=A.aH()
s=t.w
w.r=s.gq(s)
switch(t.f.a){case 0:v=new A.h(u,u)
break
case 1:v=new A.h(v.a-u,u)
break
default:v=null}this.c.cT(v,x,w)},
$S:0}
B.atF.prototype={
$2(d,e){return e*A.z(d,0,0.01)/0.01},
$S:99}
B.atG.prototype={
$2(d,e){var x=this.a,w=x.gF7().x
w===$&&A.b()
return x.MB(d,w,this.b)},
$S:83};(function aliases(){var x=B.IM.prototype
x.a3x=x.l})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(B.qs,A.a8)
v(A.u0,[B.aC0,B.azP,B.atF,B.atG])
v(A.iN,[B.aC1,B.azR,B.atD])
v(A.R,[B.wc,B.alQ])
v(A.a1,[B.E7,B.OE])
v(A.ab,[B.a_K,B.IM])
v(A.ne,[B.azQ,B.atE])
w(B.VF,A.ua)
w(B.AK,B.OE)
w(B.VG,B.IM)
v(A.vk,[B.atB,B.atC])
x(B.IM,A.eZ)})()
A.a_Q(b.typeUniverse,JSON.parse('{"qs":{"a8":[],"e":[]},"E7":{"a1":[],"e":[]},"a_K":{"ab":["E7"]},"AK":{"a1":[],"e":[]},"OE":{"a1":[],"e":[]},"VF":{"ao":[]},"VG":{"ab":["AK"]},"aWr":{"dE":[],"bu":[],"bg":[],"e":[]}}'))
var y={n:A.aj("i8"),a:A.aj("lJ"),B:A.aj("x<wc>"),u:A.aj("x<e>"),o:A.aj("aWr"),w:A.aj("m"),C:A.aj("w6"),e:A.aj("r")};(function constants(){D.Dd=new A.al(0,860,0,1/0)
D.HV=new A.b6(18e5)
D.Jv=new A.lP("Hormone twin",null)
D.H5=new A.e2(0.1,0,0.45,1)
D.KE=new A.fL(0.7038888888888889,1,D.H5)
D.H7=new A.e2(0,0,0.65,1)
D.KF=new A.fL(0.5555555555555556,0.8705555555555555,D.H7)
D.H6=new A.e2(0.4,0,1,1)
D.KG=new A.fL(0.185,0.6016666666666667,D.H6)
D.H9=new A.e2(0.2,0,0.8,1)
D.KO=new A.fL(0,0.4166666666666667,D.H9)})()};
(a=>{a["XyBuGrwmlexqjplwlUpmHwOvSWU="]=a.current})($__dart_deferred_initializers__);