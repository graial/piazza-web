#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install 
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rake db:schema:load
bundle exec rake db:seed