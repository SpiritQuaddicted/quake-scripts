 #!/usr/bin/env bash
 # Recursively crawl through the current directory print all files and
 # subdirectories nicely with filename, size, md5sum.
 # This outputs in table format for mediawiki.
 # Written by Spirit for quakewiki.org, 03-2013
 # Do whatever you want with this, consider it public domain.
 
 shopt -s globstar # to make it recursively dive into all directories
 
 echo "<tt>" # force monospace
 # mediawiki table header
 echo '{| class="wikitable"'
 echo '|-'
 echo '! Path !! Size !! md5'
 echo '|-'
 
 for file in **/*
 do
 	# Whatever you do, don't forget to quote the filename, ie "${file}".
 	#echo "now: " "${file}"
 	ls_string=$(ls --color=no -gG --time-style=long-iso "${file}")
 	file_size=$(echo ${ls_string} | awk '{print $3}')
 	file_time=$(echo ${ls_string} | awk '{print $4 " " $5}')
 	file_md5sum=$(md5sum "${file}" 2>/dev/null | awk '{print $1}')
 	if [[  -z ${file_md5sum} ]] #if "the string is empty"
 	then
 		# Current file is a directory, just print the tree (or nothing at all)
 		# echo ${file}/
 		true # you must have something in this then block :-)
 	else
 		# Current file is a valid file, print all its details
 		#echo "${file}" ${file_size} ${file_time} ${file_md5sum}
 		echo "| ${file}  ||style="text-align:right"|  ${file_size} || ${file_md5sum}"
 		echo '|-'
 	fi
 done
 
 # mediawiki table footer
 echo '|}'
 echo "</tt>"