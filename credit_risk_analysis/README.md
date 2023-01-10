### Why do we use credit risk analysis?
Basically, in institutions that grant credit, we need to be as sure as possible that we will be paid in the future, and for that we use models that analyze the chances of a given customer not paying us by the end of the stipulated period. An example of this is Serasa Score, which creates a score for you based on the timeliness of your payments.

### What exactly will we analyze?
All our work here will be done on top of a [dataset taken from the Kaggle competitions website](https://www.kaggle.com/datasets/laotse/credit-risk-dataset), in which we have certain information about certain customers , such as age, salary, what is the housing situation of that person (if they live on rent, mortgage or have their own home), amount of money they borrowed and the main thing: whether they paid it or not.

### How do we do it?
First we'll clean up our data, that is, we'll look for anomalies (a person whose age is set to 200 is an anomaly, for example) and missing values, and then decide how we're going to treat them.
After that, we will decide which algorithm is the most recommended to deal with this situation, then divide our set into two subsets, one that will serve for training and the other for testing, we will feed our model in the training subset and then we will analyze its effectiveness on the test set.