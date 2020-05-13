    #指定node镜像对项目进行依赖安装和打包
    FROM node AS builder
    # 将容器的工作目录设置为/app(当前目录，如果/app不存在，WORKDIR会创建/app文件夹)
    WORKDIR /
    COPY package.json /
    RUN npm config set registry "https://registry.npm.taobao.org/" \
        && npm install

    COPY . /
    RUN npm run build

    # 设置基础镜像 nginx是环境加载的镜像，可以通过 docker images 查看当前的镜像REPOSITORY
    FROM nginx
    # 定义作者
    MAINTAINER heetrance <516003013@qq.com>
    # 将当前目录data/html/文件中的内容复制到 /usr/share/nginx/html/ 这个目录下面
    COPY dist/  /usr/share/nginx/html/
    #用本地的 default.conf 配置来替换nginx镜像里的默认配置
    COPY ../config/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf


