#!/bin/bash

dir_here="$( cd "$(dirname "$0")" ; pwd -P )"
dir_project_root=$(dirname "${dir_here}")

virtualenv -p /usr/bin/python ${dir_project_root}/venv
