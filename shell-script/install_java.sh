#!/bin/bash

# jdk install
# 请将下载的jdk-xxx-linux-xxx.tar.gz包与此脚本放置到同一目录
# 授予此脚本可执行权限(chmod +x install_jdk.sh)
# 在终端执行此脚本开始安装(./文件名)
# 注意：不可有多个版本的jdk包！
#      为了使配置的环境变量生效，安装完成后你应该重新登陆。

echo "Please select which JDK version you want to install?"
select jdk_version in "JDK1.7" "JDK1.8" ; do
  break;
done

jvmpath=/usr/local/java/
# 不存在
if [ ! -d "$jvmpath" ]; then
    echo "creating $jvmpath directory..."
    sudo mkdir $jvmpath
    echo "Directory $jvmpath created successfully!"
fi

jdkfile=$(ls | grep jdk-*-linux-*.gz)
jdkdirname=""

if [ "$jdk_version" = "JDK1.7" ]; then
    jdkdirname="jdk1.7.0_75"
else
    jdkdirname="jdk1.8.0_73"
fi

os_version=`uname -a`
echo $os_version
architecture="64"
echo "$os_version" | grep -q "$architecture"
if [ $? -eq 0 ]
then
    echo "You are using 64 bit system, using jdk with 64 bit..."
    if [ ! -f "$jdkfile" ]; then
        if [ "$jdk_version" = "JDK1.7" ]; then
            wget http://7vil1r.com1.z0.glb.clouddn.com/jdk-7u75-linux-x64.tar.gz
        else
            wget http://7vil1r.com1.z0.glb.clouddn.com/jdk-8u73-linux-x64.gz
        fi
    fi
    #sudo chown -R jiangxin:jiangxin /usr/lib/jvm/jdk1.7.0_75
else
    echo "Yor are using 32 bit system, using jdk with 32 bit..."
    if [ ! -f "$jdkfile" ]; then
        if [ "$jdk_version" = "JDK1.7" ]; then
            wget http://7vil1r.com1.z0.glb.clouddn.com/jdk-7u75-linux-i586.gz
        else
            wget http://7vil1r.com1.z0.glb.clouddn.com/jdk-8u73-linux-i586.gz
        fi
    fi
fi

jdkfile=$(ls | grep jdk-*-linux-*.gz)

if [ -f "$jdkfile" ]; then

    sudo tar -zxvf $jdkfile -C /usr/local/java/

    echo "Installed JDK successfully"

    echo "Configuring environment variables..."
    # touch environment
    # echo "PATH=\"$PATH:/usr/lib/jvm/$jdkdirname/bin\"" >> environment
    # echo "JAVA_HOME=/usr/lib/jvm/$jdkdirname" >> environment
    # echo "CLASSPATH=.:%JAVA_HOME%/lib/dt.jar:%JAVA_HOME%/lib/tools.jar" >> environment
    # sudo mv /etc/environment /etc/environment.backup.java
    # sudo mv environment /etc
    # source /etc/environment

    mv ~/.bashrc ~/.bashrc.backup.java
    cat ~/.bashrc.backup.java >> ~/.bashrc
    echo "PATH=\"$PATH:$jvmpath/$jdkdirname/bin\"" >> ~/.bashrc
    echo "JAVA_HOME=$jvmpath/$jdkdirname" >> ~/.bashrc
    echo "CLASSPATH=.:%JAVA_HOME%/lib/dt.jar:%JAVA_HOME%/lib/tools.jar" >> ~/.bashrc
    source ~/.bashrc
    echo "Configuration secced..."

    # 如果有多个java版本需要进行以下配置（包括openjdk）
    echo "Set default JDK"
    sudo update-alternatives --install /usr/bin/java java $jvmpath/$jdkdirname/bin/java 300
    sudo update-alternatives --install /usr/bin/javac javac $jvmpath/$jdkdirname/bin/javac 300
    sudo update-alternatives --config java

    echo "Testing if installed successfully..."
    java -version
    echo "Installed successfully"

fi
