# Description
## Project Context and Data Significance
# Background
## This project is conducted in the context of ongoing considerations by the Law Commission for England and Wales regarding potential reforms in cohabitation law. 
## A key focus of this research is on unmarried couples, particularly examining their perspectives on financial management and general aspects of cohabitation.

# Importance of the Study
## Filling a Research Gap: Unlike the majority of existing research which primarily centers around married couples, this study is among the first to delve into the experiences and views of non-maritally committed, cohabiting heterosexual couples.
## Influence on Law Reform: The insights derived from this study are intended to be instrumental in informing the law reform process. By capturing the nuances of financial and relational dynamics in non-marital cohabitations, the study aims to contribute valuable data to shape future legal frameworks.

# Data Overview
## Participants in this study provided responses through an online survey, supplemented by a paper-based questionnaire. The data encompasses a wide array of items addressing financial, legal, and relationship aspects specific to non-traditional, cohabiting heterosexual couples.

# Model's Role in the Research:
## Seeks to quantitatively assess the relationship between couples' financial organization methods and their overall relationship satisfaction.
## The analysis focuses on correlating the textual descriptions of financial arrangements (mm_explain) with the self-reported levels of relationship happiness (part10).
## The outcomes of this model are anticipated to provide empirical support for potential legal reforms and offer a deeper understanding of the dynamics in non-marital cohabitations.

# Installation
## Libraries and dependencies required to run project:
pip install numpy
pip install pandas
pip install scikit-learn
pip install matplotlib
pip install seaborn

#Setting Up

# Model Code - view the code for the model, visit the Jupyter notebook available in the repository:
## https://github.com/ella-mclintic/exeter/blob/main/problemset2.ipynb

## This notebook contains the detailed steps of data preprocessing, model training, and evaluation.

# Loading the Pickled Model - The trained model has been serialized and saved as a .pkl file, which can be found here:
## https://github.com/ella-mclintic/exeter/blob/main/model.pkl

# To use this model, you need to download the file and load it into your Python environment. Follow these steps:

## 1. Download the Pickled Model: Download model.pkl from the repository and save it in your working directory.
with open('model.pkl', 'rb') as file:
    model = pickle.load(file)

## 2. Load your new data
new_data = pd.read_csv('your_new_data.csv')

## 3. Ensure your data has the same structure and column names as the training set
new_data = new_data.rename(columns={'your_original_column_name': 'text'})

# Preprocess the data to match the training format

## 4. Extract text data for vectorization
texts = new_data['text'].tolist()

## 5. Vectorize the text data using the same TF-IDF vectorizer settings as used in training
### Note: You need to load the vectorizer used during training or replicate its settings
from sklearn.feature_extraction.text import TfidfVectorizer
vectorizer = TfidfVectorizer()
X_new = vectorizer.fit_transform(texts)

## 6. Making predictions with the processed new data
predictions = model.predict(X_new)
print(predictions)
