v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 560 -300 1360 100 {flags=graph
y1=-0.036
y2=2
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=3e-08
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
legendmag=1.0
node="in
out_sch"
color="7 4"
dataset=-1
unitx=1
logx=0
logy=0
}
N -100 0 -100 30 {lab=VDD}
N -100 90 -100 120 {lab=0}
N 0 -0 0 30 {lab=IN}
N 0 0 20 -0 {lab=IN}
N 110 -0 160 -0 {lab=OUT_SCH}
N 0 90 0 120 {lab=0}
N 0 -110 20 -110 {lab=IN}
N -0 -110 0 -0 {lab=IN}
N 80 -110 100 -110 {lab=#net1}
N 190 -110 210 -110 {lab=#net2}
N 270 -110 300 -110 {lab=OUT_SV}
C {inv.sym} 60 0 0 0 {name=x_schem}
C {vsource.sym} 0 60 0 0 {name=V_IN value="pulse 0 1.8 0 100p 100p 5n 10n" savecurrent=false}
C {vsource.sym} -100 60 0 0 {name=VDD value=1.8 savecurrent=false}
C {gnd.sym} -100 120 0 0 {name=l1 lab=0}
C {gnd.sym} 0 120 0 0 {name=l2 lab=0}
C {vdd.sym} -100 0 0 0 {name=l3 lab=VDD}
C {lab_wire.sym} 160 0 0 1 {name=p1 sig_type=std_logic lab=OUT_SCH}
C {lab_wire.sym} 0 0 0 0 {name=p2 sig_type=std_logic lab=IN}
C {code.sym} 400 -160 0 0 {
name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt
"
spice_ignore=false
      }
C {code.sym} 400 -10 0 0 {name=sim_block 
only_toplevel=true
value=
"
.control
  save all
  tran 10p 30n
  write inv_test_1.raw
  write /foss/designs/inv_mixed/inv_test_1.raw
  quit
.endc
"}
C {launcher.sym} 630 130 0 0 {name=h5
descr="load waves 
(after running sim: Ctrl + LeftClick)"
tclcommand="xschem raw_read $netlist_dir/inv_test_1.raw tran"
}
C {lab_wire.sym} 300 -110 0 1 {name=p3 sig_type=std_logic lab=OUT_SV}
C {inv_sv.sym} 140 -110 0 0 {name=a_sv model=inv_sv

device_model=".model inv_sv d_cosim simulation=\\"ivlng\\" sim_args=[\\"inv_sv.vvp\\"]"}
C {adc_bridge.sym} 50 -110 0 0 {name=A1 adc_bridge_model= adc_buff
device_model=".model adc_buff adc_bridge(in_low=0.6 in_high=1.2 rise_delay=10n fall_delay=10n)"}
C {dac_bridge.sym} 240 -110 0 0 {name=A2 dac_bridge_model= dac_buff
device_model=".model dac_buff dac_bridge(input_load=1e-15 t_rise=10n t_fall=10n out_low=0 out_high=1.8)"}
