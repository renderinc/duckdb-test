#!/usr/bin/env bash

./duckdb -c "install httpfs; load httpfs; select count(*) from parquet_scan('https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2019-01.parquet')"
