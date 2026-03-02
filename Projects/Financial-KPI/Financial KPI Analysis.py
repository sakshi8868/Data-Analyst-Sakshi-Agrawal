# 1: Import Libraries

import pandas as pd
import numpy as np
import matplotlib.pyplot as  plt
from matplotlib.pyplot import xlabel
from matplotlib.pyplot import ylabel
from matplotlib.pyplot import show
from matplotlib.pyplot import title

import seaborn as sns
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, ListFlowable, ListItem
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib.units import inch
from openpyxl import Workbook

#2. Load Dataset

df = pd.read_csv("Financial-Analytics-data1.csv")
df.columns = df.columns.str.strip()
df.info()

df = df.rename(columns={
    "Sales Qtr - Crore": "revenue",
    "Mar Cap - Crore": "market_cap"
})


df.Name.nunique()

df.isnull().sum()

df.duplicated().sum()

df.describe()

plt.figure(figsize=(10, 6))
sns.histplot(df['revenue'], kde=True)
plt.title('Distribution of Sales for the Quarter')
plt.xlabel('Sales for the Quarter (revenue)')
plt.ylabel('Frequency')
plt.show()

plt.figure(figsize=(6,8))
plt.hist(df['market_cap'], bins=7, color='lightskyblue', rwidth=0.6)
plt.grid(True)
plt.show()

sns.heatmap(df.corr(numeric_only=True),annot=True)
plt.show()

pd.crosstab(df.market_cap, df.revenue)

y = df.iloc[:, -1]
y.head()

X = df.iloc[ : , :-1]
X.head()

X = pd.get_dummies(X, columns=['revenue'])
X.head()

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, y_train)

LinearRegression()

y_pred = regressor.predict(X_test)
y_pred()

from sklearn.metrics import r2_score
score = r2_score(y_test, y_pred)
print ("R^2 for using all input variables:", score)

#4. KPI Calculation

df["burn_rate"] = df["expenses"] - df["revenue"]
df.info()

df["cac"] = df["expenses"] / df["customers_acquired"].replace(0, np.nan)
df.info()

df["ltv"] = (df["revenue"] / df["total_customers"].replace(0, np.nan)) * 12
df.info()

df["ltv_cac_ratio"] = df["ltv"] / df["cac"]
df.info()

df["run_rate"] = df["revenue"] * 4
df.info()

#5. Summary Metrics

summary = {
    "Average Revenue": round(df["revenue"].mean(), 2),
    "Average Burn Rate": round(df["burn_rate"].mean(), 2),
    "Average CAC": round(df["cac"].mean(), 2),
    "Average LTV": round(df["ltv"].mean(), 2),
    "Average LTV:CAC Ratio": round(df["ltv_cac_ratio"].mean(), 2),
    "Current Annualized Run Rate": round(df["run_rate"].iloc[-1], 2)
}

print("===== KPI SUMMARY =====")
for k, v in summary.items():
    print(f"{k}: {v}")


