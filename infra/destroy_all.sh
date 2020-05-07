#!/bin/sh

base_dir=$(pwd)

echo '\n==================== id_pool\n'
cd ${base_dir}/id_pool
terraform init
terraform plan -destroy
terraform destroy -auto-approve

echo "\n==================== user_pool\n"
cd ${base_dir}/user_pool
terraform init
terraform plan -destroy
terraform destroy -auto-approve

cd ${base_dir}
./resource_publisher.sh