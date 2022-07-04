#!/usr/bin/env bash

./duckdb -c "install httpfs; load httpfs; select count(*) from parquet_scan('http://localhost:$PORT/yellow_tripdata_2019-01.parquet')"
