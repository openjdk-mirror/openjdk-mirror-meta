#!/usr/bin/env bash

# Scrapes the openjdk website for repo listings, and prints out the
# paths to the repos.

# It's polite not to look when another person uses bash.

while read -r PROJECT; do
    while read -r REPO; do
        echo "/$PROJECT$REPO"
    done < <(curl -s http://hg.openjdk.java.net/$PROJECT | awk -F\" '/<td><a href=/ { print $2 }')
done < <(curl -s http://hg.openjdk.java.net/ | awk -F\" '/<td>/ { print $2 }')
