from ubuntu:14.04

maintainer Mads Weitling

run echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
#run perl -p -i.orig -e 's/archive.ubuntu.com/mirrors.aliyun.com\/ubuntu/' /etc/apt/sources.list
run apt-get update
run apt-get install -y build-essential git
run apt-get install -y python python-dev python-setuptools
run apt-get install -y software-properties-common python-software-properties
run apt-get install -y python-pip
run apt-get install -y nginx supervisor

# install uwsgi now because it takes a little while
run pip install uwsgi

# install nginx
run apt-get update
run add-apt-repository -y ppa:nginx/stable
run apt-get install -y sqlite3

# install our code
add . /home/docker/code/

# setup all the configfiles
run echo "daemon off;" >> /etc/nginx/nginx.conf
run rm /etc/nginx/sites-enabled/default
run ln -s /home/docker/code/nginx-app.conf /etc/nginx/sites-enabled/
run ln -s /home/docker/code/supervisor-app.conf /etc/supervisor/conf.d/

# run pip install
run pip install -r /home/docker/code/app/requirements.txt

expose 80
cmd ["supervisord", "-n"]
