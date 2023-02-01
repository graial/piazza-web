#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install 
bundle exec rake db:schema:load
bundle exec rake db:seed