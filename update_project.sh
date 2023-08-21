#!/bin/bash

# get env data
source ".env"

cd $PATH_TO_REPO

# UPDATE
git fetch 
git checkout -b $BRANCH
git pull origin $BRANCH

set -e
source $PATH_TO_ACTIVATE

cd $PATH_TO_MANAGE

pip install -r requirements.txt

python3 manage.py migrate
python3 manage.py compilemessages

deactivate

service apache2 restart