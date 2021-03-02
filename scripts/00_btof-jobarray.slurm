#!/usr/bin/bash
#SBATCH --job-name="btf"
#SBATCH --cpus-per-task=1
#SBATCH --time=15:00:00
#SBATCH --err=btf.%j.err
#SBATCH --output=btf.%j.out
#SBATCH --array=0-31
#SBATCH --mem-per-cpu=10G
#SBATCH --mail-user=larimst@gmail.com
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=REQUEUE
#SBATCH --mail-type=ALL
#SBATCH --account=rrg-hsn

#----------------------------------------------------------#
echo "The job "${SLURM_JOB_ID}" is running on "${SLURM_JOB_NODELIST}
#----------------------------------------------------------#

module load samtools
module load bedtools

BAMDIR=/project/6007998/gperron/analyses/MDA-LM2_DESeq2_stability/MDA-LM2_DESeq2_stability_align/GSE49608
FSQDIR=../data/salmon_GSE49608/fastq

samples=()
i=0
while read u
do
	samples[i]=$u
	i=$((i+1))
done < samples.txt

samName=${samples[${SLURM_ARRAY_TASK_ID}]}
echo "Sample name: ${samName}"

mkdir -p ${FSQDIR}

bedtools bamtofastq -i ${BAMDIR}/${samName}.bam -fq ${FSQDIR}/${samName}.fq 

