#!/bin/sh -l

sleep 20

git_user=$1
git_password=$2
image_tag=$3
app_name=$4
env=$5
git_repo=$6
git_branch=$7

mkdir -p /tmp/eks-deployment
git clone -b ${git_branch} https://$git_user:$git_password@github.com/$git_repo /tmp/eks-deployment
cd /tmp/eks-deployment/avetta/config/${env}
yq -i eval ".image.tag = \"$image_tag\"" ${app_name}/values.yaml
git config user.email "$git_user"
git config user.name "$git_user"
git add .
git commit -m "Image tag in ${app_name}/values.yaml for ${app_name} with $image_tag"
git push
echo "Updated image tag in ${app_name}/values.yaml for ${app_name}"


status="Updated image tag in ${app_name}/values.yaml for ${app_name}"
echo "::set-output name=status::$status"
