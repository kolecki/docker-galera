FROM oberthur/docker-ubuntu:latest
MAINTAINER Krzysztof Olecki <k.olecki@oberthur.com>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN apt-get install software-properties-common \
 && apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 \
 && add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mariadb.kisiek.net/repo/10.1/ubuntu xenial main' \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8507EFA5 \ 
 && add-apt-repository 'deb http://repo.percona.com/apt xenial main'
# && add-apt-repository ppa:vbernat/haproxy-1.7
  
RUN mkdir /scripts

COPY files/docker-entrypoint.sh /scripts/docker-entrypoint.sh
COPY files/galera.cnf_template /scripts/galera.cnf_template
COPY files/galera_init_conf.tgz /scripts/
COPY files/init_db.sh /scripts/
COPY files/backup.sh /scripts/

RUN apt-get update \
 && apt-get upgrade 
RUN apt-get install -y mariadb-server percona-xtrabackup-24
# && apt-get install haproxy \
# && apt-get install keepalived 

RUN rm /etc/mysql/conf.d/mariadb.cnf /etc/mysql/conf.d/tokudb.cnf \
 && chown -R mysql: /var/lib/mysql \
 && chown -R mysql: /var/log/mysql \
 && chown -R root: /scripts \
 && chmod +x /scripts/docker-entrypoint.sh \
 && chmod +x /scripts/backup.sh \
 && chmod +x /scripts/init_db.sh 

#EXPOSE 3306

ENTRYPOINT ["sh","/scripts/docker-entrypoint.sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]

