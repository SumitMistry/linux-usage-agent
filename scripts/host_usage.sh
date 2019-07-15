#!/bin/bash

# constructing user arguments into variables
arg_psql_host=$1
arg_psql_port=$2
arg_db_name=$3
arg_psql_user=$4
arg_psql_password=$5


# step-1 parsing host hardware info using bash cmd/script/functions

timestamp=$(echo $(vmstat -dt) | awk '{print $28 " " $29}')
diskmb_avail=$(df -BM | head -2 | tail -1 | awk '{print $4+0}')
no_disk_io=$(echo $(vmstat -dt) | awk '{print $26}')
memory_free=$(vmstat -S M | tail -1 | awk '{print $4}')
cpu_kernel=$(vmstat -w | tail -1 | awk '{print $14}')
cpu_ideal=$(vmstat -w | tail -1 | awk '{print $15}')
idhost=$(cat ~/variable_host_id)


# Step-2 constructing insert statement

set_insert_data=$(cat <<-END
INSERT into host_usage ("timestamp", host_id, memory_free,cpu_ideal, cpu_kernel, disk_io, disk_available) values ('$timestamp', $idhost, $memory_free,  $cpu_ideal,  $cpu_kernel, $no_disk_io, $diskmb_avail ) ;
END
)

# step-3 executing insert statement

export PGPASSWORD=$arg_psql_password
psql -h $arg_psql_host -p $arg_psql_port -U $arg_psql_user -d $arg_db_name -c "$set_insert_data"
sleep 1


#end of the script
