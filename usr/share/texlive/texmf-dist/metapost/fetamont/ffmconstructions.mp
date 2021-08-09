% !TEX program = mpost
input TEX;
TEXPRE("%&latex" & char(10) & "\documentclass{article}\begin{document}");
TEXPOST("\end{document}");
outputtemplate := "%j-%c.mps";

%an arc is kind of a quarter of a skewed superellipse
vardef arc(expr zi,diri,zj,dirj) =
 zi{diri}...
 begingroup
  save corner,zij; 
  pair corner,zij;
  corner=zi+whatever*diri=zj+whatever*dirj;
  zij=zi
   +superness*(corner-zi)
   +(1-superness)*(zj-corner);
  zij
 endgroup{zj-zi}
 ...zj{dirj}
enddef;

%two concatenated arcs
def half(expr zi,diri,zj,dirj,zk,dirk) =
 arc(zi,diri,zj,dirj) 
 & arc(zj,dirj,zk,dirk)
enddef;

%two concatenated halfs
def full(expr zi,diri,zj,dirj,zk,dirk,zl,dirl) =
 half(zi,diri,zj,dirj,zk,dirk)
 & half(zk,dirk,zl,dirl,zi,diri)
enddef;

%----------------------------------------------------------
beginfig(0);
u:=1cm;
numeric superness;
pair zi,zj,zij,diri, dirj,corner,center;
superness=.75;
zi=(0,0);
zj=(5u,4u);
diri=(.1u,1u);
dirj=(.7u,.05u);
corner=zi+whatever*diri=zj+whatever*dirj;
center=zi+whatever*dirj=zj+whatever*diri;
z1=.5[center,zj];
z2=.5[zj,corner];
z3=.5[corner,zi];
z4=.5[zi,center];
pickup pencircle scaled 2.5bp;
draw full(z1,diri,z2,-dirj,z3,-diri,z4,dirj) withcolor .8white;
draw arc(z3,diri,z2,dirj) withcolor .6white;
pickup pencircle scaled .5bp
draw zi--center--zj--corner--cycle;
label.lrt(TEX("arc"), (z3+superness*(corner-z3)+(1-superness)*(z2-corner)));
label.bot(TEX("skewed superellipse"), z4);
endfig;
%----------------------------------------------------------
beginfig(1);
u:=1cm;
superness:=.75;
pair zi,zj,zij,diri, dirj, corner, center;
zi=(0,0);
zj=(5u,4u);
diri=(.1u,1u);
dirj=(.7u,.05u);
corner=zi+whatever*diri=zj+whatever*dirj;
center=zi+whatever*dirj=zj+whatever*diri;
zij=superness[center,corner];
z1=zi+whatever*diri=zij+whatever*(zj-zi);
z2=zj+whatever*dirj=zij+whatever*(zj-zi);
pickup pencircle scaled 5bp
draw zi{diri}
 ...(zi
 +superness*(corner-zi)
 -(1-superness)*(corner-zj))
 {zj-zi}
 ...zj{dirj}
 withcolor .8white;
pickup pencircle scaled .5bp
draw zi -- zj;
draw zi -- center -- zj -- corner -- cycle;
draw center -- corner;
drawarrow zi -- (zi+diri);
drawarrow zj -- (zj+dirj);
drawarrow zi -- (zi+(1-superness)*(zj-corner));
drawarrow (zi+(1-superness)*(zj-corner)) -- zij;
draw z1 -- z2;
label.bot(TEX("$z_i$"), zi);
label.top(TEX("$z_j$"), zj);
label.lft(TEX("$\mathrm{corner}$"), corner);
label.rt(TEX("$\mathrm{center}$"), center);
label.lft(TEX("$\mathrm{dir}_i$"), (zi+diri));
label.bot(TEX("$\mathrm{dir}_j$"), (zj+dirj));
label.top(TEX("$z_{ij}$"), zij);
label.lrt(TEX("$(1-\mathrm{superness})\cdot(z_j-\mathrm{corner})$"), (zi+.5*(1-superness)*(zj-corner)));
label.rt(TEX("$\mathrm{superness}\cdot(\mathrm{corner}-z_i)$"), .6[(zi+(1-superness)*(zj-corner)),zij]);
endfig;
%----------------------------------------------------------
beginfig(2);
u:=.5cm;
noise:=0;
h:=6u;
barheight:=.45h;
superness:=.8;
w:=20/3*u;
leftstemloc:=10/9*u;
o:=u/9;  
px:=2/3*u;                      
py:=.9px;               
pair randrt; 
randrt:=(1,0);
pickup pencircle xscaled px yscaled py;
x1=leftstemloc+noise;
x2=leftstemloc+noise; 
x3=.5w+noise; 
w-x4=leftstemloc+noise;
w-x5=leftstemloc+noise;
bot y1=noise-o;
y2=barheight+noise;
top y3=h+o; %no noise because of Aring
y4=barheight+noise;
bot y5=noise-o;
bot y6=0; %no noise
z6=whatever[z4,z5];
draw z1--z2
  & half(z2,z2-z1,z3,randrt,z4,z5-z4)
  & z4--z5
  withcolor .8white;
draw z2--z4 withcolor .8white;
pickup pencircle scaled .5bp
draw (0,0) -- (w,0) -- (w,h) -- (0,h) -- cycle;
dotlabel.top(TEX("anchor top (base)"), (.5w,h));
endfig;
%----------------------------------------------------------
beginfig(3);
u:=.5cm;
noise:=0;
h:=6.5u;
x_ht:=4.5u;
barheight:=.45h;
superness:=.8;
w:=28/9*u;
leftstemloc:=10/9*u;
o:=u/9;  
px:=2/3*u;                      
py:=.9px;               
pair randrt; 
randrt:=(1,0);
pickup pencircle xscaled px yscaled py;
lft x1=noise; 
x2=.5w+noise;
rt x3=w+noise; 
bot y1=.2[x_ht,h]+noise;
bot y3=.2[x_ht,h]+noise;
top y2=h+o+noise;
draw z1--z2--z3 withcolor .8white;
pickup pencircle scaled .5bp
draw (0,0) -- (w,0) -- (w,h) -- (0,h) -- cycle;
dotlabel.bot(TEX("anchor top (accent)"), (.5w,x_ht));
endfig;
%----------------------------------------------------------
beginfig(4);
u:=.5cm;
noise:=0;
h:=6u;
x_ht:=4.5u;
barheight:=.45h;
superness:=.8;
w:=20/3*u;
leftstemloc:=10/9*u;
o:=u/9;  
px:=2/3*u;                      
py:=.9px;               
pair randrt; 
randrt:=(1,0);
pickup pencircle xscaled px yscaled py;
x1=leftstemloc+noise;
x2=leftstemloc+noise; 
x3=.5w+noise; 
w-x4=leftstemloc+noise;
w-x5=leftstemloc+noise;
bot y1=noise-o;
y2=barheight+noise;
top y3=h+o; %no noise because of Aring
y4=barheight+noise;
bot y5=noise-o;
bot y6=0; %no noise
z6=whatever[z4,z5];
draw z1--z2
  & half(z2,z2-z1,z3,randrt,z4,z5-z4)
  & z4--z5
  withcolor .8white;
draw z2--z4 withcolor .8white;
pickup pencircle scaled .5bp
draw (0,0) -- (w,0) -- (w,h) -- (0,h) -- cycle;
z0=(.5w,h);
dotlabel.top(TEX(""), z0);
h:=6.5u;
w:=28/9*u;
pickup pencircle xscaled px yscaled py;
lft x11=noise; 
x12=.5w+noise;
rt x13=w+noise; 
bot y11=.2[x_ht,h]+noise;
bot y13=.2[x_ht,h]+noise;
top y12=h+o+noise;
z10=(.5w,x_ht);
draw (z11--z12--z13) shifted (z0-z10) withcolor .8white;
pickup pencircle scaled .5bp
draw ((0,0) -- (w,0) -- (w,h) -- (0,h) -- cycle) shifted (z0-z10);
endfig;
%----------------------------------------------------------
beginfig(5);
u:=.25cm;
noise:=0;
h:=6u;
barheight:=.45h;
superness:=.8;
w:=20/3*u;
leftstemloc:=10/9*u;
o:=u/9;  
px:=2/3*u;                      
py:=.9px;               
pair randrt; 
randrt:=(1,0);
xgap:=.1h; 
ygap:=(h/13.5u)*xgap;
pickup pencircle xscaled px yscaled py;
x1=leftstemloc+noise;
x2=leftstemloc+noise;
x4=w-leftstemloc+noise;
x5=w-leftstemloc+noise;
bot y1=noise-o;
top y2=h+o+noise;
y3=y4+ygap+noise;
bot y4=noise-o;
top y5=h+o+noise;
z3=whatever[z4,z5];
draw z1--z2--z3 withcolor .8white; 
draw z4--z5 withcolor .8white;
pickup pencircle scaled .5bp
draw (0,0) -- (w,0) -- (w,h) -- (0,h) -- cycle;
pickup pencircle xscaled px yscaled py;
draw (z1--z2--z3) shifted (w,0) withcolor .8white; 
draw (z4--z5) shifted (w,0) withcolor .8white;
pickup pencircle scaled .5bp;
draw ((0,0) -- (w,0) -- (w,h) -- (0,h) -- cycle) shifted (w,0);
endfig;
%----------------------------------------------------------
beginfig(6);
u:=.25cm;
noise:=0;
h:=6u;
barheight:=.45h;
superness:=.8;
w:=20/3*u;
leftstemloc:=10/9*u;
o:=u/9;  
px:=2/3*u;                      
py:=.9px;               
xgap:=.1h; 
ygap:=(h/13.5u)*xgap;
slant:=.25;
pair randrt; 
randrt:=(1,0);
pickup pencircle xscaled px yscaled py;
x1=leftstemloc+noise;
x2=leftstemloc+noise;
x4=w-leftstemloc+noise;
x5=w-leftstemloc+noise;
bot y1=noise-o;
top y2=h+o+noise;
y3=y4+ygap+noise;
bot y4=noise-o;
top y5=h+o+noise;
z3=whatever[z4,z5];
draw (z1--z2--z3) slanted slant withcolor .8white; 
draw (z4--z5) slanted slant withcolor .8white;
draw (z1--z2--z3) shifted (w,0) withcolor .8white; 
draw (z4--z5) shifted (w,0) withcolor .8white;
pickup pencircle scaled .5bp;
draw ((0,0) -- (w,0) -- (w,h) -- (0,h) -- cycle) slanted slant;
draw ((0,0) -- (w,0) -- (w,h) -- (0,h) -- cycle) shifted (w,0);
endfig;
%----------------------------------------------------------
beginfig(7);
u:=.25cm;
noise:=0;
h:=6u;
barheight:=.45h;
superness:=.8;
w:=20/3*u;
leftstemloc:=10/9*u;
o:=u/9;  
px:=2/3*u;                      
py:=.9px;               
xgap:=.1h; 
ygap:=(h/13.5u)*xgap;
slant:=.25;
pair randrt; 
randrt:=(1,0);
pickup pencircle xscaled px yscaled py;
x1=leftstemloc+noise;
x2=leftstemloc+noise;
x4=w-leftstemloc+noise;
x5=w-leftstemloc+noise;
bot y1=noise-o;
top y2=h+o+noise;
y3=y4+ygap+noise;
bot y4=noise-o;
top y5=h+o+noise;
z3=whatever[z4,z5];
draw (z1--z2--z3) slanted slant shifted (-h*slant,0) withcolor .8white; 
draw (z4--z5) slanted slant shifted (-h*slant,0) withcolor .8white;
draw (z1--z2--z3) shifted (w,0) withcolor .8white; 
draw (z4--z5) shifted (w,0) withcolor .8white;
pickup pencircle scaled .5bp;
draw ((0,0) -- (w,0) -- (w,h) -- (0,h) -- cycle) slanted slant shifted (-h*slant,0);
draw ((0,0) -- (w,0) -- (w,h) -- (0,h) -- cycle) shifted (w,0);
endfig;
%----------------------------------------------------------
bye
