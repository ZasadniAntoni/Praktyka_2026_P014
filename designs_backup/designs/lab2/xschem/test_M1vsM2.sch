v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -20 -0 -20 40 {lab=#net1}
N 120 0 120 40 {lab=#net2}
N 120 100 120 120 {lab=0}
N -20 120 120 120 {lab=0}
N -20 100 -20 120 {lab=0}
N -20 -80 -20 -60 {lab=VDD}
N -20 -80 120 -80 {lab=VDD}
N 120 -80 120 -60 {lab=VDD}
N -280 100 -280 120 {lab=0}
N -280 20 -280 40 {lab=VDD}
N 60 -30 80 -30 {lab=#net3}
N -80 -30 -60 -30 {lab=#net4}
N -180 20 -180 40 {lab=#net5}
N -180 100 -180 120 {lab=0}
N 0 70 100 70 {lab=VDD}
C {sky130_fd_pr/pfet3_01v8.sym} -40 -30 0 0 {name=M1
W=\{W\}
L=\{L\}
body=VDD
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_ideal
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} 100 -30 0 0 {name=M2
W=\{W\}
L=\{L\}
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
C {sky130_fd_pr/res_high_po.sym} -20 70 0 1 {name=R1
W=2
L=20
model=res_high_po_ideal
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po.sym} 120 70 0 0 {name=R2
W=2
L=20
model=res_high_po
spiceprefix=X
mult=1}
C {vdd.sym} 50 -80 0 0 {name=l1 lab=VDD}
C {gnd.sym} 50 120 0 0 {name=l2 lab=0}
C {vdd.sym} -280 20 0 0 {name=l3 lab=VDD}
C {gnd.sym} -280 120 0 0 {name=l4 lab=0}
C {vsource.sym} -280 70 0 0 {name=V1 value=1.8 savecurrent=false}
C {vsource.sym} -180 70 0 0 {name=V2 value=0.6 savecurrent=false}
C {gnd.sym} -180 120 0 0 {name=l5 lab=0}
C {vdd.sym} 50 70 0 0 {name=l6 lab=VDD}
C {code.sym} 210 -130 0 0 {
name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

* force include MC files
.include \\"$::SKYWATER_MODELS/parameters/montecarlo.spice\\"
.include \\"$::SKYWATER_MODELS/parameters/critical.spice\\"

* force mismatch/process params
.param mc_mm_switch = 1
.param mc_pr_switch = 1

* disable pfet_ideal from mismatch/process
.subckt sky130_fd_pr__pfet_ideal D G S B W=0.42 L=0.18
  .param mc_mm_switch=0
  .param mc_pr_switch=0
  XIDEAL D G S B sky130_fd_pr__pfet_01v8 W=\{W\} L=\{L\}
.ends
* disable res_high_po_ideal from mismatch/process
.subckt sky130_fd_pr__res_high_po_ideal r0 r1 b W=2 L=20 mult=1
  .param mc_mm_switch=0
  .param mc_pr_switch=0
  .param l_mult = mult
  XIDEAL r0 r1 b sky130_fd_pr__res_high_po W=\{W\} L=\{L\} mult=\{l_mult\}
.ends
"
spice_ignore=false
      }
C {code.sym} 210 40 0 0 {name=sim_block only_toplevel=false value="
.param mc_runs=100
.options savecurrents
.param W=5
.param L=5
.control
  let runs = 100
  shell mkdir -p /foss/designs/lab2/results/1.8
  shell rm -f /foss/designs/lab2/results/1.8/test_runs.dat /foss/designs/lab2/results/1.8/test_stats.dat
  let i_m1 = vector(runs)
  let i_m2 = vector(runs)
  let i_diff = vector(runs)
  let r = 0
  echo ----- Monte Carlo Current Mismatch Runs ----- >> /foss/designs/lab2/results/1.8/test_runs.dat
  echo ----- Mismatch Statistical Analysis ----- >> /foss/designs/lab2/results/1.8/test_stats.dat
  dowhile r < runs
    reset
    op
    let i_m1[r] = @m.xm1.xideal.msky130_fd_pr__pfet_01v8[id]
    let i_m2[r] = @m.xm2.msky130_fd_pr__pfet_01v8[id]
    let i_diff[r] = i_m1[r] - i_m2[r]
    let cur_m1 = i_m1[r]
    let cur_m2 = i_m2[r]
    let cur_diff = i_diff[r]
    set appendwrite
    echo RUN= $&r I(M1)= $&cur_m1 I(M2)= $&cur_m2 Diff= $&cur_diff >> /foss/designs/lab2/results/1.8/test_runs.dat
    let r = r + 1
  end
  let avg_diff = mean(i_diff)
  let sig_diff = stddev(i_diff)
  let min_diff = minimum(i_diff)
  let max_diff = maximum(i_diff)
  echo MIN_DIFF= $&min_diff MAX_DIFF= $&max_diff AVG_DIFF= $&avg_diff SIGMA_DIFF= $&sig_diff >> /foss/designs/lab2/results/1.8/test_stats.dat
.endc
"}
C {lab_wire.sym} -180 20 0 0 {name=p1 sig_type=std_logic lab=in}
C {lab_wire.sym} -80 -30 0 0 {name=p2 sig_type=std_logic lab=in}
C {lab_wire.sym} 60 -30 0 0 {name=p3 sig_type=std_logic lab=in}
