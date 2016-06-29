#!/bin/bash
LISTENERS_ORA=/u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora

cp "${LISTENERS_ORA}.tmpl" "$LISTENERS_ORA" &&
sed -i "s/%hostname%/$HOSTNAME/g" "${LISTENERS_ORA}" &&
sed -i "s/%port%/1521/g" "${LISTENERS_ORA}" &&

service oracle-xe start

if [ "$ORACLE_ALLOW_REMOTE" = true ]; then
  export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
  export PATH=$ORACLE_HOME/bin:$PATH
  export ORACLE_SID=XE
  echo "alter system disable restricted session;" | sqlplus -s SYSTEM/oracle
fi

echo "Do the dump magic..."
echo
echo "Unlock the HR user..."
echo "Create DUMP_DIR granted to HR user (@see DockerFile)...."
/u01/app/oracle/product/11.2.0/xe/bin/sqlplus "SYSTEM/oracle" @/usr/local/oracle/init.sql

echo "Import the DUMP..."
/u01/app/oracle/product/11.2.0/xe/bin/impdp C##DFOX/developer@localhost remap_schema=DFOX:c##DFOX directory=dump_dir dumpfile=dump_after_migration_fresh_config_v4.dmp NOLOGFILE=Y 
echo
