import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.pyplot import ylabel
from matplotlib.pyplot import title
from matplotlib.pyplot import xlabel
from matplotlib.pyplot import show
import seaborn as sns

df = pd.read_csv("netflix_titles.csv")
print(df)

df.info()

df.shape

df.columns

df.sample(10)

df.head()

df.tail()

df.describe()

df.describe(include="all")

df["director"].value_counts().head(10)

df["director"].value_counts().sum()

df["date_added"]=pd.to_datetime(df["date_added"], dayfirst=True, errors="coerce")
df.info()

print(df)

df.isna().sum()

df[["title", "cast"]].sort_values(by="cast",ascending=False).head(10)

df[["cast", "director"]].sort_values(by="cast",ascending=False).head(10)

y=df.pivot_table(index='type',columns='release_year',values='date_added',aggfunc=["count"])
print(y)

df["cast_count"] = df["cast"].fillna("").apply(lambda x: len(x.split(",")) if x != "" else 0)

sns.set_style("white-grid")

sns.histplot(data=df, x="cast_count", kde=True, color="blue", edgecolor="red")
xlabel("Number of Cast Members")
ylabel("Count of Movies/TV Shows")
title("Number of Cast Members per Movie/TV Show")
plt.show()

df.groupby("release_year")["title"].count().head()

x=df.pivot_table(index="release_year",columns="type",values="title",aggfunc="count")
print(x)

x.plot(kind="bar", figsize=(12,6))
plt.title("Movies vs TV Shows by Release Year")
plt.xlabel("Release Year")
plt.ylabel("Count")
plt.xticks(rotation=90)
plt.show()

r=df.pivot_table(index="type",values="cast",aggfunc=["count"])
print(r)

r["count"].plot(kind="bar", figsize=(6,4))
plt.title("Number of Titles by Type")
plt.xlabel("Type")
plt.ylabel("Number of Titles")
plt.xticks(rotation=0)
plt.show()

q=df.pivot_table(index="rating",columns="type",values="title",aggfunc="count")
print(q)

q.plot(kind="bar", figsize=(10,5))
plt.title("Number of Titles by Rating and Type")
plt.xlabel("Rating")
plt.ylabel("Count")
plt.xticks(rotation=45)
plt.show()

df.pivot_table(index="rating",columns="type",values="cast",aggfunc=["max","min"])

e=df.pivot_table(index="rating",columns="type",values="cast",aggfunc=["count"])
print(e)

e.plot(kind="line", figsize=(10,5), marker="o")
plt.title("Max and Min Cast Count by Rating and Type")
plt.xlabel("Rating")
plt.ylabel("Number of Cast Members")
plt.xticks(rotation=45)
plt.show()

