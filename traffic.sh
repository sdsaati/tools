#!/usr/bin/env bash
# Run below command for the first time to let your system
# can run nethogs without root access !
# ============================================================
# sudo setcap "cap_net_admin,cap_net_raw=ep" /usr/sbin/nethogs
# ============================================================
nethogs -l -v0 -c20 -t | head -30 | tail -15 | sed -e 's/Refreshing://mg' | sort | uniq | sed -e 's/^[\n\r\t ]*//mg'
