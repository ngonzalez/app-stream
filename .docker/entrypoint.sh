#!/usr/bin/env bash
set -e

function usage {
    echo "usage: entrypoint.sh [--server|--help]"
}

function start_puma {
    systemctl start puma
    systemctl start sidekiq
}

if [ "$1" != "" ]; then
    case $1 in
        -s | --server )   start_puma
                          exit
                          ;;
        -h | --help )     usage
                          exit
                          ;;
    esac
    shift
fi

exec "$@"
