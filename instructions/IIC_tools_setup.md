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
3. Add new user to docker.
``` bash
sudo usermod -aG docker $USER
```
4. Apply changes to your current terminal session.
``` bash
newgrp docker
```
5. If you dont want to repeat this step each time you login, you should reboot the system.
``` bash
sudo reboot
```
6. Then follow the Docker installation process described on their [site](https://docs.docker.com/desktop/setup/install/linux/ubuntu/)
7. There are few ways to launch the tool. firstly go to the iic-osic-tools folder in your home directory. then you can launch the enviroment by using commands:  
   `./start_x.sh` - launches the GUI using your local X11 server window.  
   `./start_vnc.sh` - launches a remote desktop session inside a VNC server, accessible via your web browser or a VNC viewer. After running the command go to [http://localhost](http://localhost) and use default password `abc123`. More about it [here](https://github.com/iic-jku/iic-osic-tools#42-using-vnc-and-novnc).  
   `./start_shell.sh` - launches a text-only command-line interface (CLI) directly in your current terminal.  

Just keep in mind that first launch might take a few minutes before the program launches. 

## (Optional) Quick launch for IIC-OSIC-TOOLS with chosen PDK

Iside `scripts/iic_tools_launch_scripts` there is a file `run_iic_tools.sh` - this is a new .sh file, not available with iic-osic-tools install. If you want to use it, copy it into `~/iic-osic-tools/` folder.  
You can still launch it same as the previously mentioned - by entering command `./run_iic_tools.sh`. For this instance we wanted quick and easy access to tool without bothering about our location so we created alias, which I highly recommend.  

To create pernament aliases you have to edit .bashrc file:
``` bash
micro ~/.bashrc
```
And then add at the end of the file:
``` bash
alias run_iic='~/iic-osic-tools/run_iic_tools.sh'
```
(Optional) I also added some for general use and git:
``` bash
alias c='clear'
alias update="sudo apt update && sudo apt upgrade"
alias gs='git status'
alias gc='git commit -m'
alias gp='git push origin main'
```
Then you refresh this config file:
``` bash
source ~/.bashrc
```
Everything is set up correctly now, you can launch tools by typing `run_iic` in the terminal.

---

Script `run_iic_tools.sh` is basically `./start_x.sh` but with addition of automatic PDK launch so you won't have to type sak-pdk [PDK] each time you run iic tools. If viewed with notepad/vim you can search near the file's end two variables for config:  
`SELECT_PDK` - set flag to 'True' to choose PDK on each launch. Currently set as 'False'.  
`USER_PDK` - Default PDK that will be chosen if SELECT_PDK is False or user doesn't input anything when prompted for PDK. Since I will be working on Sky130A, thats currently default. When launched it always outputs default PDK and which PDK is used for launch.  

## Introduction IIC-OSIC-TOOLS and sky130A PDK 

This guide will follow the local enviroment started up with `./start_x.sh` or `./run_iic_tools.sh`. It should launch a terminal.
1. With command `sak-pdk` you can switch between different PDKs, type this command to see the usage. In this tool, there are 4 available by default PDKs with them being: 
   * `sky130A` - SkyWater Technologies, 180-130nm hybrid 1.8-3.3V 
   * `gf180mcuD` - Global Foundries, 180nm 3.3-6V
   * `ihp-sg13g2` - IHP Microelectronics
   * `ihp-sg13cmos5l` - IHP Microelectronics
2. This instruction will get you familiar with sky130A PDK so use `sak-pdk sky130A` or the ./run. If this command is not input before starting your work, you will be using default PDK, which is `ihp-sg13g2`. You can check current PDK with `echo $PDK` after launch. This step is not necessary if launched using `run_iic_tools.sh` or `run_iic` alias that was optionally set up.
3. Then you can launch schematic capture and netlisting EDA tool - Xschem - with command:
``` bash
xschem # or `xschem [filename].sch` to launch specific file from your designs
```
4. Feel free to explore Menu Bar, especially the `Help -> Keys/Keybindings` that has many useful shortcuts and `Help -> About XSCHEM` from which can check program's git or [Xschem Manual](https://xschem.sourceforge.io/stefan/xschem_man/xschem_man.html).
5. If PDK is already chosen as sky130A and you use just `xschem` command Xschem will launch with `top.sch` that has: all available components in this PDK and some useful informations about them; Links to sky130A instructions, documentation, github; test cells for different simulations; digital standard cells. 