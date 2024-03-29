#!/usr/bin/env bash
set -eu

POSTGRES_USER=${POSTGRES_USER-postgres}

echo "Refreshing materialized views for database: $1"
for mat_view in `psql -U $POSTGRES_USER -d $1 -c "SELECT oid::regclass::text FROM pg_class where relkind='m'"   | tail -n +3 | head -n -2`
do
        refresh="REFRESH MATERIALIZED VIEW $mat_view"
        echo $refresh
        psql -U $POSTGRES_USER -d $1 -c "$refresh"
done
