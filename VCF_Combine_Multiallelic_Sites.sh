#!bin/bash

#This script looks in VCF files for MULTIALLELIC sites are combines them. 
#DO NOT use this script if  generation of origin matters to you, as we pick one and stick with it.
#This script was originally made to fix VCF files made from SLiM, which pastes multiple VCF files into one but we have a python script that rips them apart.
#This script creates a couple of *.txt files, these act as bookmarks so you can see where bugs are occuring (also because I am not good enough at sed/awk/Linux to have everything pipe into the next command).
#BACKUP ALL INPUT FILES: this script overwrites the original file. If you run this script multiple times on the same file it will either fail or constantly delete the same lines, causing a shrinking file.

#cp 2_1000_neg6_neg65_2.output 2_1000_neg6_neg65_2.vcf #Run this line if you want to play with the code. Just makes a copy with no overwriting of the original file. If you just keep running the code you will get a bunch of lines being deleted due to the last few lines.

grep -w "1000;MULTIALLELIC" 2_1000_neg6_neg65_2.vcf > multi_line.txt #this looks in the specified file for any lines that are multiallelic and rips it into a separate file. Change "2_1000_neg6_neg65_2.vcf" to whatever file you wish to analyze.

sed 's/=/\t/g; s/;/\t/g' multi_line.txt  > multi_line_tab.txt #Replaces all potential delimiters with tabs. Just makes it easier to work with. 


awk '{for(i=26;i<=NF;i++){printf "%s ", $i}; printf "\n"}' multi_line_tab.txt > zero_and_ones.txt #Separates all the individuals (0's and 1's) into a separate file, once again a quality of life step.

#awk '{ sum21+=$21} END {print sum21}' multi_line_tab.txt > AC_sum.txt #Adds together the allele counts for each site (the reason we are here). Change the $21 to whichever column you are trying to add. This SHOULDNT need to change but now you know how if you need it. Line isnt needed but a good checkpoint


cat zero_and_ones.txt | awk '{for(i=1;i<=NF;i++) { printf "%-5s",$i } ; printf("\n"); }' | sed 's/=/\t/g; s/;/\t/g; s/|/\t/g' > tab_zero_ones.txt # Adds tabs between each 0 and 1 and removes |. Another step that just makes the data easy to work with


awk -F" " '{
    for( i = 1; i <= NF; i++ ) x[i] += $i
  }

  END {
    for( i = 1; i <= NF; i++ ) printf x[i] ""
  }' tab_zero_ones.txt | sed 's/.\{1\}/&|/g' | sed 's/|/\n/2;P;D' | awk -vRS="\n" -vORS="\t" '1' | sed 's/2/1/g' > combined_sites.txt
 #this splits the individuals then recombines them. The last part replaces any 2's with 1's since we cant have 2, the individual either has the mutation or not.

#Now we have everything we need but not all together in 1 line.

sum_col21=$(sed 's/=/\t/g; s/;/\t/g' multi_line.txt| awk '{printf "%-5s  %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s%-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s\n", $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$30,$31,$32,$33}' | awk '{ sum21+=$21} END {print sum21}')


first_row=$(sed 's/=/\t/g; s/;/\t/g' multi_line.txt| awk '{printf "%-5s  %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s%-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s\n", $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$30,$31,$32,$33}' | head -1)


echo $first_row | awk '{print $1,"\t",$2,"\t",$3,"\t",$4,"\t",$5,"\t",$6,"\t",$7,"\t",$8"="$9";"$10"="$11";"$12"="$13";"$14"="$15";"$16"="$17";"$18"="$19";"$20,"=",$21='$sum_col21'";"$22"="$23,"\t","GT"}' > part1.txt #Makes the start of the VCF file and adds the new AC= number.
cat part1.txt combined_sites.txt | tr '\n' '\t' > combined_total.txt #cats the two files together then cuts off the new line that cat makes. 

#Now we insert the combined line into the original document.

grep -n "1000;MULTIALLELIC" 2_1000_neg6_neg65_2.vcf | cut -d : -f 1 | tr '\n' '\t' > line_numbers.txt #gets the line numbers we need to  replace.


file1=2_1000_neg6_neg65_2.vcf #set variables 
file2=combined_total.txt
line_numbers=line_numbers.txt
replacement=$(awk '{print $2}' $line_numbers) #what line we want to replace. It really doesnt matter which one we replace since we just remove the other one.
echo $replacement
echo $line_numbers #last two lines are just to double check yourself
sed -e "$replacement"' { r '"$file2"$'\n''d; }' "$file1" > almost_there.txt #checkpoint, just need to delete the extra line.
file3=almost_there.txt
removal=$(awk '{print $1 "d"}' $line_numbers)
echo $removal
sed -e "$removal" $file3 > $file1 #this overwrites the original file. Change $file1 to anything else if you dont want to overwrite.
