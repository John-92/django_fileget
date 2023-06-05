FROM python:3.6-alpine
ENV PYTHONUNBUFFERED=1
ENV TZ "Asia/Shanghai"
COPY pip.conf /root/.pip/pip.conf                                                                                                                                                                                                                                                                                                       
COPY . /var/www/html/fileget/
WORKDIR /var/www/html/fileget
#apk add --no-cache会下载索引文件 bzip2-dev openssl-dev ncurses-dev sqlite-dev readline-dev tk-dev 不需要
RUN apk add --no-cache   gcc make libc-dev linux-headers  pcre-dev \
   && pip install -r requirements.txt 

CMD chmod +x ./start.sh  && ./start.sh && tail -f /tmp/fileget-uwsgi.log  

