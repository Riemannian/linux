# Why not make a bash script out of this?

First of all:
sudo apt-get update


My version of ubuntu:
Ubuntu 14.04 Trusty Tahr
//yes, in system settings details it says 13.10
//but with
lsb_release -a
//it will say you have trusty
//if not, update:
sudo apt-get update; sudo apt-get dist-upgrade
sudo update-manager -d
//CLICK UPGRADE! not ok
//Some third party entries in your sources.list will
//be disabled. You can re-enable them after the
//upgrade with the 'software-properties' tool or
//your package manager.


Git:
sudo apt-get install git
git config --global user.email "adalyac@gmail.com"


Emacs:
sudo apt-add-repository ppa:cassou/emacs
sudo apt-get update
sudo apt-get install emacs-snapshot


Google chrome:
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*; sudo apt-get -f install


Hide Unity taskbar:
via GUI:
click top-right-hand-corner button
click System Settings
click Appearance
click Behaviour
Auto-hide the Launcher: ON
make it slightly more sensitive than default


Make only current directory display on terminal:
open ~/.bashrc
replace:
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
with:
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi


# bashrc configured the way you like it:
cp bash/bashrc.sh ~/.bashrc


Disable bluetooth on startup:
didn't work: sudoedit /etc/rc.local, rfkill block bluetooth
sudo emacs /etc/rc.local
add: blacklist btusb


Gitlab:
...


Aptitude (used for installing ubuntu packages):
sudo apt-get install aptitude


Okular:
sudo apt-get install okular
//would be nice to add ppa, but haven't found one for trusty
//F7: hide the chunky help bar stuff on the left
//F6: show awesomely discreet annotations toolbar
//F3: search (ESC to exit)


Toggle brightness:
//edit GRUB
sudo emacs /etc/default/grub
//change GRUB_CMDLINE_LINUX_DEFAULT to
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_osi=Linux acpi_backlight=vendor"
sudo update-grub
sudo reboot


Python libraries:
sudo apt-get install python-dev   //must start with this one!
apt-get install python-pip
sudo apt-get install python-magic
sudo apt-get install python-matplotlib
sudo pip install coverage
sudo pip install numpy
sudo pip install pymongo


Python scrapy:
sudo emacs /etc/apt/sources.list
lsb_release -cs
that comand will give you your distro.
and then add the following to the file, with relevant DISTRO:
deb http://archive.scrapy.org/ubuntu DISTRO main
sudo aptitude update
sudo apt-get install scrapy-0.22


Cuda-convnet (other):
sudo apt-get install libatlas-base-dev //for cuda-convnet
sudo apt-get install subversion        //for cuda-convnet


# Postgres (open source SQL sicstus-like querying system):
sudo apt-get install postgresql-client-common
sudo apt-get install postgres-xc-client


# Prevent ssh from freezing
//add the following to ~/.ssh/config
Host *
  ServerAliveInterval 240
//then modify permissions on file
chmod 660 ~/.ssh/config
# ssh daemon closes connection if it doesn't hear anything
//from client for a while, this sends regular signals


Hipchat (Group Project messaging):
sudo su
echo "deb http://downloads.hipchat.com/linux/apt stable main" > \
  /etc/apt/sources.list.d/atlassian-hipchat.list
wget -O - https://www.hipchat.com/keys/hipchat-linux.key | apt-key add -
apt-get update
apt-get install hipchat


# add greek/french key mappings
xmodmap -pke > extrakeydefs.lst
cp -f mykeydefs.lst extrakeydefs.lst
xmodmap extrakeydefs.lst


# Mirage light image viewer in PyGTK
sudo apt-get install mirage


# uTorrent
cd Downloads
wget http://download.utorrent.com/linux/utorrent-server-3.0-25053.tar.gz
sudo tar xvzf utorrent-server-3.0-25053.tar.gz -C /opt/
sudo chmod -R 777 /opt/utorrent-server-v3_0/
sudo ln -s /opt/utorrent-server-v3_0/utserver /usr/bin/utserver
utserver -settingspath /opt/utorrent-server-v3_0/
//If you get an error about libssl.so package missing:
sudo apt-get install libssl0.9.8:i386


# gimp - image editor
sudo apt-get install gimp


# shutter - snipping tool
sudo apt-get install shutter


# sshpass: to alias mundane ssh-ing
sudo apt-get install sshpass
# http://bit.ly/1izdr0J
# alias alias ssh-graphic02="sshpass -p password ssh -A -t ad6813@shell2.doc.ic.ac.uk ssh -A -t graphic02.doc.ic.ac.uk"


# gnuplot - graphs from command line
sudo apt-get install gnuplot
