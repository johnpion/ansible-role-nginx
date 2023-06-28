#!/bin/bash

# Run ansible-lint only for modified or added files with .yml or .yaml extension
files=$(git diff --name-only --cached --diff-filter=ACM | grep -E "\.(yml|yaml)$")

if [ -n "$files" ]; then
    ansible-lint $files
    lint_result=$?

    if [ $lint_result -ne 0 ]; then
        echo "Ansible-lint check failed. Please review the errors and warnings."
        exit 1
    fi
fi

