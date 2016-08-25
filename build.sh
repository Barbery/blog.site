#!/bin/bash
git add *
git commit -m "release article"
git push
hugo -t hugo-pacman-theme
sudo rm -rf /tmp/public
sudo mv public /tmp/public
git checkout gh-pages
shopt -s extglob
rm -rf !(CNAME)
sudo mv /tmp/public/* ./

git add *
git commit -m "publish"
git push