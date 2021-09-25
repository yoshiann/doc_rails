#!/bin/bash
set -e

rm -f /doc_rails/tmp/pids/server.pid

exec "$@"