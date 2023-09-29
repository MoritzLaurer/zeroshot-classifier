# Efficient zero-shot classifier

This repository contains the code for preparing the data and training the model [MoritzLaurer/deberta-v3-zeroshot-v1](https://huggingface.co/MoritzLaurer/deberta-v3-base-zeroshot-v1).

The model is designed for zero-shot classification with the Hugging Face pipeline. 
The model should be substantially better at zero-shot classification than my other zero-shot models on the
Hugging Face hub: https://huggingface.co/MoritzLaurer 

The model can do one universal task: determine whether a hypothesis is `true` or `not_true` given a text.  
This task format is based on the Natural Language Inference task (NLI).
The task is so universal that any classification task can be reformulated into this true vs. false task.

The model was trained on a mixture of 27 tasks and 310 classes that have been reformatted into this universal format.
1.   26 classification tasks with ~400k texts:
['amazonpolarity', 'imdb', 'appreviews', 'yelpreviews', 'rottentomatoes',
'emotiondair', 'emocontext', 'empathetic',
'financialphrasebank', 'banking77', 'massive',
'wikitoxic_toxicaggregated', 'wikitoxic_obscene', 'wikitoxic_threat', 'wikitoxic_insult', 'wikitoxic_identityhate', 
'hateoffensive', 'hatexplain', 'biasframes_offensive', 'biasframes_sex', 'biasframes_intent',
'agnews', 'yahootopics',
'trueteacher', 'spam', 'wellformedquery',]
2.   Five NLI datasets with ~885k texts: ["mnli", "anli", "fever", "wanli", "ling"]

Note that this is only version v1.0 and I am working on several improvements (more tasks, better evaluation, ...).

### Preprocessing steps:
- `1_data_download_harmonization.ipynb`: Download and harmonization of millions of texts from 26 tasks and 310 classes (and downsample).
- `2_data_cleaning.ipynb`: Automatic data cleaning with CleanLab: delete around 150k texts due to noise. Quality > quantity.
- `3_data_formatting_universal_nli.ipynb`: Reformatting all 26 classification tasks into the universal NLI format. 
This also includes downsampling to ~400k texts for training to avoid overfitting.  I use max 20k texts per task, because quality > quantity. 
I then add ~885k texts from different NLI datasets ["mnli", "anli", "fever", "wanli", "ling"] (in binary format).


### Call for input

This is only v1.0 and I plan on updating the code and model with more datasets.  
- If you know good datasets and want them to be included in the next version, let me know!
You can either open an issue in this repo or contact me on
[LinkedIn](https://www.linkedin.com/in/moritz-laurer/) or [Twitter/X](https://twitter.com/MoritzLaurer).
- If you spot errors in my code or have ideas for improvements, please also let me know. 

### License

The code is under the Apache-2.0 license. The datasets used for training, however,
have a mix of different licenses. 