#!/bin/bash

# Purpose: Ruby filename to be minified and obfuscated. Outputs are automatically
# generated in an ./outputs subdirectory. See README.md for instructions.

# Usage Examples:
#   sh ./main.sh
#   
# IMPORTANT NOTE: Must be run from within the 'minify_and_obfuscate_ruby' directory

# TODO - Add user prompt

# declare and instantiate variables
MINLEN=0 # optionally exclude iteration of blank lines when MINLENGTH is 1
input_file="./source.rb"
reverse=""
output_file="./outputs/output_minified_and_obfuscated.rb"
output_file_recovered="./outputs/output_unminified_and_unobfuscated.rb"

# obfuscate: by reversing each line
function obfuscate {
	for (( i=$len-1; i>=0; i-- )); do
		reverse="$reverse${line:$i:1}"
	done
	reverse+="\n"
}

# minify: find instances of the tuple keys in the variable containing the
# reversed input file string and replace with respective tuple values
function minify {
	find_data='eriuqer;*r* fed;*d* dne;*e* edulcni;*i* ssalc;*c* redaer_rtta;*ar*'; 
	for tuple in $find_data; do
		key=$(echo $tuple | cut -d ';' -f 1); 
		value=$(echo $tuple | cut -d ';' -f 2); 
		# echo "tuple: '$tuple', key : '$key', value : '$value'";
		reverse=${reverse/$key/$value} 
	done
}

function unobfuscate {
	obfuscate # reverse back
}

# TODO - Refactor as is same as 'minify' function except $value and $key swapped in assignment to reverse
function unminify {
	find_data='eriuqer;*r* fed;*d* dne;*e* edulcni;*i* ssalc;*c* redaer_rtta;*ar*'; 
	for tuple in $find_data; do
		key=$(echo $tuple | cut -d ';' -f 1); 
		value=$(echo $tuple | cut -d ';' -f 2); 
		# echo "tuple: '$tuple', key : '$key', value : '$value'";
		reverse=${reverse/$value/$key} 
	done
}

function recover_source {
	# read lines from output file
	while IFS= read -r line || [ -n "$line" ]; do
		len=${#line}
		if [ "$len" -ge "$MINLEN" ]; then
			unminify
			unobfuscate
			# printf '%s\n' "$line"
		fi
	done < "$output_file"

  echo "$output_file not found. Creating $output_file and adding minified and obfuscated contents"
  ! [[ -d "outputs" ]] && mkdir outputs
  touch $output_file
  echo $reverse >> $output_file_recovered
}

# notes:
# 	-r option passed to read command prevents backslash escapes being interpreted
# 	IFS= option before read command prevents leading/trailing whitespace being trimmed
# 	[ -n "$line" ] is to allow script to read last line. See http://stackoverflow.com/questions/12916352/shell-script-read-missing-last-line
function process_source {

	# read lines from input file
	while IFS= read -r line || [ -n "$line" ]; do
		len=${#line}
		if [ "$len" -ge "$MINLEN" ]; then
			obfuscate
			minify
			# printf '%s\n' "$line"
		fi
	done < "$input_file"

  echo "$output_file not found. Creating $output_file and adding minified and obfuscated contents"
  ! [[ -d "outputs" ]] && mkdir outputs
  touch $output_file
  echo $reverse >> $output_file
}

# check if output Ruby file already exists and if so regenerate source, otherwise create it
if [ -f "$output_file" ] && ! [ -f "$output_file_recovered" ]; then
  echo "$output_file already exists."
  recover_source
  exit 0
elif [ -f "$input_file" ] && ! [ -f "$output_file_recovered" ]; then
	process_source
	exit 0
else
	# IMPORTANT NOTE: Calling shell script from `ruby main.rb` 
	# prevents echo's from showing up in Bash. They only appear when run with
	# `sh main.rb`. Hence user cannot see any prompts.

	echo "$output_file and $output_file_recovered have both already been generated."

	# echo -n "Do you want to delete these outputs and start again? (y/n)"
	# STATUS=""
	# read STATUS
	# if [ "$STATUS" = "y" ] || [ "$STATUS" = "Y" ]; then
	  echo "Deleted temporary files and restarting process..."
		[ -f "$output_file" ] && rm -f "$output_file"
		[ -f "$output_file_recovered" ] && rm -f "$output_file_recovered"
		[ -d "outputs" ] && rmdir outputs
	  exit 0
	# else
	# 	exit 1
	# fi
fi
