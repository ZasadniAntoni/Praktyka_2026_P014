v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 280 -420 280 -380 {lab=VDD}
N 350 -350 350 -300 {lab=DAC_REF}
N 280 -320 280 -260 {lab=DAC_REF}
N 280 -200 280 -180 {lab=gnd}
N 720 -200 720 -150 {lab=gnd}
N 260 -80 280 -80 {lab=b[0]}
N 160 -190 160 -160 {lab=gnd}
N 410 -80 440 -80 {lab=b[1]}
N 570 -80 600 -80 {lab=b[2]}
N 730 -80 760 -80 {lab=b[3]}
N 890 -80 920 -80 {lab=b[4]}
N 340 -80 340 -30 {lab=VDD}
N 340 -30 980 -30 {lab=VDD}
N 980 -80 980 -30 {lab=VDD}
N 500 -80 500 -30 {lab=VDD}
N 660 -80 660 -30 {lab=VDD}
N 820 -80 820 -30 {lab=VDD}
N 320 -350 350 -350 {lab=DAC_REF}
N 280 -300 350 -300 {lab=DAC_REF}
N 280 -180 280 -160 {lab=gnd}
N 510 -340 540 -340 {lab=DAC_REF}
N 510 -390 540 -390 {lab=b[0:4]}
N 280 -460 710 -460 {lab=VDD}
N 720 -310 720 -260 {lab=I_DAC}
N 720 -460 720 -420 {lab=VDD}
N 710 -460 720 -460 {lab=VDD}
N 160 -280 160 -250 {lab=VDD}
N 280 -440 280 -420 {lab=VDD}
N 280 -460 280 -440 {lab=VDD}
N 250 -80 260 -80 {lab=b[0]}
N 980 -30 1020 -30 {lab=VDD}
C {res.sym} 280 -230 0 0 {name=RES_DAC
value=\{RES_DAC\}
footprint=1206
device=resistor
m=1}
C {gnd.sym} 280 -160 0 0 {name=l1 lab=gnd}
C {res.sym} 720 -230 0 0 {name=RES_OUT
value=100
footprint=1206
device=resistor
m=1}
C {gnd.sym} 720 -150 0 0 {name=l2 lab=gnd}
C {vsource.sym} 310 -80 1 0 {name=V0 value="\{VDD*((dac_bit-2*int(dac_bit/2)))\}" savecurrent=false}
C {lab_wire.sym} 350 -350 0 1 {name=p1 sig_type=std_logic lab=DAC_REF
}
C {lab_wire.sym} 510 -340 0 0 {name=p2 sig_type=std_logic lab=DAC_REF
}
C {lab_wire.sym} 510 -390 0 0 {name=p3 sig_type=std_logic lab=b[0:4]
}
C {lab_wire.sym} 250 -80 0 0 {name=p4 sig_type=std_logic lab=b[0]
}
C {vsource.sym} 160 -220 0 0 {name=VSUPPLY value=\{VDD\} savecurrent=false}
C {gnd.sym} 160 -160 0 0 {name=l3 lab=gnd}
C {vsource.sym} 470 -80 1 0 {name=V1 value="\{VDD*((dac_bit-4*int(dac_bit/4)>1))\}" savecurrent=false}
C {lab_wire.sym} 410 -80 0 0 {name=p7 sig_type=std_logic lab=b[1]
}
C {vsource.sym} 630 -80 1 0 {name=V2 value="\{VDD*((dac_bit-8*int(dac_bit/8)>3))\}" savecurrent=false}
C {lab_wire.sym} 570 -80 0 0 {name=p8 sig_type=std_logic lab=b[2]
}
C {vsource.sym} 790 -80 1 0 {name=V3 value="\{VDD*((dac_bit-16*int(dac_bit/16)>7))\}" savecurrent=false}
C {lab_wire.sym} 730 -80 0 0 {name=p9 sig_type=std_logic lab=b[3]
}
C {vsource.sym} 950 -80 1 0 {name=V4 value="\{VDD*((dac_bit-32*int(dac_bit/32)>15))\}" savecurrent=false}
C {lab_wire.sym} 890 -80 0 0 {name=p10 sig_type=std_logic lab=b[4]
}
C {lab_wire.sym} 1020 -30 0 1 {name=p11 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} 720 -280 0 0 {name=p12 sig_type=std_logic lab=I_DAC
}
C {sky130_fd_pr/pfet3_01v8.sym} 300 -350 0 1 {name=M_REF
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
C {vdd.sym} 160 -280 0 0 {name=l4 lab=VDD}
C {vdd.sym} 500 -460 0 0 {name=l5 lab=VDD}
C {code.sym} 860 -450 0 0 {
name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt
"
spice_ignore=false
      }
C {DAC_CORE_5_Bit.sym} 640 -380 0 0 {name=x1}
C {code.sym} 860 -280 0 0 {name=sim_block only_toplevel=false 
value="
.param VDD = 1.8
.param RES_DAC = 26.8k
.param dac_bit = 0
.options savecurrents

.control
  save all

  let d_val = 0
  dowhile d_val <= 5
    alterparam dac_bit = $&d_val
    reset
    op
    let Id_ref = @m.xm_ref.msky130_fd_pr__pfet_01v8[id]
    echo dac_bit= $&d_val  |  Id_M_REF= $&Id_ref  |  V_b0= v(\\"b[0]\\") 
*>> /foss/designs/lab2/results/2.3/test_run.dat
    let d_val = d_val + 1
  end
.endc
"
}
