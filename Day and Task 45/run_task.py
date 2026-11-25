import pandas as pd, numpy as np
from pathlib import Path
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split, StratifiedKFold, cross_val_score, GridSearchCV
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder, StandardScaler
from sklearn.impute import SimpleImputer
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, roc_auc_score, ConfusionMatrixDisplay, RocCurveDisplay, confusion_matrix
import joblib
raw=pd.read_csv('customer_churn.csv')
def engineer(df):
    df=df.copy()
    t=next((c for c in ['TenureMonths','Tenure_Months'] if c in df),None)
    m=next((c for c in ['MonthlyCharges','Monthly_Charges_INR'] if c in df),None)
    if t: df['Tenure_Group']=pd.cut(df[t],[-1,12,36,np.inf],labels=['New','Medium','Long-term']).astype(object)
    if m: df['Spending_Category']=pd.cut(df[m],[-np.inf,500,1500,np.inf],labels=['Low','Medium','High']).astype(object)
    if 'AvgMonthlyDataUsageGB' in df: df['Average_Usage']=df['AvgMonthlyDataUsageGB']
    return df
assert raw.Churn.notna().all()
y=raw.Churn.astype(str).str.lower().map({'yes':1,'no':0,'1':1,'0':0})
assert y.notna().all()
X=engineer(raw).drop(columns=['Churn','CustomerID','ChurnFlag'],errors='ignore')
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=.2,random_state=42,stratify=y)
num=X.select_dtypes(include='number').columns.tolist(); cat=[c for c in X if c not in num]
def prep():
    return ColumnTransformer([('num',Pipeline([('impute',SimpleImputer(strategy='median')),('scale',StandardScaler())]),num),('cat',Pipeline([('impute',SimpleImputer(strategy='most_frequent')),('encode',OneHotEncoder(handle_unknown='ignore'))]),cat)])
models={'Logistic Regression':LogisticRegression(max_iter=1000),'Decision Tree':DecisionTreeClassifier(random_state=42),'Random Forest':RandomForestClassifier(n_estimators=100,random_state=42,class_weight='balanced')}
cv=StratifiedKFold(5,shuffle=True,random_state=42)
def pipeline(name): return Pipeline([('preprocessor',prep()),('classifier',models[name])])
def metrics(model):
    pred=model.predict(X_test); prob=model.predict_proba(X_test)[:,1]
    tn,fp,fn,tp=confusion_matrix(y_test,pred,labels=[0,1]).ravel()
    return dict(Accuracy=accuracy_score(y_test,pred),Precision=precision_score(y_test,pred,zero_division=0),Recall=recall_score(y_test,pred,zero_division=0),F1=f1_score(y_test,pred,zero_division=0),ROC_AUC=roc_auc_score(y_test,prob),TN=tn,FP=fp,FN=fn,TP=tp)
def compare(names):
    fitted={}; rows=[]
    for name in names:
        model=pipeline(name); score=cross_val_score(model,X_train,y_train,cv=cv,scoring='roc_auc').mean(); model.fit(X_train,y_train); fitted[name]=model
        rows.append(dict(Model=name,CV_ROC_AUC=score,**metrics(model)))
    return fitted,pd.DataFrame(rows)

fitted,table=compare(['Logistic Regression','Decision Tree']); table.to_csv('model_comparison_day45.csv',index=False); print(table); print(fitted['Decision Tree'].named_steps['classifier'].get_depth())