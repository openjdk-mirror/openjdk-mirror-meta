#!/usr/bin/env bash

# Pulls changes from openjdk mercurial repos (for all repos listed in
# active-repos.txt) and pushes them to github or whatever.

GIT_REPO_PREFIX="git+ssh://git@github.com/gfredericks"

REPOS=( `cat active-repos.txt` )

for REPO in "${REPOS[@]}"
do
    :
    REPO_NAME=`echo $REPO | sed 's/^\///' | sed 's/\/$//' | tr '/' '.'`
    REPO_PATH="hg-repos/$REPO_NAME"
    if [ -d "$REPO_PATH" ]; then
      echo "Getting changes for $REPO_NAME..."
      cd $REPO_PATH
      hg pull
      echo "Pushing changes to $GIT_REPO_PREFIX/$REPO_NAME..."
      hg push $GIT_REPO_PREFIX/$REPO_NAME.git
      cd -
    else
      echo "Skipping $REPO_NAME, not cloned yet (try ./bootstrap.sh)"
    fi
done
