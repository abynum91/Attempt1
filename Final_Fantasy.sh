#!/bin/bash
#cp 15100GV200.output2 15100GV200.output
#python ../getOUTfromVCF.py -f *.output
ls *.output | grep GV > convertcount.txt
filename='convertcount.txt'
while read outputfile; do

	rm removed_lines.txt
	rm multi_split_list.txt
	rm *.split

	grep -w "1000;MULTIALLELIC" $outputfile | sort -n > multi_line.txt #this looks in the specified file for any lines that are multiallelic and rips it into a separate file. Change "2_1000_neg6_neg65_2.vcf" to whatever file you wish to analyze.

	sed -e '/1000;MULTIALLELIC/d' $outputfile > removed_lines.txt

	awk '{print>$2 ".split"}' multi_line.txt

	ls *.split > multi_split_list.txt

	filename2='multi_split_list.txt'

	while read splitlist;
	do
        	sed 's/=/\t/g; s/;/\t/g' $splitlist  > multi_line_tab.txt

        	awk '{for(i=26;i<=NF;i++){printf "%s ", $i}; printf "\n"}' multi_line_tab.txt > zero_and_ones.txt

        	cat zero_and_ones.txt | awk '{for(i=1;i<=NF;i++) { printf "%-5s",$i } ; printf("\n"); }' | sed 's/=/\t/g; s/;/\t/g; s/|/\t/g' > tab_zero_ones.txt # Adds tabs between each 0 and 1 and removes |. Another step that just makes the data easy to work with

        	awk -F" " '{
                	for( i = 1; i <= NF; i++ ) x[i] += $i
        		}

        	END {
                for( i = 1; i <= NF; i++ ) printf x[i] ""
       		 }' tab_zero_ones.txt | sed 's/.\{1\}/&|/g' | sed 's/|/\n/2;P;D' | awk -vRS="\n" -vORS="\t" '1' | sed 's/2/1/g' > combined_sites.txt

 #this splits the individuals then recombines them. The last part replaces any 2's with 1's since we cant have 2, the individual either has the mutation or not.

#Now we have everything we need but not all together in 1 line.

		sum_col21=$(sed 's/=/\t/g; s/;/\t/g' $splitlist | awk '{printf "%-5s  %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s%-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s\n", $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$30,$31,$32,$33}' | awk '{ sum21+=$21} END {print sum21}')


		first_row=$(sed 's/=/\t/g; s/;/\t/g' $splitlist | awk '{printf "%-5s  %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s%-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s %-5s\n", $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$30,$31,$32,$33}' | head -1)


		echo $first_row | awk '{print $1 "\t" $2,$3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8 "=" $9 ";" $10 "=" $11 ";" $12 "=" $13 ";" $14 "=" $15 ";" $16 "=" $17 ";" $18 "=" $19 ";" $20 "=" '$sum_col21' ";" $22 "=" $23 "\t" "GT"}' > part1.txt #Makes the start of the VCF file and adds the new AC= number.
		cat part1.txt combined_sites.txt | tr '\n' '\t' > combined_total.txt #cats the two files together then cuts off the new line that cat makes.

		grep -n "1000;MULTIALLELIC" $outputfile | cut -d : -f 1 | tr '\n' '\t' > line_numbers.txt

		#sed -e '/1000;MULTIALLELIC/d' 15100GV200.output > removed_lines.txt #removes all multiallelic lines

		cat combined_total.txt >>  removed_lines.txt

		sed -i '$a\' removed_lines.txt

		cat removed_lines.txt > $outputfile

	done < $filename2
done < $filename
