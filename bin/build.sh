#!/bin/bash

dir_here="$( cd "$(dirname "$0")" ; pwd -P )"
dir_project_root="$(dirname "${dir_here}")"
dir_venv="${dir_project_root}/venv"
bin_pip="${dir_venv}/bin/pip"

${bin_pip} install -r ${dir_project_root}/requirements-alfred-workflow.txt --target=${dir_project_root}
${bin_pip} install -r ${dir_project_root}/requirements.txt --target=${dir_project_root}/lib
