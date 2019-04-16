#%%
import pandas as pd
import numpy as np 
import matplotlib.pyplot as plt
#%%
df = pd.read_csv("./umbc-cs-projects/umbc-cs491-data-science/hw/hw3/sklearn/salaryData.csv")
X = df["YearsExperience"]
X = np.array(X).reshape(-1, 1)
y = df["Salary"]
y = np.array(y)
#%%
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
#%%
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=.33, random_state=42)
model = LinearRegression().fit(X_train, y_train)
y_pred = model.predict(X_test)
#%%
print(f"MSError: {mean_squared_error(y_test, y_pred)}")
y_loss = y_test - y_pred
print(y_loss)
#%%
plt.scatter(X_test, y_test, color='yellow')
plt.plot(X_test, y_pred, color='blue', linewidth=3)
plt.show()