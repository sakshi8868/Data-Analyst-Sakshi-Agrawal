#1. Import Libraries

import numpy as np
import pandas as pd
import os
import matplotlib.pyplot as plt
from matplotlib.pyplot import xlabel
from matplotlib.pyplot import ylabel
from matplotlib.pyplot import title
from matplotlib.pyplot import show
from matplotlib.pyplot import xticks
import seaborn as sns

#2. Load Datasets

df = pd.read_csv('Shark Tank India Dataset.csv')
df_sk_n = pd.read_csv('Shark Tank Data complete 121pitches.csv')

df.head()
df_sk_n.head()

df.shape
df_sk_n.shape

df.describe()
df_sk_n.describe()

df.info()
df_sk_n.info()

df.isna().any()
df.columns

df_sk_n.columns
df['deal'].value_counts()

df[df['pitcher_ask_amount']==df['pitcher_ask_amount'].max()]

df[df['deal_amount']==df['deal_amount'].max()]

df[df['ask_valuation']==df['ask_valuation'].max()]

df[df['ask_equity']==df['ask_equity'].min()]

df[df['deal_valuation']==df['deal_valuation'].max()]

def synergy(data):
  list = ['anupam_deal','aman_deal','namita_deal','vineeta_deal','peyush_deal','ghazal_deal','ashneer_deal']
  for i in list:
    deal = data[['amount_per_shark','equity_per_shark']][data[i]==1]
    print("\n{} deals with {}".format(len(deal),i[:-5]))
    print(deal)

ash_grover = df[df['ashneer_deal']==1]
ash_grover

ash_grover['amount_per_shark'].sum()

synergy(ash_grover)

df.isnull().sum()
df_sk_n.isnull().sum()

#3. Common Cleaning Steps

df = df.dropna(subset=['total_sharks_invested'])
df.info()

#4. Deal Success Analysis

deal_counts = df['deal'].value_counts()

deal_counts

##Visualization
deal_counts.plot(kind='bar')
plt.title("Deal vs No Deal")
plt.xticks([0,1], ["No Deal", "Deal"], rotation=0)
plt.ylabel("Number of Pitches")
plt.show()

success_rate = (df['deal'].sum() / len(df)) * 100
print("Deal Success Rate: {:.2f}%".format(success_rate))

#5. Ask vs Deal Analysis

df[['pitcher_ask_amount', 'deal_amount']].mean()

comparison = df[['pitcher_ask_amount', 'deal_amount']].mean()
comparison

##Visualization
comparison.plot(kind='bar')
plt.title("Average Ask Amount vs Deal Amount")
plt.ylabel("Amount (Lakhs)")
plt.show()

#6. Ask Valuation vs Deal Valuation

df[['ask_valuation', 'deal_valuation']].mean()
valuation_comparison = df[['ask_valuation', 'deal_valuation']].mean()
valuation_comparison

##Visualization
valuation_comparison.plot(kind='bar')
plt.title("Ask Valuation vs Deal Valuation")
plt.ylabel("Valuation")
plt.show()

#7. Equity Analysis

df[['ask_equity', 'deal_equity']].mean()
equity_comparison = df[['ask_equity', 'deal_equity']].mean()
equity_comparison

##Visualization
equity_comparison.plot(kind='bar')
plt.title("Ask Equity vs Deal Equity")
plt.ylabel("Equity (%)")
plt.show()

#8. Multi-Shark Investment Analysis

df['total_sharks_invested'].describe()

##Visualization
df['total_sharks_invested'].plot(kind='hist', bins=5)
plt.title("Distribution of Sharks per Deal")
plt.xlabel("Number of Sharks")
plt.show()

#9. Individual Shark Participation

"""shark_columns = [
    'Ashneer_Deal',
    'Anupam_Deal',
    'Aman_Deal',
    'Namita_Deal',
    'Vineeta_Deal',
    'Peyush_Deal',
    'Ghazal_Deal'
]

shark_investments = df[shark_columns].sum().sort_values(ascending=False)
shark_investments 
"""

"""##Visualization
shark_investments.plot(kind='bar')
plt.title("Number of Deals per Shark")
plt.ylabel("Total Deals")
plt.show() """

#10. Deal vs No Deal Comparison

deal_comparison = df.groupby('deal')[[
    'pitcher_ask_amount',
    'ask_equity',
    'ask_valuation'
]].mean()
deal_comparison

##Visualization
deal_comparison.T.plot(kind='bar')
plt.title("Deal vs No Deal Comparison (Ask Metrics)")
plt.xticks(rotation=0)
plt.show()

#11. Valuation Drop Percentage (Negotiation Power)

##Create a new feature
df['valuation_drop_%'] = (
    (df['ask_valuation'] - df['deal_valuation'])
    / df['ask_valuation']
) * 100

##Now analyze only successful deals
df[df['deal'] == 1]['valuation_drop_%'].describe()

##Visualization
df[df['deal'] == 1]['valuation_drop_%'].plot(kind='hist', bins=20)
plt.title("Distribution of Valuation Drop % (Successful Deals)")
plt.xlabel("Valuation Drop %")
plt.show()

#12. Equity Increase Percentage (Founder Dilution)

df['equity_increase_%'] = (
    (df['deal_equity'] - df['ask_equity'])
    / df['ask_equity']
) * 100

##Analyze
df[df['deal'] == 1]['equity_increase_%'].describe()

##Visualization
df[df['deal'] == 1]['equity_increase_%'].plot(kind='hist', bins=20)
plt.title("Equity Increase % After Negotiation")
plt.xlabel("Equity Increase %")
plt.show()

#13. Sharks vs Deal Amount (Investor Confidence Effect)

shark_vs_amount = df[df['deal'] == 1].groupby(
    'total_sharks_invested'
)['deal_amount'].mean()

shark_vs_amount

##Visualization
shark_vs_amount.plot(kind='bar')
plt.title("Average Deal Amount vs Number of Sharks")
plt.xlabel("Total Sharks Invested")
plt.ylabel("Average Deal Amount")
plt.show()

#14. High vs Low Valuation Success Rate

##Split by median valuation:
median_val = df['ask_valuation'].median()

df['valuation_category'] = df['ask_valuation'].apply(
    lambda x: 'High' if x > median_val else 'Low'
)

valuation_success = df.groupby('valuation_category')['deal'].mean() * 100
valuation_success

##Visualization
valuation_success.plot(kind='bar')
plt.title("Deal Success Rate: High vs Low Ask Valuation")
plt.ylabel("Success Rate (%)")
plt.show()

#15. Correlation Focused on Deal Metrics

important_cols = [
    'pitcher_ask_amount',
    'ask_equity',
    'ask_valuation',
    'deal_amount',
    'deal_equity',
    'deal_valuation',
    'total_sharks_invested'
]

##Visualization
sns.heatmap(df[important_cols].corr(), annot=True)
plt.title("Correlation Between Key Financial Metrics")
plt.show()

#16. Outlier Analysis (Big Deal)

df[df['deal_amount'] > df['deal_amount'].quantile(0.95)][
    ['deal_equity', 'deal_amount', 'total_sharks_invested']
]

