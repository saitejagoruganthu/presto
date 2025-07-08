#!/bin/sh

set -e

/usr/bin/telegraf &
/opt/presto/bin/launcher run