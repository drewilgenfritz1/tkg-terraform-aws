# tkg-terraform-aws

prerequisites:
-AWS cli installed
-AWS creds put into env variables
-terraform cli installed

Notes:
Jumpbox ami is a custom private ami I created with all the necessary CLI tools installed as well as a template file for the management-cluster.
You will need to manually create your own key pairs and change the values in the terraform before you apply.
This is still a work in progress.
