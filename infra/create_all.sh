#!/bin/sh

base_dir=$(pwd)

echo "\n==================== user_pool\n"
cd ${base_dir}/user_pool
terraform init
terraform plan
terraform apply -auto-approve

echo '\n==================== id_pool\n'
cd ${base_dir}/id_pool
terraform init
terraform plan
terraform apply -auto-approve

cd ${base_dir}
./resource_publisher.sh
