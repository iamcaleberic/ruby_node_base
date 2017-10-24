FROM ubuntu:xenial

# needed packages
RUN apt-get update -yqq && apt-get install -yqq build-essential libpq-dev curl dbus apt-utils libssl-dev sudo \
    libpng-dev libmysqlclient-dev wget pngquant liblcms2-2 nginx dirmngr gnupg apt-transport-https ca-certificates libpng16-16 \
    software-properties-common python-software-properties rubygems

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - &&  apt-get install -y nodejs

#yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

# libpng
# RUN wget http://sourceforge.net/projects/libpng/files/libpng16/1.6.32/libpng-1.6.32.tar.gz/download -O libpng.tar.gz && tar -xvf libpng.tar.gz && cd libpng-1.6.32 && bash configure --prefix=/usr --disable-static &&  make install

# rvm
RUN apt-add-repository -y ppa:rael-gc/rvm
RUN apt-get update
RUN apt-get install -y rvm

# ruby (2.4.2) && bundler
# RUN /bin/bash source /usr/share/rvm/scripts/rvm
RUN /bin/bash -l -c "rvm install 2.4.2"
RUN /bin/bash -l -c "rvm use --default 2.4.2"
RUN gem install bundler 

# passenger
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
RUN sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'
RUN apt-get update
RUN apt-get install -y nginx-extras passenger

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
