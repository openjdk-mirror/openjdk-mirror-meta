#!/usr/bin/env bash

# Naive non-incremental method of preparing the merged repo.

# Usage: ./naive-merged-repo.sh [jdk|corba|jaxp|...]

OPENJDK_REPO_NAME=$1

REPOS=( `grep -P "/$OPENJDK_REPO_NAME/$" all-repos.txt` )

rm -rf git-repos hg-repos
mkdir hg-repos
mkdir -p git-repos/$OPENJDK_REPO_NAME
cd git-repos/$OPENJDK_REPO_NAME
git init --bare
cd -

for REPO in "${REPOS[@]}"
do
    :
    REPO_NAMESPACE=`echo $REPO | grep -P -o "(?<=^/).*(?=/$OPENJDK_REPO_NAME/$)"`
    URL="http://hg.openjdk.java.net$REPO"
    REPO_NAME=`echo $REPO | sed 's/^\///' | sed 's/\/$//' | tr '/' '.'`
    REPO_PATH="hg-repos/$REPO_NAME"
    echo "[$(date --rfc-3339=seconds)] starting $REPO_NAME"
    hg clone -U $URL $REPO_PATH
    mkdir -p git-repos/tmp
    cd git-repos/tmp
    git init --bare
    cd -
    cd $REPO_PATH
    hg push ../../git-repos/tmp
    cd ../../git-repos/tmp
    git push ../$OPENJDK_REPO_NAME/ master:$REPO_NAMESPACE/master
    TAGSDIR=../$OPENJDK_REPO_NAME//refs/tags/$REPO_NAMESPACE
    mkdir -p $TAGSDIR
    rmdir $TAGSDIR
    cp -r refs/tags $TAGSDIR
    cd ../..
    rm -rf git-repos/tmp $REPO_PATH
done
