
# downloading datasets in separate script to avoid caching and HPC server issues

from datasets import load_dataset
import config

dataset_train = load_dataset(
    "MoritzLaurer/dataset_train_nli", token=config.HF_ACCESS_TOKEN,
    force_download=True
)["train"]

dataset_test_concat_nli = load_dataset(
    "MoritzLaurer/dataset_test_concat_nli", token=config.HF_ACCESS_TOKEN,
    force_download=True
)["train"]

dataset_test_disaggregated = load_dataset(
    "MoritzLaurer/dataset_test_disaggregated_nli", token=config.HF_ACCESS_TOKEN,
    force_download=True
)

