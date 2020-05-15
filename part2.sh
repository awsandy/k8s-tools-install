echo "IAM role eksworkshop-admin"
aws iam list-instance-profiles-for-role --role-name eksworkshop-admin
aws iam remove-role-from-instance-profile --role-name eksworkshop-admin --instance-profile-name eksworkshop-admin
aws iam delete-role --role-name eksworkshop-admin
aws iam create-role --role-name eksworkshop-admin --assume-role-policy-document file://role-trust-policy.json
aws iam attach-role-policy --role-name eksworkshop-admin --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
aws iam create-instance-profile --instance-profile-name eksworkshop-admin
aws iam add-role-to-instance-profile --instance-profile-name eksworkshop-admin --role-name eksworkshop-admin
instid=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id`
aws ec2 associate-iam-instance-profile --iam-instance-profile eksworkshop-admin --instance-id $instid




rm -vf ${HOME}/.aws/credentials
export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')
test -n "$AWS_REGION" && echo AWS_REGION is "$AWS_REGION" || echo AWS_REGION is not set
echo "export ACCOUNT_ID=${ACCOUNT_ID}" | tee -a ~/.bash_profile
echo "export AWS_REGION=${AWS_REGION}" | tee -a ~/.bash_profile
aws configure set default.region ${AWS_REGION}
aws configure get default.region
aws sts get-caller-identity --query Arn | grep eksworkshop-admin -q && echo "IAM role valid" || echo "IAM role NOT valid"
aws sts get-caller-identity