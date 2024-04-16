#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
time parallel ./load_denormalized.sh ::: $files

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time parallel python3 -u load_tweets.py --db=postgresql://postgres:pass@localhost:13511/ --inputs={} ::: $files

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time parallel python3 load_tweets_batch.py --db=postgresql://postgres:pass@localhost:13512/ --inputs={} ::: $files
