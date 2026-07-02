# **Setting up remote Linux workstation for IIC-OSIC-TOOLS**

## **Ubuntu 24.04.4 LTS (Noble Numbat) setup**
---
1. Download Desktop Image; we got one from [here](https://releases.ubuntu.com/noble/)
2. Create a bootable USB stick with that image (using prefered software; we used win32_disc_imager on Windows or dd on linux)
3. Restart PC and boot the Ubuntu from USB stick
4. Get through installation process with prefered software 
   * we used default version
   * with 2 divided partitions (SATA Disc 240GB): 
     * one for Ubuntu (100GB; /)
     * second one for software (~140GB; /home)
     * there is third one default for boot (around 1GB; /boot/uefi)
5. Partitions can be divided after the setup with the help of USB stick by booting Ubuntu from USB and dividing partitions through "Discs" manager

## **Remote connection to server**
---
Here we mostly followed this [guide](https://www.cherryservers.com/blog/install-xrdp-on-ubuntu-2404)
1. Its good to update system packages first:
  ``` bash
  sudo apt update && sudo apt upgrade -y
  ```
1. Install Vim, OpenSSH, Xrdp and XFCE. Enable ssh and change config - In 'sshd_config' file uncomment line that has `#Port 22` in it and change the Port number to designated one. In our case it was ports 10160-10164. 
  ``` bash
  sudo apt install vim
  sudo apt install openssh-server -y
  sudo apt install xrdp
  sudo apt install xfce4 xfce4-goodies -y

  sudo systemctl enable ssh
  sudo ufw allow ssh

  cd /etc/ssh
  sudo vim sshd_config
  # inside the file change uncomment Port line and change the number to your port
  ```
3. Reload system services and apply SSH configuration: 
  ``` bash
  usystemctl daemon-reload
  systemctl restart ssh.socket
  ```
4. Configure XRDP to use XFCE:
  ``` bash
  sudo adduser xrdp ssl-cert
  echo "xfce-session" | tee ~/.xsession
  sudo systemctl restart xrdp
  ```
**IMPORTANT:** If you have changed your default sshd port, you must update your firewall rules to allow traffic through the new port.
  ``` bash
  sudo ufw allow [port_number]/tcp # change the [port_number] to your port
  sudo ufw deny 22/tcp
  ```
Update firewall rules to enable RDP access:
  ```bash
  sudo ufw allow 3389/tcp
  sudo ufw enable
  sudo ufw reload
  ```
5. In new terminal you can check if everything is working correctly; **IMPORTANT:** remember to logout after each login.
   * '-p [port_number]' is port number - change to your own
   * '-l [login]' is login - change to your own
  ``` bash
  ssh -p 22 localhost 
  ssh 192.168.0.160 -p [port_number]
  ssh 149.156.107.197 -p [port_number] -l [login]

  ssh -L 3389:localhost:3389 [login]@149.156.107.197 -p [port_number]
  ```
6. If everything is working fine from the side of the Ubuntu now you can connect from the other device.
7. First go into **Powershell** and establish the secure SSH tunnel: 
  ``` bash
  ssh -L 3389:localhost:3389 [login]@149.156.107.197 -p [port_number]
  ```
1. Open **Remote Desktop Connection** and configure settings: 
   * **Default/Computer:** `127.0.0.1`
   * **Default/Username:** `[login]`
   * **Display/Display Configuration:** set to your prefered display resolution
   * **Display/Colors:** set to `True Color` or `16-bit High Color`
   * **Experience/Performance:** `Automatic` or your prefered connection quality
2. Click **Connect** and log into your remote desktop.

## (Optional) VSCode setup

You can follow this quick [guide](https://code.visualstudio.com/docs/setup/linux) or download VSC from App Center.

## (Optional) Git quick setup

1. Check for updates and install git.
  ``` bash
  sudo apt update
  sudo apt install git -y
  ```
2. Set your identity.
  ``` bash
  git config --global user.name "Your Name"
  git config --global user.email "your.email@example.com"
  ```
3. Generate new ssh key.
  ```bash
  ssh-keygen -t ed25519 -C "your.email@example.com"
  ```
4. Start the SSH agent in the background and add new key.
  ```bash
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  ```
5. Add ssh key to your github. Firstly copy the output of: 
  ``` bash
  cat ~/.ssh/id_ed25519.pub
  ```
  Create new ssh key on github website; Go into Account Settings -> SSH and GPG keys -> New SSH key. Then you can paste the `cat` output you previously copied. Everything should be set now.

6. Now you can test the connection.
  ```bash
  ssh -T git@github.com
  ```
  If it asks if you want to continue connecting, type `yes` and hit Enter. You should see a success message containing your username. Congrats, everything is working correctly.