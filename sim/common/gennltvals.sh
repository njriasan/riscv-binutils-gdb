#! /bin/sh
# Generate nltvals.def, a file that describes various newlib/libgloss
# target values used by the host/target interface.
#
# Syntax: /bin/sh gennltvals.sh shell srcroot cpp

shell=$1
srcroot=$2
cpp=$3

srccom=$srcroot/sim/common
if [ -d "${srcroot}/newlib" ]; then
  # If newlib is manually in the same source tree, use it.
  newlibroot=${srcroot}
else
  # Else assume it's alongside the gdb/binutils repo.
  newlibroot=${srcroot}/../newlib
fi

echo '/* Newlib/libgloss macro values needed by remote target support.  */'
echo '/* This file is machine generated by gennltvals.sh.  */'

$shell ${srccom}/gentvals.sh "" errno ${newlibroot}/newlib/libc/include \
	"errno.h sys/errno.h" 'E[[:upper:][:digit:]]*' "${cpp}"

$shell ${srccom}/gentvals.sh "" signal ${newlibroot}/newlib/libc/include \
	"signal.h sys/signal.h" 'SIG[[:upper:][:digit:]]*' "${cpp}"

$shell ${srccom}/gentvals.sh "" open ${newlibroot}/newlib/libc/include \
	"fcntl.h sys/fcntl.h sys/_default_fcntl.h" 'O_[[:upper:][:digit:]]*' "${cpp}"

# Unfortunately, each newlib/libgloss port has seen fit to define their own
# syscall.h file.  This means that system call numbers can vary for each port.
# Support for all this crud is kept here, rather than trying to get too fancy.
# If you want to try to improve this, please do, but don't break anything.
# Note that there is a standard syscall.h file (libgloss/syscall.h) now which
# hopefully more targets can use.

dir=libgloss target=bfin
$shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"

dir=newlib/libc/sys/d10v/sys target=d10v
$shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"

# OBSOLETE dir=libgloss target=d30v
# OBSOLETE $shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
# OBSOLETE 	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"

dir=libgloss/cr16/sys target=cr16
$shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"

dir=libgloss target=fr30
$shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"

dir=libgloss target=frv
$shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"

dir=libgloss/i960 target=i960
$shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"

dir=libgloss target=m32r
$shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"

dir=libgloss target=mn10200
$shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"

dir=libgloss target=mn10300
$shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"

dir=libgloss target=msp430
$shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"

dir=libgloss target=sparc
$shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"

dir=libgloss/v850/sys target=v850
$shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"

dir=libgloss target=lm32
$shell ${srccom}/gentvals.sh $target sys ${newlibroot}/$dir \
	"syscall.h" 'SYS_[_[:alnum:]]*' "${cpp}"
