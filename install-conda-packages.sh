#!/bin/bash

# This script will install the conda packages specified by the user in
# "conda_packages.txt" or the default ones.

set -o errexit
resource_path=$1
echo "==== Installing Conda packages with $(which conda)"

conda info --envs
package_list=${resource_path}/conda_packages.txt

if [ -f ${package_list} ]
then
    printf "Found user-specified conda_packages.txt\n"
    conda_packages="$(cat ${package_list})"
else
    printf "No conda_packages.txt found, installing default packages\n"
    conda_packages="pocl pyvisfile fparser matplotlib pep8 flake8"
fi
if ! command -v mpicc &> /dev/null ;then
    printf "No MPI found. Adding required MPI installation to conda.\n"
    conda_packages="${conda_packages} openmpi openmpi-mpicc"
fi
for conda_package in ${conda_packages}
do
    printf "Installing conda package: ${conda_package}\n"
    conda install --yes ${conda_package}
done
