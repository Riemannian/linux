#!/bin/bash
cd /home/alex/Git/linux
git pull origin master
git add --all
git commit -a -m "auto-commit"
git push origin master
