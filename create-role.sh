#!/bin/bash -xe

# Check that the S3 bucket option has been passed in
# Needed to assign role to that bucket
if [ "$#" -ne 1 ]
then
  echo "Usage: $0 <s3_bucket>"
  exit 1
fi

S3_BUCKET=${1}

# Create role
aws iam create-role --role-name vmimport --assume-role-policy-document "file://trust-policy.json"

# Use role policy template file to create policy file for bucket
cat role-policy.json | sed "s|amzn-s3-demo-import-bucket|${S3_BUCKET}|g" | sed "s|amzn-s3-demo-export-bucket|${S3_BUCKET}|g" > /tmp/role-policy.json

# Change the S3 ARN if using govcloud or the put-role-policy command will fail
if aws configure list | grep region | awk '{print $2}' | grep -i gov
then
  sed -i 's|arn:aws:s3|arn:aws-us-gov:s3|g' /tmp/role-policy.json
fi

# Add role policy
aws iam put-role-policy --role-name vmimport --policy-name vmimport --policy-document "file:///tmp/role-policy.json"

rm -f /tmp/role-policy.json
