# cf api https://api.jtest.suse.com --skip-ssl-validation

# cf auth cf-admin


# 1. Create Org and Space

# cf create-org org1
# cf create-space -o org1 space1
# cf target -o org1 -s space1


# 2. Distribute Application

# git clone https://github.com/sylvainkalache/sample-web-apps

# cd sample-web-apps/java

# cf push java1

# 3. Check Application
# Access Application Deployed

# curl --insecure https://java1.apps.jtest.suse.com
# Hello, World!
# Java Version: 17.0.10


# Check additional information of application as below

# Check the list of appilcationed distributed by cf
# cf a
# Getting apps in org org1 / space space1 as cf-admin...
# name    requested state   processes                               routes
# java1   started           web:1/1, executable-jar:0/0, task:0/0   java1.apps.az1.sysdocu.kr

# check the detailed information of the specific application

# cf app java1
# Showing health and status for app java1 in org org1 / space space1 as cf-admin...

# name:              java1
# requested state:   started
# routes:            java1.apps.jtest.suse.com
# last uploaded:     Fri 16 Feb 07:13:55 UTC 2024
# stack:             io.buildpacks.stacks.bionic
# buildpacks:        


# type:           web
# sidecars:       
# instances:      1/1
# memory usage:   1024M
#     state     since                  cpu    memory   disk     logging      details
# 0   running   2024-02-16T07:45:20Z   0.0%   0 of 0   0 of 0   0/s of 0/s   


# type:           executable-jar
# sidecars:       
# instances:      0/0
# memory usage:   1024M
# There are no running instances of this process.


# type:           task
# sidecars:       
# instances:      0/0
# memory usage:   1024M
# There are no running instances of this process.
