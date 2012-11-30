# Get the YARI MIPS simulator from Tommy

mkdir build-yarisim
cd build-yarisim
git clone git://github.com/tommythorn/yari.git
# git clone git://github.com/schoeberl/yari.git
cd yari/shared/yarisim
make yarisim
cp yarisim ../../../../bin
cd ../../../..
rm -rf build-yarisim
