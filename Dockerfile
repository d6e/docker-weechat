FROM ubuntu:14.04
MAINTAINER Danielle Jenkins

# Based off of Moul's weechat container, but more up to date and with some changes for better practices.

ENV DEBIAN_FRONTEND=noninteractive TERM=screen-256color LANG=C.UTF-8

RUN apt-get update && \
    apt-get -qq -y install software-properties-common && \
    add-apt-repository ppa:nesthib/weechat-stable && \
    apt-get -qq -y update  && \
    apt-get -qq -y install weechat && \
    apt-get -qq -y install tmux && \
    apt-get clean

ENV WEECHAT_HOME=/opt/weechat
RUN useradd weechat #&& mkdir -p $WEECHAT_HOME && chown -R weechat:weechat $WEECHAT_HOME

ADD http://www.weechat.org/files/scripts/weeget.py $WEECHAT_HOME/python/
RUN mkdir -p $WEECHAT_HOME/python/autoload && \
    ln -s $WEECHAT_HOME/python/weeget.py $WEECHAT_HOME/python/autoload/weeget.py

EXPOSE 8000 8001 8002

USER weechat
CMD ["/usr/bin/tmux", "new", "-s", "weechat", "'/usr/bin/weechat-curses'"]
