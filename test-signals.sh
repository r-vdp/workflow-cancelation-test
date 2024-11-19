#!/usr/bin/env bash

_term() {
  echo "Caught SIGTERM signal!"

  echo "Passing signal to child process"
  #kill -TERM "$child" 2>/dev/null
}

_int() {
  echo "Caught SIGINT signal!"

  echo "Passing signal to child process"
  #kill -TERM "$child" 2>/dev/null
}

_other() {
  echo "Caught OTHER signal!"

  echo "Passing signal to child process"
  #kill -INT "$child" 2>/dev/null
}

_chld() {
  echo "Caught CHLD signal!"
  exit 0
}

echo "Installing signal handlers..."

trap _term SIGTERM
trap _int SIGINT

trap _other SIGHUP
trap _other SIGUSR1
trap _other SIGUSR2
trap _other SIGABRT
trap _other SIGQUIT
trap _other SIGPIPE

trap _chld SIGCHLD

echo "Done"

#terraform "$@" &
sleep 5000 &
child=$!
echo "Launched child, child pid: $child"

while true; do
  wait "$child"
done
