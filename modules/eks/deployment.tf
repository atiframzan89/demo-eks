resource "null_resource" "update_kubeconfig" {
  depends_on = [
    aws_eks_cluster.customer-eks
  ]
  provisioner "local-exec" {

    command = "aws eks --region ${var.region} update-kubeconfig --name ${aws_eks_cluster.customer-eks.id}"
  }
}

resource "null_resource" "set_kubeconfig" {
  depends_on = [
    aws_eks_cluster.customer-eks
  ]
  provisioner "local-exec" {

    command = "export KUBE_CONFIG_PATH=~/.kube/config"
  }
}