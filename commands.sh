Would be better to have 2 font colours, for code, for title

Which shell am I using:
echo $SHELL


Copy:
# copy multiple files here
 ficp file[wildcards] .       # it's all about the '.'
# ---
# force copy recursively:
cp -rf target destination_directory
# if this doesn't work, then your cp is aliased
# move to another environment (ksh, tcsh) and try again
# hopefully cp won't be aliased everywhere
# ---
# files from local to remote computer via ssh:
scp local/path/filename ad6813@shell4.doc.ic.ac.uk:/remote/path
scp ad6813@shell4.doc.ic.ac.uk:/remote/path/filename local/path
# pipe scp:
# bit.ly/1kzp8ZY
# ---
# preserve symlinks:
rsync -av path/to/olddirectory/ path/to/newdirectory


Bash:
# ---
not a valid identifier
# When you use a variable you write its name without $
# when you use a value of a variable you write $
# ---


Unix commands to explore data:
# bit.ly/1lf45Ow



for dir in train val test; do cd $dir; do mkdir temp; 
for file in *; do ln -s
/data/ad6813/pipe-data/Bluebox/raw_data/dump/$file temp/$file; done;
rm *; mv temp/* . ; rmdir temp; cd ..; done


Create symlink symbolic link:
ln -s <src> <linkname>
# many
for file in *; do ln -s $file ../../temp/$file; done
# hard link
ln <src> <linkname>


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
# https:#help.ubuntu.com/community/find
# looks in all subdirs too:
find $HOME -name "text"
# to separate stdout from stderr (stdout to file):
find -name "text" > temp.txt
# case insensitive:
find -iname "text"
# in list of dirs piped from output of other command:
find $(other_command) -name "filename" > find.out


Remove whitespace in all files:
IFS="\n"
for file in *;
do
    mv "$file" "${file//[[:space:]]}"
done



Locate text within files:
# grep regex:
ls | grep .jpg^ # ending with .jpg
ls | grep ^tonight.txt$ # exactly that fname
# to look in whole filesystem:
DONT PUT * WILDCARDS IN TEXT TO SEARCH!
# because grep looks up substrings by default
# ---
grep "text" /*
# to look here:
grep "text" .
# to look in a specific directory:
grep "text" /path/to/directory/*
# to look in a specific directory and all its subdirectories:
grep -r "text" /path/to/directory/
# to look there except for a directory
grep -r --exclude-dir=dirname "text" path
# test if any strings in file
# strings.txt contains list of them
if grep -Fxq file strings.txt
then
    # ...
else
    # ...
fi


split/cut file content into columns and select k-th column:
cat file | cut -d"<separating pattern>" -f <col_num>,<col_num>,..
# caffe
cat conv1/train_output.log.beg | cut -d" " -f 5,6,7,8,9,10,11,12,13 >> conv1/train_output.log.beg2


Locate multiple words within files:
grep "word1\|word2\|word3" /path/to/files


Delete all files except:
ls | grep -v 'file-to-keep' | xargs rm
# if you forget -v you're fucked!




Git:
# remove branch:
git branch -d branchname
# branch from commit:
git branch branch_name commit_id
# switch from https to ssh:
git remote set-url origin git@github.com:HoldenCaulfieldRye/repo_name.git
# ---
# find out when file deleted:
git log -- [file_path_from_\.git]   # can contain wildcards
git diff-tree --no-commit-id --name-only -r <commit> # exact fname
git checkout commit_id^ -- filename # get it back
# Note! the ^
# ---
# checkout back to head:
git checkout master
# checkout a single file:
git checkout commit_id -- filename
# ---
# git clone no history, only tip of branch
git clone --depth=1 --branch <branch_name> git://github.com/<repo_name>.git
# ---
# git reset 
# ---
# Remove objects too heavy
# bit.ly/1xSIMEG
# git clone downloads entire history of project. bad if someone
# at some point added then deleted a single huge file.
# warning! technique below can be destrcutive to other contributors
# because rewrites entire commit history.
git count-objects -v
# size-pack is the size for your packfiles in KB
# if it's in the MBs, there should be a big stupid file.
git verify-pack -v .git/objects/pack/* | sort -k 3 -n | tail -10
# you will get the biggest blobs (in bytes)
# to find what file is associated with a blob:
git rev-list --objects --all | grep commit_hash_substring
# to find what commits are associated with the file:
git log --pretty=oneline --branches -- <the_file>
# rewrite commits downstream from latest one (lowest on list)
# CAREFUL! maybe one commit downsized that file, maybe you want to
# keep it?
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch <the_file>' -- <commit-hash-beg>^..
# done!
# ---
# degager tout .git et recommencer
# recursive
find -type d -name '.git' -print0 | xargs -0 rm -rf
git init
# ---
# git preserve file permissions
# bit.ly/1nQmDiV
# bit.ly/1nQmE6i
# ---
Undo git stash:
git stash pop
# ---
Merge in favour of remote or local:
git merge --strategy-option theirs
git merge --strategy-option ours
# if already conflicting:
# specific file
git checkout --theirs file
git checkout --ours file
# ---


Diff between two files:
grep -f file1 file2

Diff between two directories:
diff -arq dir1 dir2
# recursive
diff -r dir1 dir2


Common between two files:
comm -12 <(sort file1) <(sort file2)
# ---
# more: bit.ly/1tduUFD


List files:
# by date last modified:
ls -lt
# by file size:
ls -lh   #-h stands for human readable
du -sh *
# matching a certain expression
ls image_[0-9]{.jpg,meta.dat}  # notice no inverted commas!
# except those matching:
ls | grep -v '.txt'

How many files / dirs / symlinks:
# count number of files 
# files or dirs or symlinks
ls -l dir | wc -l
# files only
ls -l dir | grep ^- | wc -l
# dirs only
ls -l dir | grep ^d | wc -l
# symlinks only
ls -l dir | grep ^l | wc -l


Other users on machine:
# see who they are
who
# ---
# chat to message one of them
write user <username>
# then wait, a '>' will appear inviting you to send text


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


Redirecting:
# stderr and stdout to file
command >> filename 2>&1
# append stdout to filename, but stderr is redirected to stdout,
# so both append to filename
# ---
# WARNING! unexpected:
command 2>&1 >> filename
# stdout gets written to file only, not stderr - for some reason
# ---
# redirect sterr to one file, stdout to another
command 2 >> command.err 1 >> command.out
# ---
# bit.ly/1mzYhxb
# there are always 3 files: open, std, stdout
# each file gets a file descriptor: 0,1,2 for open,stdout,stderr
# ---
# redirect stdout to a file:
> filename
>> filename # to append
# ---
# redirect stdout:
1 > filename
1 >> filename # to append
# so same as without the 1?
# ---
# redirect only stderr:
2 > filename
2 >> filename # to append
# ---
# both stdout and stderr 
& > filename
# ---
# redirect stderr to stdout
2>&1


stderr, stdout to file AND print stderr, stdout to console:
do_something 2>&1 | tee -a some_file
# don't care about console, just everything to file:
command >> output.txt 2>&1 
# IF ERROR: WORKS IN BASH, not tcsh
# ---
only stdout:
command > out.txt


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
    

Makefile:
# tutorial: bit.ly/1lWm4Dh
# ---
Modify where to install:
# if configure or b2 script exists
# this will create a makefile suited to
# your computer
./configure --prefix=$HOME/.local --exec-prefix=$HOME/.local
make && make install
#
./b2 --prefix=$HOME/.local --exec-prefix=$HOME/.local
# is b2 for build? so this applied to build scripts too?
# I think build script combines configure and make
# ---
usr/bin/ld: cannot find -l<library>


Filesystem:
#
bin     # binary, machine code, executable files
include # header files, function definitions
lib     # .so (dyn), .a (stat), .pyc bytecode ie function defs
share   # not sure, doesn't seem to be code



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
df -h
# f for filesystem, -h for human readable
# ---
# used in current dir:
du -h
du -sh *
# used in specific dir:
du -s -h path/to/dir  
du -h path/to/dir     # recursive
#---
ncdu
# awesome visual interactive!

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
# from dir
tar -cvf name.tar /path/to/directory
# from files
tar -cvf name.tar /path/to/file1 /path/to/file2 /path/to/file3


Emacs:
# TRAMP
C-x C-f /ssh:username@hostname:
# piped ssh
C-x C-f /ssh:ad6813@shell2.doc.ic.ac.uk|ssh:graphic06.doc.ic.ac.uk:/data/ad6813/caffe/RUN.md
/ssh:ad6813@shell2.doc.ic.ac.uk|ssh:graphic06.doc.ic.ac.uk:/data/ad6813/caffe/src/caffe/layers/softmax_bayesian_loss_layer.cpp
add alias:
alias emacs="emacs23"
#add that to your ~/.cshrc file


List running processes:
ps aux
# all user processes:
ps
# all processes containing substrings:
ps auwxx | grep <substring of top attribute> | grep <other substring of top attribute>
# list in descending order of values of 3rd column
# bit.ly/1mfTqSk
ps aux | sort -k 3 -n # doesn't work, cf bit.ly/1oDt75h


Sort files:
du -s * | sort -n | tail -10


Kill process:
kill <PID>
# ---
# kill all okular processes:
killall -9 okular


Disable screensaver:
gsettings set org.gnome.settings-daemon.plugins.power active false


Screenshot:
shutter


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
nohup #no hang-up
# ---
# execute script with nohup
nohup path/to/script "upload" &

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
# range(coreid) gives you number of physical cores
# range(physical\ id) gives you number of CPUs (a dual core CPU is still 1 CPU)
# bit.ly/1iLLgBk
# bit.ly/1sJiRQT
# ---
# Imperial graphic machines:
# graphic02: 1 quadcore processor
# graphic06: 


Packages:
# check if package installed:
aptitude search '^package_name$'
# where package is:
dpkg -L <package_name>
# locations of all the files installed as part of the package
# ---
# check if package_name exists:
apt-cache search package_name
# no output iif it doesn't
AWESOME:
# search package by keyword
apt-cache search 'keyword'
# eg apt-cache search 'glog'
# ---
# check if installed:
dpkg -s package_name
# ---
# install from command line
sudo dpkg -i package.deb
# manual, backend equivalent of apt-get
# ---
# uninstall/remove:
sudo apt-get remove package_name
# ---
# remove along with config files:
sudo apt-get --purge remove package_name
# ---
# install without sudo:
dpkg -i --force-not-root --root=$HOME package.deb
# better to have --root=$HOME/.local instead?
# alternatively, use schroot - apparently involved: bit.ly/1ksYliJ
# alternatively, like for c++ boost:
./b2 install --prefix=$HOME
# alternatively, like for libgoogle-glog
./configure --prefix=$HOME/.local --exec-prefix=$HOME/.local
make && make install
# ---
i386: NEVER!
# aka x86 aka IA-32
# 32bit vs 64bit edition of ubuntu
# the i386 was a 32bit Intel microprocessor
# binaries that run on it are said to run on
amd64: ALWAYS!
# aka x86_64 aka x64
# paradox: x86 is less bits than x64!
# an extension of the x86 instruction set
# supports longer memory addresses 
# ---
-dbg vs -dev vs -doc 
# bit.ly/1tjAOWt
#
# no suffix but with numbers eg 1.0.0:
# contains version 1.0.0 of the dynamic library
# this is what programs linked against the package/library need to
# run
# version number important in case versions not backward-
# compatible and you have programs running on earlier version
# 
# dev:
# contains the files that you need if you want to compile a
# program that links against the package. There are C header files (*.h), libraries for linking (*.a, *.so), and a few assorted files.
# probably much heavier than compiled lib!
# 
# doc:
# documentation for the package. useful if you want to write a
# program that uses the library.


Install tar.gz tar.bz2 file:
# http://askubuntu.com/questions/25961/how-do-i-install-a-tar-gz-or-tar-bz2-file


Install package from command line:
# cd to directory containing .deb file


Solve unmet dependencies:
#note: last time I had this, I went to .deb file in downloads
#and manually installed it using above.
#General installation issues, 2 useful posts:
http://askubuntu.com/questions/140246/how-do-i-resolve-unmet-dependencies
http://ubuntuforums.org/showthread.php?t=1986644
#this is a specific case, but great to learn from:
http://www.bitsbythepound.com/installing-wink-on-64-bit-ubuntu-210.html


Install .deb file, ie a package:
sudo dpkg -i package_filename


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


Virtual Environment:
# bit.ly/1w0Jz3B
# an isolated working copy of python to work with different library
# versions only for a specific project
# ---
# create venv:
virtualenv path/to/venv
# ---
# (re)enter venv:
source path/to/venv/bin/activate
# ---
# (re)leave venv:
deactivate
# ---
# delete venv:
# delete the venv folder
# ---



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

nvidia htop for gpu:
nvidia-smi
# not able to list proceses for all though, because:
# what is 'not supported' is the ability to see the CUDA process
# name(s) active on the GPU via nvidia-smi, because NVIDIA believes
# that to be a 'professional' feature and restricts it to higher end
# cards that are fully supported by nvidia-smi.
# ---
# hack around it! bit.ly/1nmjmJp


CUDA:
# hello world
# bit.ly/1kpS5E5


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


sed - replace strings in files:
# /g       global replacement
# -i       insert
# s/../../ substitute
# -e       combine multiple commands
# bit.ly/1pNBihh
multiple files:
for file in *; do sed -i 's/clampdet/soilrisk/g' $file; done
# ---
replace within specific line:
# eg at l.12
sed -i file '12s/old/new/'
# ---
replace with value of a variable:
# intuition: concatenate const strings with bash var holding a
# string val.
# concatenation automatically occurs just by placing const string
# and var holding string together
sed -i file 's/old/'$VAR'/'
# ---
replace with multiple lines:
# i.e how to do newline with sed i.e. regex
echo "a,b" | sed -e $'s/,/\\\n/g'
# note 's/,/\\n/g' works as well somehow...
# ---
comment out all couts:
for file in *; do sed -i 's/std::cout/\/\/std::cout/g' $file; done
# ---
append to end of line starting with pattern:
sed -i '/^pattern:/ s/$/ append_text/' file
# 1st part is pattern to find, 2nd part is std sed
# substitution using $ for the end of a line
# ---
delete line containing:
sed -i '/pattern/d' file
# delete lines 5-10, 12
sed -i -e '5,10d;12d' file


Regex:
# wildcards are different to those in bash
# http://www.grymoire.com/unix/Regular.html
$ #: end with
^ #: start with
\ #: cancel wildcard effect of next char


bash calculator:
echo "32*12" | bc
result=$(echo "32*12" | bc)
# float
bc -l 
# floating point comparison
if [ $(echo " $VAR < 4.3" | bc) -eq 1 ]; then echo yes; fi


Launch utorrent:
#http://askubuntu.com/questions/104094/how-to-install-utorrent-step-by-step


LaTeX:
Install latex package:
#Note! you just need package.sty to be present in directory of latex file
#for it to load when opening the latex file.
#otherwise:
#go to http://www.ctan.org/search
#enter package search query
#follow rest of instructions at
#http://www.inf.ed.ac.uk/systems/tex/new-packages.html
#under 'installing a package yourself'
# ---
Compile latex into pdf:
pdflatex file.tex
#if error appears, you can hit enter to skip it
# ---
Comment block:
Ctrl-T
# ---
Uncomment block:
Ctrl-U
# ---
LaTeX prezi:
# ---
graphics:
# bit.ly/VWdwq1
# ---


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


open folder GUI:
nautilus <path>


Python:
# ---
!= vs is not:
# a is not b     in c++ corresponds to    &a !- &b
# a != b         in c++ corresponds to    a  !=  b
# a <> b         in c++ corresponds to    a  !=  b

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
# bit.ly/SjzKAU
# bit.ly/SjzJNb
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

egg:
# bit.ly/1u4ZizE
Update egg:
python setup.py <whichever_args_are_needed>

import .so file:
# for some reason, not found even when in cwd
# solution is in this post: http://bit.ly/1jQHz7l
# bit.ly/1jQKbSS

print dict contents to txt file:
json.dump(dict, open('dict.txt','w'))
# to load:
json.load(open('dict.txt','r')) # but unicode string issue
# ---
# dumps is more compact
json.dumps(dict, open('dict.txt','w'))
# requires loads
json.loads(open('dict.txt','r')) # but unicode string issue
# ---
# better for string stuff, yaml:
yaml.dump(dict, open('dict.txt','w'))
# to load:
yaml.load(open('dict.txt','r'))
# ---


pretty print list:
print '%s' % ', '.join(map(str, mylist))

arg min arg max:
# indices of max values along given axis
# by default, flatten array
a = np.array(...) 
np.argmax(a, axis=..)

numpy array multiple types:
# use 'object' type for strings otherwise fixed length strings will
# be used as dtype
a = np.array(array, dtype=[('x',object),('y',int)])
# bit.ly/1oi23N4


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


Cron:
# automatically run script every few minutes
# bit.ly/1pDhXkW
# bit.ly/1yBS9tM
# Have cron run a script no matter what, and then have the script decide
# if the program is running and start it if necessary
# ---
what is it:
# a daemon that executes shell commands periodically. Cron is
# configured by a file called a crontab.
# ---
select a crontab to activate:
crontab -u <user> <crontab_file>
# ---
which crontab active:
crontab -l
# ---
your serious tweak:
# you have created /etc/cron.allow with 'alex' inside 
# bit.ly/1pDhXkW


Caffe:
# cf packages.sh
# ---
# class imbalance ratio from data_info:
for model in *;
do
    cd $model;
    numer=$(cat train.txt | grep '0$' | wc -l);
    denom=$(cat train.txt | wc -l);
    thresh=$(echo "scale=2; $numer/$denom" | bc);
    if [ $(echo " $thresh < 0.5" | bc) -eq 1 ];
    then
	echo "0$thresh threshold" >> read.txt
	echo "0 flag_val" >> read.txt
    else
	thresh=$(echo "1 - $thresh" | bc)
	echo "0$thresh threshold" >> read.txt
	echo "1 flag_val" >> read.txt
    fi;
    cd ..;
done





