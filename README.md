<div align="center">
  
# Appx Package Installer Community
</div>

###  说明
一个安装appx、msix、appxbundle、msixbundle打包格式的小工具, 用于在右键菜单添加快捷安装选项，可选择系统级安装或用户级安装，还可以通过注册xml来把松散文件注册成microsoft store（容器）应用.

注意:

* xml注册需要在系统设置打开开发者选项才能使用.


### 安装
从release [下载main.zip文件（从github actions构建得到）](https://github.com/nzl-architecture/Appx_Package_Installer_Community_For_Windows/releases)，完全解压后运行install.ps1即可安装

![image](ScreenShots/image0.png)

### 软件主界面

![image](ScreenShots/image1.png)

### 支持.appx、.msix、.appxbundle、.msixbundle软件包的安装

#### 绑定.appx、.msix、.appxbundle、.msixbundle等格式的右键菜单

![image](ScreenShots/image2.png)

#### 安装appx应用包时的页面

可以选4个模式
1.系统级安装+默认参数
2.用户级安装+默认参数
1.系统级安装+自定义参数
2.用户级安装+自定义参数

![image](ScreenShots/image3.png)

### 支持直接注册文件夹的appxmanifest.xml来注册成软件包（需要在系统设置打开开发者模式）

#### 绑定.xml格式的右键菜单

![image](ScreenShots/image5.png)

#### 通过松散文件注册软件包时的页面

![image](ScreenShots/image4.png)
