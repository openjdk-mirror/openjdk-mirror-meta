#!/usr/bin/env bash

# Clones the repos listed in active-repos.txt


REPOS=( `cat active-repos.txt` )

for REPO in "${REPOS[@]}"
do
    :
    URL="http://hg.openjdk.java.net$REPO"
    REPO_NAME=`echo $REPO | sed 's/^\///' | sed 's/\/$//' | tr '/' '.'`
    REPO_PATH="hg-repos/$REPO_NAME"
    if [ -d "$REPO_PATH" ]; then
      echo "Skipping $REPO_NAME, directory already exists"
    else
      echo "Cloning $URL into $REPO_PATH"
      hg clone -U $URL $REPO_PATH
    fi
done
