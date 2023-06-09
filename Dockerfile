FROM python:3.6-alpine AS builder-image
LABEL AUTHOR="JOHN"
RUN python -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"
COPY pip.conf /root/.pip/pip.conf
COPY requirements.txt /var/www/html/fileget/requirements.txt
RUN apk add --no-cache   gcc make libc-dev linux-headers  pcre-dev \
   && pip install -r /var/www/html/fileget/requirements.txt
FROM python:3.6-alpine AS builder-run      
ENV PYTHONUNBUFFERED=1 TZ="Asia/Shanghai"
COPY pip.conf /root/.pip/pip.conf
# 自动在 容 器 内 /var/www/html/下 创 建  fileget 文 件 夹
COPY . /var/www/html/fileget/
COPY --from=builder-image /opt/venv /opt/venv
WORKDIR /var/www/html/fileget
#apk add --no-cache不进行缓存bzip2-dev openssl-dev ncurses-dev sqlite-dev readline-dev tk-dev 不需要
VOLUME [ "/var/www/html/fileget/img" ]#指定容器目录用来映射
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN apk add --no-cache  pcre-dev  
EXPOSE 8000/tcp
ENTRYPOINT [ "sh", "start.sh" ]
#ENTRYPOINT  [ "tail","-f","/tmp/fileget-uwsgi.log"  ]
#CMD chmod +x ./start.sh  && echo "1" && ./start.sh && tail -f /tmp/fileget-uwsgi.log
#CMD [ "chmod" ,"+x" ,"./start.sh" , "&&","./start.sh","&&", "tail","-f","/tmp/fileget-uwsgi.log" ]
