v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -40 -30 60 -30 {lab=Vg}
N 100 -100 100 -60 {lab=VDD}
N -100 -100 -100 -60 {lab=VDD}
N -100 -100 100 -100 {lab=VDD}
N -140 -30 -100 -30 {lab=VDD}
N -140 -100 -140 -30 {lab=VDD}
N -140 -100 -100 -100 {lab=VDD}
N 100 -30 140 -30 {lab=VDD}
N 140 -100 140 -30 {lab=VDD}
N 100 -100 140 -100 {lab=VDD}
N -40 -30 -40 30 {lab=Vg}
N -60 -30 -40 -30 {lab=Vg}
N -100 0 -100 30 {lab=Vg}
N 100 0 100 20 {lab=#net1}
N -100 100 -100 140 {lab=0}
N 100 100 100 140 {lab=0}
N -40 30 60 30 {lab=Vg}
N -100 30 -100 40 {lab=Vg}
N -100 30 -40 30 {lab=Vg}
N 40 70 60 70 {lab=0}
N 40 100 100 100 {lab=0}
N 100 80 100 100 {lab=0}
N 40 70 40 100 {lab=0}
N -280 100 -280 140 {lab=0}
N -280 20 -280 40 {lab=VDD}
C {gnd.sym} -100 140 0 0 {name=l1 lab=0}
C {gnd.sym} 100 140 0 0 {name=l2 lab=0}
C {isource.sym} -100 70 0 0 {name=I_REF value=\{I_DAC\}}
C {vcvs.sym} 100 50 0 0 {name=E1 value=1
}
C {vsource.sym} -280 70 0 0 {name=V1 value=\{VDD_val\} savecurrent=false}
C {vdd.sym} 0 -100 0 0 {name=l6 lab=VDD}
C {vdd.sym} -280 20 0 0 {name=l10 lab=VDD}
C {gnd.sym} -280 140 0 0 {name=l11 lab=0}
C {code.sym} 240 -110 0 0 {
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
+ nf=1 ad='int((1 + 1)/2) * \{W\} / 1 * 0.29' as='int((1 + 2)/2) * \{W\} / 1 * 0.29'
+ pd='2*int((1 + 1)/2) * (\{W\} / 1 + 0.29)' ps='2*int((1 + 2)/2) * (\{W\} / 1 + 0.29)' 
+ nrd='0.29 / \{W\}' nrs='0.29 / \{W\}' sa=0 sb=0 sd=0 mult=1
  .param mc_mm_switch=0
  .param mc_pr_switch=0
  XIDEAL D G S B sky130_fd_pr__pfet_01v8 W=\{W\} L=\{L\}
  + nf=\{nf\} ad=\{ad\} as=\{as\} pd=\{pd\} ps=\{ps\} 
  + nrd=\{nrd\} nrs=\{nrs\} sa=\{sa\} sb=\{sb\} sd=\{sd\} mult=\{mult\}
.ends
"
spice_ignore=false
}
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
C {code.sym} 240 40 0 0 {name=sim_block only_toplevel=false
value=
"
.param W_DAC = 2.0 L_DAC = 5.0
.param I_DAC = 10u
.param VDD_val = 1.8
.options savecurrents

.control
  let runs = 100
  shell mkdir -p /foss/designs/lab2/results/1.11/c/
  shell rm -f /foss/designs/lab2/results/1.11/c/M1_stats.dat /foss/designs/lab2/results/1.11/c/M1_Iruns.dat

  alterparam I_DAC = $idac_val
  * allocate vector for currents
  let Ivec = vector(runs)
  let r = 0

  * reset and op to apply W/L changes
  reset
  op
  let W = @m.xm1.msky130_fd_pr__pfet_01v8[w] * 1e6
  let L = @m.xm1.msky130_fd_pr__pfet_01v8[l] * 1e6
  echo ----- W/L= $&W / $&L IDAC= $idac_val ----- >> /foss/designs/lab2/results/1.11/c/M1_Iruns.dat
  echo ----- W/L= $&W / $&L IDAC= $idac_val ----- >> /foss/designs/lab2/results/1.11/c/M1_stats.dat
  dowhile r < runs
    reset
    op
    let Ivec[r] = @m.xm1.msky130_fd_pr__pfet_01v8[id]
    let curI = Ivec[r] * 1e6
    set appendwrite 
    echo RUN= $&r I[uA]= $&curI >> /foss/designs/lab2/results/1.11/c/M1_Iruns.dat
    let r = r + 1
    *break
  end

  * calculate stats
  let avgI = mean(Ivec) * 1e6
  let sigI = stddev(Ivec) * 1e6
  let ratio = sigI/avgI * 100
  * vecmin() would do the same as minimum() ; analogically is maximum() and vecmax()
  let minI = minimum(Ivec) * 1e6
  let maxI = maximum(Ivec) * 1e6
  
  echo MIN[uA]= $&minI MAX[uA]= $&maxI AVG[uA]= $&avgI SIGMA[uA]= $&sigI sigma/AVG[%]= $&ratio >> /foss/designs/lab2/results/1.11/c/M1_stats.dat
  echo >> /foss/designs/lab2/results/1.11/c/M1_stats.dat
.endc
"}
C {lab_pin.sym} -40 0 0 1 {name=p1 sig_type=std_logic lab=Vg}
