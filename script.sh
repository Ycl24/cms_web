#分支名称
branch_name='master'
#判断文件夹或文件是否存在
if [ ! -d "/cms_web/" ];then
  #不存在-拉去git项目
  git clone https://github.com/Ycl24/cms_web.git

  chmod -R 777 cms_web
  
fi


cd cms_web

git checkout ${branch_name}

git pull origin ${branch_name}

