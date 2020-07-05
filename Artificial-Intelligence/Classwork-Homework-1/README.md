# Problem Statement - Home Credit Risk
Many people struggle to get loans due to insufficient or non-existent credit histories. And, unfortunately, this population is often taken advantage of by untrustworthy lenders.

Home Credit strives to broaden financial inclusion for the unbanked population by providing a positive and safe borrowing experience. In order to make sure this underserved population has a positive loan experience, Home Credit makes use of a variety of alternative data--including telco and transactional information--to predict their clients' repayment abilities.

While Home Credit is currently using various statistical and machine learning methods to make these predictions, they're challenging Kagglers to help them unlock the full potential of their data. Doing so will ensure that clients capable of repayment are not rejected and that loans are given with a principal, maturity, and repayment calendar that will empower their clients to be successful.

# Link Reference
https://www.kaggle.com/c/home-credit-default-risk/


# Approaches to predict the glass grade
* Logistic Regression
* Ensemble Learning (Random Forest)

# Leaderboard Accuracy
0.71094

# Accuracies
I applied five K-folds on random forest classifier an logistic regression. <br>

Results of 5-folds on RFC without feature engineering <br>
Mean Accuracy Score on CV-5:  0.9193297150628963
Mean Precision Score on CV-5:  0.0010473313192346425
Mean Recall Score on CV-5:  0.7611904761904762
Mean ROC AUC Score on CV-5:  0.7141749427426861
Mean Logloss Score on CV-5:  0.26840721365271203

Results of 5-folds on RFC with feature engineering <br>
Mean Accuracy Score on CV-5:  0.9192939439213379
Mean Precision Score on CV-5:  0.0006445115810674723
Mean Recall Score on CV-5:  0.6671428571428571
Mean ROC AUC Score on CV-5:  0.715156124646816
Mean Logloss Score on CV-5:  0.2704385764754867 <br>

To select the feature I removed the variable that holds a correlation of 98% and above after gaining the feature importance from RFC, the variables which are neglected are, <br>
Total variables: 31 <br>
['AMT_GOODS_PRICE', 'OBS_60_CNT_SOCIAL_CIRCLE', 'LIVINGAREA_AVG', 'YEARS_BEGINEXPLUATATION_MEDI', 'APARTMENTS_MEDI', 'LANDAREA_MEDI', 'LANDAREA_MODE', 'BASEMENTAREA_MEDI', 'YEARS_BUILD_MEDI', 'NONLIVINGAREA_MEDI', 'COMMONAREA_MEDI', 'YEARS_BUILD_AVG', 'LIVINGAPARTMENTS_MEDI', 'ENTRANCES_MEDI', 'ENTRANCES_MODE', 'FLAG_OWN_REALTY_Y', 'FLOORSMAX_MEDI', 'FLAG_OWN_CAR_Y', 'CODE_GENDER_F', 'FLOORSMAX_MODE', 'FLOORSMIN_MEDI', 'FLOORSMIN_MODE', 'NONLIVINGAPARTMENTS_MEDI', 'ELEVATORS_MEDI', 'ELEVATORS_MODE', 'NAME_CONTRACT_TYPE_Revolving loans', 'EMERGENCYSTATE_MODE_Unknown', 'HOUSETYPE_MODE_Unknown', 'FLAG_EMP_PHONE', 'NAME_INCOME_TYPE_Pensioner', 'ORGANIZATION_TYPE_XNA'] <br>

Results of 5-folds on Logistic Regression <br>
Mean Accuracy Score on CV-5:  0.9192549209587615
Mean Precision Score on CV-5:  0.0
Mean Recall Score on CV-5:  0.0
Mean ROC AUC Score on CV-5:  0.6122580207177722
Mean Logloss Score on CV-5:  0.276148176334584
