# Why not make a bash script out of this?

First of all:
sudo apt-get update


My version of ubuntu:
Ubuntu 14.04 Trusty Tahr
#yes, in system settings details it says 13.10
#but with
lsb_release -a
#it will say you have trusty
#if not, update:
sudo apt-get update; sudo apt-get dist-upgrade
sudo update-manager -d
#CLICK UPGRADE! not ok
#Some third party entries in your sources.list will
#be disabled. You can re-enable them after the
#upgrade with the 'software-properties' tool or
#your package manager.


Git:
sudo apt-get install git
git config --global user.email "adalyac@gmail.com"


Emacs:
sudo apt-add-repository ppa:cassou/emacs
sudo apt-get update
sudo apt-get install emacs-snapshot


Google chrome:
wget https:#dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
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
#would be nice to add ppa, but haven't found one for trusty
#F7: hide the chunky help bar stuff on the left
#F6: show awesomely discreet annotations toolbar
#F3: search (ESC to exit)


Toggle brightness:
#edit GRUB
sudo emacs /etc/default/grub
#change GRUB_CMDLINE_LINUX_DEFAULT to
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_osi=Linux acpi_backlight=vendor"
sudo update-grub
sudo reboot


Fortran compiler:
# needd it for scipy
sudo apt-get install gfortran

BLAS:
# need it for scipy
sudo apt-get install libblas-dev libatlas-dev liblapack-dev


Python libraries:
sudo apt-get install python-dev   #must start with this one!
apt-get install python-pip
sudo apt-get install python-magic
sudo apt-get install python-matplotlib
sudo pip install coverage numpy scipy matplotlib


Python scrapy:
sudo emacs /etc/apt/sources.list
lsb_release -cs
that comand will give you your distro.
and then add the following to the file, with relevant DISTRO:
deb http:#archive.scrapy.org/ubuntu DISTRO main
sudo aptitude update
sudo apt-get install scrapy-0.22


Cuda-convnet (other):
sudo apt-get install libatlas-base-dev #for cuda-convnet
sudo apt-get install subversion        #for cuda-convnet


# Postgres (open source SQL sicstus-like querying system):
sudo apt-get install postgresql-client-common
sudo apt-get install postgres-xc-client


# Prevent ssh from freezing
#add the following to ~/.ssh/config
Host *
  ServerAliveInterval 240
#then modify permissions on file
chmod 660 ~/.ssh/config
# ssh daemon closes connection if it doesn't hear anything
#from client for a while, this sends regular signals


Hipchat (Group Project messaging):
sudo su
echo "deb http:#downloads.hipchat.com/linux/apt stable main" > \
  /etc/apt/sources.list.d/atlassian-hipchat.list
wget -O - https:#www.hipchat.com/keys/hipchat-linux.key | apt-key add -
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
wget http:#download.utorrent.com/linux/utorrent-server-3.0-25053.tar.gz
sudo tar xvzf utorrent-server-3.0-25053.tar.gz -C /opt/
sudo chmod -R 777 /opt/utorrent-server-v3_0/
sudo ln -s /opt/utorrent-server-v3_0/utserver /usr/bin/utserver
utserver -settingspath /opt/utorrent-server-v3_0/
#If you get an error about libssl.so package missing:
sudo apt-get install libssl0.9.8:i386


# gimp - image editor
sudo apt-get install gimp


# shutter - snipping tool
sudo apt-get install shutter


# sshpass: to alias mundane ssh-ing
sudo apt-get install sshpass
# bit.ly/1izdr0J
# alias alias ssh-graphic02="sshpass -p password ssh -A -t ad6813@shell2.doc.ic.ac.uk ssh -A -t graphic02.doc.ic.ac.uk"


# gnuplot - graphs from command line
sudo apt-get install gnuplot

# screenshot
sudo apt-get install shutter



# Caffe:
# WARNING: without sudo, need a shit ton of space eg if Cython 
# not installed on system
# currently, caffe is installed on graphic06 under /data
# ---
cd /data/ad6813
git clone --depth=1 --branch master git://github.com/BVLC/caffe.git
# ---
# which version of CUDA
nvcc --version
# othw cat CUDA_SDK/gpu_sdk/doc/CUDA_SDK_Release_Notes.txt
# othw /usr/local/cuda then tab-tab to see which ones
# 
# delete ~/CUDA_SDK and copy it to /data because don't want to share
# same CUDA_SDK across all machines since they run different drivers.
rm -rf ~/CUDA_SDK
source /usr/local/cuda/setup.sh
mkdir -p /data/`whoami`/CUDA-SDK
cd !$
cp -pr /usr/local/cuda/gpu_sdk/{C,shared} .
cd shared
make
cd ../C/common
make
cd ../src/deviceQuery
# now don't follow exactly the README:
NVIDIALIBDIR=/data/$(whoami)/shared/lib
# should be:
/data/$(whoami)/CUDA-SDK/shared/lib
# nvidia driver 337 has a bug, needs to be run as root first
# that killed you for days, possibly weeks
# ---
# BLAS
# assume installed
# ---
# OpenCV
# which version:
pkg-config --modversion opencv
# ---
# C++ Boost 1.55
# which version of boost: cf pipe-classification/caffe/install/
# download:
cd /data/ad6813
mkdir boost
cd boost
wget -O boost_1_55_0.tar.gz
tar zxvf boost_1_55_0.tar.gz
cd boost_1_55_0
# install without sudo:
./b2 install --prefix=$HOME/.local
# add path environment variables
echo "export BOOST_ROOT=$HOME/.local"
# ---
# page says: glog, gflags, protobuf, leveldb, snappy, hdf5
cd /data/ad6813
for term in glog leveldb snappy hdf5; do apt-cache search $term; done > out.txt
# assume the python associated lib is required every time
for package in python-gflags protobuf leveldb python-snappy h5py;  do pip install --install-option="--prefix=$HOME/.local" $package >> install.out; done
# ---
# libgoogle-glog
wget https://google-glog.googlecode.com/files/glog-0.3.3.tar.gz
tar zxvf glog-0.3.3.tar.gz
rm glog-0.3.3.tar.gz
./configure --prefix=$HOME/.local --exec-prefix=$HOME/.local
make && make install
# ---
# (C++) protobufs
# dpkg -i fails. instead, download source and compile
cd ~/.local/src
apt-get source libprotobuf8 
cd protobuf-2.5.0
./configure --prefix=/homes/ad6813/.local
make && make check && make install
mv src/google/protobuf ../
cd .. && rm -rf protobuf-2.5.0
# ---
# gflags
cd ~/.local/src
wget https://github.com/schuhschuh/gflags/archive/master.zip
unzip master.zip
cd gflags-master
mkdir build && cd build
export CXXFLAGS="-fPIC" && export CMAKE_INSTALL_PREFIX="/homes/ad6813/.local"
cmake .. && make VERBOSE=1
# modify prefix in ~/.local/src/gflags-master/build/cmake_install.cmake from /usr/local/ to /homes/ad6813/.local
make && make install
# ---
# leveldb
apt-get source libleveldb-dev
rm leveldb*
# modify prefix in Makefil
make && make install
# ---
# hdf5
cd ~/.local/src
apt-get source libhdf5-dev
cd libhdf5-dev
./configure --prefix=/homes/ad6813/.local
make && make install
mv hdf5-1.8.11/src hdf5
rm -rf hdf5-1.8.11
# ---
# lmdb
cd ~/.local/src
mkdir ~/.local/man
mkdir ~/.local/man1
git clone git://gitorious.org/mdb/mdb.git
cd mdb/libraries/liblmdb
# in ~/.local/src/mdb/libraries/liblmdb/Makefile, update l.26 wih
# appropriate prefix
make && make install
# ---
# snappy
cd ~/.local/src
apt-get source libsnappy-dev
rm snappy*
cd snappy-1.1.0
./configure --prefix=/homes/ad6813/.local
make && make install
# ---
# Numpy >= 1.7
# which version of numpy
numpy.version.version
# ---
# Boost-provided boost.python
# assume installed
# ---
# path env vars
export CUDA_DIR=$CUDA_DIR:/usr/local/cuda
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/homes/ad6813/.local/lib:/usr/local/cuda/lib64:/usr/local/cuda/lib
export PATH=$PATH:/usr/local/cuda/bin
# ---
# Compile
# carry out instructions in /usr/local/cuda/README
# add following to bashrc:
if [ -f /usr/local/cuda/setup.sh ]
  then
	. /usr/local/cuda/setup.sh
fi
# to compile CUDA source code (which caffe has):
source /usr/local/setup.sh
# assume CUDA_SDK copied to ~, if not do it.
# then modify  Makefile in caffe: oh actually, -lcuda
# never appears anywhere. so proceed:
cp Makefile.config.example Makefile.config
# Adjust Makefile.config: 
# (like in ~/Git/pipe-classification/caffe/Makefile.config)
make all
make test
make runtest
# ---
lib, src, test, tools, examples
# are all in caffe/build.
# should be in ~/.local? change Makefile.config , build 
DONE!
# ---
# runtest
# executes $TEST_BIN_DIR/test_all.testbin which is unreadable
# runtest can't find libglog.so.0 but it's in ~/.local/lib
# which env var hasn't been set properly?
# LIBRARY_DIRS in Makefile.config has it
# maybe we need to set a special google-glog flag?
grep -r "GLOG" . > grep_GLOG.out
# candidates:
# LIBGLOG (as in glog-0.3.3/src/demangle_unittest.sh)
# GOOGLE_GLOG_DLL_DECL (probs not) 
# first, see if changing build to .local helps
# ---
make clean
cp -r build ~/.local/caffe_build
# (Makefile.config has build_dir changed to ~/.local/caffe_build
make all && make test && make runtest
# still same error, so reverting to previous setup
# maybe because test files are precompiled, so doesn't take the
# glog lib path specified in Makefile.config into account
# ---
# python wrappers
make pycaffe
# there may be missing libraries
# on graphic, need to upgrade six, need to use venv
cd caffe/python
pip install --install-option="--prefix=$HOME/.local" -r requirements.txt
# ImportError: You need `six` version 1.3 or later.
# struggling to upgrade a lib in /usr/
# instead, work inside a virtual environment
# bit.ly/1w0Jz3B
# work inside virtualenv but making use of all possible system libs
# to optimise space
virtualenv --system-site-packages venv
source venv/bin/activate
# find out which libraries from requirements.txt need installing/upgrading, and put them in requirements_min.txt
git clone https://github.com/colorgcc/colorgcc ~/Git/colorgcc
cp ~/Git/colorgcc/colorgccrc.txt ~/.colorgccrc
for link in g++ gcc cc colorgcc; do ln -s ~/Git/colorgcc/colorgcc.pl venv/bin/$link; done
for line in $(cat requirements_min.txt); do pip install $line; done
# call make pycaffe whenever make all:
sed -i '/^all:/ s/$/ pycaffe/' Makefile
# compile
make all
# ---

