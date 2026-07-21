v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 290 -390 290 -350 {lab=VDD}
N 290 -390 710 -390 {lab=VDD}
N 530 -350 570 -350 {lab=b[0:4]}
N 530 -310 570 -310 {lab=DAC_REF}
N 330 -320 350 -320 {lab=DAC_REF}
N 400 -320 400 -260 {lab=DAC_REF}
N 290 -260 350 -260 {lab=DAC_REF}
N 290 -290 290 -260 {lab=DAC_REF}
N 290 -260 290 -240 {lab=DAC_REF}
N 290 -180 290 -150 {lab=gnd}
N 710 -180 710 -150 {lab=gnd}
N 710 -390 710 -350 {lab=VDD}
N 710 -310 710 -240 {lab=I_DAC}
N 350 -320 400 -320 {lab=DAC_REF}
N 350 -260 400 -260 {lab=DAC_REF}
N 230 -80 280 -80 {lab=b[0]}
N 160 -290 160 -240 {lab=VDD}
N 160 -180 160 -150 {lab=gnd}
N 390 -80 440 -80 {lab=b[1]}
N 550 -80 600 -80 {lab=b[2]}
N 710 -80 760 -80 {lab=b[3]}
N 870 -80 920 -80 {lab=b[4]}
N 340 -80 340 -30 {lab=VDD}
N 340 -30 980 -30 {lab=VDD}
N 980 -80 980 -30 {lab=VDD}
N 500 -80 500 -30 {lab=VDD}
N 660 -80 660 -30 {lab=VDD}
N 820 -80 820 -30 {lab=VDD}
N 250 -320 290 -320 {lab=VDD}
N 250 -390 250 -320 {lab=VDD}
N 250 -390 290 -390 {lab=VDD}
C {symbols/pfet_03v3.sym} 310 -320 0 1 {name=M1
L=5u
W=2u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {res.sym} 290 -210 0 0 {name=RES_DAC
value=\{RES_DAC\}
footprint=1206
device=resistor
m=1}
C {gnd.sym} 290 -150 0 0 {name=l1 lab=gnd}
C {res.sym} 710 -210 0 0 {name=RES_OUT
value=100
footprint=1206
device=resistor
m=1}
C {gnd.sym} 710 -150 0 0 {name=l2 lab=gnd}
C {vsource.sym} 310 -80 1 0 {name=V0 value="\{VDD*((dac_bit-2*int(dac_bit/2)))\}" savecurrent=false}
C {lab_wire.sym} 400 -320 0 0 {name=p1 sig_type=std_logic lab=DAC_REF
}
C {lab_wire.sym} 550 -310 0 0 {name=p2 sig_type=std_logic lab=DAC_REF
}
C {lab_wire.sym} 550 -350 0 0 {name=p3 sig_type=std_logic lab=b[0:4]
}
C {lab_wire.sym} 260 -80 0 0 {name=p4 sig_type=std_logic lab=b[0]
}
C {vsource.sym} 160 -210 0 0 {name=VSUPPLY value=\{VDD\} savecurrent=false}
C {lab_wire.sym} 420 -390 0 0 {name=p5 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} 160 -290 0 0 {name=p6 sig_type=std_logic lab=VDD
}
C {gnd.sym} 160 -150 0 0 {name=l3 lab=gnd}
C {vsource.sym} 470 -80 1 0 {name=V1 value="\{VDD*((dac_bit-4*int(dac_bit/4)>1))\}" savecurrent=false}
C {lab_wire.sym} 420 -80 0 0 {name=p7 sig_type=std_logic lab=b[1]
}
C {vsource.sym} 630 -80 1 0 {name=V2 value="\{VDD*((dac_bit-8*int(dac_bit/8)>3))\}" savecurrent=false}
C {lab_wire.sym} 580 -80 0 0 {name=p8 sig_type=std_logic lab=b[2]
}
C {vsource.sym} 790 -80 1 0 {name=V3 value="\{VDD*((dac_bit-16*int(dac_bit/16)>7))\}" savecurrent=false}
C {lab_wire.sym} 740 -80 0 0 {name=p9 sig_type=std_logic lab=b[3]
}
C {vsource.sym} 950 -80 1 0 {name=V4 value="\{VDD*((dac_bit-32*int(dac_bit/32)>15))\}" savecurrent=false}
C {lab_wire.sym} 900 -80 0 0 {name=p10 sig_type=std_logic lab=b[4]
}
C {lab_wire.sym} 710 -30 0 0 {name=p11 sig_type=std_logic lab=VDD
}
C {code_shown.sym} 840 -510 0 0 {name=code only_toplevel=false value="
.param VDD=3.3
.param RES_DAC=198k
.param dac_bit=7

.control
  save all
  op
  print @m.xm1.m0[id]
.endc
"}
C {devices/code_shown.sym} 260 -490 0 0 {name=MODELS only_toplevel=true
format="tcleval( @value )"
value="
.include $::180MCU_MODELS/design.ngspice
.lib $::180MCU_MODELS/sm141064.ngspice typical
"}
C {lab_wire.sym} 710 -280 0 0 {name=p12 sig_type=std_logic lab=I_DAC
}
C {DAC_CORE_5bit/DAC_CORE_5bit.sym} 630 -330 0 0 {name=x1}
