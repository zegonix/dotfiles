#!/usr/bin/env bash

files=($(find . -not -path "*/.git/*" -type f -exec grep -Iq . {} \; -print))
unset trailing_whitespace

for file in ${files[@]}; do
    sed -i 's/\r$//' ${file}
    if [[ -n "$(sed -ne '/[[:space:]]$/p' ${file})" ]]; then
        sed -i 's/[[:space:]]$//' ${file}
        trailing_whitespace+="${file}\n"
    fi
done
echo ""

if [[ -n "${trailing_whitespace}" ]]; then
    tput setaf 1
    tput smso
    echo "[ DO NOT LEAVE TRAILING WHITE SPACE IN PLAIN TEXT FILES !!! ]"
    tput sgr0
    echo ""
    echo "The following files contained whitespace:"
    echo -e "${trailing_whitespace}"
fi
