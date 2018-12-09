WORK_DIR=/Users/runpinghuang/dev
cd $WORK_DIR

VERSION=2.1.0
wget http://repo.locationtech.org/content/repositories/geomesa-releases/org/locationtech/geomesa/geomesa-accumulo-dist_2.11/$VERSION/geomesa-accumulo-dist_2.11-$VERSION-bin.tar.gz

tar xvf geomesa-accumulo-dist_2.11-$VERSION-bin.tar.gz
cd geomesa-accumulo_2.11-$VERSION

echo " " >> ~/.bashrc
echo "# ======== GEOMESA ======== #" >> ~/.bashrc
echo "export GEOMESA_ACCUMULO_HOME=$WORK_DIR/geomesa-accumulo_2.11-$VERSION" >> ~/.bashrc
echo 'export PATH=$PATH:$GEOMESA_ACCUMULO_HOME/bin' >> ~/.bashrc

source ~/.bashrc