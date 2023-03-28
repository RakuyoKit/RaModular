#!/bin/zsh
# Authoer: Rakuyo
# Update Date: 2023.03.28

project_path=$(cd `dirname $0` ; pwd)
cd $project_path

# Need to be defined in order of dependency
names=(
    "RaModularCore" 
    "RaModularBehavior" 
    "RaModularRouter" 
    "RaModular"
)

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

lintLib(){
    pod lib lint $1.podspec --allow-warnings --skip-tests
}

publish(){
    pod trunk push $1.podspec --allow-warnings --skip-tests
    pod repo update
}

release

for name in "${names[@]}"; do
  lintLib $name && publish $name 
done