为n8n创建支持python环境的镜像
使用docker build命令创建镜像
例如docker build -t n8npython .

FROM n8nio/n8n:latest


# Install python3
USER root
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk add --update python3 py3-pip
RUN apk add  curl --no-cache && apk add bash --no-cache  && apk add bash --no-cache


USER node
RUN pip config set global.index-url http://mirrors.aliyun.com/pypi/simple/
RUN pip config set install.trusted-host mirrors.aliyun.com
RUN pip config set global.timeout 6000


RUN python3 -m pip install --user --break-system-packages pipx
RUN python3 -m pip install --user --break-system-packages pandas loguru requests toml tomli akshare mootdx baostock pillow

# Add the path of the pipx installation to PATH
ENV PATH="/home/node/.local/bin:$PATH"
