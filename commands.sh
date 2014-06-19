Which shell am I using:
echo $SHELL


Copy:
# copy multiple files here
cp file[wildcards] .       # it's all about the '.'
# ---
# force copy recursively:
cp -rf target destination_directory
# if this doesn't work, then your cp is aliased
# move to another environment (bash, ksh, tcsh) and try again
# hopefully cp won't be aliased everywhere
# ---
# files from local to remote computer via ssh:
scp local/path/filename ad6813@shell4.doc.ic.ac.uk:/remote/path
scp ad6813@shell4.doc.ic.ac.uk:/remote/path/filename local/path
# pipe scp:
# bit.ly/1kzp8ZY
# ---
Git remove branch:
git branch -d branchname

Git branch from commit:
git branch branch_name commit_id

Git switch from https to ssh:
git remote set-url origin git@github.com:HoldenCaulfieldRye/repo_name.git

Git when file deleted:
git log -- [file_path]

Git checkout back to head:
git checkout master

Git merge certain files:


Create hard link:

Download from command line:
wget download_link


FTP commands:
# connect & save all files in ftp server directory to local directory:
wget -r ftp://username:password@hostname.com
# connect to server:
ftp user@ftp.example.com
# set the mode of file transfer:
ascii          # good for txt
binary         # recommended for all non txt: images, archives etc
# authorised commands:
ls
mget           # download multiple files to local dir
get filename   # saves to local dir
cd             # change dir on ftp server
lcd            # change dir locally
pwd            # print dir path on ftp server
lpwd           # print local dir path
#internet file transfer program
#http://www.cyberciti.biz/faq/linux-unix-ftp-commands/


Locate file:
locate file_name_substring
# notice you need no wild cards, no inverted commas to locate file
# containing substring.
# to locate file with exactly file_name as filename:
locate 'file_name'
# to locate file ending with file_name_end:
locate '*file_name_end'
# to locate file starting with file_name_neg:
locate 'file_name_beg*'


Locate file with find:
#https:#help.ubuntu.com/community/find
#looks in all subdirs too:
find $HOME -name "text"
#to separate stdout from stderr (stdout to file):
find -name "text" > temp.txt
#case insensitive:
find -iname "text"
#regex match:
find -regex 



Locate text within files:
# to look in whole filesystem:
DONT PUT * WILDCARDS IN TEXT TO SEARCH! # we know it's a substring
grep "text" /*
# to look here:
grep "text" .
# to look in a specific directory:
grep "text" /path/to/directory/*
# to look in a specific directory and all its subdirectories:
grep -r "text" /path/to/directory/
# to look there except for a directory
grep -r --exclude-dir=dirname "text" path


Locate multiple words within files:
grep "word1\|word2\|word3" /path/to/files


Create symlink:
ln -s <dest> <linkname>
# hard link
ln <dst> <linkname>


Diff between two files:
grep -f file1 file2


List files:
# by date last modified:
ls -lt
# by file size:
ls -lh   #-h stands for human readable
du -sh *
# matching a certain expression
ls image_[0-9]{.jpg,meta.dat}  # notice no inverted commas!

How many files / dirs / symlinks:
# Number of files 
# files or dirs or symlinks
ls -l dir | wc -l
# files only
ls -l dir | grep ^- | wc -l
# dirs only
ls -l dir | grep ^d | wc -l
# symlinks only
ls -l dir | grep ^l | wc -l




What is my local ssh address:
# it's your ip address
fgrep `hostname` /etc/hosts
# also
ifconfig


Test if ssh working:
ssh -T git@github.com


Launch an ssh tunnel:
ssh -D 8080 -C -N username@example.com
# bit.ly/S1t8Xo


Mount remote filesystem:
sshfs 
# bit.ly/1kzzg4V


Image pixel size:
convert MyJpeg.jpg -print "Size: %wx%h\n" /dev/null


What shell am I using:
echo $SHELL


Redirect stderr, stdout to file AND print stderr, stdout to console:
do_something 2>&1 | tee -a some_file
#don't care about console, just everything to file:
command >> output.txt 2>&1 
# IF ERROR: WORKS IN BASH, not tcsh


Append text to file(s):
# to end of file:
echo 'text' >> file
# to beginning of file:
sed -i 'text' file
# to beg & end of multiple files
for file in *.txt; do
    echo 'text' >> file &&
    sed -i 'text' file
done
# but apparently this one is better:
echo 'task goes here' | cat - todo.txt > temp && mv temp todo.txt
# interpret syntax: cf comment bit.ly/1wOhEqR 
    

Environment variables:
#what is PATH set to:
echo "$PATH"
# append to path variable:
export PATH=$PATH:/path/to/dir1
# append multiple paths
export PATH=$PATH:/path/to/dir1:/path/to/dir2
# bit.ly/1u4Souj


How much space:
# used and available on entire disk:
df -h                #-h is for human readable form
# used in current dir:
du -h
du -sh *
# used in specific dir:
du -s -h path/to/dir  
du -h path/to/dir     # recursive


Extract archives:
# tar.gz, .tgz:
tar zxvf archive_name.tgz
# tar.gz, place files in another folder:
tar zxvf archive_name.tgz -C /path/to/directory
# arch.tar, place files in another folder:
tar -xf arch.tar -C dir/filename
# tar.bz2, create and store in dir:
tar jxf tar.bz2 -C dir/filename
# zip:
unzip file.zip -d destination_folder


Create archive:
zip zipfilename file1 file2 fil3


add alias:
alias emacs="emacs23"
#add that to your ~/.cshrc file


List running processes:
ps aux
# all user processes:
ps
# all processes containing substrings:
ps auwxx | grep <substring of top attribute> | grep <other substring of top attribute>

Kill process:
kill <PID>

Disable screensaver:
gsettings set org.gnome.settings-daemon.plugins.power active false


Run process in background without interruption even if logout, take 1:
#btw, concurrent processes can simply be obtained with '&'
#parallel computing requires root access because OS usually manages that
#tmux just keeps a whole shell running even if you log out, until machine 
#reboots. so having multiple tmuxes doesn't increases parallelism I think!
tmux                            #starts a detached shell
<command that launches process> #starts a process on that shell
<hotkey: Ctrl-b d>              #returns from detached shell to home shell
tmux ls                         #list all detached shells
tmux a -t <tmux number>         #moves to specified detached shell


Run process in background without interruption even if logout, take 2:
nohup     #no hang-up
# example:
nohup rlwrap sicstus -l my_wol.pl < input.txt > output.txt 2>&1 &
#run sicstus with my_wol.pl consulted and execute commands in
#input.txt and redirect stderr/stdout to output.txt and place process
#in background
ps aux | grep ad6813   #to find your running process

view image:
mirage <img_name>


What is my distro:
# which version of ubuntu
lsb_release -a
trusty


my computer model, manufacturer and other specs:
dmidecode | less


Is my machine 32 bit or 64 bit:
uname -m
#x86_64 means part of X86 family, uses 64 bit registers, 64 bit mem
addresses, max 2^64 main memory


What kernel version:
uname -a
uname -r #for exact version


System performance stats:
nmon         #loads of awesome stuff!


Display CPU info:
less /proc/cpuinfo
# you have a dual core hyperthreading processor
# graphic02 has a quadcore processor
# range(coreid) gives you number of physical cores
# range(physical\ id) gives you number of CPUs (a dual core CPU is still 1 CPU)
#http://www.makeuseof.com/tag/hyperthreading-technology-explained/
#http://www.richweb.com/cpu_info


Check whether a package is installed:
dpkg -s package_name

Uninstall/remove package:
sudo apt-get remove package_name
#remove package and all configuration files:
sudo apt-get --purge remove package_name


Install package without root priviledges:
dpkg -i --force-not-root --root=$HOME package.deb
# better to have --root=$HOME/local instead?
# ---
# alternatively, use schroot - apparently involved: bit.ly/1ksYliJ


Install tar.gz tar.bz2 file:
# http://askubuntu.com/questions/25961/how-do-i-install-a-tar-gz-or-tar-bz2-file


Install package from command line:
# cd to directory containing .deb file
sudo spkg -i that_package.deb



Solve unmet dependencies:
#note: last time I had this, I went to .deb file in downloads
#and manually installed it using above.
#General installation issues, 2 useful posts:
http://askubuntu.com/questions/140246/how-do-i-resolve-unmet-dependencies
http://ubuntuforums.org/showthread.php?t=1986644
#this is a specific case, but great to learn from:
http://www.bitsbythepound.com/installing-wink-on-64-bit-ubuntu-210.html


install .deb file, ie a package:
sudo dpkg -i package_filename
#dpkg is the manual, backend equivalent of apt-get
#dpkg -i is eq to apt-get install


Where are package configuration files stored:
#(stored automatically during setup)
/usr/local/lib


Clean space:
sudo apt-get autoremove


Change mode of a file:
#(ie change the rwx permissions) 
#to give full permission:
chmod 777 filename


Okular:
okular file_name


Determine pixels in image file:
identify filename.jpg


Navigate on vim:


Whats my version of scrapy:
scrapy version -v


How much RAM am I using:
free -m


Whats my internet speed:
wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip
#will download a 10MB file to dustbin then print avg download speed


PPA installation:
sudo add-apt ppa:name_of_ppa
sudo apt-get update
sudo apt-get install program_name
ppa means personal package archive


Check if a library/package is installed:
locate library_name
#or, for more info
dpkg -s library_name


Which packages include a specific file:
apt-file search filename


What does apt stand for:
advanced packaging tool


What does ppa stand for:
#personal package archive


view processor activity:
top
htop #looks nicer/cooler, with graphical CPU usage for each core
# interpret coolours in status bars:
# CPU:
#   Blue  = Low priority threads
#   Green = Normal priority threads
#   Red   = Kernel threads
# Memory:
#   Green = Used memory
#   Blue  = Buffers
#   Yellow/Orange = Cache
cache memory takes up all space?
# http://bit.ly/1pzlIJF
VIRT:
# virtual size of a process ie: sum of
# memory it is using
# memory it has mapped to itself
# files on disk that have been mapped into it
# memory shared with other processes

gpu specs:
hardinfo   #needs sudo apt-get
lspci -v | less

nvidia gpu specs:
nvidia-smi -a
#GeForce GTX Titan black:
#number of cores: 2880 cuda cores
#clock speed: 889 MHz
#main memory: 6 GB
#memory bandwidth: 336 GB/sec


Network diagnostics, mtr:
# find bottleneck in ssh connection:
mtr <IP address or hostname>
# shows state, connection, responsiveness of intermediate hosts.
# bit.ly/1pzoCOp
# ---
BSG bottleneck # ae29.londpg-sbr1.ja.net
Interpret mtr stats:
Loss% # % of packet loss at corresponding hop
Snt   # number of packets sent
Avg   # avg latency in milliseconds of packets sent
# ---
# one-off losses are likely due to rate limiting.


Rename all files otf:
# to rename abcdefg999hijklmnopq.txt to abcdefghijklmnopq.txt
mv abcdefg{999,}hijklmnopq.txt
# but because you need {old, new}, you can't use other wildcards
# so if you want to replace report3 with litSurvey for every file containing
# report3 substring: http://bit.ly/1tjywBl
for file in *report3.*; do mv $file ${file/report3/litSurvey}; done


Regex:
# wildcards are different to those in bash
# http://www.grymoire.com/unix/Regular.html
$ #: end with
^ #: start with
\ #: cancel wildcard effect of next char


Launch utorrent:
#http://askubuntu.com/questions/104094/how-to-install-utorrent-step-by-step


Launch gummi:
gummi filename.tex

Install latex package:
#Note! you just need package.sty to be present in directory of latex file
#for it to load when opening the latex file.
#otherwise:
#go to http://www.ctan.org/search
#enter package search query
#follow rest of instructions at
#http://www.inf.ed.ac.uk/systems/tex/new-packages.html
#under 'installing a package yourself'


Compile latex into pdf:
pdflatex file.tex
#if error appears, you can hit enter to skip it


Connect to postgres database system:
psql --username=<username> --dbname=<database_name>


Scroll/navigate through output:
less <command>


Add plugin to emacs:
# 1) place myplugin.el in ~/.emacs.d/
# 2) add to ~/.emacs:
(add-to-list 'load-path "~/.emacs.d/")
(load "myplugin.el")
# 2) or if that doesn't work, instead:
(require 'myplugin')

Emacs commands:
# search backwards
C-r
# replace string
M-x replace-string
# indent region
C-c >
C-c <

Lynx browser:
MOVEMENT:
   Down arrow     - Highlight next topic
   Up arrow       - Highlight previous topic
   Right arrow,   - Jump to highlighted topic
   Return, Enter  - Follow selected link
   Left arrow     - Return to previous topic

SCROLLING: 
   CTRL-A         - Go to first page of the current document (Home)
   CTRL-E         - Go to last page of the current document (End)
   CTRL-B         - Scroll up to previous page (Page-Up)
   CTRL-F         - Scroll down to next page (Page-Down)

DIRED:
   d              - Download selected file
   f              - Show a full menu of options for current file

OTHER:       
   ? (or h)       - Help (this screen)
   d              - Download the current link
   g              - Goto a user specified URL or file
   p              - Print to a file, mail, printers, or other
   q              - Quit (Capital 'Q' for quick quit)
   /              - Search for a string within the current document
   V              - Go to the Visited Links Page
   z              - Cancel transfer in progress
   [backspace]    - Go to the History Page
   =  - Show info about current document, URL and link
   CTRL-R         - Reload current file and refresh the screen
   CTRL-L         - Refresh the screen
   CTRL-U         - Inside text input line or field,
                    erase input line (more input line commands)
   CTRL-G         - Cancel input or transfer


save source install files under:
/usr/local/src


# Gcc which version:
gcc -v

#Caffe:
#which version of CUDA
nvcc --version
#othw cat CUDA_SDK/gpu_sdk/doc/CUDA_SDK_Release_Notes.txt
#othw /usr/local/cuda then tab-tab to see which ones
#assume BLAS is installed
#which version of openCV
pkg-config --modversion opencv
#which version of boost: cf pipe-classification/caffe/install/
#which version of numpy
numpy.version.version



Python:

Install any python library:
# inside the uncompressed directory for the lib, enter:
sudo python setup.py install
# ---

Install python package without root privileges:
DONT FORGET TO EXTEND PYTHONPATH
# ---
python setup.py install --prefix=~/.local
# or
easy_install --prefix=$HOME/.local package_name
# or
pip install --install-option="--prefix=$HOME/.local" package_name
# http://bit.ly/SjzKAU
# http://bit.ly/SjzJNb
# ---
# upgrade a library in /usr/lib without sudo:
pip install --prefix=${HOME} six; export PYTHONPATH=$PYTHONPATH:/home/yourusername/lib/python2.6/site-packages


Print pythonpath:
import os
print sys.path

Extent module search path:
# just for one program
sys.path.append('dir')
# permanently:
export PYTHONPATH=$PYTHONPATH:/my/other/path

Python egg:
# bit.ly/1u4ZizE
Update egg:
python setup.py <whichever_args_are_needed>

Python import .so file:
# for some reason, not found even when in cwd
# solution is in this post: http://bit.ly/1jQHz7l
# bit.ly/1jQKbSS

Python print dict contents to txt file:
json.dump(dict, open('dict.txt','w'))


LaTeX:
italic: \it
bold:   \bf


Video edit from command line:
# ffmpeg deprecated,
avconv 


Gnuplot graph from command line:
# see pipe-classification/models/stats-scripts/gn


Lisp emacs:
# extend emacs load path
(add-to-list 'load-path "~/.emacs.d/lisp/")  ;;' 
# ---
# load elisp file on emacs launch:
(require 'file_rootname)  ;;'
  # rootname: filename without extension
# ---
# automatically open files with .ext extension using the wtv-mode.el file
# (which should be located within reach of load-path) 
(setq auto-mode-alist 
      (append '(("\\.\\(gp\\|gnuplot\\)$" . gnuplot-mode)) auto-mode-alist))  ;;'


Snipping tool:
shutter


