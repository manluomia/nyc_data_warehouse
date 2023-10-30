import duckdb

con = duckdb.connect(database='main.db')
result = con.execute("SHOW TABLES").fetchall()

for table in result:
    table_name = table[0]
    print(f"Table Name is {table_name}")
    count = con.execute(f"SELECT count(*) FROM {table_name}").fetchall()
    number = count[0][0]
    print(f"The Table has {number} number of rows ")


#python3 scripts/dump_raw_counts.py -> answers/raw_counts.txt