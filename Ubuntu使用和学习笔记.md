### 在MSI GE72上安装Win10和Ubuntu 16.04 双系统

之前一直在尝试安装Ubuntu系统，但是一直卡在启动页面，进不去系统，让我非常的头疼，但是昨天，终于成功的安装了Ubuntu，现在简要的记录一下成功的方法

1. 划分一块200G的未分配空间
2. 禁用了Intel High Speed，Fast Boot，Secure Boot，同时在安装之前我也禁用了Nvidia显卡驱动，不知道这个有没有影响
3. Bios改成uefi，关闭安全启动。PS：这个时候安装linux，貌似是因为grub的问题，导致图形界面打不开，所以黑屏。
4. 插入启动U盘，启动安装，在install deepin的那个界面（如果是Ubuntu 就是try ubuntu/install Ubuntu的那个），按e，进入grub的调整界面
5. 把里边的`quiet splash`修改为`nomodeset idle=nomwait`，修改完成以后Ctrl + X或F10，使之生效
6. 然后就能正常安装了，安装完成以后，开机进入deepin的系统选择界面时，继续按e，里边还会藏着一个quiet splash，同样替换，修改完成以后Ctrl + X或F10，使之生效。
7. 然后就能正常进入系统了，进入系统以后，`sudo gedit /etc/default/grub` 里边还有quiet splash，同样替换
8. 使用`sudo update-grub`生成新的配置文件