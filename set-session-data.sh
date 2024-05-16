#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)
COMMIT=$(git rev-parse HEAD)
REPO=$(git remote get-url origin)
COMMITTER=$(git log -1 --pretty=format:"%an")
SESSION="session_metadata: branchName=${BRANCH},commitHash=${COMMIT},committer=${COMMITTER},repository=${REPO},environment=dev"

sed -i "s#session_metadata: .*\$#${SESSION}#" contrast_security.yaml
