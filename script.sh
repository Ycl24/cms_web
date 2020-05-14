#分支名称
branch_name='master'

#镜像前缀名称
images_name='cms_web'

#容器名称
con_name='cms_web_vue_app'

#dockerfile path  相对路径
dockerfile_path='Dockerfile'

#project path 项目路径 相对路径
project_path='/data/webroot/cms_web'

#webroot path 项目路径 相对路径
webroot_path='/data/webroot'

#script path 脚本 相对路径
script_path='/data/webroot/cms_web_script'

#prot  端口
prot='80:80'

#删除文件夹
rm -rf ${project_path}

cd ${webroot_path}
#不存在-拉去git项目
git clone https://github.com/Ycl24/cms_web.git

chmod -R 777 ${project_path}

cd ${project_path}

git checkout ${branch_name}

git pull origin ${branch_name}

#判断容器否存在
images_info=`docker ps -a | grep "${con_name}" `

if [[ "$images_info" != "" ]]
 then
    #容器存在
    #查询所有的容器，过滤出Exited状态的容器，列出容器ID，删除这些容器
    docker rm  -f `docker ps -a|grep ${con_name}|awk '{print $1}'`
 fi




#获取git项目最后的tag
tag_name=`git describe --tags \`git rev-list --tags --max-count=1\``

cd ${script_path}

#dockerfile打包生成镜像
docker build -f ${dockerfile_path} -t ${images_name}:${tag_name}  ${project_path}

#清理所有悬挂（<none>）镜像
docker rmi `docker images -f "dangling=true" -q`

docker run   --name ${con_name}   -d -p ${prot} -d ${images_name}:${tag_name} 

#在脚本目录下执行./