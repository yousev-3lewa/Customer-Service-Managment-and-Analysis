import pandas as pd
from sqlalchemy import create_engine

# Step 1: Create a SQLAlchemy engine
conn_str = 'mssql+pyodbc:///?odbc_connect=' + 'DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost;DATABASE=customerDWH;Trusted_Connection=yes;'
engine = create_engine(conn_str)

# Step 2: Extract data from all tables using Pandas
customers_df = pd.read_sql('SELECT * FROM Customer_Dimension', engine)
products_df = pd.read_sql('SELECT * FROM Product_Dimension', engine)
time_df = pd.read_sql('SELECT * FROM Time_Dimension', engine)
sales_df = pd.read_sql('SELECT * FROM Sales_Fact', engine)

# Step 3: Data Preparation
def clean_dataframe(df):
    # Identify numeric and non-numeric columns
    numeric_columns = df.select_dtypes(include=['int64', 'float64']).columns
    non_numeric_columns = df.select_dtypes(exclude=['int64', 'float64']).columns
    
    # Handle missing values
    df[numeric_columns] = df[numeric_columns].fillna(df[numeric_columns].median())
    df[non_numeric_columns] = df[non_numeric_columns].fillna(df[non_numeric_columns].mode().iloc[0])
    
    # Remove duplicates
    df = df.drop_duplicates()
    
    return df

# Clean all dataframes
customers_df_cleaned = clean_dataframe(customers_df)
products_df_cleaned = clean_dataframe(products_df)
time_df_cleaned = clean_dataframe(time_df)
sales_df_cleaned = clean_dataframe(sales_df)

# Step 4: Merge dataframes
merged_df = pd.merge(sales_df_cleaned, customers_df_cleaned, on='Customer_ID', how='left')
merged_df = pd.merge(merged_df, products_df_cleaned, on='Product_ID', how='left')
merged_df = pd.merge(merged_df, time_df_cleaned, on='Date_ID', how='left')

# Step 5: Check the final merged data
print(merged_df.head())
print(merged_df.describe())
print(merged_df.isnull().sum())