#!/bin/zsh
# Authoer: Rakuyo
# Update Date: 2023.03.28

# Need to be defined in order of dependency
names=(
    "RaModularCore" 
    "RaModularBehavior" 
    "RaModularRouter" 
    "RaModular"
)

lint(){
    pod lib lint $1.podspec --allow-warnings --skip-tests --include-podspecs='*.podspec'
}

publish(){
    pod trunk push $1.podspec --allow-warnings --skip-tests --synchronous
}

release(){
    config_file="ConfigurePodspec.rb"
    version=$(grep -E "^ *version *= *'[0-9]+(\.[0-9]+)*'?" "$config_file" | sed -E "s/^ *version *= *'?(.+)'.*/\1/")

    release_branch=release/$version
    
    git checkout -b $release_branch develop
    
    git_message="[Release] version: $version"
    
    git add . && git commit -m "$git_message"
    
    git checkout main
    git merge --no-ff -m 'Merge branch '$release_branch'' $release_branch
    git push origin main
    git tag $version
    git push origin $version
    git checkout develop
    git merge --no-ff -m 'Merge tag '$version' into develop' $version
    git push origin develop
    git branch -d $release_branch
}

main(){
    project_path=$(cd `dirname $0` ; pwd)
    cd $project_path

    for name in "${names[@]}"; do
        lint $name
        if [ $? -ne 0 ]; then
            exit 1
        fi
    done

    release

    for name in "${names[@]}"; do
        publish $name
        if [ $? -ne 0 ]; then
            exit 1
        fi
    done
}

main