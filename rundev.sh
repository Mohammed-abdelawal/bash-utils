#!/bin/bash
source ".env"

set -e
source $PATH_TO_ACTIVATE

cd $PATH_TO_MANAGE

# i used 0.0.0.0 because i run it on vps
python3 manage.py runserver 0.0.0.0:8000

