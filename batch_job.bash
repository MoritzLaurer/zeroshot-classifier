#!/bin/bash
#Set batch job requirements
#SBATCH -t 25:00:00
#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=m.laurer@vu.nl
#SBATCH --job-name=zeroshot

#Loading modules
#module load 2021
#module load Python/3.9.5-GCCcore-10.3.0
module load 2022
module load Python/3.10.4-GCCcore-11.3.0

#set correct working directory
cd ./zeroshot

pip install --upgrade pip
pip3 install torch --extra-index-url https://download.pytorch.org/whl/cu118
pip install -r requirements.txt
# install git-lsf
#echo VUSnellius!123 | sudo -S apt-get install git-lfs

python train_eval.py &> "./logs/logs_$(date +"%y%m%d%H%M").txt"
#jupyter nbconvert --to notebook --execute train_eval.ipynb &> ./logs_230928.txt

#sbatch ./zeroshot/batch_job.bash

