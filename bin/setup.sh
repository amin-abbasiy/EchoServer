#!/bin/bash

set -e


echo "Please Fill Database Information"

read -p 'Host:' host
read -p 'Port:' port
read -p 'Username:' username
read -p 'Password :' password


export DATABASE_HOST=$host
export DATABASE_PORT=$port
export DATABASE_USERNAME=$username
export DATABASE_PASSWORD=$password

#run postgres
until PGPASSWORD="$DATABASE_PASSWORD" psql -h "$DATABASE_HOST" -p $DATABASE_PORT -U "$DATABASE_USERNAME" postgres -c '\l';
do
  >&2 echo "Postgres is unavailable - Sleeping"
  sleep 1
done

>&2 echo "Postgres is up - Executing command"

if [[ $@ == 'app' ]]; then
  echo "Application Going to Start"
  rake db:create
  rake db:migrate
  rake db:seed
  rails s -p 3000 -b 0.0.0.0
fi
