#!/bin/bash

git config --global alias.lola "log --graph --decorate --pretty=oneline --abbrev-commit --all"
git config --global alias.lol "log --decorate --pretty=oneline --abbrev-commit"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=7200'

cd ~/exercises

unzip tracker-workshop.zip
rm tracker-workshop.zip

git remote remove origin
git tag -d v1
git tag -d v2
