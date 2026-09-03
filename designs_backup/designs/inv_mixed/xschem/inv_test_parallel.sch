v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 650 -220 1450 180 {flags=graph
y1=-0.029
y2=2
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=0
x2=5e-06
divx=5
subdivx=4
xlabmag=1.0
ylabmag=1.0
legendmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=1
color="7 12"
node="out_sch
out_sv"
autoload=1
sim_type=tran
vlegend=0}
B 2 650 -640 1450 -240 {flags=graph
y1=0
y2=1.8
ypos1=0
ypos2=2
divy=5
subdivy=4
unity=1
x1=0
x2=5e-06
divx=5
subdivx=4
xlabmag=1.0
ylabmag=1.0
legendmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
hilight_wave=0
color=4
node=in
autoload=1
sim_type=tran
vlegend=0}
T {This is testbench for mixed simulation of inverters: 
* inv - created cmos inverter using sky130A library 
* inv_sv - inverter defined by verilog module (press 
ctrl + LeftClick on the symbol to check verilog code)

First Build Icarus Verilog or Verilator objects by 
pressing 'Ctrl + LeftClick' on the green arrows.
To view the waves on the right of the schematic - press 
'Ctrl + LeftClick' after running simulation. } 0 -600 0 0 0.3 0.3 {}
N 460 40 460 70 {lab=VDD}
N 460 130 460 160 {lab=0}
N 0 -0 0 30 {lab=IN}
N 0 0 20 -0 {lab=IN}
N 110 -0 160 -0 {lab=OUT_SCH}
N 0 90 0 120 {lab=0}
N 0 -110 20 -110 {lab=IN}
N 0 -110 0 0 {lab=IN}
N 80 -110 100 -110 {lab=#net1}
N 190 -110 210 -110 {lab=#net2}
N 270 -110 300 -110 {lab=OUT_SV}
C {inv.sym} 60 0 0 0 {name=x_sch}
C {vsource.sym} 0 60 0 0 {name=V_IN value="pulse 0 1.8 0 100p 100p 1u 2u" savecurrent=false}
C {vsource.sym} 460 100 0 0 {name=VDD value=1.8 savecurrent=false}
C {gnd.sym} 460 160 0 0 {name=l1 lab=0}
C {gnd.sym} 0 120 0 0 {name=l2 lab=0}
C {vdd.sym} 460 40 0 0 {name=l3 lab=VDD}
C {lab_wire.sym} 160 0 0 1 {name=p1 sig_type=std_logic lab=OUT_SCH}
C {lab_wire.sym} 0 -110 0 0 {name=p2 sig_type=std_logic lab=IN}
C {code.sym} 520 -80 0 0 {
name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt
"
spice_ignore=false
      }
C {code.sym} 520 70 0 0 {name=sim_block 
only_toplevel=true
value=
"
.control
  save all
  tran 100p 5u
  write inv_test_parallel.raw
  write /foss/designs/inv_mixed/results/inv_test_parallel.raw
  quit
.endc
"}
C {launcher.sym} 60 -270 0 0 {name=h_load_wave
descr="load waves"
tclcommand="xschem raw_read $netlist_dir/inv_test_parallel.raw tran"
}
C {lab_wire.sym} 300 -110 0 1 {name=p3 sig_type=std_logic lab=OUT_SV}
C {inv_sv.sym} 140 -110 0 0 {name=a_sv 
model=inv_sv 
***Icarus_verilog***
device_model=".model inv_sv d_cosim simulation=\\"ivlng\\" sim_args=[\\"inv_sv.vvp\\"] delay=1p"
***Verilator***
*device_model=".model inv_sv d_cosim simulation=\\"inv_sv.so\\""
tclcommand="edit_file [abs_sym_path ../verilog/inv_sv.sv]"}
C {adc_bridge.sym} 50 -110 0 0 {name=A1 adc_bridge_model= adc_buff
device_model=".model adc_buff adc_bridge(in_low=0.6 in_high=1.2 rise_delay=1p fall_delay=1p)"}
C {dac_bridge.sym} 240 -110 0 0 {name=A2 dac_bridge_model= dac_buff
device_model=".model dac_buff dac_bridge(input_load=1e-15 t_rise=1p t_fall=1p out_low=0 out_high=1.8)"}
C {launcher.sym} 60 -390 0 0 {name=h_build_iverilog
descr="Build Icarus Verilog object"
tclcommand="execute 1 sh -c \\"iverilog -g2012 -o [abs_sym_path ../verilog/inv_sv.vvp] [abs_sym_path ../verilog/inv_sv.sv] && cp -f [abs_sym_path ../verilog/inv_sv.vvp] $netlist_dir/\\""}
C {launcher.sym} 60 -330 0 0 {name=h_build_verilator
descr="Build Verilator object"
tclcommand="execute 1 sh -c \\"cd $netlist_dir; ngspice vlnggen [abs_sym_path ../verilog/inv_sv.sv]\\""}
