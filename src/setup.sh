#!/bin/bash

CONFIG_DIR=$(git rev-parse --show-toplevel)
source "${CONFIG_DIR}/src/utils.sh"

source "${CONFIG_DIR}/src/vscode/setup.sh"
source "${CONFIG_DIR}/src/terminal/setup.sh"
source "${CONFIG_DIR}/src/applications/setup.sh"
