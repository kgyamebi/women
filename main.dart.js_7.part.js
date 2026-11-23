((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,E,F,B={qA:function qA(d,e,f){this.c=d
this.d=e
this.a=f},
pk(d){if(d<0.22)return"Quiet"
if(d<0.42)return"Low"
if(d<0.62)return"Steady"
if(d<0.8)return"Rising"
return"High"},
b24(a3,a4){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2=a3.d
if(a2<15)a2=28
x=C.i.b2(a4,1,a2)
w=A.aDA(x,a2,C.i.b2(a3.e,2,8))
v=A.aP3(x,a2)
if(w===C.aX)u=0.84
else u=w===C.bW?0.24:0.46
A:{t=C.bW!==w
if(!t||C.bv===w){s=0.82
break A}if(C.f5===w||C.f6===w){s=0.58
break A}if(C.bu===w||C.aX===w){s=0.34
break A}s=null}r=C.d.b2(0.5+A.aCP(w),0,1)
q=A.Jz(w)
B:{if("High"===q){p=0.28
break B}if("Moderate"===q){p=0.5
break B}p=0.78
break B}C:{if(!t||C.bv===w){t=0.8
break C}if(C.f5===w||C.f6===w){t=0.62
break C}if(C.bu===w){t=0.36
break C}if(C.aX===w){t=0.4
break C}t=null}o=A.y(y.w,y.e)
n=a3.c
if(n)for(m=a3.dx,l=m.length,k=0;k<l;++k){j=m[k]
i=A.e_(j.a)
if(i==null||A.dN(a3,i).c!==w)continue
for(h=j.f,g=h.length,f=0;f<h.length;h.length===g||(0,A.x)(h),++f){e=h[f]
d=o.h(0,e)
o.n(0,e,(d==null?0:d)+1)}}a0=n?"These are textbook words, not your hormone levels.":"No period date is saved. These are textbook words, not your hormone levels."
if(o.a!==0){n=o.$ti.i("cI<1,2>")
a1=A.M(new A.cI(o,n),n.i("q.E"))
C.b.dD(a1,new B.aCn())
n=C.b.gM(a1)
m=C.b.gM(a1)
l=C.b.gM(a1).b===1?"time":"times"
a0=a0+" In this phase you have logged "+n.a+" "+m.b+" "+l+". That is a pattern, not a diagnosis."}n=new B.aCo()
m=v.a
l=v.b
h=v.c
g=v.d
d=y.B
return new B.am7(x,w,A.a([n.$3("Estrogen",B.pk(m),m),n.$3("Progesterone",B.pk(l),l),n.$3("Testosterone",B.pk(h),h),n.$3("Cortisol",B.pk(g),g)],d),A.a([n.$3("Cravings",B.pk(u),u),n.$3("Mood",B.pk(s),s),n.$3("Energy",B.pk(r),r),n.$3("Sleep quality",B.pk(p),p),n.$3("Recovery",B.pk(t),t)],d),a0)},
aCn:function aCn(){},
aCo:function aCo(){},
wn:function wn(d,e,f){this.a=d
this.b=e
this.c=f},
am7:function am7(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.d=f
_.e=g
_.f=h},
aYY(){return new B.El(null)},
El:function El(d){this.a=d},
a_X:function a_X(){this.c=this.a=this.d=null},
aAb:function aAb(d){this.a=d},
aAa:function aAa(d,e){this.a=d
this.b=e},
aA9:function aA9(d,e){this.a=d
this.b=e},
OQ:function OQ(){},
VR:function VR(d,e,f,g,h,i,j,k,l,m){var _=this
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
atX:function atX(d,e,f){this.a=d
this.b=e
this.c=f},
atY:function atY(d,e,f){this.a=d
this.b=e
this.c=f},
atZ:function atZ(){},
AW:function AW(d,e,f,g,h,i,j,k){var _=this
_.y=d
_.c=e
_.d=f
_.e=g
_.f=h
_.r=i
_.w=j
_.a=k},
VS:function VS(d,e){var _=this
_.d=$
_.dN$=d
_.bh$=e
_.c=_.a=null},
au_:function au_(d,e){this.a=d
this.b=e},
atV:function atV(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
atW:function atW(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t){var _=this
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
IZ:function IZ(){},
aX4(d){var x
d.K(y.o)
x=A.L(d)
return x.aY}},D
J=c[1]
A=c[0]
C=c[2]
E=c[8]
F=c[10]
B=a.updateHolder(c[5],B)
D=c[11]
B.qA.prototype={
F(d){var x=null,w=A.c4(x,x,C.x,x,x,new A.aW(this.c,x,x,x,x,x,C.aV),x,8,x,x,x,x,8)
return A.ba(A.a([w,C.mJ,A.k(this.d,x,x,x,x,A.l(x,x,(A.L(d).ax.a===C.q?C.t:C.u).d,x,x,x,x,x,"Outfit",x,x,12,x,x,C.e,x,1.35,!0,x,0,x,x,x,x,x,x),x,x)],y.u),C.v,C.j,C.bF,0)}}
B.wn.prototype={}
B.am7.prototype={}
B.El.prototype={
a8(){return new B.a_X()}}
B.a_X.prototype={
F(d){var x,w,v,u,t,s,r,q=this,p=null,o="Fraunces",n="Outfit",m=d.K(y.a).f,l=A.L(d).ax.a===C.q?C.t:C.u,k=A.f9(m.d,m.c.$0()).Q,j=m.d,i=j.r||j.x==="menopause",h=j.c||i,g=q.d
if(g==null)g=h?k.a:1
x=B.b24(j,g)
j=l.c
w=y.u
v=A.ba(A.a([A.bM(A.k("A sketch of a cycle",p,p,p,p,A.l(p,p,j,p,p,p,p,p,o,p,p,30,p,p,C.w,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),1),C.aS,F.pf],w),C.v,C.j,C.k,0)
u=A.aP2(k.b)
t=h?k.a-1:-1
s=q.d==null?p:g-1
u=A.ad(A.a([A.aJY(!1,240,i?p:new B.aAb(q),s,u,t),C.l,A.k("Not a blood test.",p,p,p,p,A.l(p,p,j,p,p,p,p,p,n,p,p,14,p,p,C.B,p,1.35,!0,p,0,p,p,p,p,p,p),p,p),C.l,A.bF(A.a([new B.qA(l.w,"Estrogen",p),new B.qA(l.y,"Progesterone",p),new B.qA(l.Q,"Testosterone",p),new B.qA(l.z,"Cortisol",p)],w),C.I,6,14)],w),C.r,C.j,C.k)
t=!h
if(t&&q.d==null)s="Not enough information yet"
else{s=x.b
r=""+x.a
s=h?"Textbook day "+r+" \xb7 "+A.tC(s):"Textbook day "+r+" \xb7 "+A.tC(s)}r=l.d
j=A.a([D.Kb,C.a3,v,C.L,new A.bN(u,C.ad,28,p,p,p),C.aq,A.k(s,p,p,p,p,A.l(p,p,j,p,p,p,p,p,o,p,p,28,p,p,C.w,p,1.05,!0,p,-0.7,p,p,p,p,p,p),p,p),C.l,A.k(x.f,p,p,p,p,A.l(p,p,r,p,p,p,p,p,n,p,p,14.5,p,p,C.e,p,1.4,!0,p,0,p,p,p,p,p,p),p,p)],w)
if(!t||q.d!=null)C.b.I(j,A.a([C.aq,q.Q2(x.d),C.L,A.k("Typical associations",p,p,p,p,A.l(p,p,r,p,p,p,p,p,n,p,p,13,p,p,C.B,p,1.35,!0,p,0.5,p,p,p,p,p,p),p,p),C.l,q.Q2(x.e)],w))
j.push(C.L)
j.push(A.k("Educational model. Not a diagnosis, a lab, or a reason to start or stop medication.",p,p,p,p,A.l(p,p,l.e,p,p,p,p,p,n,p,p,12.5,p,p,C.e,p,1.4,!0,p,0,p,p,p,p,p,p),p,p))
return A.hj(C.C,A.hi(!1,A.fR(A.a([A.dl(new A.dF(D.DE,A.ad(j,C.r,C.j,C.k),p),p,p)],w),p,p,E.hY,C.af),C.al,!0))},
Q2(d){var x=this.c
x.toString
return A.aFr(new B.aA9(d,A.L(x).ax.a===C.q?C.t:C.u))}}
B.OQ.prototype={}
B.VR.prototype={
aC(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=this,l=m.y
if(l==null)l=0
x=new B.atX(m,e,d)
w=new B.atZ()
v=l/e.a
u=m.d
t=u==null?null:A.z(u,0,1)
if(t!=null){s=v>0?t+w.$2(t,v):0
if(s<1)x.$3$color$endFraction$startFraction(m.b,1,s)
w=m.x
if(w!=null&&w>0)new B.atY(m,e,d).$0()
if(t>0)x.$3$color$endFraction$startFraction(m.c,t,0)
return}u=m.e
r=D.Lu.ah(0,u)
q=D.Lm.ah(0,u)
p=D.Ll.ah(0,u)
o=D.Lk.ah(0,u)
if(r<1-v){s=r>0?r+w.$2(r,v):0
x.$3$color$endFraction$startFraction(m.b,1,s)}if(r-q>0)x.$3$color$endFraction$startFraction(m.c,r,q)
if(q>v){s=p>0?p+w.$2(p,v):0
n=q<1?q-w.$2(1-q,v):1
x.$3$color$endFraction$startFraction(m.b,n,s)}if(p-o>0)x.$3$color$endFraction$startFraction(m.c,p,o)
if(o>v){n=o<1?o-w.$2(1-o,v):1
x.$3$color$endFraction$startFraction(m.b,n,0)}},
dh(d){var x=this
return!d.b.j(0,x.b)||!d.c.j(0,x.c)||d.d!=x.d||d.e!==x.e||d.f!==x.f||!J.d(d.r,x.r)||!J.d(d.w,x.w)||d.x!=x.x||d.y!=x.y}}
B.AW.prototype={
a8(){return new B.VS(null,null)}}
B.VS.prototype={
aH(){var x,w=this
w.aV()
x=A.c8(null,D.IA,null,null,w)
w.d!==$&&A.bb()
w.d=x
w.SU()},
b_(d){this.bk(d)
this.SU()},
l(){var x=this.d
x===$&&A.b()
x.l()
this.a3E()},
gF8(){var x,w=this
w.a.toString
w.c.BC(y.o)
w.c.I_(y.C)
x=w.d
x===$&&A.b()
return x},
SU(){var x,w=this,v=w.a.c
A.z(v,0,1)
x=!1
if(x){v=w.d
v===$&&A.b()
v.Jv(0)}else{A.z(v,0,1)
v=w.d
v===$&&A.b()
v=v.r
v=v!=null&&v.a!=null
if(v){v=w.d
v===$&&A.b()
v.f6(0)}}},
MF(d,e,f){var x,w,v,u,t,s,r,q,p=this,o=null,n=B.aX4(d)
p.a.toString
A.L(d)
switch(!0){case!0:x=new B.atW(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
case!1:x=new B.atV(d,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o)
break
default:x=o}w=p.a
w.toString
w=w.d
v=w==null?n.b:w
if(v==null)v=x.gqS()
u=p.a.y
t=n.f
if(t==null)t=x.f
w=p.a
w.toString
x.gdI(x)
x=p.a
s=x.c
r=A.z(s,0,1)
w=A.fc(o,o,o,new B.VR(v,w.e,r,e,f,t,o,o,o,o),C.K)
if(t!=null)A.z(s,0,1)
q=x.w
s=A.z(s,0,1)
q=""+C.d.aF(s*100)
x=x.r
return A.bZ(o,new A.dF(new A.al(1/0,1/0,u,1/0),w,o),!1,o,o,!1,o,o,o,o,o,o,x,o,o,"100",o,"0",o,o,o,o,o,o,o,o,o,o,o,C.Z1,o,o,o,o,o,o,o,o,q)},
F(d){var x,w=this,v=d.K(y.n).w
A.z(w.a.c,0,1)
x=w.gF8().x
x===$&&A.b()
return w.MF(d,x,v)
return A.i6(w.gF8(),new B.au_(w,v),null)}}
B.atV.prototype={
gtG(){var x,w=this,v=w.CW
if(v===$){x=A.L(w.ch)
w.CW!==$&&A.aR()
v=w.CW=x.ax}return v},
gdI(d){return this.gtG().b},
gqS(){var x=this.gtG(),w=x.aw
return w==null?x.k2:w},
gv_(){return 4}}
B.atW.prototype={
gtG(){var x,w=this,v=w.CW
if(v===$){x=A.L(w.ch)
w.CW!==$&&A.aR()
v=w.CW=x.ax}return v},
gdI(d){return this.gtG().b},
gqS(){var x=this.gtG(),w=x.Q
return w==null?x.y:w},
gv_(){return 4}}
B.IZ.prototype={
l(){var x=this,w=x.bh$
if(w!=null)w.O(0,x.gfd())
x.bh$=null
x.aB()},
bE(){this.cl()
this.cb()
this.fe()}}
var z=a.updateTypes(["wn(m,m,H)"])
B.aCn.prototype={
$2(d,e){return C.i.b9(e.b,d.b)},
$S:47}
B.aCo.prototype={
$3(d,e,f){return new B.wn(d,"Sketch \xb7 "+e,f)},
$S:z+0}
B.aAb.prototype={
$1(d){var x=this.a
return x.V(new B.aAa(x,d))},
$S:25}
B.aAa.prototype={
$0(){return this.a.d=this.b+1},
$S:0}
B.aA9.prototype={
$2(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=null,l=e.b,k=l>640?4:2,j=(l-(k-1)*10)/k
l=y.u
x=A.a([],l)
for(w=this.a,v=w.length,u=this.b,t=u.r,s=u.w,r=u.c,u=u.d,q=0;q<w.length;w.length===v||(0,A.x)(w),++q){p=w[q]
o=A.k(p.a,m,m,m,m,new A.n(!0,u,m,"Outfit",m,m,12,C.e,m,0,m,m,1.35,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m)
n=new A.aK(99,99)
x.push(new A.ch(j,m,new A.bN(A.ad(A.a([o,C.U,A.k(p.b,m,m,m,m,new A.n(!0,r,m,"Fraunces",m,m,22,C.w,m,-0.7,m,m,1.05,m,m,m,m,m,m,m,m,m,m,m,m,m),m,m),C.l,new A.z4(new A.c6(n,n,n,n),new B.AW(4,C.d.b2(p.c,0,1),t,s,m,m,m,m),m)],l),C.r,C.j,C.k),C.kL,20,m,m,m),m))}return A.bF(x,C.I,10,10)},
$S:588}
B.atX.prototype={
$3$color$endFraction$startFraction(d,e,f){var x,w,v,u,t,s,r,q,p
if(e-f<=0)return
x=this.a
w=x.f
v=w===C.a7
u=v?f:1-e
t=this.b
s=t.a
r=v?e:1-f
q=new A.D(u*s,0,r*s,t.b)
$.a4()
p=A.aG()
p.r=d.gq(d)
x=x.r
u=this.c
if(x!=null)u.dZ(x.ab(w).dq(q),p)
else u.eZ(q,p)},
$S:589}
B.atY.prototype={
$0(){var x,w,v=this.b,u=v.b/2,t=this.a,s=t.x
s.toString
x=Math.min(s,u)
$.a4()
w=A.aG()
s=t.w
w.r=s.gq(s)
switch(t.f.a){case 0:v=new A.i(u,u)
break
case 1:v=new A.i(v.a-u,u)
break
default:v=null}this.c.dJ(v,x,w)},
$S:0}
B.atZ.prototype={
$2(d,e){return e*A.z(d,0,0.01)/0.01},
$S:89}
B.au_.prototype={
$2(d,e){var x=this.a,w=x.gF8().x
w===$&&A.b()
return x.MF(d,w,this.b)},
$S:71};(function aliases(){var x=B.IZ.prototype
x.a3E=x.l})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(B.qA,A.a8)
v(A.u8,[B.aCn,B.aA9,B.atZ,B.au_])
v(A.iQ,[B.aCo,B.aAb,B.atX])
v(A.R,[B.wn,B.am7])
v(A.a1,[B.El,B.OQ])
v(A.ab,[B.a_X,B.IZ])
v(A.nj,[B.aAa,B.atY])
w(B.VR,A.ui)
w(B.AW,B.OQ)
w(B.VS,B.IZ)
v(A.vs,[B.atV,B.atW])
x(B.IZ,A.f3)})()
A.a02(b.typeUniverse,JSON.parse('{"qA":{"a8":[],"e":[]},"El":{"a1":[],"e":[]},"a_X":{"ab":["El"]},"AW":{"a1":[],"e":[]},"OQ":{"a1":[],"e":[]},"VR":{"ao":[]},"VS":{"ab":["AW"]},"aX1":{"dI":[],"bu":[],"bg":[],"e":[]}}'))
var y={n:A.ai("ia"),a:A.ai("lO"),B:A.ai("v<wn>"),u:A.ai("v<e>"),o:A.ai("aX1"),w:A.ai("m"),C:A.ai("wg"),e:A.ai("r")};(function constants(){D.DE=new A.al(0,860,0,1/0)
D.IA=new A.b6(18e5)
D.Kb=new A.lU("Hormone twin",null)
D.HM=new A.e4(0.1,0,0.45,1)
D.Lk=new A.fQ(0.7038888888888889,1,D.HM)
D.HO=new A.e4(0,0,0.65,1)
D.Ll=new A.fQ(0.5555555555555556,0.8705555555555555,D.HO)
D.HN=new A.e4(0.4,0,1,1)
D.Lm=new A.fQ(0.185,0.6016666666666667,D.HN)
D.HQ=new A.e4(0.2,0,0.8,1)
D.Lu=new A.fQ(0,0.4166666666666667,D.HQ)})()};
(a=>{a["83rdlsAqMNZmfn7ww5giZYKB9KI="]=a.current})($__dart_deferred_initializers__);