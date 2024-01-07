## Building an efficient zero-shot classifier

This repository contains the code for preparing the data and training the zeroshot models described in the paper "[Building Efficient Universal Classifiers with Natural Language Inference
](https://arxiv.org/abs/2312.17543)". The models can be downloaded via my
[Hugging Face Zeroshot Classifiers Collection](https://huggingface.co/collections/MoritzLaurer/zeroshot-classifiers-6548b4ff407bb19ff5c3ad6f).

The models are designed for zeroshot classification with the Hugging Face pipeline. 

The model can do one universal classification task: determine whether a hypothesis is "true" or "not true" given a text
(`entailment` vs. `not_entailment`).  
This task format is based on the Natural Language Inference task (NLI).
The task is so universal that any classification task can be reformulated into this task.

The models are trained on a mixture of __33 datasets and 387 classes__ that have been reformatted into this universal format.
1.   Five NLI datasets with ~885k texts: "mnli", "anli", "fever", "wanli", "ling"
2.   28 classification tasks reformatted into the universal NLI format. ~51k cleaned texts were used to avoid overfitting:
'amazonpolarity', 'imdb', 'appreviews', 'yelpreviews', 'rottentomatoes',
'emotiondair', 'emocontext', 'empathetic',
'financialphrasebank', 'banking77', 'massive',
'wikitoxic_toxicaggregated', 'wikitoxic_obscene', 'wikitoxic_threat', 'wikitoxic_insult', 'wikitoxic_identityhate', 
'hateoffensive', 'hatexplain', 'biasframes_offensive', 'biasframes_sex', 'biasframes_intent',
'agnews', 'yahootopics',
'trueteacher', 'spam', 'wellformedquery',
'manifesto', 'capsotu'.

See details on each dataset here: https://github.com/MoritzLaurer/zeroshot-classifier/blob/main/datasets_overview.csv

Note that compared to other NLI models, these models predicts two classes (`entailment` vs. `not_entailment`)
as opposed to three classes (entailment/neutral/contradiction)

The model was only trained on English data. For __multilingual use-cases__, 
I recommend machine translating texts to English with libraries like [EasyNMT](https://github.com/UKPLab/EasyNMT).
English-only models tend to perform better than multilingual models and
validation with English data can be easier if you don't speak all languages in your corpus.


### How to use the model
```python
#!pip install transformers[sentencepiece]
from transformers import pipeline
text = "Angela Merkel is a politician in Germany and leader of the CDU"
hypothesis_template = "This example is about {}"
classes_verbalized = ["politics", "economy", "entertainment", "environment"]
zeroshot_classifier = pipeline("zero-shot-classification", model="MoritzLaurer/deberta-v3-large-zeroshot-v1.1-all-33")
output = zeroshot_classifier(text, classes_verbalised, hypothesis_template=hypothesis_template, multi_label=False)
print(output)
```


### Main steps for reproduction/modification:
For reproducing or training your own model, you can use the following notebooks.

- `1_data_harmonization.ipynb`: Download and harmonization of millions of texts from 33 datasets and 387 classes (and downsample).
- `2_data_cleaning.ipynb`: Automatic data cleaning with CleanLab: delete around 150k texts due to noise. Quality > quantity.
- `3_data_formatting_universal_nli.ipynb`: Reformatting all 28 classification tasks into the universal NLI format. 
This also includes downsampling to ~51k texts for training to avoid overfitting.  I use max 500 texts per class, because quality > quantity. 
I then add ~885k texts from different NLI datasets ["mnli", "anli", "fever", "wanli", "ling"] (in binary format).
- `4_train_eval.ipynb`: Train and evaluate the model on the 33 datasets and 387 classes.
- `5_viz.ipynb`: Visualize the results.


### Performance metrics and additional details
For metrics and more details see the model cards in my 
[Zeroshot Classifiers Collection](https://huggingface.co/collections/MoritzLaurer/zeroshot-classifiers-6548b4ff407bb19ff5c3ad6f).


### Call for input
I might update the code and models with more datasets.  
- If you know good datasets and want them to be included in the next version, let me know.
You can either open an issue in this repo or contact me on
[LinkedIn](https://www.linkedin.com/in/moritz-laurer/) or [Twitter/X](https://twitter.com/MoritzLaurer).
- If you spot errors in my code or have ideas for improvements, please also let me know. 


### License
The code is under the Apache-2.0 license. The datasets used for training, however,
have a mix of different licenses. 
