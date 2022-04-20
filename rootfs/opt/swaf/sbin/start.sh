#!/bin/sh -vx
# sWAF - A simple Web Application Firewall
# Copyright (C) 2020  styx0x6 <https://github.com/styx0x6>

# This file is part of sWAF. This software is licensed under the
# European Union Public License 1.2 (EUPL-1.2), published in Official Journal
# of the European Union (OJ) of 19 May 2017 and available in 23 official 
# languages of the European Union.
# The English version is included with this software. Please see the following
# page for all the official versions of the EUPL-1.2:
# https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12


# Show header
cat /etc/motd

# Deploy /etc/nginx after potentially mounted volume
if [[ $(cat /opt/swaf/SWAF_IS_SET) == 0 ]]; then
    echo "+ Deploying sWAF configuration..."
        tar xz -f /opt/swaf/swaf_def_cnf_bck.tar.gz -C /etc/nginx
    echo "+ Generating DH parameters for DHE ciphers..."
        libressl dhparam -out /etc/ssl/dhparams.pem -dsaparam 4096
    echo "+ Configuring container..."
        echo "1" > /opt/swaf/SWAF_IS_SET
fi

# Let's go
echo "+ Starting sWAF..."
/usr/sbin/nginx -g 'daemon off;'
