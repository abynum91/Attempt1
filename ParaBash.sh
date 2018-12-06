#!/bin/bash
# Run the scrip. Use the '../' since the script is now a directory above
        ls *.vcf | grep GV > convertcount.txt
        filename='convertcount.txt'

        while read k; do
                java -Xmx1024m -Xms512m -jar /home/apps/PGDSpider/2.1.1.0/PGDSpider2-cli.jar -inputfile $k -inputformat VCF -outputfile $k.arp -outputformat ARLEQUIN -spid ../vcftoarp.spid > spidercheck.pgd
                if grep -q ERROR spidercheck.pgd; then
                        echo Zero Div on $k
                        cp ../zerodiv.arpnull $k.arp
                else
                        echo No PGD issue on $k
                fi

        done < $filename

       ls -v *.arp > countarps.cnt
        filename='countarps.cnt'
        while read j; do
                outname2=$(echo $j | awk -F'[:.\]' '{print $1}')
                python ../appendAsToARP.py -f $j > $outname2.arp
                rm $j
        done < $filename
        ls -v *.arp > countarp.cnt
        filename='countarp.cnt'
        while read u; do
                # I assume that SimcoalSettings1.ars is a file a dir above
                arlecore3522_64bit $u ../SimcoalSettings1.ars
        done < $filename
        bash ../BabiesFirstGrep