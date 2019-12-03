# CMSC 455 HW 6 Report

I ran the program in C a couple times with various levels of optimization flags 
in GCC. The computer I ran it on is pretty modern with lots of memory, so it
didn't take too much time to run each iteration. The `gcc -v` output is below.

>Using built-in specs.
>COLLECT_GCC=gcc
>COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/7/lto-wrapper
>OFFLOAD_TARGET_NAMES=nvptx-none
>OFFLOAD_TARGET_DEFAULT=1
>Target: x86_64-linux-gnu
>Configured with: ../src/configure -v --with-pkgversion='Ubuntu 7.4.0-1ubuntu1~18.04.1' --with-bugurl=file:///usr/share/doc/gcc-7/README.Bugs --enable-languages=c,ada,c++,go,brig,d,fortran,objc,obj-c++ --prefix=/usr --with-gcc-major-version-only --program-suffix=-7 --program-prefix=x86_64-linux-gnu- --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-vtable-verify --enable-libmpx --enable-plugin --enable-default-pie --with-system-zlib --with-target-system-zlib --enable-objc-gc=auto --enable-multiarch --disable-werror --with-arch-32=i686 --with-abi=m64 --with-multilib-list=m32,m64,mx32 --enable-multilib --with-tune=generic --enable-offload-targets=nvptx-none --without-cuda-driver --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu
>Thread model: posix
>gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1) 

The normalized time it took to run each took around the same time for each, around 
4 normalized seconds each. Oddly though, the first and last runs typically had a
much longer normalized time to run, each taking around 6 seconds. I found this kind 
of odd, especially as the memory allocation and freeing aspects were outside of the 
timing. I would expect it to take slightly longer to allocate more memory, but since 
the allocation is outside of the timing, that doesn't explain it.

Oddly enough, I didn't see the additional time taken on the final run once I added
the `-O1` compiler flag to GCC. As I would expect, it took slightly longer to compile, 
but ran signficiantly faster. It's possible that the compiler took advantage of vectorized
instructions on my CPU, as I'm pretty sure the Ryzen CPU I have does that. The optimized
version also had more consistent timing performance.

When I ran the program with the `-O2` compiler flag, I again saw signifcant speed up
over the `-O1` version, but the spike in the last N size returned. I did not see much
of an increase in compile time between the compilation of `-O2` and `-O1`.

Adding the `-O3` compile flag did not provide much benefit over just the `-O2` flag, so
I assumed that `-O2` must have optimized it as much as possible, especially considering it
is a rather short program.
