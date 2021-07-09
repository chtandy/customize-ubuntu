FROM ubuntu:20.04
MAINTAINER cht.andy@gmail.com

RUN set -eux \
  && echo "######### apt install supervisor ##########" \
  && apt-get update && apt-get install --assume-yes supervisor bash-completion \ 
  && rm -rf /var/lib/apt/lists/* && apt-get clean \ 
  && echo \
"[supervisord] \n\
nodaemon=true \n\
logfile=/dev/null \n\
logfile_maxbytes=0 \n\
pidfile=/tmp/supervisord.pid" > /etc/supervisor/conf.d/supervisord.conf

RUN set -eux \
  && echo "######### apt install vim ##########" \
  && apt-get update && apt-get install vim -y \
  && echo \
"set paste \n\
syntax on \n\ 
colorscheme torte \n\
set t_Co=256 \n\
set nohlsearch \n\
set fileencodings=ucs-bom,utf-8,big5,gb18030,euc-jp,euc-kr,latin1 \n\
set fileencoding=utf-8 \n\
set encoding=utf-8" >> /etc/vim/vimrc \
  && rm -rf /var/lib/apt/lists/* && apt-get clean

ENTRYPOINT ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
