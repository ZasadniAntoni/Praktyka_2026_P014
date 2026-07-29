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
.param mc_mm_switch = 0
.param mc_pr_switch = 0

* disable pfet_ideal from mismatch/process
.subckt sky130_fd_pr__pfet_ideal D G S B W=0.42 L=0.15
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
value="
.param W_DAC = 0.42 L_DAC = 0.15
.param I_DAC = 100n
.param VDD_val = 1.8
.options savecurrents

.control
  * Clear M1 files
  shell mkdir -p /foss/designs/lab2/results/1.2
  shell rm -f /foss/designs/lab2/results/1.2/M1_Vgs_Vth.dat
  * I_REF current sweep
  foreach idac_val 100n 10u
    * W/L group sweep (indexed W/L groups)
    foreach case_idx 1 2 3
      if $case_idx = 1
        alterparam W_DAC = 0.42
        alterparam L_DAC = 0.15
      end
      if $case_idx = 2
        alterparam W_DAC = 5.0
        alterparam L_DAC = 3.5
      end
      if $case_idx = 3
        alterparam W_DAC = 3.5
        alterparam L_DAC = 5.0
      end
      alterparam I_DAC = $idac_val
      reset
      op
      set appendwrite
      * NOTE: The syntax for extracting model params depends on the exact instance name in the PDK.
      * Typically, for Xschem, this is @m.xm1.msky130_fd_pr__pfet_01v8[model_parameter]
      let scale = 1e6
      * scaled to um
      let W = @m.xm1.msky130_fd_pr__pfet_01v8[w]*scale
      let L = @m.xm1.msky130_fd_pr__pfet_01v8[l]*scale
      let vg_val = v(Vg)
      let vgs_val = @m.xm1.msky130_fd_pr__pfet_01v8[vgs]
      let vth_val = @m.xm1.msky130_fd_pr__pfet_01v8[vth]
      
      echo W/L= $&W / $&L [um] Idac= $idac_val [A] >> /foss/designs/lab2/results/1.2/M1_Vgs_Vth.dat
      echo Vg= $&vg_val Vgs= $&vgs_val Vth= $&vth_val >> /foss/designs/lab2/results/1.2/M1_Vgs_Vth.dat
      echo >> /foss/designs/lab2/results/1.2/M1_Vgs_Vth.dat
    end
  end
.endc
"


name=sim_block only_toplevel=false
value="
.param W_DAC = 0.42 L_DAC = 0.15
.param I_DAC = 100n
.param VDD_val = 1.8
.options savecurrents

.control
  * Clear M1 files
  shell mkdir -p /foss/designs/lab2/results/1.2
  shell rm -f /foss/designs/lab2/results/1.2/M1_Vgs_Vth.dat
  * I_REF current sweep
  foreach idac_val 100n 10u
    * W/L group sweep (indexed W/L groups)
    foreach case_idx 1 2 3
      if $case_idx = 1
        alterparam W_DAC = 0.42
        alterparam L_DAC = 0.15
      end
      if $case_idx = 2
        alterparam W_DAC = 5.0
        alterparam L_DAC = 3.5
      end
      if $case_idx = 3
        alterparam W_DAC = 3.5
        alterparam L_DAC = 5.0
      end
      alterparam I_DAC = $idac_val
      reset
      op
      set appendwrite
      * NOTE: The syntax for extracting model params depends on the exact instance name in the PDK.
      * Typically, for Xschem, this is @m.xm1.msky130_fd_pr__pfet_01v8[model_parameter]
      let scale = 1e6
      * scaled to um
      let W = @m.xm1.msky130_fd_pr__pfet_01v8[w]*scale
      let L = @m.xm1.msky130_fd_pr__pfet_01v8[l]*scale
      let vg_val = v(Vg)
      let vgs_val = @m.xm1.msky130_fd_pr__pfet_01v8[vgs]
      let vth_val = @m.xm1.msky130_fd_pr__pfet_01v8[vth]
      
      echo W/L= $&W / $&L [um] Idac= $idac_val [A] >> /foss/designs/lab2/results/1.2/M1_Vgs_Vth.dat
      echo Vg= $&vg_val Vgs= $&vgs_val Vth= $&vth_val >> /foss/designs/lab2/results/1.2/M1_Vgs_Vth.dat
      echo >> /foss/designs/lab2/results/1.2/M1_Vgs_Vth.dat
    end
  end
.endc
"


}
C {lab_wire.sym} 0 -30 0 0 {name=p1 sig_type=std_logic lab=Vg}
