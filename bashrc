# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

# term256color
case "$TERM" in
	xterm)
	    export TERM=xterm-256color
	    ;;
	screen)
	    export TERM=screen-256color
	    ;;
esac

#追加路径到头部
prepend() { [ -d "$2" ] && eval $1=\"$2\$\{$1:+':'\$$1\}\" && export $1; }    
sufpend() { [ -d "$2" ] && eval $1=\"\$\{$1:+\$$1':'\}$2\" && export $1; }

#可执行文件查找路径
prepend PATH /opt/tmux/bin/
sufpend PATH /opt/python34/bin/
sufpend PATH /opt/libtool/bin/

#动态库查找路径
prepend LD_LIBRARY_PATH /usr/local/lib/
prepend LD_LIBRARY_PATH /usr/local/lib64/
prepend LD_LIBRARY_PATH /opt/libtool/lib/
prepend LD_LIBRARY_PATH /opt/gcc5_3_0/lib/
prepend LD_LIBRARY_PATH /opt/gcc5_3_0/lib64/

#静态库查找路径
prepend LIBRARY_PATH /opt/libtool/lib

#gcc头文件
prepend C_INCLUDE_PATH /opt/libtool/include/

#g++头文件
prepend CPLUS_INCLUDE_PATH /opt/libtool/include/
