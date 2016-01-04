#!/bin/bash
USER=${1:-weblogic}
PASS=${2:-Welcome1}
echo "****" Starting weblogic
weblogic/user_projects/domains/base_domain/startWebLogic.sh 2>&1 >/app/admin.log &
perl tailuntil.pl RUNNING admin.log
echo "****" Granting Permissions
weblogic/user_projects/domains/base_domain/wcsites/bin/grant-opss-permission.sh "$USER" "$PASS"
echo "****" Starting managed Sites
weblogic/user_projects/domains/base_domain/bin/startManagedWebLogic.sh wcsites_server1 t3://sites:7001 2>&1 >/app/managed.log &
perl tailuntil.pl RUNNING managed.log
