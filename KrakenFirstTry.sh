#!/bin/sh -v
# Script created for taxonomic classification via Kraken 2 (due to problems on the lg.bio.br server, in accessing rsync from NCBI, saccharum and PC were also used)
# Lucas Vieira 11/04/2021
# Databases dowload in 12/04/2021


# Building a Database
~/Downloads/kraken2-master/kraken2-build --special silva --threads 10 --db SilvaDB
~/Downloads/kraken2-master/kraken2-build --special greengenes --threads 10 --db GreengenesDB
~/Downloads/kraken2-master/kraken2-build --special rdp --threads 10 --db RDP_DB

## NCBI
~/Downloads/kraken2-master/kraken2-build --download-library bacteria --threads 10 --db NCBIbacteria
--download-library fungi --threads 10 --db NCBIfungi
../kraken2-master/kraken2-build --build --db NCBIfungi
../kraken2-master/kraken2-build --download-library archaea --threads 10 --db Standart

## LGBio
/home/lucasvieira/Kraken2/kraken2-build --standard --use-ftp --threads 15 --db Standart

~/Downloads/kraken2-master/kraken2 --db KrakenDB --paired SP10_forward_paired.fq SP10_reverse_paired.fq


# 37884974 sequences (10609.63 Mbp) processed in 765.730s (2968.5 Kseq/m, 831.33 Mbp/m).
# 22327 sequences classified (0.06%)
# 37862647 sequences unclassified (99.94%)


~/Downloads/kraken2-master/kraken2 --paired --classified-out cseqs#.fq SP10_forward_paired.fq SP10_reverse_paired.fq

# Kraken 2 Fungi (NCBI)
/home/lucasvieira/Kraken2/kraken2 --db /media/hd4/lucasvieira/Databases/FungiDB --threads 15 --paired --gzip-compressed SP10_forward_paired.fq.gz SP10_reverse_paired.fq.gz --output SP10_FungiNCBI_K2.txt --use-names --report ReportSP10_FungiNCBI_K2.txt

# Results:
SP10 - 20383 sequences classified (0.07%)
SP12 - 24369 sequences classified (0.06%)
SP13 - 17612 sequences classified (0.06%)
SP14 - 18070 sequences classified (0.06%)
SP15 - 24397 sequences classified (0.08%)
SP16 - 22704 sequences classified (0.07%)
SP17 - 16586 sequences classified (0.06%)
SP18 - 20983 sequences classified (0.07%)
SP19 - 22805 sequences classified (0.08%)
SP02 - 17093 sequences classified (0.06%)
SP20 - 17241 sequences classified (0.06%)
SP21 - 22365 sequences classified (0.07%)
SP22 - 20428 sequences classified (0.08%)
SP23 - 17792 sequences classified (0.07%)
SP24 - 18071 sequences classified (0.07%)
SP25 - 24757 sequences classified (0.09%)
SP26 - 19334 sequences classified (0.07%)
SP27 - 23622 sequences classified (0.08%)
SP28 - 24138 sequences classified (0.07%)
SP29 - 20100 sequences classified (0.07%)
SP03 - 29096 sequences classified (0.09%)
SP30 - 20984 sequences classified (0.07%)
SP31 - 30236 sequences classified (0.10%)
SP32 - 23709 sequences classified (0.09%)
SP33 - 24806 sequences classified (0.07%)
SP34 - 18640 sequences classified (0.07%)
SP04 - 19781 sequences classified (0.07%)
SP05 - 22618 sequences classified (0.07%)
SP06 - 29948 sequences classified (0.09%)
SP07 - 26140 sequences classified (0.08%)
SP08 - 19683 sequences classified (0.07%)
SP09 - 16224 sequences classified (0.07%)

# Kraken 2 Bacteria (NCBI)
/home/lucasvieira/Kraken2/kraken2 --db /media/hd4/lucasvieira/Databases/BacteriaDB --threads 15 --paired --gzip-compressed SP10_forward_paired.fq.gz SP10_reverse_paired.fq.gz --output SP10_BacteriaNCBI_K2.txt --use-names --report ReportSP10_BacteriaNCBI_K2.txt

# Results
SP10 - 7014209 sequences classified (23.52%)
SP12 - 8859682 sequences classified (23.39%)
SP13 - 6501544 sequences classified (22.58%)
SP14 - 6128858 sequences classified (20.92%)
SP15 - 7876942 sequences classified (25.15%)
SP16 - 7250593 sequences classified (23.34%)
SP17 - 5852990 sequences classified (22.91%)
SP18 - 7907539 sequences classified (25.98%)
SP19 - 7054405 sequences classified (24.28%)
SP02 - 5744002 sequences classified (20.97%)
SP20 - 5950078 sequences classified (22.07%)
SP21 - 7759323 sequences classified (23.91%)
SP22 - 6050618 sequences classified (22.93%)
SP23 - 5802447 sequences classified (21.44%)
SP24 - 5903014 sequences classified (22.65%)
SP25 - 7054605 sequences classified (25.02%)
SP26 - 6001721 sequences classified (20.19%)
SP27 - 7794943 sequences classified (25.04%)
SP28 - 7438952 sequences classified (22.84%)
SP29 - 7059445 sequences classified (23.93%)
SP03 - 8166913 sequences classified (25.77%)
SP30 - 6388376 sequences classified (22.68%)
SP31 - 7936291 sequences classified (27.30%)
SP32 - 6514176 sequences classified (25.72%)
SP33 - 9351161 sequences classified (26.95%)
SP34 - 6061647 sequences classified (23.77%)
SP04 - 7000126 sequences classified (24.73%)
SP05 - 7051962 sequences classified (22.66%)
SP06 - 9768620 sequences classified (29.32%)
SP07 - 8818101 sequences classified (25.50%)
SP08 - 6397171 sequences classified (21.64%)
SP09 - 5106525 sequences classified (21.17%)

# Kraken 2 Plant (NCBI)
/home/lucasvieira/Kraken2/kraken2 --db /media/hd4/lucasvieira/Databases/PlantDB --threads 15 --paired --gzip-compressed SP10_forward_paired.fq.gz SP10_reverse_paired.fq.gz --output SP10_PlantNCBI_K2.txt --use-names --report ReportSP10_PlantNCBI_K2.txt

# Results
SP10 - 134454 sequences classified (0.45%)
SP12 - 168040 sequences classified (0.44%)
SP13 - 120338 sequences classified (0.42%)
SP14 - 121963 sequences classified (0.42%)
SP15 - 153140 sequences classified (0.49%)
SP16 - 144811 sequences classified (0.47%)
SP17 - 110878 sequences classified (0.43%)
SP18 - 133231 sequences classified (0.44%)
SP19 - 139577 sequences classified (0.48%)
SP02 - 113175 sequences classified (0.41%)
SP20 - 120734 sequences classified (0.45%)
SP21 - 149402 sequences classified (0.46%)
SP22 - 126375 sequences classified (0.48%)
SP23 - 119317 sequences classified (0.44%)
SP24 - 114429 sequences classified (0.44%)
SP25 - 141875 sequences classified (0.50%)
SP26 - 124311 sequences classified (0.42%)
SP27 - 149060 sequences classified (0.48%)
SP28 - 148629 sequences classified (0.46%)
SP29 - 134899 sequences classified (0.46%)
SP03 - 193172 sequences classified (0.61%)
SP30 - 136816 sequences classified (0.49%)
SP31 - 175080 sequences classified (0.60%)
SP32 - 143994 sequences classified (0.57%)
SP33 - 164380 sequences classified (0.47%)
SP34 - 119734 sequences classified (0.47%)
SP04 - 130139 sequences classified (0.46%)
SP05 - 139244 sequences classified (0.45%)
SP06 - 163516 sequences classified (0.49%)
SP07 - 173323 sequences classified (0.50%)
SP08 - 127395 sequences classified (0.43%)
SP09 - 105172 sequences classified (0.44%)

# Kraken 2 GreenGenes
/home/lucasvieira/Kraken2/kraken2 --db /media/hd4/lucasvieira/Databases/GreengenesDB --threads 15 --paired --gzip-compressed SP10_forward_paired.fq.gz SP10_reverse_paired.fq.gz --output SP10_GDB_K2.txt --use-names --report ReportSP10_GDB_K2.txt

# Results
SP10 - 8321 sequences classified (0.03%)
SP12 - 11319 sequences classified (0.03%)
SP13 - 8107 sequences classified (0.03%)
SP14 - 7917 sequences classified (0.03%)
SP15 - 10090 sequences classified (0.03%)
SP16 - 9116 sequences classified (0.03%)
SP17 - 6918 sequences classified (0.03%)
SP18 - 9582 sequences classified (0.03%)
SP19 - 8602 sequences classified (0.03%)
SP02 - 7124 sequences classified (0.03%)
SP20 - 6862 sequences classified (0.03%)
SP21 - 9102 sequences classified (0.03%)
SP22 - 8257 sequences classified (0.03%)
SP23 - 7247 sequences classified (0.03%)
SP24 - 7074 sequences classified (0.03%)
SP25 - 8159 sequences classified (0.03%)
SP26 - 7643 sequences classified (0.03%)
SP27 - 9946 sequences classified (0.03%)
SP28 - 9305 sequences classified (0.03%)
SP29 - 9064 sequences classified (0.03%)
SP03 - 10044 sequences classified (0.03%)
SP30 - 7975 sequences classified (0.03%)
SP31 - 10306 sequences classified (0.04%)
SP32 - 10328 sequences classified (0.04%)
SP33 - 9891 sequences classified (0.03%)
SP34 - 6931 sequences classified (0.03%)
SP04 - 8513 sequences classified (0.03%)
SP05 - 8268 sequences classified (0.03%)
SP06 - 10984 sequences classified (0.03%)
SP07 - 11005 sequences classified (0.03%)
SP08 - 8349 sequences classified (0.03%)
SP09 - 6344 sequences classified (0.03%)

# Kraken 2 RDP
/home/lucasvieira/Kraken2/kraken2 --db /media/hd4/lucasvieira/Databases/RDP_DB --threads 15 --paired --gzip-compressed SP10_forward_paired.fq.gz SP10_reverse_paired.fq.gz --output SP10_RDB_K2.txt --use-names --report ReportSP10_RDB_K2.txt

# Results
SP10 - 12686 sequences classified (0.04%)
SP12 - 17316 sequences classified (0.05%)
SP13 - 12399 sequences classified (0.04%)
SP14 - 12117 sequences classified (0.04%)
SP15 - 15877 sequences classified (0.05%)
SP16 - 14187 sequences classified (0.05%)
SP17 - 10495 sequences classified (0.04%)
SP18 - 14536 sequences classified (0.05%)
SP19 - 13052 sequences classified (0.04%)
SP02 - 10823 sequences classified (0.04%)
SP20 - 10398 sequences classified (0.04%)
SP21 - 13980 sequences classified (0.04%)
SP22 - 12607 sequences classified (0.05%)
SP23 - 10854 sequences classified (0.04%)
SP24 - 10948 sequences classified (0.04%)
SP25 - 12741 sequences classified (0.05%)
SP26 - 12023 sequences classified (0.04%)
SP27 - 15644 sequences classified (0.05%)
SP28 - 14453 sequences classified (0.04%)
SP29 - 13531 sequences classified (0.05%)
SP03 - 15751 sequences classified (0.05%)
SP30 - 11991 sequences classified (0.04%)
SP31 - 15728 sequences classified (0.05%)
SP32 - 15604 sequences classified (0.06%)
SP33 - 15388 sequences classified (0.04%)
SP34 - 10778 sequences classified (0.04%)
SP04 - 13167 sequences classified (0.05%)
SP05 - 12914 sequences classified (0.04%)
SP06 - 17118 sequences classified (0.05%)
SP07 - 17041 sequences classified (0.05%)
SP08 - 12685 sequences classified (0.04%)
SP09 - 9778 sequences classified (0.04%)

# Kraken 2 Silva Database
/home/lucasvieira/Kraken2/kraken2 --db /media/hd4/lucasvieira/Databases/SilvaDB --threads 15 --paired --gzip-compressed SP10_forward_paired.fq.gz SP10_reverse_paired.fq.gz --output SP10_SDB_K2.txt --use-names --report ReportSP10_SDB_K2.txt

# Results
SP10 - 17601 sequences classified (0.06%)
SP12 - 22327 sequences classified (0.06%)
SP13 - 16390 sequences classified (0.06%)
SP14 - 17338 sequences classified (0.06%)
SP15 - 21979 sequences classified (0.07%)
SP16 - 18780 sequences classified (0.06%)
SP17 - 14229 sequences classified (0.06%)
SP18 - 19121 sequences classified (0.06%)
SP19 - 17699 sequences classified (0.06%)
SP02 - 15092 sequences classified (0.06%)
SP20 - 14548 sequences classified (0.05%)
SP21 - 19035 sequences classified (0.06%)
SP22 - 16852 sequences classified (0.06%)
SP23 - 14985 sequences classified (0.06%)
SP24 - 14751 sequences classified (0.06%)
SP25 - 18060 sequences classified (0.06%)
SP26 - 16750 sequences classified (0.06%)
SP27 - 20159 sequences classified (0.06%)
SP28 - 20475 sequences classified (0.06%)
SP29 - 17990 sequences classified (0.06%)
SP03 - 22397 sequences classified (0.07%)
SP30 - 16792 sequences classified (0.06%)
SP31 - 21897 sequences classified (0.08%)
SP32 - 21173 sequences classified (0.08%)
SP33 - 20071 sequences classified (0.06%)
SP34 - 15334 sequences classified (0.06%)
SP04 - 17674 sequences classified (0.06%)
SP05 - 17670 sequences classified (0.06%)
SP06 - 22700 sequences classified (0.07%)
SP07 - 22811 sequences classified (0.07%)
SP08 - 16981 sequences classified (0.06%)
SP09 - 13567 sequences classified (0.06%)

# Total number of sequences
SP10 - 29824573 sequences
SP12 - 37884974 sequences
SP13 - 28794811 sequences
SP14 - 29293346 sequences
SP15 - 31316179 sequences
SP16 - 31060055 sequences
SP17 - 25552107 sequences
SP18 - 30434455 sequences
SP19 - 29051756 sequences
SP02 - 27390931 sequences
SP20 - 26957468 sequences
SP21 - 32457092 sequences
SP22 - 26390097 sequences
SP23 - 27060238 sequences
SP24 - 26058228 sequences
SP25 - 28191333 sequences
SP26 - 29726468 sequences
SP27 - 31129127 sequences
SP28 - 32574534 sequences
SP29 - 29500161 sequences
SP03 - 31691883 sequences
SP30 - 28168705 sequences
SP31 - 29068687 sequences
SP32 - 25323000 sequences
SP33 - 34693006 sequences
SP34 - 25498215 sequences
SP04 - 28305133 sequences
SP05 - 31119229 sequences
SP06 - 33318476 sequences
SP07 - 34575181 sequences
SP08 - 29565364 sequences
SP09 - 24127101 sequences

# Creating the Bracken Database
PATH=$PATH:/home/lucasvieira/Kraken2/
/home/lucasvieira/Bracken/bracken-build  -d /media/hd4/lucasvieira/Databases/BacteriaDB -t 30 -k 35 -l 151
/home/lucasvieira/Bracken/bracken-build  -d /media/hd4/lucasvieira/Databases/PlantDB -t 30 -k 35 -l 151
/home/lucasvieira/Bracken/bracken-build  -d /media/hd4/lucasvieira/Databases/FungiDB -t 30 -k 35 -l 151
/home/lucasvieira/Bracken/bracken-build  -d /media/hd4/lucasvieira/Databases/RDP_DB -t 30 -k 35 -l 151
/home/lucasvieira/Bracken/bracken-build  -d /media/hd4/lucasvieira/Databases/GreengenesDB -t 30 -k 35 -l 151
/home/lucasvieira/Bracken/bracken-build  -d /media/hd4/lucasvieira/Databases/SilvaDB -t 30 -k 35 -l 151

# Running Bracken
/home/lucasvieira/Bracken/bracken -d /media/hd4/lucasvieira/Databases/BacteriaDB -i ReportSP10_BacteriaNCBI_K2.txt -o Teste.bracken -r 151 -l S -t 0
