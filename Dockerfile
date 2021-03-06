    #-f 指定的dockerfile文件
    #-t 镜像名称和tag
    #../cms_web 工作目录
     #docker build -f Dockerfile -t cms_web:v1 ../cms_web

    #指定node镜像对项目进行依赖安装和打包
    FROM node  AS builder
    #docker打包vue build 镜像，把打包的镜像 放到 /usr/share/nginx/html/中
    # 将容器的工作目录设置为/
    #dockerfile 工作目录设置为/,不管在什么地方都设置/,再调用运行dockerfile时，加上运行目录
    WORKDIR /
    COPY package.json /
    #打包项目，重新安装npm并更新
    RUN npm config set registry "https://registry.npm.taobao.org/" \
      && npm install 
    COPY . /
    RUN npm run build 

     #指定nginx配置项目，--from=builder 指的是从上一次 build 的结果中提取了编译结果(FROM node:alpine as builder)，即是把刚刚打包生成的dist放进nginx中
    FROM nginx
    COPY --from=builder dist /usr/share/nginx/html/
 
 


