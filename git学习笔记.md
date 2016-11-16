### Git初始化

#### 4.1 创建版本库及第一次提交

查看git版本：`git --version`

在开始使用git之前，需要配置一下git的变量

    1. 告诉git当前用户的姓名和邮件
        git config --global user.name 'Your Name'
        git config --global user.email 'You Email'
    
    2. 设置一些git的别名
        git config --system alias.st status
        git config --system alias.ci commit
        
    3. 在git命令输出中开启颜色显示
        git config --global color.ui true
        

   隐藏的.git目录就是git的版本库，又叫仓库，.git版本库所在的目录为工作区
   
三种状态

已提交：意味着数据安全的存储在你本地的数据库

已修改：意味着你已经改变了文件但还没有提交到你的数据库

已暂存： 意味着你已经标记了一个已修改的文件到你当前的版本，准备到你下一次提交的快照

Git项目分成了三个部分
git版本库： 存储你的项目的元数据和对象的数据库，这是git最重要的部分
工作区： 你的项目的版本的一个单独版本
暂存区： 是一个文件，被包含在你的git版本库，存储关于你下次提交的信息，有时候也要索引，但更常用的是指暂存区域

git config 可以设置和配置环境变量，这些变量可以存储在三个不同的地方

/etc/gitconfig 文件 包含该系统的每个用户的值和它们的所有仓库 git config --system来设置该文件

~/.gitconfig 或 ～/.config/git/config 文件 具体到你的用户，使用git config --global 选项来设置该文件

.git/config 在你git仓库中的配置文件 这个是针对具体的仓库设置的

后面的设置将会覆盖前面的配置

配置身份
	
	git config --global user.name "zhangsan"
	git config --global user.email "zhangsan@email.com"

配置编辑器
	
	git config --global core.editor emacs
	
检查你的设置
	
	git config --list
	git config user.name 查看具体的key对应的值
	
获取帮助
有三种方式获取帮助
	
	git help <verb>
	git <verb> --help
	man git -<verb>


获取一个git仓库

有两种方式可以获得一个git仓库
1.初始化一个仓库在一个已存在的目录
	
	git init

2.克隆一个存在的仓库
	
	git clone [url]




