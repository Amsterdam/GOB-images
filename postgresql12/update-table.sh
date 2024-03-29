#!/usr/bin/env bash

# Extract tables from a large dump. Then we need multiple tables
# so we do NOT DELETE the downloaded dump

set -eu
set -x

echo "Downloading $1 extracting table $2 from schema $3 into $4 as user X"

if [ $# -eq 4 ]; then
    download-db.sh $1
elif [ $# -eq 5 ]; then
    download-db.sh $1 $5
else
    echo "Too many arguments or incorrect parameters. Please see the README for proper usage.";
fi

POSTGRES_USER=${POSTGRES_USER-postgres}

createuser -U $POSTGRES_USER $4 || echo "Could not create $4, continuing"

SECONDS=0

pg_restore -U $POSTGRES_USER -c --if-exists --no-acl --no-owner --table=$2 --schema=$3 --file $2_table.pg /tmp/$1_latest.gz

echo "CREATE SCHEMA IF NOT EXISTS $3;" | psql -U $POSTGRES_USER -d $4

echo "Extracting table $2 into $4"
# Download table
psql -v ON_ERROR_STOP=1 -U $POSTGRES_USER $4 < $2_table.pg


echo "Finished pg_restore $1 table $2 into $4"

duration=$SECONDS

echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."

# DO NOT DELETE THE DOWNLOADED DATABASE
# rm -f $1_latest.gz
rm -f $2_table.pg
