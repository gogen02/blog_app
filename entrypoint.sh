#!/bin/bash

echo "Making migrations..."
python manage.py migrate

echo "Collecting static..."
python manage.py collectstatic --noinput

echo "Creating superuser..."
python manage.py createsuperuser \
    --username=$DJANGO_SUPERUSER_USERNAME --noinput \
    --email=$DJANGO_SUPERUSER_EMAIL \
    || true

gunicorn blog_project.wsgi:application --bind $API_HOST:$API_PORT --log-level INFO
