# ########### ACCUMULO #############
# https://accumulo.apache.org/downloads/
# requires: hdfs, zookeeper

# change this
cd $WORK_DIR=/Users/runpinghuang/dev

# change if necessary
export VERSION=1.9.2
wget http://www.mirrorservice.org/sites/ftp.apache.org/accumulo/$VERSION/accumulo-$VERSION-bin.tar.gz
tar -xzvf accumulo-$VERSION-bin.tar.gz

echo " " >> ~/.bashrc
echo "# ======== ACCUMULO ======== #" >> ~/.bashrc
echo "export ACCUMULO_HOME=$WORK_DIR/accumulo-$VERSION" >> ~/.bashrc
echo 'export PATH=$PATH:$ACCUMULO_HOME/bin' >> ~/.bashrc

source ~/.bashrc

cd accumulo-$VERSION


./bin/build_native_library.sh
cp conf/examples/1GB/standalone/* conf/

# to be able to access it over the Internet, you have to set the value
# of ACCUMULO_MONITOR_BIND_ALL to true.
sed 's/# export ACCUMULO_BIND_ALL/export ACCUMULO_BIND_ALL/' < conf/accumulo-env.sh > conf/accumulo-env.test.sh
rm conf/accumulo-env.sh
mv conf/accumulo-env.test.sh conf/accumulo-env.sh

chmod 700 conf/accumulo-env.sh

# instance.volumes: where to store the data on HDFS
perl -0777 -i.original -pe 's@<name>instance.volumes</name>\n\s+<value></value>@<name>instance.volumes</name>\n<value>hdfs://localhost:9000/accumulo</value>@igs' conf/accumulo-site.xml

# change instance.secret
perl -0777 -i.original -pe 's@<value>test</value>@<value>test</value>@igs' conf/accumulo-site.xml