# ETL for Big Query

This is etl script for bigquery, consists of 2 type of etl:
1. MySQL DB to Big Query dataset
2. Big Query dataset to Big Query dataset

## Tools:
1. Google Cloud Platform (GCP) including: <br />
  · GCP Bucket/Cloud Storage <br />
  · GCP BigQuery <br />
2. Airflow
3. MySQL client
4. Google SDK
5. Python
6. Ubuntu (OS)

## Dataset:
1. Financial dataset (MySQL)
2. Google Analytics dataset (Big Query)

## Setup
1. For Airflow (local) setup on Windows you can read [here](https://github.com/iqbalhanif/airflow-etl-local)
2. For GCP Service Account & Project setup you can read [here](https://github.com/iqbalhanif/airflow-etl-gcp)
3. For Google SDK setup you can read [here](https://github.com/iqbalhanif/ge-data-quality)

## Task 1: From MySQL DB to Big Query Dataset
1. Create Airflow variables to store confidential information such as MySQL connection properties: <br />
   · Host <br />
   · User <br />
   · Password <br />
   · Database name <br />
   · Path <br />
2. Create code/script for extracting MySQL Data (into .tsv format)
3. Upload extracted data into google cloud storage (bucket)
4. Create Big Query dataset and import data from bucket
You can see the script in /script/mysql_extract.sh and /script/bigquery_upload.sh
![image](https://user-images.githubusercontent.com/18484807/143805505-64ec3004-314a-4db7-8c49-bde5dd5c9522.png)


## Task 2: From Big Query Dataset to Big Query Dataseet
1. Search big query public dataset bigquery-public-data.ga4_obfuscated_sample_ecommerce
2. Create query for extracting this column on 'event' table: <br />
   · event_date <br />
   · event_date_partition -> formatted result from “event_date” column to YYYY-MM-DD  <br />
   · event_params.key: page_title & page_location <br />
   · user_pseudo_id <br />
   · event_date <br />
   · device: category & mobile_brand_name <br />
   · user_first_touch_timestamp  <br />
   · user_first_touch_at -> converted result from “user_first_touch_timestamp” column to YYYY-MM-DD HH:mm:ss <br />
   · user_ltv -> filter the revenue properties to greater than zero (> 0) <br />
   · geo -> filter the continent properties to match “Asia” only <br />
   · stream_id <br />
   · traffic_source -> filter the medium properties to “organic” only <br />
3. Set option for dataset location, standard SQL (instead of legacy SQL), and partition
You can see the script in /script/bq_to_bq.sh
![image](https://user-images.githubusercontent.com/18484807/143805624-ed7c06e5-bd84-45ad-a049-fd4c93e4dec0.png)


## Airflow dags
You can see the script in /dags/bigquery_etl.py

![image](https://user-images.githubusercontent.com/18484807/143805147-766e7a98-c791-4a06-b31d-ed2b05b6339d.png)

![image](https://user-images.githubusercontent.com/18484807/143805178-e9f34ff0-ddcf-4c28-9ec9-7c045cfa8a92.png)
