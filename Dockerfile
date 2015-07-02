FROM ubuntu:14:04
MAINTAINER Danielle Jenkins

# Based off of Moul's weechat container, but more up to date and with some changes for better practices.

ENV DEBIAN_FRONTEND=noninteractive TERM=screen-256color LANG=C.UTF-8

RUN apt-get update && \
    apt-get -qq -y install software-properties-common && \
    add-apt-repository ppa:nesthib/weechat-stable && \
    apt-get -qq -y update  && \
    apt-get -qq -y install weechat && \
    apt-get clean

RUN useradd -m -d /weechat weechat
ADD http://www.weechat.org/files/scripts/weeget.py /weechat/.weechat/python/
RUN mkdir -p /weechat/.weechat/python/autoload && \
    ln -s /weechat/.weechat/python/weeget.py /weechat/.weechat/python/autoload/weeget.py

#VOLUME ["/weechat"]

EXPOSE 8000 8001 8002

CMD ["/bin/bash"]
#chown -R weechat:weechat ~weechat
#su weechat -c weechat-curses
