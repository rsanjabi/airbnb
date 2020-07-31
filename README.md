# Global Short-Term Rentals - a Data Warehouse and Dashboard

The global short-term rentals project is a full data pipeline and warehouse. A dashboard allows for the exploration of the impact of short-term rental listings (Airbnb) on housing. Data is pulled from three separate public datasets and consists of over 35 million records from 2015-2020. 
![Dashboard](img/dashboard.png)
## Architecture:
### Overview
* Python scripts perform API calls and web scraping for extraction and loading.
* Snowflake is used as a cloud-based data warehouse.
* DBT is used for transformations, data testing, and data documentation.
* X used for data visualizations.

### Data Sources
* Scraped data from:
  - [Inside Airbnb](http://insideairbnb.com/get-the-data.html). [CC0 1.0 Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/).
* Kaggle
  - [World Cities Population and Location](https://www.kaggle.com/i2i2i2/cities-of-the-world). CC0: Public Domain.
  - Kaggle [Cost of Living Indices](https://www.kaggle.com/debdutta/cost-of-living-index-by-country). Original source [Numbeo](https://www.numbeo.com/cost-of-living/rankings.jsp)

### ETL and Data Model
![Data Flow and Star Schema](img/data_flow.png)
### DBT Model DAG
![DBT Models Lineage Graph](img/dbt_dag.png)
### Visualization

## Environment Setup:
### To reproduce the warehouse, you will need to have these cloud-based accounts set up prior to running the remaining steps:
1. You will need to have a Kaggle account and authenticate using an API token. For more information, read Kaggle's [API documentation](https://www.kaggle.com/docs/api).
2. You will need a [Snowflake account](https://trial.snowflake.com/) with sysadmin privileges. They offer a 30-day trial with up to $400 in free usage. This project uses well under that, and no credit card is required until the limits are reached.

### To setup the warehouse:
1. Download the repository and create a virtual environment.
2. Install the required dependencies with `pip install -r requirements.txt`.
3. Copy .env.example to a file called .env at the root level of the project. Add in relevant Snowflake variables.
4. Run `python setup.py` to export credentials and other environment variables.

### Extract, load, and transform data:
1. Setup users, databases, and warehouses on Snowflake. Use `src/create_warehouse.sql` as a guide.
2. To extract datasets (scraping and API calls), run `python src/extract.py`. The script may take a few hours.
3. To load data, run `python src/load.py`. Again, depending on your connection, will take awhile.
4. To transform data, run `dbt run`.
5. To test your data, run `dbt test`.
6. To generate documentation, run `dbt docs generate`, and `dbt docs serve` for locally hosted documentation.

### Visualization:
1. Download and install [Metabase](https://www.metabase.com/start/) on the platform of your choice (I used Heroku).
2. Follow setup instructions for an admin user and add your Snowflake credentials.
3. Create a new dashboard.
4. Create questions for each card based on the files in `visualizations/`, adjusting the visualization component.

## Author:
A personal project by Rebecca Sanjabi.
