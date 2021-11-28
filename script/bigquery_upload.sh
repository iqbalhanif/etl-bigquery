#!/usr/bin/env bash
##remove and upload data into google cloud

gsutil rm -r gs://blankspace89783/financial
gsutil cp -r /home/iqbal/financial  gs://blankspace89783/financial

##remove and create dataset

bq rm -r -f -d financial
bq --location=US mk -d --description "This is financial dataset." financial

##load to bigquery

bq load --skip_leading_rows=1 --source_format=CSV --field_delimiter=tab financial.account gs://blankspace89783/financial/account.tsv account_id:INTEGER,district_id:INTEGER,frequency:STRING,date:DATE 
bq load --skip_leading_rows=1 --source_format=CSV --field_delimiter=tab financial.card gs://blankspace89783/financial/card.tsv card_id:INTEGER,disp_id:INTEGER,type:STRING,issued:DATE 
bq load --skip_leading_rows=1 --source_format=CSV --field_delimiter=tab financial.client gs://blankspace89783/financial/client.tsv client_id:INTEGER,gender:STRING,birth_date:DATE,distric_id:INTEGER
bq load --skip_leading_rows=1 --source_format=CSV --field_delimiter=tab financial.disp gs://blankspace89783/financial/disp.tsv disp_id:INTEGER,client_id:INTEGER,account_id:INTEGER,type:STRING
bq load --skip_leading_rows=1 --source_format=CSV --field_delimiter=tab financial.district gs://blankspace89783/financial/district.tsv district_id:INTEGER,A2:STRING,A3:STRING,A4:INTEGER,A5:INTEGER,A6:INTEGER,A7:INTEGER,A8:INTEGER,A9:INTEGER,A10:FLOAT,A11:INTEGER,A12:STRING,A13:FLOAT,A14:INTEGER,A15:STRING,A16:INTEGER 
bq load --skip_leading_rows=1 --source_format=CSV --field_delimiter=tab financial.loan gs://blankspace89783/financial/loan.tsv loan_id:INTEGER,account_id:INTEGER,date:DATE,amount:INTEGER,duration:INTEGER,payments:FLOAT,status:STRING
bq load --skip_leading_rows=1 --source_format=CSV --field_delimiter=tab financial.trans gs://blankspace89783/financial/trans.tsv trans_id:INTEGER,account_id:INTEGER,date:DATE,type:STRING,operation:STRING,amount:INTEGER,balance:INTEGER,k_symbol:STRING,bank:STRING,account:INTEGER
