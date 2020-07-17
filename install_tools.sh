#!bin/bash

#run this command before run this script
#sudo apt install csh

bin_dir=$(pwd)/bin
tmp_dir=tmp
rm -rf $tmp_dir
mkdir -p $tmp_dir

src_dir=$(pwd)/src
tar -zxvf $src_dir/HTK-3.4.1.tar.gz --directory tmp
tar -zxvf $src_dir/HDecode-3.4.1.tar.gz --directory tmp
tar -xvjf $src_dir/HTS-2.3_for_HTK-3.4.1.tar.bz2 --directory tmp

mkdir -p $bin_dir/hts-2.3
cd tmp/htk/
patch -p1 -d . < ../HTS-2.3_for_HTK-3.4.1.patch
./configure CFLAGS="-DARCH=linux" --prefix=$bin_dir/hts-2.3
make install
make hdecode
make install-hdecode

cd ../..

mkdir -p $bin_dir/sptk-3.10
tar -zxvf $src_dir/SPTK-3.10.tar.gz --directory tmp
cd tmp/SPTK-3.10
./configure --prefix=$bin_dir/sptk-3.10
make install

cd ../..

mkdir -p $bin_dir/hts_engine_1.10
tar -zxvf $src_dir/hts_engine_API-1.10.tar.gz --directory tmp
cd tmp/hts_engine_API-1.10
./configure --prefix=$bin_dir/hts_engine_1.10
make install


echo "Succeed."

