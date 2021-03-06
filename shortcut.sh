function myssh {
    target=$1
    if [[ "$target" == "arts" ]]; then
        ssh xiz921@pp406c8fb7b6ea.usask.ca
    elif [[ "$target" == "mapping" ]]; then
        ssh mappingthepages@asweb.usask.ca
    elif [[ "$target" == "grubstreet" ]]; then
        ssh xiz921@dev.grubstreetproject.net
    fi
}

function is_function {
    type -t $1 | grep -q 'function'
}

function pm {
    source venv/bin/activate
    python manage.py $*
}


