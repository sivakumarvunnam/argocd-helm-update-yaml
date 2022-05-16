#!/bin/sh -l

sleep 20

git_user=$1
git_password=$2
image_tag=$3
app_name=$4
env=$5
git_repo=$6
git_branch=$7

DIR="$( cd "$( dirname "$0" )" && pwd )" && la -later
VALUES_FILE=$DIR/avetta/configs/${env}/${app_name}/values.yaml
old_tag=$(cat $VALUES_FILE | grep tag: | awk '{print $2}')

if [[ -z $old_tag ]]; then
echo 'tag is null! trying to update tag'
sed -i "s/tag:/tag: $image_tag/" $VALUES_FILE
elif [[ $old_tag != $image_tag ]]; then
echo 'updating tag to `${image_tag}`'
sed -i "s/$old_tag/$image_tag/" $VALUES_FILE
else
echo "Nothing to update"
exit 0
fi

#yq -i eval ".image.tag = \"$image_tag\"" $VALUES_FILE
git remote set-url origin https://github.com/avetta/argocd-helm.git
git config user.email "$git_user"
git config user.name "$git_user@avetta.com"
git add .
git commit -m "Image tag in ${app_name}/values.yaml for ${app_name} with $image_tag"
git push -u origin originize_repo
echo "Updated image tag in ${app_name}/values.yaml for ${app_name}"


status="Updated image tag in ${app_name}/values.yaml for ${app_name}"
echo "::set-output name=status::$status"
