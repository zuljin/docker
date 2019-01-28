FROM mysql:5.7

MAINTAINER zuljin8 kovkov@gmail.com

# docker run --name CONTAINER-NAME -e MYSQL_ROOT_PASSWORD=ROOT-PSW -d mysql:tag (TAG: mysql version)
# +info: https://hub.docker.com/_/mysql?tab=description
# | 5.7.24-0ubuntu0.18.04.1 |


RUN apt-get update && apt-get install -y wget \
	  apt-transport-https \
    lsb-release \
    ca-certificates \ 
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

RUN apt-get update && apt-get install -y \
    git \ 
    apache2 \
    composer \
    php7.2 \
    php7.2-common \       
    php7.2-cli \                                 
    php7.2-curl \    
    php7.2-fpm \                                                                                                                            
    php7.2-intl \                        
    php7.2-json  \   
    php7.2-mysql \                                                                                  
    php7.2-mongo \                                  
    php7.2-mongodb \                                  
    php7.2-xml \                                   
    php7.2-readline \                          
    php7.2-mbstring \
    php7.2-zip \
    curl \
    vim \ 
    #git clone XXXXXXXXX \
    #composer install \
  && rm -rf /var/lib/apt/lists/*

RUN php -v

COPY supervisord.conf /etc/supervisor/conf.d/supervisrod.conf
# COPY envvars /etc/apache2/envvars

RUN groupadd docker -g 1001
RUN useradd -u 1001 -g docker -d /bin/bash docker

CMD ["/usr/bin/supervisord"]

# CONFIG VHOST | MYSQL -> create user  | .env

# docker build -t name .  (donde esté dockerfile) (crear cuenta hub.docker.com)
# docker compose