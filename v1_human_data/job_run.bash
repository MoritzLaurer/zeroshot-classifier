#!/bin/bash
#Set batch job requirements
#SBATCH -t 20:00:00
#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=m.laurer@vu.nl
#SBATCH --job-name=zs

#Loading modules
module load 2021
module load Python/3.9.5-GCCcore-10.3.0

#set correct working directory
cd ./zeroshot

pip install --upgrade pip
pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu
pip install -r requirements.txt

# Check PyTorch and CUDA compatibility
echo "Checking PyTorch and CUDA compatibility"
python -c "import torch; print('PyTorch version:', torch.__version__); print('CUDA is available:', torch.cuda.is_available()); print('CUDA version:', torch.version.cuda); print('CUDNN version:', torch.backends.cudnn.version())"

# This script expects an argument: a string for heldout datasets
dataset_name_heldout=$1
do_train=$2
upload_to_hub=$3

# Rest of your script that runs the experiment with $param
echo "Running experiment with parameter: dataset_name_heldout = $dataset_name_heldout,  do_train = $do_train,  upload_to_hub = $upload_to_hub"

# run script
python 4_train_eval.py --dataset_name_heldout "$dataset_name_heldout" --do_train "$do_train" --upload_to_hub "$upload_to_hub" &> "./logs/logs_$dataset_name_heldout-$(date +"%y%m%d%H%M").txt"


# submit script via terminal
#sbatch --output=./zeroshot/logs/logs_sbatch.txt ./zeroshot/batch_job.bash

# single model run via terminal
#cd zeroshot/zeroshot-classifier
#nohup python 4_train_eval.py --dataset_name_heldout "all_except_nli_mixtral_small_zeroshot" --do_train "True" --upload_to_hub "True" &> "./logs/logs_debertav3_base-$(date +"%y%m%d%H%M").txt" &

