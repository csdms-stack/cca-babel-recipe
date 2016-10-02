export CC=$(which gcc)
export CXX=$(which g++)
export FC=$(which gfortran)
export F77=$FC
export F90=$FC
export F03=$FC

if [ $(uname) == Darwin ]; then
  export JAVAPREFIX=$(/usr/libexec/java_home)
else
  export JAVAPREFIX="${JAVA_HOME:-/usr/java/default}"
fi
export JAVA=$JAVAPREFIX/bin/java

export PYTHON=$PREFIX/bin/python
export PATH=$JAVAPREFIX/bin:$PATH

ln -s "$PREFIX/lib" "$PREFIX/lib64"

export FCFLAGS="-Wl,-rpath,${PREFIX}/lib"
export FFLAGS="-Wl,-rpath,${PREFIX}/lib"

./configure --prefix=$PREFIX --disable-documentation \
  --with-libparsifal=$PREFIX --with-ltdl-include=$PREFIX/include \
  --with-ltdl-lib=$PREFIX/lib --with-libxml2=$PREFIX --with-chasm=$PREFIX \
  --without-sidlx

make all -j$CPU_COUNT
make install

rm "$PREFIX"/lib64
