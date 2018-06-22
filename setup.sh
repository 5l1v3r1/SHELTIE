#!/bin/bash

#NOTE: this should be run from the logging script repo
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
	#provide help info
	echo "Sets up the logging scripts in the main repo."
	echo "Intended to be run in the same directory as the logging scripts."
	echo "Usage: setup.sh [main-repo-path] [-h] [--help]"
	echo "main-repo-path [optional] - the path to the top level of"
	echo "                            the main repo; uses the level"
	echo "                            above the current directory"
	echo "                            by default"
	echo "-h --help - displays this help message"
elif [ -z "$1" ]; then
	#if we don't have a positional argument,
	#use the level above this by default
	MAIN_REPO=..
else
	#if we have a positional argument passed in,
	#interpert it as the path to the main repo
	MAIN_REPO=$1
fi

#setup the main repo hooks
for hook in commit-msg post-commit ; do
	#move over the main-repo-side hooks
	cp $hook $MAIN_REPO/.git/hooks/$hook
	
	#make sure the hooks are executable
	chmod +x $MAIN_REPO/.git/hooks/$hook
done
