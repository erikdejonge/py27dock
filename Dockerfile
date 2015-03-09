FROM google/debian:wheezy
RUN apt-get update -y && apt-get install --no-install-recommends -y -q build-essential python2.7 python2.7-dev python-pip git
RUN pip install -U pip
RUN pip install virtualenv
ADD requirements.txt /
ADD Dockerfile /
RUN easy_install -U distribute
RUN pip install -r /requirements.txt