v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 -0 -140 {}
N -0 -0 -0 20 {lab=0}
N -0 -100 0 -60 {lab=Vout}
N -0 -180 0 -160 {lab=VDD}
N -140 -30 -40 -30 {lab=#net1}
N -140 -30 -140 -0 {lab=#net1}
N -140 60 -140 80 {lab=0}
N -220 80 -140 80 {lab=0}
N -220 60 -220 80 {lab=0}
N -220 -40 -220 -0 {lab=VDD}
N -0 -30 20 -30 {lab=0}
N 20 -30 20 10 {lab=0}
N 0 10 20 10 {lab=0}
N -40 -130 -20 -130 {lab=VDD}
N 0 -200 0 -180 {lab=VDD}
N -40 -180 -40 -130 {lab=VDD}
N -40 -180 0 -180 {lab=VDD}
C {sky130_fd_pr/nfet_01v8.sym} -20 -30 0 0 {name=MOUT
W=WN
L=0.5
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
C {vsource.sym} -220 30 0 0 {name=V1 value=1.8 savecurrent=false}
C {vsource.sym} -140 30 0 0 {name=V2 value=0 savecurrent=false}
C {gnd.sym} 0 20 0 0 {name=l1 lab=0}
C {gnd.sym} -180 80 0 0 {name=l2 lab=0}
C {vdd.sym} -220 -40 0 0 {name=l3 lab=VDD}
C {vdd.sym} 0 -200 0 0 {name=l4 lab=VDD}
C {lab_wire.sym} 0 -80 0 1 {name=p1 sig_type=std_logic lab=Vout}
C {sky130_fd_pr/res_xhigh_po.sym} 0 -130 0 0 {name=R2
W=1
L=6.83
model=res_xhigh_po
spiceprefix=X
mult=1}
C {code.sym} 110 -120 0 0 {name=dc+WN_sweep only_toplevel=false value=
"
* ngspice commands
.param WN=1
.options savecurrents
.dc v2 0 1.8 0.01
.control
  let start_w = 1
  let stop_w = 90
  let delta_w = 5
  let w_act = start_w
  let new_vth = 0.3
  while w_act le stop_w
    alterparam WN = $&w_act
    reset
    ** example for changing a model param
    * altermod @m.xm1.msky130_fd_pr__nfet_01v8[vth0]=$&new_vth
    save all
    save @m.xm1.msky130_fd_pr__nfet_01v8[id]
    save @m.xm1.msky130_fd_pr__nfet_01v8[gm]
    save @m.xm1.msky130_fd_pr__nfet_01v8[W] 
    run
    remzerovec
    write /foss/designs/simulations/test_sweep_nmos_w.raw
    let w_act = w_act + delta_w
    set appendwrite
  end
  load /foss/designs/simulations/test_sweep_mos_w.raw
  plot dc1.v(vout)
  plot dc1.@m.xmout.msky130_fd_pr__nfet_01v8[id]
  print dc1.@m.xmout.msky130_fd_pr__nfet_01v8[gm]
.endc
"}
C {code.sym} 110 -270 0 0 {
name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt
"
spice_ignore=false
      }
