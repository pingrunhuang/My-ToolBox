# change this 
WORK_DIR=/Users/runpinghuang/dev

echo " " >> ~/.bashrc
echo "# ======== Hadoop ======== #" >> ~/.bashrc
echo "export HADOOP_HOME=$WORK_DIR/hadoop-$VERSION" >> ~/.bashrc
echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' >> ~/.bashrc
source ~/.bashrc

VERSION=2.6.5
wget https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-$VERSION/hadoop-$VERSION.tar.gz

# Pseudo-Distributed mode
perl -0777 -i.original -pe 's@<configuration>\n</configuration>@<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>@igs' ./etc/hadoop/core-site.xml

perl -0777 -i.original -pe 's@<configuration>\n\n</configuration>@<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>@igs' etc/hadoop/hdfs-site.xml

# setup passphraseless
echo 'y' | ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

