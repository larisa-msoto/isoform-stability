#!/bin/bash
#SBATCH --mem=8gb
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --time=01:00:00
#SBATCH --account=rrg-hsn
#SBATCH --job-name=rbp-utr5
#SBATCH --output=utr5.%x.out.txt
#SBATCH --error=utr5.%x.err.txt

SEQ=utr5
MOTIFS=cisbp.HomoSapiens.inferred.motifs
#MOTIFS=microRNA.seeds.conserved.reverse_complement

AFF=/home/lmoral7/lib/MoSBAT/bin/AffiMx
PWM=/home/lmoral7/projects/rrg-hsn/lmoral7/isoform-stability/data/binding_motifs/${MOTIFS}.txt
FASTA=/home/lmoral7/projects/rrg-hsn/lmoral7/isoform-stability/data/fastas_GSE49608/${SEQ}.transcripts.fa
OUTDIR=/home/lmoral7/projects/rrg-hsn/lmoral7/isoform-stability/results/affimix_GSE49608/${MOTIFS}
OUT=${OUTDIR}/${SEQ}_binding

mkdir -p ${OUTDIR}

"${AFF}" -pwm $PWM -fasta $FASTA -dir 0 -out $OUT