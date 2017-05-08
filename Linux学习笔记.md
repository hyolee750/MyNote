### 命令，选项和参数

一个Linux命令通常包含三个部分：
1. 命令本身
2. 命令选项
3. 参数

`useradd -m -G sales linda`

### 管道和重定向

使用管道，你可以发送一个命令的结果到另外一个命令，使用重定向，你可以决定该命令应该把它的结果发送到何处

`ls -R / | less`

> FUCK THIS RUBBISH COMPANY
> USE THE OUT DATE TECHNOLOGY.NO LINUX SERVER,NO GIT,NO MAVEN,AS A JAVA PROGRAMMTER I WANT TO SAY FUCK YOU 
> NOT ONLY THIS ,BUT ALSO OTHERS
> FOR EXAMPLE,NO INTERNET
> I DON'T WANT TO ANY MORE.
> IF I HAVE ANOTHER CHOICE,I WILL NOT CHOICE THIS COMPANY
> BUT NOW,BECAUSE I DONT' HAVE ENOUGH MONEY AND MY BROTHER IS GOING TO MARRY
> BEFORE MARRY,STILL HAVE MONEY TO BUY HOUSE
> FUCK CHINA HOUSE PRICE
> FUCK !!!

使用`ls -l` 默认显示在控制台上

使用`ls -l > somewhere` 输出到文件，如果该文件不存在，则会创建，如果存在，则覆盖

使用`ls -l >> somewhere`输出到文件，如果该文件不存在，则会创建，如果存在，则添加到文件最后

使用`mail -s hello root < .` 进行输入重定向

#### 获取帮助

1. 使用`man`命令
2. 使用命令的`--help`选项
3. 使用Bash自带的`help`选项来获取更多的信息


