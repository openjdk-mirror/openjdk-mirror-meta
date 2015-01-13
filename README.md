# OpenJDK Github Mirroring

This repository houses the scripts I've been trying to hack together
to make it feasible to regularly and painlessly mirror the OpenJDK
mercurial repos to Github.

I haven't achieved this goal yet, but I'll try to document here what
I've figured out and done so far, and what I think is left to do.

## Tools

I'm working with both Git and Mercurial installed, as well as the
[hg-git](http://hg-git.github.io/) Mercurial plugin, which does the
actual work of converting the Mercurial history to the Git format.

## Challenges

There are three different challenges involved with doing this.

### Organization

As best I can tell, OpenJDK organizes itself into sub-projects, and
many of these projects have their own dedicated set of Mercurial
repos, (e.g., `jdk`, `jaxp`, `corba`, ...), so that they seem to be
functioning similarly to git branches.

This suggests that a helpful mirroring strategy would combine
shared-history mercurial repositories into a single github repository,
e.g. a single `jdk` repository with many branches.


### Time

The initial conversion of a large Mercurial repo (e.g., one of the jdk
repos) takes hours with the hg-git plugin. I assume that incorporating
incremental changes is fast after that, but this means needing to have
the Mercurial repo sitting on disk long term, which brings us to:

### Disk Space

Keeping all the OpenJDK repos on disk in a git-converted state would
require dozens, maybe hundreds, of gigabytes, depending on the exact
strategy employed. Much of this is redundant data, but due to how
Mercurial storage works I don't think there's any easy way around
that.

## This is the end of this README

There's some other details in my head but I'm going to stop writing
now.
