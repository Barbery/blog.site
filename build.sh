#!/bin/bash
hugo -t hugo-pacman-theme
mv public /tmp/public
git checkout gh-pages
shopt -s extglob
rm -rf !(CNAME)
mv /tmp/public/* ./
