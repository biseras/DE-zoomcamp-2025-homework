import pandas as pd

from sqlalchemy import create_engine

db_url = "postgresql://bisera:bisera@localhost:5432/taxi_db"
engine = create_engine(db_url)
print(engine)

list = ["10", "11", "12"]
listj = ["2019", "2020"]
for i in list:
    for j in listj:
        file = "yellow_tripdata_" + j + "-" + i + ".parquet"
        df = pd.read_parquet("data/2019/yellow/" + file)

        df.to_sql('yellow_trip', engine, schema='taxi_homework', if_exists='append', index=False)
        print(file)

#yellow_tripdata_2019-09.parquet
# yellow_tripdata_2020-09.parquet
