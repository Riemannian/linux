
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
# ---


Git remove branch:
git branch -d branchname


Git switch from https to ssh:
git remote set-url origin git@github.com:HoldenCaulfieldRye/repo_name.git


Test if ssh working:
ssh -T git@github.com


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
grep "text" /*
# to look in a specific directory:
grep "text" /path/to/directory/*
# to look in a specific directory and all its subdirectories:
grep "text" -r /path/to/directory/
# notice no wildcard is needed in this case

Locate multiple words within files:
grep "word1\|word2\|word3" /path/to/files


List files:
# by date last modified:
ls -lt
# by file size (or image pixel size):
ls -lh   #-h stands for human readable
# matching a certain expression
ls image_[0-9]{.jpg,meta.dat}  # notice no inverted commas!


What shell am I using:
echo $SHELL


Redirect stderr, stdout to file AND print stderr, stdout to console:
do_something 2>&1 | tee -a some_file


Environment variables:
#what is PATH set to:
echo "$PATH"
#modify path:
#bash:
export PATH=$PATH:/path/to/dir1:/path/to/dir2


How much size space on disk:
df -h                #-h is for human readable form
du -s -h path/to/dir #how much space does dir take
du -h path/to/dir    #recursive



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


Keep process running:
# http://askubuntu.com/questions/8653/how-to-keep-processes-running-after-ending-ssh-session


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
lsb_release -cs
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
#you have a dual core hyperthreading processor 
#http://www.makeuseof.com/tag/hyperthreading-technology-explained/
#http://www.richweb.com/cpu_info


Check whether a package is installed:
dpkg -s package_name

Uninstall/remove package:
sudo apt-get remove package_name
#remove package and all configuration files:
sudo apt-get --purge remove package_name


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


Install any python library:
#inside the uncompressed directory for the lib, enter:
sudo python setup.py install


What does apt stand for:
advanced packaging tool


What does ppa stand for:
#personal package archive


view processor activity:
top
htop #looks nicer/cooler, with graphical CPU usage for each core


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


