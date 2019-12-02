#!/usr/bin/env bash

# get character from character code
#
# syntax: chr <character_code>
function chr() {
    [[ $1 -ge 0 && $1 -le 255 ]] || return 1
    printf "\\$(printf '%03o' "$1")"
}

# get character code from character
#
# syntax: ord <character>
function ord() {
    LC_TYPE=C printf '%d' "'$1"
}

# back up a list of files
#
# syntax: back_up_files [file_1] ... [file_n]
function back_up_files()
{
    # process list of files
    for file in $@; do
        if [ -r "${file}" ]; then
            # if file exists, move it
            mv "${file}" "${file}.$(date +%Y%m%dT%H%M%S).bak"
        fi
    done
}

# get the platform of the OS where this function is called
#
# syntax: get_platform
function get_platform()
{
    # get the uname
    local unamestr=$(uname)

    # parse the uname
    local shell_nocasematch=$(shopt -p nocasematch)
    shopt -s nocasematch
    case ${unamestr} in
        *bsd)       platform='bsd'      ;;
        cygwin*)    platform='windows'  ;;
        darwin)     platform='mac'      ;;
        linux)      platform='linux'    ;;
        ming*)      platform='windows'  ;;
        minix)      platform='minix'    ;;
        msys*)      platform='windows'  ;;
        sunos)      platform='solaris'  ;;
        windows*)   platform='windows'  ;;
        *)          platform='unknown'  ;;
    esac
    ${shell_nocasematch}
    
    # return the platform
    echo ${platform}
}

# checks to make sure a list of prereqs are met
#
# syntax: check_prereqs [prereq_1] ... [prereq_n]
function check_prereqs()
{
    # declare local array to keep track of what needs to be installed
    local to_install=()

    # loop through and check what's there and what's not
    for prereq in $@; do
        if ! command -v ${prereq} &>/dev/null; then
            to_install+=(${prereq})
        fi
    done

    if [[ ${#to_install[@]} -ne 0 ]]; then
        # things need to be installed
        echo "      └ needs to be installed: ${to_install[@]}"
        return 1
    else
        # things don't need to be installed
        return 0
    fi
}

# creates multiple links from pairs of inputs
#
# syntax: create_links [(<link_from_1> <link_to_1>) ... (<link_from_n> <link_to_n>)]
function create_links()
{
    # run through pairs of links, shifting as needed
    while [[ "${1}" != "" && "${2}" != "" ]]; do
        ln -s "${1}" "${2}"
        shift 2
    done
}

# parses a config file and substitutes variables for a given action type
#
# syntax: parse_config_action <config_file> <action_type> [(<var_name_1> <var_value_1>) ... (<var_name_n> <var_value_n>)]
function parse_config_action()
{
    # set the variable marker prefix and suffix
    local var_prefix='{{'
    local var_suffix='}}'

    # get the config file and which action type is being parsed for
    local config_file="${1:?}"
    local action_type="${2:?}"

    # read the variables that are going to be used
    local -A variables
    while [[ "${3}" != "" && "${4}" != "" ]]; do
        variables[${3}]=${4}
        shift 2
    done

    # get all options of the specified action type and escape '|' as necessary
    options=($(grep '^'${action_type} ${config_file} | cut -d ' ' -f '2-' | sed 's/|/\|/g'))

    # go through options and search and replace variables
    for variable in ${!variables[@]}; do
        options=($(sed 's|'${var_prefix}${variable}${var_suffix}'|'${variables[${variable}]}'|g' <<< ${options[@]}))
    done

    # check for any unknown variables and exit if any are found
    if grep -P '('${var_prefix}'|'${var_suffix}')' <<< ${options[@]} &>/dev/null; then
        declare -A unknown_vars
        for unknown_var in $(grep -Po '(?<='${var_prefix}')\w+(?='${var_suffix}')' <<< ${options[@]}); do
            unknown_vars[${unknown_var}]=1
        done
        >&2 echo "unrecognized variable(s): ${!unknown_vars[@]}"
        >&2 echo "config_file: ${config_file}"
        >&2 echo "action_type: ${action_type}"
        return 1
    fi

    # return options
    echo ${options[@]}
}

# tuple-ify an associative array
#
# syntax: tuplify <array_name>
function tuplify() {
    # note that this uses features found ONLY in bash versions >= 4.3

    # get a namedref to associative array
    local -n array_name=$1

    # set up variable to keep track of tuplified portions of the array
    local tuplified=()

    # run through the array
    for index in ${!array_name[@]}; do
        tuplified+=(${index})
        tuplified+=(${array_name[${index}]})
    done

    # return tuplified version of the array
    echo ${tuplified[@]}
}

# tuple-ify the 'variables' associative array
#
# syntax: tuplify_variables
function tuplify_variables() {
    # set up variable to keep track of tuplified portions of the array
    local tuplified=()

    # run through the array
    for index in ${!variables[@]}; do
        tuplified+=(${index})
        tuplified+=(${variables[${index}]})
    done

    # return tuplified version of the array
    echo ${tuplified[@]}
}

# run an arbitrary command
#
# syntax: run_command [param_1] ... [param_n]
function run_command() {
    # run the command
    eval "$@"
    return $?
}

# checks whether the minimum version is met
#
# syntax: check_minimum_version <program_to_check> <version_argument> <minimum_version> <version_string_type>
function check_minimum_version() {
    # declare local variables
    local program_to_check=""
    local version_argument=""
    local version_string_type=""
    local minimum_version_string=""
    local minimum_version=()
    local current_version_string=""
    local current_version=()

    # declare local array to keep track of what commands don't meet minimum version reqs
    local minimum_version_not_met=()

    # loop through and check versions
    while [[ -n "$@" ]]; do
        # reinitialize version variables
        minimum_version=()
        current_version=()

        # get version string type
        #   type1: x.y
        #       x: number
        #       y: number
        #   type2: x.y.z
        #       x: number
        #       y: number
        #       z: number
        #   type3: x.ya
        #       x: number
        #       y: number
        #       a: letter
        version_string_type=$4

        # get minimum version
        minimum_version_string="$3"
        case ${version_string_type} in
            type1|type2)
                readarray -t minimum_version < <(echo "${minimum_version_string}" | sed 's/\./\n/g')
                ;;
            type3)
                readarray -t minimum_version < <(echo "${minimum_version_string}" | awk '{print tolower($1)}' | sed -r 's/([0-9]+)([a-zA-Z])/\1.\2/' | sed 's/\./\n/g')
                ;;
            *)
                echo "      └ error: unknown version string type '${version_string_type}'"
                ;;
        esac

        # get current version
        program_to_check="$1"
        version_argument="$2"
        current_version_string="$(${program_to_check} ${version_argument})"
        case ${version_string_type} in
            type1)
                readarray -t current_version < <(echo "${current_version_string}" | egrep -o '[0-9]+\.[0-9]+' | head -n 1 | sed 's/\./\n/g')
                ;;
            type2)
                readarray -t current_version < <(echo "${current_version_string}" | egrep -o '[0-9]+\.[0-9]+\.[0-9]+' | head -n 1 | sed 's/\./\n/g')
                ;;
            type3)
                readarray -t current_version < <(echo "${current_version_string}" | egrep -o '[0-9]+\.[0-9]+[a-zA-Z]' | head -n 1 | awk '{print tolower($1)}' | sed -r 's|([0-9]+)([a-zA-Z])|\1.\2|' | sed 's/\./\n/\g')
                ;;
            *)
                ;;
        esac

        # compare versions
        case ${version_string_type} in
            type1)
                if [[ ${current_version[0]} -lt ${minimum_version[0]} || ( ${current_version[0]} -eq ${minimum_version[0]} && ${current_version[1]} -lt ${minimum_version[1]} ) ]]; then
                    minimum_version_not_met+=( "${program_to_check}<${minimum_version_string}" )
                fi
                ;;
            type2)
                if [[ ${current_version[0]} -lt ${minimum_version[0]} || ( ${current_version[0]} -eq ${minimum_version[0]} && ${current_version[1]} -lt ${minimum_version[1]} ) || ( ${current_version[0]} -eq ${minimum_version[0]} && ${current_version[1]} -eq ${minimum_version[1]} && ${current_version[2]} -lt ${minimum_version[2]} ) ]]; then
                    minimum_version_not_met+=( "${program_to_check}<${minimum_version_string}" )
                fi
                ;;
            type3)
                if [[ ${current_version[0]} -lt ${minimum_version[0]} || ( ${current_version[0]} -eq ${minimum_version[0]} && ${current_version[1]} -lt ${minimum_version[1]} ) || ( ${current_version[0]} -eq ${minimum_version[0]} && ${current_version[1]} -eq ${minimum_version[1]} && $(ord ${current_version[2]}) -lt $(ord ${minimum_version[2]}) ) ]]; then
                    minimum_version_not_met+=( "${program_to_check}<${minimum_version_string}" )
                fi
                ;;
            *)
                ;;
        esac

        shift 4
    done

    if [[ ${#minimum_version_not_met[@]} -ne 0 ]]; then
        # minimum versions not met
        echo "      └ minimum versions not met: ${minimum_version_not_met[@]}"
        return 1
    else
        # minimum versions met
        return 0
    fi
}

# define actions to be taken
#
# syntax: define_action <action_name> <action_to_be_taken> <true|false>
function define_action() {
    # define the action name
    actions+=($1)

    # define the action to be executed
    action_execs[$1]="$2"

    # define whether an error in this action is fatal
    error_is_fatal[$1]="$3"
}
