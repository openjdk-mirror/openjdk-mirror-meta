#!/usr/bin/env bash

# Scrapes the openjdk website for repo listings, and prints out the
# paths to the repos.

# It's polite not to look when another person uses bash.

PROJECTS=( `curl -s http://hg.openjdk.java.net/ | grep '<td>' | grep -P -o '(?<=>)\w+(?=<)'` )

for PROJECT in "${PROJECTS[@]}"
do
    :
    REPOS=( `curl -s http://hg.openjdk.java.net/$PROJECT | grep '<td>' | grep -P -o '(?<=href=")[^"]*(?=")'` )
    for REPO in "${REPOS[@]}"
    do
        :
        echo "$REPO"
    done
done
