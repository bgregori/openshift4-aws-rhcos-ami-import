# openshift4-aws-rhcos-ami-import

The scripts in this repo assume you have the `aws` CLI installed and configured.

- Ensure your AWS account has the proper VMIE role. If it does not, use the create-role.sh script

```
./create-role.sh <s3 bucket name to allow role operation on>
```

- Modify the configuration at the top of the rhcos_ami.sh script for your environment. Specifically make sure to set:
```
S3_BUCKET="s3-your-bucket-name-here"
```
- Execute the script to create the AMI
```
./rhcos_ami.sh
```

