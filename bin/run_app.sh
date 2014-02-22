#!/bin/sh

if [ -t ./environment.sh ]; then
  source ./environment.sh
fi

bundle exec unicorn -c config/unicorn.conf
