#!/bin/bash
#Set batch job requirements
#SBATCH -t 15:00:00
#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=m.laurer@vu.nl
#SBATCH --job-name=zeroshot

#Loading modules
module load 2021
module load Python/3.9.5-GCCcore-10.3.0
#module load 2022
#module load Python/3.10.4-GCCcore-11.3.0

#set correct working directory
cd ./zeroshot

pip install --upgrade pip
#pip3 install torch --extra-index-url https://download.pytorch.org/whl/cu118
pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu
pip install -r requirements.txt

# Check PyTorch and CUDA compatibility
echo "Checking PyTorch and CUDA compatibility"
python -c "import torch; print('PyTorch version:', torch.__version__); print('CUDA is available:', torch.cuda.is_available()); print('CUDA version:', torch.version.cuda); print('CUDNN version:', torch.backends.cudnn.version())"

# run script
python 4_train_eval.py &> "./logs/logs_$(date +"%y%m%d%H%M").txt"

#sbatch --output=./zeroshot/logs/logs_sbatch.txt ./zeroshot/batch_job.bash

