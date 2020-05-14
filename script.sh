#分支名称
branch_name='master'
#删除文件夹
rm -rf cms_web
#不存在-拉去git项目
git clone https://github.com/Ycl24/cms_web.git

chmod -R 777 cms_web

cd cms_web

git checkout ${branch_name}

git pull origin ${branch_name}

#删除docker 80 crm_web dist镜像

