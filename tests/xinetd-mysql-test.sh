#!/bin/sh
#
# Simplified shell-based tests for the xinetd-mysql scripts.
#

set -e

no_such_uri_output=$(xinetd-mysql "/no-such-uri")
echo ${no_such_uri_output} | grep -q "Unexpected URI" || {
  echo "xinetd-mysql /no-such-uri failed"
  echo "output was:"
  echo "${no_such_uri_output}"
  exit 1
}

lag_output=$(xinetd-mysql "/check-lag")
echo ${lag_output} | grep -q "503; MySQL error" || {
  # Actually attempted to connect to MySQL, of course there isn't one in the testing environment
  echo "xinetd-mysql /check-lag failed"
  echo "output was:"
  echo "${lag_output}"
  exit 1
}

master_output=$(xinetd-mysql "/master")
echo ${master_output} | grep -q "404; Not a master" || {
  # Was looking for a /etc/xinetd-mysql/ master hint file. Of course it's not there in the testing environment
  echo "xinetd-mysql /master failed"
  echo "output was:"
  echo "${master_output}"
  exit 1
}

exit 0
