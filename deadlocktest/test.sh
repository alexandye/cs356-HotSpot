#!/bin/sh

# Had to put testing into script because make doesn't keep the PID from the fork

rm -f dump.txt
java DeadlockTest >> dump.txt &
sleep 1
kill -3 $!
sleep 1
kill -9 $!
