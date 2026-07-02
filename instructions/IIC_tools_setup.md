# Setting up Integrated Ciruit Layout Design Software

## IIC_OSIC_TOOLS first setup and launch
IIC tools git is available under this [link](https://github.com/iic-jku/iic-osic-tools). The whole setup process comes down to one-line tool setup and installing Docker. 

1. If you dont have curl, install it.
``` bash
sudo apt install curl
```
2. Then install IIC tools, the one-line setup is: 
``` bash
curl -fsSL https://osic.tools/install.sh | bash
```
3. Then follow the Docker installation process described on their [site](https://docs.docker.com/desktop/setup/install/linux/ubuntu/)
4. There are few ways to launch the tool. firstly go to the iic-osic-tools folder in your home directory. then you can launch the enviroment by using commands:  
   `./start_x.sh` - launches the x  
   `./start_vnc.sh` - x  
   `./start_shell.sh` - x  
Just keep in mind that first launch might take few minutes before the program launches. 

## Getting familiar with IIC-OSIC-TOOLS and sky130A library
This guid will follow the local enviroment started up with `./start_x.sh`. It should launch a terminal.
1. With command `sak-pdk` you can switch between different PDKs, type this command to see the usage. In this tool, there are 4 available by default PDKs with them being: 
   * `sky130A` - SkyWater Technologies, 180-130nm hybrid 1.8-3.3V 
   * `gf180mcuD` - Global Foundries, 180nm 3.3-6V
   * `ihp-sg13g2` - IHP Microelectronics
   * `ihp-sg13cmos5l` - IHP Microelectronics
2. This instruction will get you familiar with sky130A PDK so use `sak-pdk sky130A`. If this command is not input before starting your work, you will be using default PDK, which is `ihp-sg13g2`. You can check current PDK with `echo $PDK` after launch.
3. Then you can launch schematic capture
and netlisting EDA tool - Xschem with command:
``` bash
xschem [filename].sch
```
4. Feel free to explore Menu Bar, especially the `Help -> Keys/Keybindings` that has many useful shortcuts and `Help -> About XSCHEM` from which can check program's git or [Xschem Manual](https://xschem.sourceforge.io/stefan/xschem_man/xschem_man.html).
5. x