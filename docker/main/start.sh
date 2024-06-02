#!/bin/bash

export HOST_UID=`id -u`
export HOST_NAME=`id -un`

function parse_yml {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s-$s\(.*\)$s\$|\3|p" $1
}

function add_service_compose_file {
  echo " -f ../$1/docker-compose.yml "
}

services_string=$(parse_yml services.yml)

compose_files='-f docker-compose.yml'
while read line ; do
  compose_files+=$(add_service_compose_file $line)
done <<< $services_string

script_dir="$(dirname "$BASH_SOURCE")"

source "${script_dir}/.env"
cd $script_dir

command="docker-compose $compose_files up -d"

echo $command
$command