#构建的镜像
FROM python:3.6-alpine AS builder-image
LABEL AUTHOR="JOHN"
#创建虚拟环境
RUN python -m venv /opt/venv
COPY pip.conf /root/.pip/pip.conf
ENV PATH="/opt/venv/bin:$PATH"
COPY requirements.txt /var/www/html/fileget/requirements.txt
RUN apk add --no-cache  gcc make libc-dev linux-headers  pcre-dev \
   && pip install -r /var/www/html/fileget/requirements.txt
#运行镜像 
FROM python:3.6-alpine AS builder-run      
ENV PYTHONUNBUFFERED=1 TZ="Asia/Shanghai"
COPY . /var/www/html/fileget/
#获取构建期间的依赖包（虚拟环境）
COPY --from=builder-image /opt/venv /opt/venv
WORKDIR /var/www/html/fileget
VOLUME [ "/var/www/html/fileget/img" ]#指定容器目录用来映射
# activate virtual environment激活虚拟环境，获取虚拟环境路径
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN apk add --no-cache  pcre-dev && chmod +x ./start.sh
EXPOSE 8000/tcp
#CMD   ./start.sh && tail -f /tmp/fileget-uwsgi.log
ENTRYPOINT [ "sh", "start.sh" ]