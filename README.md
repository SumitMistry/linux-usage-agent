## Introduction
What does this project do?

Cluster Monitor Agent is an internal tool that monitors the cluster/server/node resources availability and its usage, its also useful to track and save data into database into a server. It helps the infrastructure team to keep track of the hardware specifications and resource usages of a Linux cluster.

## Design and Architecture
1) Design and Implementation
![caption](https://github.com/sumitJRVS/linux-usage-agent/blob/master/Diagram.jpg)

2) scripts; `host_info` is collecting the hardware information of Linux system /server a once. `host_usage` is collecting the server usage and perfmoance abiity over the period of time. `host_info.sh` script executes and insert the information into the table name `host_info`. `host_usage.sh` script executes and insert the CPU activity usage into table name `host_usage`. The last `init.sql` creates the file databse and creates the tables. It also create and strcture the DDL schema into the table

## Usage
1) How to init database and tables
   File `init.sql` contains script for table initialization, but for the db init need to create posrtgresql db and run via docker.  `psql -h localhost -U postgres -W host_agent -f init.sql to execute init.sql`

2) `host_info.sh` usage
   `host_info.sh` is used to collection CPU parameters and parsing it to the insert table query to make db. It makes table name           
   `host_info`  `bash host_info.sh psql_host psql_port db_name psql_user psql_password`

3) `host_usage.sh` usage
    `host_usage.sh` is used to collect CPU/RAM/Storage etc HW resources from  server and insert to the table `host_usage`
    `bash host_usage.sh psql_host psql_port db_name psql_user psql_password`

4) Scheduler setup using command crontab
     crontab is used to setup scheduled event command script for us automatically defined on period range from seconds, day, months etc. eg: every minute run is defined by:
     `crontab setup: * * * * * /home/centos/dev/jrvs/bootcamp/host_agent/scripts/host_usage.sh localhost 5432 host_agent postgres password > /tmp/host_usage.log`


## Improvements
Things has been improved so far in this projects:
1) Handle hardware updates (System configuration)
2) Instruction on crontab (scheduler job)
3) README.md updated

`End of README.MD`



