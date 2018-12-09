# adjust working directory if required
export WORK_DIR=/Users/runpinghuang/dev

# ########### ZOOKEEPER #############
# https://zookeeper.apache.org/releases.html
# requires:

cd $WORK_DIR

export VERSION=3.4.10
wget http://apache.mirrors.nublue.co.uk/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz
tar -xzvf zookeeper-$VERSION.tar.gz

echo " " >> ~/.bashrc
echo "# ======== ZOOKEEPER ======== #" >> ~/.bashrc
echo "export ZOOKEEPER_HOME=$WORK_DIR/zookeeper-$VERSION" >> ~/.bashrc
echo 'export PATH=$PATH:$ZOOKEEPER_HOME/bin' >> ~/.bashrc

source ~/.bashrc

cd zookeeper-$VERSION
cp conf/zoo_sample.cfg conf/zoo.cfg

# define permanent data dir
mkdir $pwd/zookeeper-data
DATA_DIR=$pwd/zookeeper-data
# IMPORTANT: CHANGE USER HOME DIR PATH
perl -0777 -i.original -pe 's@/tmp/zookeeper@$DATA_DIR@igs' conf/zoo.cfg                                                                          