#!/bin/bash

echo "--- (csu) Container startup code running (nodeApp container)"

# Fallback aliveness option ("cat /tmp/container-alive")
touch /tmp/container-alive

# Move into the operational directory
cd /srv

set INSTALL_COMMAND="npm install"
set BUILD_COMMAND="npm run build"
set START_COMMAND="npm run container-startup"

# Passed in from dockerfile:
#set USER_REPO = "jmarshallpresnell/dockertests"
# or... you can do it this way:
#set GIT_USER="jmarshallpresnell"
#set GIT_REPO="dockertests"

# Set the branch of the repo to deploy
set GIT_BRANCH="deploy"
# To deploy from a non-public repository, you will need a
# username and an OAUTH2 token with read access on the repo.
set GIT_TOKEN="token"

####################################################################
##                                                                ##
## N O   U S E R - S E R V I C A B L E   P I E C E S   B E L O W  ##
##                     (well.... generally)                       ##
##                                                                ##
####################################################################

if [ "$GIT_TOKEN" == ""]; then
    COMMAND="clone -b ${GIT_BRANCH} https://github.com/${USER_REPO}.git"
else
    COMMAND="clone -b ${GIT_BRANCH} https://${GIT_TOKEN}:x-oauth-basic@github.com/${USER_REPO}.git"
fi

# Clone the codebase
echo "--- (csu) Cloning ${USER_REPO} codebase from branch: ${GIT_BRANCH}"
git ${COMMAND} .

# Remove the repo parts
echo "--- (csu) Removing .git directory"
rm -rf ./.git

# Install NPM dependencies
echo "--- (csu) Installing dependencies"
${INSTALL_COMMAND}

# Build the app
if [ "$BUILD_COMMAND" != ""]; then
    echo "--- (csu) Building app"
    ${BUILD_COMMAND}
fi

# Run the app in the container
echo "--- (csu) Running app"
${RUN_COMMAND}

