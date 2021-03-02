#!/usr/bin/bash
#SBATCH --job-name="salmon"
#SBATCH --cpus-per-task=8
#SBATCH --time=2:00:00
#SBATCH --err=salmon.%j.err
#SBATCH --output=salmon.%j.out
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

# Modules required

module load nixpkgs/16.09
module load gcc/7.3.0
module load openmpi/3.1.4
module load salmon/1.3.0

# Variables

FAIDX=../data/references/gencode_GRCh38.12/gencode.v30_salmon-1.3.0
FSQDIR=/project/6007998/gperron/analyses/MDA-LM2_DESeq2_stability/MDA-LM2_DESeq2_stability_rawData
OUTDIR=../data/salmon_GSE49608/quant_gcBias_seqBias

samples=()
i=0
while read u
do
	samples[i]=$u
	i=$((i+1))
done < samples.txt

samName=${samples[${SLURM_ARRAY_TASK_ID}]}
echo "Sample name: ${samName}"
OUTSAM=${OUTDIR}/${samName}

mkdir -p ${OUTDIR}
mkdir -p ${OUTSAM}

salmon quant -p 8 \
			 -i ${FAIDX} \
			 -l A \
			 --validateMappings --gcBias --seqBias \
			 -o ${OUTSAM} \
			 -r ${FSQDIR}/${samName}.1.fastq \
			 
			 
			 
			 
			 






