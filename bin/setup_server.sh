#!/bin/bash

set -e

#run postgres
export PGPASSWORD="$DATABASE_PASSWORD"
until psql -h "$DATABASE_HOST" -p "$DATABASE_PORT" -U "$DATABASE_USERNAME" postgres -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"

if [[ $@ == 'app' ]]; then
  echo "Application Going to Start"
  rake db:create
  rake db:migrate
  rails s -p 3000 -b 0.0.0.0
fi

exec "$@"
