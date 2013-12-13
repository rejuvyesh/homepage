---
title: Cross Compile Matlab mex files on linux
description: How to cross-compile mex files on linux
author: rejuvyesh
status: finished
lastmodified: 13 December, 2013
belief: highly likely
tags: matlab, how-to 
---

I was fed up with matlab while trying to cross compile mex files for [MTBA](<http://iitk.ac.in/iil/mtba/>). I couldn't find a single useful post/guide explaining how to go about doing this. They either used Mingw/Cygwin on Windows itself or `gcc` on Linux and none for cross compiling stuff. I finally managed to successfully compile windows `mex64` on linux using `mingw-w64` libraries on Archlinux.

# What I did

First we install the required libraries:

```bash
$ yaourt -S mingw-w64-gcc 
```
Similarly, install `mingw-w64-g++` and `mingw-w64-gfortran` if needed. On Ubuntu, I think the packages are `gcc-mingw-w64`, `g++-mingw-w64` and `gfortran-mingw-w64` respectively. 

I needed GNU Scentific Library as well:

```bash
$ yaourt -S mingw-w64-gsl
```
Now we'll write a new `mexopt` script for our use.

First define the matlab location:

```bash
TMW_ROOT="$MATLAB"
MLIBS="-L$TMW_ROOT/bin/$Arch -lmx -lmex -lmat"
RPATH="-Wl,-rpath-link,$TMW_ROOT/bin/$Arch"
```
Next we define the c compiler and its libraries.

```bash
MINGW='-L/usr/x86_64-w64-mingw32/lib'
WINMAT='-L/mnt/Windows/Program\ Files/MATLAB/R2012a/bin/win64/' # Windows matlab libraries
CUSTOMLIB='-lgsl -lgslcblas' # I needed gsl
CC='x86_64-w64-mingw32-gcc' # compiler
CFLAGS='-std=c99 -D_GNU_SOURCE'
CFLAGS="$CFLAGS  -fexceptions"
CFLAGS="$CFLAGS -fPIC -fno-omit-frame-pointer -pthread -I/usr/x86_64-w64-mingw32/include"
CLIBS="$RPATH $MLIBS $MINGW $WINMAT -lm $CUSTOMLIB"
COPTIMFLAGS='-O -DNDEBUG'
CDEBUGFLAGS='-g'
CLIBS="$CLIBS -lstdc++"
```
Do the same for g++ and gfortran if needed, replacing them respectively by their mingw conterparts.

Finally we define the linker as:

```bash
LD="$COMPILER"
LDEXTENSION='.mexw64' # Set extension for our mex file
LDFLAGS="-pthread -shared -Wl,--version-script,$TMW_ROOT/extern/lib/$Arch/$MAPFILE"
LDFLAGS="$LDFLAGS -Wl,--no-undefined"
LDOPTIMFLAGS='-O'
LDDEBUGFLAGS='-g'
```

Now we are mostly done.

Compile the required files as:

```matlab
% Here I have named my mexopt script as win.sh
>> mex -v -f /home/rejuvyesh/.matlab/win.sh algo.c
```
And voila, it works!

Share your thoughts if there is a better way.
