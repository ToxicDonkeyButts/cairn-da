#!/bin/bash
# This creates a compiled PDF of all the monster stat blocks in both A4 and Letter formats (including booklets)
date="$(date "+%B %e, %Y")"
cd /tmp
rsync -av /home/yochai/github/cairn/resources/monsters/ /tmp/monsters/
sed -i '/^author/d' /tmp/monsters/*.md
sed -i '/^source:/d' /tmp/monsters/*.md
sed -i '1 { /^---/ { :a N; /\n---/! ba; d} }' /tmp/monsters/*.md
pandoc --variable papersize=Letter --variable title="Cairn Monsters" --variable subtitle="Compiled on " --variable subtitle="$date" --variable subtitle=" by Yochai Gal | CC-BY-SA 4.0" --variable mainfont=Alegreya --variable sansfont=Alegreya --variable monofont=Alegreya -f gfm --toc -s /tmp/monsters/*.md -o "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-letter.pdf"
pandoc --variable papersize=A4 --variable title="Cairn Monsters" --variable subtitle="Compiled on " --variable subtitle="$date" --variable subtitle=" by Yochai Gal | CC-BY-SA 4.0" --variable mainfont=Alegreya --variable sansfont=Alegreya --variable monofont=Alegreya -f gfm --toc -s /tmp/monsters/*.md -o "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-a4.pdf"
cd "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/"
pdfbook2 -p=letter -s "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-letter.pdf" "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-letter-book.pdf"
pdfbook2 -p=a4 -s "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-a4.pdf"
rm -rf /tmp/monsters
