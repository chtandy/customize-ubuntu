FROM ubuntu:20.04
MAINTAINER cht.andy@gmail.com

# 替換dash > bash
RUN mv /bin/sh /bin/sh.old && ln -s /bin/bash /bin/sh

# 安裝 supervisor 並設置 /etc/supervisor/conf.d/supervisord.conf 
RUN set -eux \
  && echo "######### apt install supervisor ##########" \
  && apt-get update && apt-get install --assume-yes supervisor bash-completion \ 
  && rm -rf /var/lib/apt/lists/* && apt-get clean \ 
  && { \
     echo "[supervisord]"; \
     echo "nodaemon=true"; \
     echo "logfile=/dev/null"; \
     echo "logfile_maxbytes=0"; \
     echo "pidfile=/tmp/supervisord.pid"; \
     } > /etc/supervisor/conf.d/supervisord.conf


# 安裝 vim 並設置 /etc/vim/vimrc
RUN set -eux \
  && echo "######### apt install vim ##########" \
  && apt-get update && apt-get install vim -y \
  && { \
     echo "set paste"; \
     echo "syntax on"; \ 
     echo "colorscheme torte"; \
     echo "set t_Co=256"; \
     echo "set nohlsearch"; \
     echo "set fileencodings=ucs-bom,utf-8,big5,gb18030,euc-jp,euc-kr,latin1"; \
     echo "set fileencoding=utf-8"; \
     echo "set encoding=utf-8"; \
     } >> /etc/vim/vimrc \
  && rm -rf /var/lib/apt/lists/* && apt-get clean

ENTRYPOINT ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
