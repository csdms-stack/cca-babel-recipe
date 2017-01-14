export CC=$(which gcc)
export CXX=$(which g++)
export FC=$(which gfortran)
export F77=$FC
export F90=$FC
export F03=$FC

if [ $(uname) == Darwin ]; then
  export JAVAPREFIX=$(/usr/libexec/java_home)
else
  # export JAVAPREFIX="${JAVA_HOME:-/usr/java/default}"
  export JAVAPREFIX="${JAVA_HOME:-/usr}"
fi
export JAVA=$JAVAPREFIX/bin/java

export PYTHON=$PREFIX/bin/python
export PATH=$JAVAPREFIX/bin:$PATH

if [! -d "$PREFIX/lib64" ]; then
  ln -s "$PREFIX/lib" "$PREFIX/lib64"
fi

export FCFLAGS="-Wl,-rpath,${PREFIX}/lib"
export FFLAGS="-Wl,-rpath,${PREFIX}/lib"

./configure --prefix=$PREFIX --disable-documentation \
  --with-libparsifal=$PREFIX --with-ltdl-include=$PREFIX/include \
  --with-ltdl-lib=$PREFIX/lib --with-libxml2=$PREFIX --with-chasm=$PREFIX \
  --without-sidlx

make all -j$CPU_COUNT > stdout.txt || tail -100 stdout.txt
make install > stdout.txt || tail -100 stdout.txt

rm "$PREFIX"/lib64 || echo "Unable to remove $PREFIX/lib64"
