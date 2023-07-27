# Deploying TMC-SelfManaged


## Prerequisites
- AWS cli installed
- AWS creds put into env variables
- terraform cli installed
- kapp installed
- helm installed
- docker installed

## Setup

- update tfvars file with env specific variables
- Run the following

```
terraform init
terraform plan --var-file sandbox.tfvars -out=plan
terraform apply plan -auto-approve
```

aws eks update-kubeconfig $CLUSTER_NAME
export KUBE_CONFIG_PATH=/home/drew/.kube/config

