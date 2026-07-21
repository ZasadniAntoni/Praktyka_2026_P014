v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -240 -100 -240 -60 {lab=VDD}
N -220 -100 410 -100 {lab=VDD}
N -40 -100 -40 -60 {lab=VDD}
N 160 -100 160 -60 {lab=VDD}
N 560 -100 560 -60 {lab=VDD}
N 360 -100 360 -60 {lab=VDD}
N -240 0 -240 60 {lab=#net1}
N -40 0 -40 60 {lab=#net2}
N 160 0 160 60 {lab=#net3}
N 360 0 360 60 {lab=#net4}
N 560 0 560 60 {lab=#net5}
N 560 120 560 160 {lab=I_DAC}
N -220 160 500 160 {lab=I_DAC}
N -240 120 -240 160 {lab=I_DAC}
N -40 120 -40 160 {lab=I_DAC}
N 160 120 160 160 {lab=I_DAC}
N 360 120 360 160 {lab=I_DAC}
N 500 160 560 160 {lab=I_DAC}
N -300 -30 -280 -30 {lab=DAC_REF}
N -100 -30 -80 -30 {lab=DAC_REF}
N -240 160 -220 160 {lab=I_DAC}
N -240 -100 -220 -100 {lab=VDD}
N -100 90 -80 90 {lab=b[1]}
N 560 160 620 160 {lab=I_DAC}
N 410 -100 560 -100 {lab=VDD}
N 100 -30 120 -30 {lab=DAC_REF}
N 100 90 120 90 {lab=b[2]}
N 300 90 320 90 {lab=b[3]}
N 300 -30 320 -30 {lab=DAC_REF}
N 500 -30 520 -30 {lab=DAC_REF}
N 500 90 520 90 {lab=b[4]}
N -300 90 -280 90 {lab=b[0]}
C {sky130_fd_pr/pfet3_01v8.sym} -60 -30 0 0 {name=M1
W=2
L=5
body=VDD
nf=1
mult=2
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 140 -30 0 0 {name=M2
W=2
L=5
body=VDD
nf=1
mult=4
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 340 -30 0 0 {name=M3
W=2
L=5
body=VDD
nf=1
mult=8
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 540 -30 0 0 {name=M4
W=2
L=5
body=VDD
nf=1
mult=16
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -260 -30 0 0 {name=M0
W=2
L=5
body=VDD
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
C {sky130_fd_pr/pfet3_01v8.sym} -260 90 0 0 {name=MK0
W=0.5
L=0.18
body=VDD
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
C {sky130_fd_pr/pfet3_01v8.sym} -60 90 0 0 {name=MK1
W=0.5
L=0.18
body=VDD
nf=1
mult=2
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 140 90 0 0 {name=MK2
W=0.5
L=0.18
body=VDD
nf=1
mult=4
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 340 90 0 0 {name=MK3
W=0.5
L=0.18
body=VDD
nf=1
mult=8
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 540 90 0 0 {name=MK4
W=0.5
L=0.18
body=VDD
nf=1
mult=16
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {iopin.sym} -260 -200 0 0 {name=p8 lab=DAC_REF}
C {ipin.sym} -240 -170 0 0 {name=p9 lab=b[4:0]}
C {iopin.sym} -260 -230 0 0 {name=p10 lab=VDD}
C {opin.sym} -260 -140 0 0 {name=p15 lab=I_DAC}
C {lab_wire.sym} 140 -100 0 0 {name=p17 sig_type=std_logic lab=VDD}
C {lab_wire.sym} -300 -30 0 0 {name=p2 sig_type=std_logic lab=DAC_REF}
C {lab_wire.sym} -100 -30 0 0 {name=p3 sig_type=std_logic lab=DAC_REF}
C {lab_wire.sym} 100 -30 0 0 {name=p4 sig_type=std_logic lab=DAC_REF}
C {lab_wire.sym} 300 -30 0 0 {name=p5 sig_type=std_logic lab=DAC_REF}
C {lab_wire.sym} 500 -30 0 0 {name=p6 sig_type=std_logic lab=DAC_REF}
C {lab_wire.sym} -300 90 0 0 {name=p18 sig_type=std_logic lab=b[0]}
C {lab_wire.sym} -100 90 0 0 {name=p7 sig_type=std_logic lab=b[1]}
C {lab_wire.sym} 100 90 0 0 {name=p11 sig_type=std_logic lab=b[2]}
C {lab_wire.sym} 300 90 0 0 {name=p12 sig_type=std_logic lab=b[3]}
C {lab_wire.sym} 500 90 0 0 {name=p13 sig_type=std_logic lab=b[4]}
C {lab_wire.sym} 620 160 0 1 {name=p1 sig_type=std_logic lab=I_DAC}
