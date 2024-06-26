#!/bin/bash
changed_files="$(git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD)"

shouldRun() {
  if echo "$changed_files" | grep -E --quiet "$1"; then
    return 0;
  else
    return 1;
  fi
}

check_run() {
  if shouldRun "$1"; then
  	echo "Detected change: \`${1}\`"
  	echo "Executing: ${2}"
  	echo
  	eval "$2"
  fi
}
REPO_ROOT=`git rev-parse --show-toplevel`
check_run ^package-lock.json "cd ${REPO_ROOT} && npm install"
