#!/usr/bin/env bash
set -e

function usage {
    echo "usage: entrypoint.sh [--server|--help]"
}

function start_puma {
    su -c "bundle exec puma -e $RAILS_ENV -p $PUMA_PORT" $USER
}

function db_migrate {
    su -c "bundle exec rails db:create db:migrate" $USER
}

function rspec {
    su -c "bundle exec rspec --format progress --format RspecJunitFormatter --out rspec.xml" $USER
}

if [ "$1" != "" ]; then
    case $1 in
        -s | --server )   db_migrate
                          start_puma
                          exit
                          ;;
        -r | --rspec )    db_migrate
                          rspec
                          exit
                          ;;
        -h | --help )     usage
                          exit
                          ;;
    esac
    shift
fi

exec "$@"
