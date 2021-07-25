#!/bin/bash

dir_here="$( cd "$(dirname "$0")" ; pwd -P )"
dir_project_root="$(dirname "${dir_here}")"
dir_venv="${dir_project_root}/venv"
bin_pip="${dir_venv}/bin/pip"

# Update this manually. Right click your workflow in Alfred Workflow view, then click open in finder.
dir_workflow="/Users/sanhehu/Google Drive/Alfred Setting/Alfred.alfredpreferences/workflows/user.workflow.E388A044-E072-41AE-9860-B23213C86BA6"

rm -r ${dir_workflow}/lib
rm -r ${dir_workflow}/workflow
rm ${dir_workflow}/main.py

${bin_pip} install -r ${dir_project_root}/requirements-alfred-workflow.txt --target=${dir_workflow}
${bin_pip} install ${dir_project_root} --target=${dir_workflow}/lib
cp ${dir_project_root}/main.py ${dir_workflow}/main.py
