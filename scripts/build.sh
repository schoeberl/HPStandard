# download and build MIPS tools

DIR=`pwd`
export PREFIX=$DIR/yamp-tools
export PATH=$PATH:$PREFIX/bin

wget http://ftp.gnu.org/gnu/binutils/binutils-2.22.tar.bz2
tar xjf binutils-2.22.tar.bz2
mkdir build-binutils
cd build-binutils
../binutils-2.22/configure --target=mipsel-elf --prefix=$PREFIX --with-gnu-as --with-gnu-ld --disable-werror 
make -j16
make install
cd ..
rm binutils-2.22.tar.bz2
rm -rf binutils-2.22
rm -rf build-binutils
