
declare -a module_names
declare -a module_urls
declare -a module_branches

function parse_requirements() {
    requirements_file=$1
    local MY_MODULES=$(cat ${requirements_file})

    for module in $MY_MODULES; do

        if [[ $module == git+* ]]; then
            local module=${module/\#egg=[a-z]*/}

            if [[ $module == *@* ]]; then
                local modulebranch="--branch ${module/*@/}"
                local module=${module/@*/}
            else
                local modulebranch=""
            fi

            local moduleurl=${module/git+/}
            local modulename=$(basename $module)
            local modulename=${modulename/.git/}

            module_names+=("$modulename")
            module_urls+=("$moduleurl")
            module_branches+=("$modulebranch")
        else
            module_names+=("$module")
            module_urls+=("")
            module_branches+=("")
        fi
    done
}