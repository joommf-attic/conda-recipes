#!/bin/bash

VER=8.5.18

if [ -z "$DISPLAY" ]; then
    echo "Error: variable DISPLAY not set. Aborting."
    exit 1
fi

wget http://downloads.sourceforge.net/project/tcl/Tcl/${VER}/tcl${VER}-src.tar.gz
wget http://downloads.sourceforge.net/project/tcl/Tcl/${VER}/tk${VER}-src.tar.gz

tar xzf tcl${VER}-src.tar.gz
tar xzf tk${VER}-src.tar.gz

# Compile and install tcl
cd $SRC_DIR/tcl${VER}/unix
./configure --prefix=$PREFIX --enable-threads --enable-64bit
make
make install
make install-private-headers

# Compile and install tk
cd $SRC_DIR/tk${VER}/unix
./configure --with-tcl=$PREFIX/lib --prefix=$PREFIX --enable-aqua=yes --enable-threads --enable-64bit
make
make install
make install-private-headers

# Copy source files to $PREFIX/src
install -d $PREFIX/src
cp -r $SRC_DIR/tcl${VER} $PREFIX/src/
cp -r $SRC_DIR/tk${VER} $PREFIX/src/

sed -i "s|^TCL_SRC_DIR=.*$|TCL_SRC_DIR='$PREFIX/src/tcl${VER}'|" $PREFIX/lib/tclConfig.sh
sed -i "s|^TK_SRC_DIR=.*$|TK_SRC_DIR='$PREFIX/src/tk${VER}'|" $PREFIX/lib/tkConfig.sh

cd $PREFIX
rm -rf man share

cd $PREFIX/bin
ln -s tclsh8.5 tclsh
