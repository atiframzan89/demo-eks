#!/bin/sh
set -x
sudo yum install mysql telnet -y

# load the properties:
# . ./dbconfig.properties

#Replace namespace placeholder
if [ "${db-namespace}" != "${db-namespace}" ] && [[ ${db-namespace} = *[!\ ]* ]]; then
  namespace_db_name=${db-namespace}"_sequent_dsp"
  sed -i "s/sequent_dsp/$namespace_db_name/g" 0_cleanUp.sql
  sed -i "s/sequent_dsp/$namespace_db_name/g" 1_DDL_sequent_dsp.sql
fi


# read provided password
param="$1"

# check whether password is not empty
if [[ $param = *[!\ ]* ]]; then
  db_password="$param"
else
  echo "Enter Password:"
  read db_password
fi

echo "Creating database..."

mysql -h ${rds-endpoint} -P ${rds-port} -u "${rds-username}" "-p${rds-password}" < /home/ec2-user/ec2-user

echo "Successfully completed..."