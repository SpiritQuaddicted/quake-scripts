#!/bin/sh
# makes overview montages of any wad files inside zip files in CWD

for i in *.zip; do unzip  "$i" -d "$i"_dir ; done
rm -i *.zip
rename .zip_dir .zip *.zip_dir

for i in *
do
	echo ${i}
	cd ${i}

	#lowercase filenames, from http://unstableme.blogspot.com/2008/03/renaming-files-lowercase-to-uppercase.html
	ls | while read file
	do
		mv $file `echo $file | sed 's/.*/\L&/'`
	done

	for w in *.wad
	do
		wad -x --nomip ${w} && rename + _+ *.pcx && montage -geometry 64x64\>+1+1 -tile 12 -background black -title "${w}" -fill white *.pcx ${i}_${w}.png
		convert -quality 90 ${i}_${w}.png ${i}_${w}.jpg && rm *.pcx && rm *.png
	done
	cd ..
done