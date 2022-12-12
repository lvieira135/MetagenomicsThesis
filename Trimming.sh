# Trimming das raw sequences
# Analyses started in 18/02/2021

cd /media/hd1/lucasvieira/raw_data/

# Trimming

java -jar -Xms5g -Xmx100g ~/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 80 -phred33 \
SP13_CSFP200002477-1a_H3N7LDSXY_L1_1.fq.gz SP13_CSFP200002477-1a_H3N7LDSXY_L1_2.fq.gz \
SP13_forward_paired.fq.gz SP13_forward_unpaired.fq.gz \
SP13_reverse_paired.fq.gz SP13_reverse_unpaired.fq.gz \
ILLUMINACLIP:/home/lucasvieira/Trimmomatic-0.39/adapters/TruSeq3-PE-2.fa:2:30:10:2:keepBothReads HEADCROP:9 SLIDINGWINDOW:4:15 MINLEN:36

# Assembling the metagenome (first test Feb 26)
/home/lucasvieira/SPAdes-3.15.0-Linux/bin/metaspades.py -1 SP8_forward_paired.fq.gz -2 SP8_reverse_paired.fq.gz \
--only-assembler --threads 36 -o Metagenome8

/home/lucasvieira/SPAdes-3.15.0-Linux/bin/metaspades.py -1 SP9_forward_paired.fq.gz -2 SP9_reverse_paired.fq.gz \
--only-assembler --threads 36 -o Metagenome9
