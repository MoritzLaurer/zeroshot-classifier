#!/bin/bash

# download datasets to avoid server issues
#module load 2022
#module load Python/3.9.5-GCCcore-10.3.0
#pip install datasets~=2.14.0
#python ./zeroshot/download_datasets.py


# Iterate through all datasets for heldout testing
#dataset_name_heldout=(
#    'wellformedquery' 'financialphrasebank' 'rottentomatoes' 'amazonpolarity'
#    'imdb' 'appreviews' 'yelpreviews' 'wikitoxic_toxicaggregated'
#    'wikitoxic_obscene' 'wikitoxic_threat' 'wikitoxic_insult'
#    'wikitoxic_identityhate' 'hateoffensive' 'hatexplain'
#    'trueteacher' 'spam' 'massive' 'banking77' 'emotiondair'
#    'emocontext' 'empathetic' 'agnews' 'yahootopics'
#    'biasframes_offensive' 'biasframes_sex' 'biasframes_intent'
#    "manifesto" "capsotu"
#)

# do not upload these to the hub
#for dataset_name in "${dataset_name_heldout[@]}"
#do
#    sbatch --output=./zeroshot/logs/logs_sbatch_$dataset_name.txt ./zeroshot/job_run.bash "$dataset_name" True False
#done


# two runs with all data (not heldout) or with only nli data
# upload these to the hub
datasets=("all_except_nli" "none")

for dataset_name in "${datasets[@]}"
do
    sbatch --output=./zeroshot/logs/logs_sbatch_$dataset_name.txt ./zeroshot/job_run.bash "$dataset_name" True True
done

# submit script via terminal
#chmod +x ./zeroshot/jobs_submit.bash
#./zeroshot/jobs_submit.bash

