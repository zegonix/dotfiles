#!/usr/bin/env bash

function remove-whitespace {

    unset line_endings
    unset help
    unset quiet
    unset files

    for arg in $@; do
        case ${arg} in
        "-e" | "--eol" | "--end-of-line")
            line_endings="true"
            continue
            ;;
        "-h" | "--help" | "-help")
            help="true"
            continue
            ;;
        "-n" | "--quiet")
            quiet="true"
            continue
            ;;
        *) ;;
        esac

        if [[ -f "${arg}" ]]; then
            grep -Iq . "${arg}" && files=(${files} "${arg}")
            continue
        fi
        if [[ -d "${arg}" ]]; then
            files=(${files} $(find "${arg}" \
                -not -path "*/.git/*" \
                -not -name "*.lst" \
                -not -name "*.map" \
                -not -name "*.svd" \
                -not -name "*.sym" \
                -type f \
                -exec grep -Iq . {} \; \
                -print))
            continue
        fi
    done

    ## search current directory if no argument is provided
    if [[ -z "${files[@]}" ]]; then
        files=($(find . \
            -not -path "*/.git/*" \
            -not -name "*.lst" \
            -not -name "*.map" \
            -not -name "*.svd" \
            -not -name "*.sym" \
            -type f \
            -exec grep -Iq . {} \; \
            -print))
    fi

    if [[ -n "${dir_arg}" ]] && [[ -n "${file_arg}" ]]; then
        help="true"
    fi

    if [[ -n "${help}" ]]; then
        echo "Usage: remove-whitespace [-h] [-n] path [path]"
        echo ""
        echo "Remove trailing whitespace from plain text files."
        echo "Path points to either a file or directory, or both."
        echo "Directories are search recursively for non binary."
        echo "If no paths are provided, the current working"
        echo "directory is search for plain text files."
        echo ""
        echo "Options:"
        echo "  -e, --eol,"
        echo "  --end-of-line   convert all line endings to unix style"
        echo "                  line endings"
        echo "  -h, --help      show this help"
        echo "  -n, --quiet     suppress output"

        return 0
    fi

    unset trailing_whitespace

    for file in ${files[@]}; do
        sed -i 's/\r$//' ${file}
        if [[ -n "$(sed -ne '/[[:blank:]]\+\r\?$/p' ${file})" ]]; then
            if [[ -n "${line_endings}" ]]; then
                sed -i 's/[[:blank:]]\+\(\r\?\)$//' ${file}
            else
                sed -i 's/[[:blank:]]\+\(\r\?\)$/\1/' ${file}
            fi
            trailing_whitespace+="${file}\n"
        fi
    done
    echo ""

    if [[ -z "${quiet}" ]] &&
        [[ -n "${trailing_whitespace}" ]]; then
        tput setaf 1
        tput smso
        echo "[ DO NOT LEAVE TRAILING WHITE SPACE IN PLAIN TEXT FILES !!! ]"
        tput sgr0
        echo ""
        echo "The following files contained whitespace:"
        echo -e "${trailing_whitespace}"
    fi

}
