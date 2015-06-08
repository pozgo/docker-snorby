### Snorby Docker Image
[Docker Image](https://registry.hub.docker.com/u/polinux/snorby/) with Snorby using CentOS-7, Ruby on Rails, Daq and Snort.
Using ENV variable called `OINKCODE` this docker image can download rules provided for **registered** and **subscribed** users from [snort.org](https://www.snort.org).  

Snorby is build on `ruby-1.9.3-p551`, `daq-2.0.4` and `snort-2.9.7.0` using `community` rules.  

This container is built that any extra parameters provided to `docker run` will be passed directly to rails server command. For example, if you run `docker run [run options] polinux/snorby -e production` you pass `-e production` to rails server daemon.

### Database deployment 
To be able to connect to database we would need one to be running first. Easiest way to do that is to use another docker image. For this purpose we will use our [million12/mariadb](https://registry.hub.docker.com/u/million12/mariadb/) image as our database.

**For more information about million12/MariaDB see our [documentation.](https://github.com/million12/docker-mariadb) **

Example:  

    docker run \
    -d \
    --name snorby-db \
    -p 3306:3306 \
    --env="MARIADB_USER=snorbyuser" \
    --env="MARIADB_PASS=my_password" \
    million12/mariadb

### Environmental Variable
In this Image you can use environmental variables to connect into external MySQL/MariDB database.  

`DB_USER` = database user  
`DB_PASS` = database password  
`DB_ADDRESS` = database address (either ip or domain-name).

Snorby Config:  
`SNORBY_CONFIG=/usr/local/src/snorby/config/snorby_config.yml`  
If you mount your config to different location, simply edit it.

## Usage
### Basic

    docker run \
    -d \
    --name snorby \
    -p 3000:3000 \
    --env="DB_ADDRESS=database_ip" \
    --env="DB_USER=snorbyuser" \
    --env="DB_PASS=password" \
    polinux/snorby


### Mount custom config , override some options

    docker run \
    -d \
    --name snorby \
    -p 80:80 \
    --env="DB_ADDRESS=database_ip" \
    --env="DB_USER=snorbyuser" \
    --env="DB_PASS=password" \
    --env="OINKCODE=my_oinkcode" \
    -v /my-snorby-config.yml:/usr/local/src/snorby/config/snorby_config.yml \
    -v /my-email-settings.rb:/usr/local/src/snorby/config/initializers/mail_config.rb \
    polinux/snorby \
    -e development -p 80

### Rails Server CMD params
`rails server` command can be used with some parameters to define address and port on which rails server should work.  
Simple `--help` output below:

	Usage: rails server [mongrel, thin, etc] [options]
    -p, --port=port                  Runs Rails on the specified port.
                                     Default: 3000
    -b, --binding=ip                 Binds Rails to the specified ip.
                                     Default: 0.0.0.0
    -c, --config=file                Use custom rackup configuration file
    -d, --daemon                     Make server run as a Daemon.
    -u, --debugger                   Enable ruby-debugging for the server.
    -e, --environment=name           Specifies the environment to run this server under (test/development/production).
                                     Default: development
    -P, --pid=pid                    Specifies the PID file.
                                     Default: tmp/pids/server.pid

    -h, --help                       Show this help message.


### Access Snorby web interface
Visit your `snorby_ip:port` to access snorby interface and use default credentials:  
Username: **snorby@snorby.org**  
Password: **snorby**  

## Author
  
Author: Przemyslaw Ozgo (<linux@ozgo.info>)

---
