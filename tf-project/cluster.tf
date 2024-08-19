# # build instances on Openstack for a Kubernetes cluster
# variable "K8S_WORKER_COUNT" {}
# variable "K8S_WORKER_FLAVOR" {}
# variable "K8S_IMAGE_NAME" {}
# variable "K8S_NETWORK_NAME" {}
# variable "K8S_KEY_PAIR" {}
# variable "K8S_KEY_PAIR_LOCATION" {}
# variable "K8S_SECURITY_GROUP" {}

terraform {
  required_version = ">= 0.13"
}

resource "local_file" "ansible_inventory" {
  content = <<-EOT
[master]
k8s-master-1 ansible_host=3.27.38.11

[workers]
${join("\n",
  formatlist(
    "%s ansible_host=%s",
    ["worker1"],
    ["54.79.235.236"]
  ))}

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_user=cloud_user
ansible_password=dupa123!
ansible_connection=ssh
ansible_ssh_extra_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
EOT

  file_permission = "0600"
  filename        = "ansible_inventory"
}