#!/bin/sh

cat user_pool/terraform.tfstate | jq '.outputs' > ../client/admin/resource/temp_files/user_pool.json
cat id_pool/terraform.tfstate | jq '.outputs' > ../client/user/resource/temp_files/id_pool.json