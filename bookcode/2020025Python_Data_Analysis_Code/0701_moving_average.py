import matplotlib.pyplot as plt 
import statsmodels.api as sm 
# from pandas.stats.moments import rolling_mean「rolling_mean has been removed in the new version」
import pandas as pd 

data_loader = sm.datasets.sunspots.load_pandas()
df = data_loader.data 
year_range = df["YEAR"].values

plt.plot(year_range, df["SUNACTIVITY"].values, label="Original")
# plt.plot(year_range, pd.rolling_mean(df, 11)["SUNACTIVITY"].values, label="SMA 11")「the style of old version」
plt.plot(year_range, df.rolling(window=11,center=False).mean()["SUNACTIVITY"].values, label="SMA 11")
plt.plot(year_range, df.rolling(window=22,center=False).mean()["SUNACTIVITY"].values, label="SMA 22")
plt.legend()
plt.show()