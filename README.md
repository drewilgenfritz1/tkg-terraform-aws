# Deploying TMC-SelfManaged


## Prerequisites
- AWS cli installed
- AWS creds put into env variables
- terraform cli installed
- kapp installed
- helm installed
- docker installed
- key pair created in console and saved locally

## Setup

- update tfvars file with env specific variables
- Run the following

```
terraform init
terraform plan --var-file sandbox.tfvars -out=tfplan
# If you want to further inspect the output use the following command
terraform show tfplan
terraform apply -auto-approve tfplan
```

```
aws eks update-kubeconfig $CLUSTER_NAME
export KUBE_CONFIG_PATH=/home/drew/.kube/config
```
