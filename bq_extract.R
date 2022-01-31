
# store the project id
projectid = "source-data-314320"

# set your query
sql_Centro <- "SELECT *
        FROM `source-data-314320.Store_Data.All_Data`
        WHERE Owner = 'M&D'
          AND Tienda = 'Centro'
          AND product_type <> 'Aro'
          AND product_type <> 'Bisel'
          AND product_type <> 'Collar'
          AND product_type <> 'Varios'
          AND product_type <> 'Gargantilla'
          AND Date <= '2021-12-31'
        ORDER BY Date desc
"

# Run the query and store the data in a tibble
All_Data_Centro <- bq_project_query(projectid, sql_Centro)

BQ_Table_Centro <- bq_table_download(All_Data_Centro)

# Print first rows of the data
BQ_Table_Centro



# analyse the monthly sales trends. Transform the data set by aggregating by month.
sales_monthly_Centro <- BQ_Table_Centro %>%
  mutate(month = month(date, label = TRUE),
         year  = year(date)) %>%
  group_by(year, month) %>%
  summarise(total_sales = sum(sales))

sales_monthly_Centro