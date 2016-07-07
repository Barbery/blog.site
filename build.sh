hugo -t hugo-pacman-theme
mv public /tmp/public
git checkout gh-pages
rm -rf !(CNAME)
mv /tmp/public/* ./
