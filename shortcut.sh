_webhome=~/cmpt/howlworld/trunk/webhome
_um=~/cmpt/drc/liferay-plugins/portlets/user-manager-portlet/
_sd=~/work/drc/SDPublisher
_oak=~/cmpt/js/Oak3D
_jsutil=~/cmpt/js/jsutil
_tc=~/cmpt/drc/tc
_js=~/cmpt/js

function arts {
    cmd=$1
    host=xiz921@arts-drc-1418.usask.ca
    shift
    if [[ "$cmd" == "clone" ]]; then
        git clone ssh://$host/~/git/$1.git
    elif [[ "$cmd" == "ssh" ]]; then
        ssh $host
    fi
}

function is_function {
    type -t $1 | grep -q 'function'
}

function go {
    eval cd \$_$1
}

function pm {
    source venv/bin/activate
    python manage.py $*
}


