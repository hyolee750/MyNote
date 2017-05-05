### 1.在MSI GE72上安装Win10和Ubuntu 16.04 双系统

之前一直在尝试安装Ubuntu系统，但是一直卡在启动页面，进不去系统，让我非常的头疼，但是昨天，终于成功的安装了Ubuntu，现在简要的记录一下成功的方法

1. 划分一块200G的未分配空间
2. 禁用了Intel High Speed，Fast Boot，Secure Boot，同时在安装之前我也禁用了Nvidia显卡驱动，不知道这个有没有影响
3. Bios改成uefi，关闭安全启动。PS：这个时候安装linux，貌似是因为grub的问题，导致图形界面打不开，所以黑屏。
4. 插入启动U盘，启动安装，在install deepin的那个界面（如果是Ubuntu 就是try ubuntu/install Ubuntu的那个），按e，进入grub的调整界面
5. 把里边的`quiet splash`修改为`nomodeset idle=nomwait`，修改完成以后Ctrl + X或F10，使之生效
6. 然后就能正常安装了，安装完成以后，开机进入deepin的系统选择界面时，继续按e，里边还会藏着一个quiet splash，同样替换，修改完成以后Ctrl + X或F10，使之生效。
7. 然后就能正常进入系统了，进入系统以后，`sudo gedit /etc/default/grub` 里边还有quiet splash，同样替换
8. 使用`sudo update-grub`生成新的配置文件

### 2. 安装Ubuntu16.04后不能调整屏幕亮度

####　测试

1. 首先，为了测试这是一个解决办法，重启系统，在GRUB2启动菜单，按`e`编辑配置文件，滚动到`linux` 或`linuxefi`行
- 删除`nomodeset`参数
- 添加`apci_backlight=vendor`参数
    - 添加 `nouveau.modeset=0 rd.driver.blacklist=nouveau`参数
2. 按F10启动系统，你应该能够使用键盘来调整屏幕的亮度了

#### 永久修复

1. 作为root用户，编辑`/etc/default/grub`配置文件
2. 修改`GRUB_CMDLINE_LINE`行
- 删除`nomodeset`参数
- 添加`apci_backlight=vendor nouveau.modeset=0 rd.driver.blacklist=nouveau`
3. 使用`sudo update-grub`使配置生效
4. 使用`sudo reboot`重启系统
5. 按`FN+UP`或`FN+DOWN`来调整屏幕亮度 是否成功


### 3. 卸载compiz之后，不显示导航栏和左侧菜单，只显示背景图片

只需要重新启动Unity插件即可

1. 使用`Ctrl+Alt+T` 打开终端，如果该方法不工作，你也可以试着在桌面点击右键，然后选择`打开终端` ，如果还不行，使用`Ctrl+Alt+F1` 打开终端并登录

2. 安装`compizconfig-settings-manager`

   ```shell
   sudo apt-get install compizconfig-settings-manager
   ```

3. 然后运行下面的命令

   ```shell
   DISPLAY=:0 ccsm &
   ```

   第一部分告诉终端你想要加载的是哪个显示

4. 找到`Unity Plugin`并启用

5. 这样就可以解决不显示导航栏和左侧菜单的问题了