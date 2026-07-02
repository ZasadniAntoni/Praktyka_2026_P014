v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -40 -30 60 -30 {lab=#net1}
N 100 -100 100 -60 {lab=VDD}
N -100 -100 -100 -60 {lab=VDD}
N -100 -100 100 -100 {lab=VDD}
N -140 -30 -100 -30 {lab=VDD}
N -140 -100 -140 -30 {lab=VDD}
N -140 -100 -100 -100 {lab=VDD}
N 100 -30 140 -30 {lab=VDD}
N 140 -100 140 -30 {lab=VDD}
N 100 -100 140 -100 {lab=VDD}
N -40 -30 -40 30 {lab=#net1}
N -60 -30 -40 -30 {lab=#net1}
N -100 0 -100 30 {lab=#net1}
N 100 0 100 20 {lab=#net2}
N -100 100 -100 140 {lab=0}
N 100 100 100 140 {lab=0}
N -40 30 60 30 {lab=#net1}
N -100 30 -100 40 {lab=#net1}
N -100 30 -40 30 {lab=#net1}
N 40 70 60 70 {lab=0}
N 40 100 100 100 {lab=0}
N 100 80 100 100 {lab=0}
N 40 70 40 100 {lab=0}
N -280 100 -280 140 {lab=0}
N -280 20 -280 40 {lab=VDD}
C {/foss/pdks/sky130A/libs.tech/xschem/sky130_fd_pr/pfet_01v8.sym} 80 -30 0 0 {name=M1
W=\{W_DAC\}
L=\{L_DAC\}
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
C {/foss/pdks/sky130A/libs.tech/xschem/sky130_fd_pr/pfet_01v8.sym} -80 -30 0 1 {name=M_REF
W=\{W_DAC\}
L=\{L_DAC\}
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
C {gnd.sym} -100 140 0 0 {name=l1 lab=0}
C {gnd.sym} 100 140 0 0 {name=l2 lab=0}
C {isource.sym} -100 70 0 0 {name=I_REF value=\{i_dac\}}
C {vcvs.sym} 100 50 0 0 {name=E1 value=1
}
C {vsource.sym} -280 70 0 0 {name=V1 value=\{VDD_val\} savecurrent=false}
C {vdd.sym} 0 -100 0 0 {name=l6 lab=VDD}
C {vdd.sym} -280 20 0 0 {name=l10 lab=VDD}
C {gnd.sym} -280 140 0 0 {name=l11 lab=0}
C {code.sym} 240 -50 0 0 {name=spice only_toplevel=true 
value=
".lib $PDK_ROOT/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.options savecurrents
.param W_DAC = 1.0
.param L_DAC = 0.2
.param i_dac = 10u
.param VDD_val = 1.8
.save all

.control
  foreach current_val 1u 2u 3u 4u 5u 6u 7u 8u 9u 10u
    alterparam i_dac = $current_val
    reset
    dc V1 1.8 1.9 0.1
    let net1v = v(net1)
    echo "For i_dac = $current_val -> Vout = $&net1v V"
  end
.endc"}
