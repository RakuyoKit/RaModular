#!/bin/zsh
# Authoer: Rakuyo
# Update Date: 2023.03.28

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <lint|push> <pod_name>"
  exit 1
fi

command=$1
name=$2

lint(){
    pod lib lint $name.podspec --allow-warnings --skip-tests --include-podspecs='*.podspec'
}

publish(){
    pod trunk push $name.podspec --allow-warnings --skip-tests --synchronous
}

main(){
    if [ "$command" == "lint" ]; then
        lint
        exit $?
    fi

    if [ "$command" == "push" ]; then
        publish
        exit $?
    fi

    # Invalid command
    echo "Error: Invalid command. Usage: $0 <lint|push>"
    exit 1
}

main