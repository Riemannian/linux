Locate file:
locate file_name_substring
notice you need no wild cards, no inverted commas to locate file
containing substring.
to locate file with exactly file_name as filename:
locate 'file_name'
to locate file ending with file_name_end:
locate '*file_name_end'
to locate file starting with file_name_neg:
locate 'file_name_beg*'
 

Locate file with find:
find -name "text"
to separate stdout from stderr (stdout to file):
find -name "text" > temp.txt



Locate text within files:
to look in whole filesystem:
grep "text" /*
to look in a specific directory:
grep "text" /path/to/directory/*
to look in a specific directory and all its subdirectories:
grep "text" -r /path/to/directory/
notice no wildcard is needed in this case


Extract archives:
to unpack tar.gz aka .tgz:
tar zxvf archive_name.tgz
to unpack tar.gz and place files in another folder:
tar zxvf archive_name.tgz -C /path/to/directory

Unzip:


What is my distro:
lsb_release -cs
trusty


PPA installation:
sudo add-apt ppa:name_of_ppa
sudo apt-get update
sudo apt-get install program_name
ppa means personal package archive


Uninstall:
sudo apt-get --purge remove program_name


Clean space:
sudo apt-get autoremove


Okular:
okular file_name


Navigate on vim:


What's my version of scrapy:
scrapy version -v


How much RAM am I using:
free -m


Check if a library is installed
locate library_name
or, for more info
dpkg -s library_name


Using lynx browser:

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


