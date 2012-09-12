# 2009-09-30_at_19:22 make terminal got color
export CLICOLOR=1
export LSCOLORS=gxfxaxdxcxegedabagacad

# change prompt
export PS1="\w\$ "

##
# DELUXE-USR-LOCAL-BIN-INSERT
# (do not remove this comment)
##
echo $PATH | grep -q -s "/usr/local/bin"
if [ $? -eq 1 ] ; then
    PATH=/usr/local/bin:$PATH
    export PATH
fi

# Setting PATH for MacPython 2.6
# The orginal version is saved in .profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
#export PATH

export LC_CTYPE=en_US.UTF-8

export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home
export PATH=$PATH:$JAVA_HOME/bin

SVN_EDITOR=/usr/bin/vi
export SVN_EDITOR

export PYTHON_HOME=/Library/Frameworks/Python.framework/Versions/Current

alias ll='ls -l'
set -o vi
export ANT_OPTS="-Xmx1024m -XX:MaxPermSize=256m"
source ~/.shotcut.sh


##
# Your previous /Users/xzhang/.profile file was backed up as /Users/xzhang/.profile.macports-saved_2012-07-26_at_22:32:27
##

# MacPorts Installer addition on 2012-07-26_at_22:32:27: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

