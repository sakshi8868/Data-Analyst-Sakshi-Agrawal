import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.pyplot import xlabel
from matplotlib.pyplot import ylabel
from matplotlib.pyplot import show
from matplotlib.pyplot import title
import seaborn as sns

data = pd.read_csv("SuperMarket Analysis.csv")

data.head()
data.info()

#Step 2: Data Cleaning

data.isnull().sum()

data = data.drop_duplicates()
data.info()

#Step-3: Basic Statistics Summary
data.describe()

meta_gross_income = data['gross income'].mean()
print(f"Average Gross Income: {meta_gross_income:.2f}")

#Step-4: Branch-wise Sales Analysis

branch_sales = data.groupby('Branch')['gross income'].sum()
print("Total Gross Income by Branch:\n", branch_sales)

branch_mean = data.groupby('Branch')['gross income'].mean()
print("Mean Gross Income by Branch:\n", branch_mean)

best_branch = branch_mean.idxmax()
print(f"The best performing branch is: {best_branch}")

#Step-5: Category-wise Sales Analysis

category_sales = data.groupby('Product line')['gross income'].sum().sort_values(ascending=False)
print("Gross Income by Product Line:\n", category_sales)

top_categories = category_sales.head(3)
print("Top 3 Product Lines:\n", top_categories)

#Step-6: Customer & City Sales Analysis

customer_type_sales = data.groupby('Customer type')['gross income'].sum()
print("Gross Income by Customer Type:\n", customer_type_sales)

city_sales = data.groupby('City')['gross income'].sum()
print("Gross Income by City:\n", city_sales)

#Step-7: Data Visualization

branch_sales.plot(kind='bar', title='Gross Income by Branch')
plt.ylabel('Gross Income')
plt.show()

top_categories.plot(kind='bar', color='orange', title='Top 3 Product Lines by Gross Income')
plt.ylabel('Gross Income')
plt.show()

#Step-8: Advanced Data Visualization with Seaborn

plt.figure(figsize=(8,5))
sns.histplot(data['gross income'], bins=20, kde=True)
plt.title('Distribution of Gross Income')
plt.xlabel('Gross Income')
plt.show()

plt.figure(figsize=(8,5))
sns.boxplot(x='Branch', y='gross income', data=data)
plt.title('Gross Income Distribution by Branch')
plt.show()

#Step-9: Correlation Analysis

data_encoded = pd.get_dummies(data)
corr = data_encoded.corr()
print("Correlation matrix:\n", corr)

data_numeric = data.select_dtypes(include='number')
corr1 = data_numeric.corr()
plt.figure(figsize=(8,6))
sns.heatmap(corr1, annot=True, cmap='cool-warm')
plt.title('Correlation Heatmap')
plt.show()

#Step-10: Temporal Analysis

data['Date'] = pd.to_datetime(data['Date'], dayfirst=True, errors='coerce')
data['Month'] = data['Date'].dt.month

monthly_sales = data.groupby('Month')['gross income'].sum()
monthly_sales.plot(kind='line', marker='o', title='Monthly Gross Income')
plt.ylabel('Gross Income')
plt.show()

#Step-11: Pivot Table Analysis

pivot_table = pd.pivot_table(data, values='gross income', index='Branch', columns='Customer type', aggfunc='sum')
print(pivot_table)

pivot_table.plot(kind='bar', figsize=(8,6), title='Gross Income by Branch and Customer Type')
plt.ylabel('Gross Income')
plt.show()

