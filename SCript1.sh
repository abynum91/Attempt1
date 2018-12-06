#!/bin/bash
#SBATCH -J neg5_10k_SK
#SBATCH -N 1
#SBATCH -t 96:00:00
#SBATCH -p normal
#Run this once you have output files.
#SBATCH --mail-type=ALL
#SBATCH --mail-user=abynum2@islander.tamucc.edu
module load bio-misc
module load arlequin
module load pgdspider
module load parallel
date
ls *.output > output.lst
parallel  "mkdir Cele_{}" ::: {1..1000}
ls -d Cele_* > dir.lst
parallel --link "mv {} {}" :::: output.lst :::: dir.lst
parallel "cp working_copy.sh {}" :::: dir.lst
parallel "cp ParaBash.sh {}" :::: dir.lst
parallel "cd {} && bash working_copy.sh" :::: dir.lst
parallel "cd {} && bash ParaBash.sh" :::: dir.lst
parallel "cat ./Cele_{}/output.txt >> Final_Output.txt" ::: {1..1000}
date
