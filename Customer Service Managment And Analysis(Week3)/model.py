import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, mean_squared_error
from sklearn.impute import SimpleImputer
from sklearn.ensemble import HistGradientBoostingRegressor

# Load data
sales = pd.read_excel('D:/CoUrSE/PRojEcT/Sales.xlsx')
products = pd.read_excel('D:/CoUrSE/PRojEcT/Products.xlsx')
time = pd.read_excel('D:/CoUrSE/PRojEcT/Time.xlsx')

# Merge sales with product and time dimensions
df_sales_product = pd.merge(sales, products, on='Product_ID')
df_sales_time = pd.merge(df_sales_product, time, on='Date_ID')

# Example feature engineering: Sales amount, product price, month, quarter
df_sales_time['Month'] = pd.to_datetime(df_sales_time['Transaction_Date']).dt.month
df_sales_time['Quarter'] = df_sales_time['Quarterr']

# Select features and target variable
X = df_sales_time[['Price', 'Month', 'Quarter']]
y = df_sales_time['Amount']

# Train-test split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

X_train.fillna(X_train.median(), inplace=True) #inplace null values by median
y_train.fillna(y_train.median(), inplace=True) #inplace null values by median

# Drop rows with missing values in both train and test sets
X_train = X_train.dropna()
y_train = y_train[X_train.index]

X_test = X_test.dropna()
y_test = y_test[X_test.index]

# Ensure X_test and y_test are clean and aligned
X_test = X_test[y_test.notna()]
y_test = y_test.dropna()

# Train a Random Forest Regressor
model = RandomForestRegressor(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# Make predictions
y_pred = model.predict(X_test)

# Evaluate the model
print("MAE:", mean_absolute_error(y_test, y_pred))
print("RMSE:", mean_squared_error(y_test, y_pred, squared=False))