v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 460 1140 460 1200 {lab=OUT}
N 380 1230 420 1230 {lab=IN}
N 380 1110 380 1230 {lab=IN}
N 380 1110 420 1110 {lab=IN}
N 320 1170 380 1170 {lab=IN}
N 460 1170 520 1170 {lab=OUT}
N 460 1260 460 1300 {lab=0}
N 460 1040 460 1080 {lab=VDD}
N 460 1230 480 1230 {lab=0}
N 480 1230 480 1280 {lab=0}
N 460 1280 480 1280 {lab=0}
N 460 1110 480 1110 {lab=VDD}
N 480 1060 480 1110 {lab=VDD}
N 460 1060 480 1060 {lab=VDD}
C {sky130_fd_pr/pfet_01v8.sym} 440 1110 0 0 {name=M1
W=0.42
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {gnd.sym} 460 1300 0 0 {name=l2 lab=0}
C {opin.sym} 520 1170 0 0 {name=p1 lab=OUT}
C {ipin.sym} 320 1170 0 0 {name=p2 lab=IN}
C {sky130_fd_pr/nfet_01v8.sym} 440 1230 0 0 {name=M3
W=0.42
L=0.15
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {vdd.sym} 460 1040 0 0 {name=l1 lab=VDD}
