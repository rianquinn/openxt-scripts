#!/bin/bash

# Make sure that this script is run by root, otherwise it will not work. 
if [ “$(id -u)” != “0” ]; then
    echo ERROR: This script must be run as root!!! 2>&1
    exit 1
fi

# The following provides access to the same paths as a root user, so that you 
# are not constantly having to /sbin everything. Stupid Debian. 
sed -i.bak 's|/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games|/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games|g' /etc/profile
