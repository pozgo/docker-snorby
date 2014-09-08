### Snorby Docker Container.
This Container wads created for making or life with installation of Snorby much easier. Now we just need to run few commands and the whole Snorby based on Ruby on Rails will be created and configured inside this 
container. Pretty Easy setup.

Build on Snorby 2.6.2, Daq 2.0.2, Snort 2.9.6.2 

### MySQL Database configuration needed for Snorby.
Database is needed for Snorby to work properly. Same database can be user for barnyard2 to store data from snort log files. 
If you do not have running MySQL Database Server you can use my container that was prepared in Docker for this very purpose. 

MySQL Setup:

`CREATE DATABASE snorby;`

`GRANT ALL ON snorby.* to 'snorbyuser'@'%' IDENTIFIED BY 'password';`

`FLUSH PRIVILEGES;`

Make sure your server firewall is open for incoming connections to MySQL database.

#Download Snorby Container
`docker pull polinux/snorby:latest`

Run image and wait around 1 minute for inatller to finish setting up the server

`docker run -d --name db --net host polinux/snorby:latest`

Docker container should be running and in 1 minute you will be able to acces it through your server ip address and port 3000.
FYI - Make sure that firewall is accepting connections on port 3000. 

Access through: snorby.server.address:3000 (localhost:3000).

Login details are as follows:
> login:  snorby@snorby.org

> pass;   snorby

