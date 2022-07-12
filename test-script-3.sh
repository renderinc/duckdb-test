#!/usr/bin/env bash

./duckdb -c "SELECT count(*) FROM read_parquet('yellow_tripdata_2019-01.parquet');"