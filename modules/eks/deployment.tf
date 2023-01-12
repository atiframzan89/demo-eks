# # Keycloak Deployment
# resource "kubernetes_deployment" "keycloak" {
#   metadata {
#   name = "keycloak"
#   labels = {
#   "app" = "keycloak"
#   "tier"= "frontend"
#     }
  
#   }
#   spec {
#     replicas = 1
#     selector {
#     match_labels = {
#     "app" = "keycloak"
#     "tier"= "frontend"
#       }
#     }
#     strategy {
#     type = "Recreate"
#     }
#     template {
#     metadata {
#     labels = {
#     "app" = "keycloak"
#     "tier"= "frontend"
#     }
#   }
#   spec {
#     container {
#     image = "quay.io/keycloak/keycloak:17.0.0"
#     name  = "keycloak"
#     image_pull_policy = "Always"
#     args = ["start-dev"]
#     env {
#     name = "KEYCLOAK_ADMIN"
#     value= "qs-admin"
#     }
#     env {
#     name = "KEYCLOAK_ADMIN_PASSWORD"
#     value= "dem0azUba"
#     }
#     # env {
#     # name = "WORDPRESS_DB_USER"
#     # value= var.rds-username
#     # }
#     # env {
#     # name = "WORDPRESS_DB_PASSWORD"
#     # value= var.rds-password
#     # }
#     port {
#     container_port = 8080
#     name = "keycloak-http"
#     }
#     port {
#     container_port = 8443
#     name = "keycloak-https"
#     }
#     # volume_mount {
#     # name = "wordpress-ps"
#     # mount_path = "/var/www/html"
#     #       }
#     }
#     # volume {
#     # name = "wordpress-ps"
#     # persistent_volume_claim {
#     # claim_name = "wordpress-pv-claim"
#     #                   }
#     #             }
#             }
#         }
#     }
#     # depends_on = [aws_eks_node_group.customer-eks-nodes]
#     # timeouts {
#     # create = "30m"
#     #     }
#     }
# resource "kubernetes_service" "keycloak-svc" {
#     depends_on  =   [ kubernetes_deployment.keycloak ]
#     metadata {
#       name = "keycloak-service-update"
#       labels = {
#       "app" = "keycloak"
#       }
#     }
#     spec {
#       selector = {
#       "app" = "keycloak"
#       "tier"= "frontend"
#       }
#       port {
#       port        = 80
#       target_port = 8080
#       # node_port = 30010
#       }
#       type = "NodePort"
#       }
#       # depends_on = [ aws_eks_node_group.customer-eks-nodes ]
#       # timeouts {
#       # create = "15m"
#       # }
#       }

# # DSPWEB Deployment
# resource "kubernetes_deployment" "dspweb" {
#   metadata {
#   name = "dspweb"
#   labels = {
#   "app" = "dspweb"
#     }
  
#   }
#   spec {
#     replicas = 1
#     selector {
#     match_labels = {
#     "app" = "dspweb"
#       }
#     }
#     strategy {
#     type = "Recreate"
#     }
#     template {
#     metadata {
#     labels = {
#     "app" = "dspweb"
#     }
#   }
#   spec {
#     container {
#     image = "055638961298.dkr.ecr.us-east-1.amazonaws.com/sequent/dspweb:eks-demo-7"
#     name  = "dspweb"
#     image_pull_policy = "Always"
#     port {
#     container_port = 80
#     name = "dspweb-http"
#     }
    
    
#         }
#     }
#     # depends_on = [aws_eks_node_group.customer-eks-nodes]
#     # timeouts {
#     # create = "15m"
#     #     }
#     }
#   }
# }
# resource "kubernetes_service" "dspweb-svc" {
#     depends_on = [
#       kubernetes_deployment.dspweb
#     ]
#     metadata {
#       name = "dspweb-svc"
#       labels = {
#       "app" = "dspweb"
#       }
#     }
#     spec {
#       selector = {
#       "app" = "dspweb"
#       }
#       port {
#       port        = 80
#       target_port = 80
#       }
#       type = "NodePort"
#       }
#       # depends_on = [ aws_eks_node_group.customer-eks-nodes ]
#       # timeouts {
#       # create = "15m"
#       # }
#       }

# # Mirth Deployment
# resource "kubernetes_deployment" "mirth" {
#   metadata {
#   name = "mirth"
#   labels = {
#   "app" = "mirth"
#     }
  
#   }
#   spec {
#     replicas = 1
#     selector {
#     match_labels = {
#     "app" = "mirth"
#       }
#     }
#     strategy {
#     type = "Recreate"
#     }
#     template {
#     metadata {
#     labels = {
#     "app" = "mirth"
#     }
#   }
#   spec {
#     container {
#     image = "055638961298.dkr.ecr.us-east-1.amazonaws.com/sequent/mirth:latest"
#     name  = "mirth"
#     image_pull_policy = "Always"
#     port {
#     container_port = 8080
#     name = "mirth-http"
#     }
#     port {
#     container_port = 8443
#     name = "mirth-https"
#     }
    
    
#         }
#     }
#     # depends_on = [aws_eks_node_group.customer-eks-nodes]
#     # timeouts {
#     # create = "15m"
#     #     }
#     }
#   }
# }
# resource "kubernetes_service" "mirth-svc" {
#     depends_on = [
#       kubernetes_deployment.mirth
#     ]
#     metadata {
#       name = "mirth-svc"
#       labels = {
#       "app" = "mirth"
#       }
#     }
#     spec {
#       selector = {
#       "app" = "mirth"
#       }
#       port {
#       port        = 8443
#       target_port = 8080
#       }
#       type = "NodePort"
#       }
#       # depends_on = [ aws_eks_node_group.customer-eks-nodes ]
#       # timeouts {
#       # create = "15m"
#       # }
#       }

# # DSPRest Deployment
# resource "kubernetes_deployment" "dsprest" {
  
#   metadata {
#   name = "dsprest"
#   labels = {
#   "app" = "dsprest"
#     }
  
#   }
#   spec {
#     replicas = 1
#     selector {
#     match_labels = {
#     "app" = "dsprest"
#       }
#     }
#     strategy {
#     type = "Recreate"
#     }
#     template {
#     metadata {
#     labels = {
#     "app" = "dsprest"
#     }
#   }
#   spec {
#     container {
#     image = "055638961298.dkr.ecr.us-east-1.amazonaws.com/sequent/dsprest:eks-demo-28"
#     name  = "dsprest"
#     image_pull_policy = "Always"
#     port {
#     container_port = 8443
#     name = "dsprest-http"
#     }
#     port {
#     container_port = 9718
#     name = "dsprest-https"
#     }
    
    
#         }
#     }
#     # depends_on = [aws_eks_node_group.customer-eks-nodes]
#     # timeouts {
#     # create = "15m"
#     #     }
#     }
#   }
# }
# resource "kubernetes_service" "dsprest-svc" {
#     depends_on = [
#       kubernetes_deployment.dsprest
#     ]
#     metadata {
#       name = "dsprest-svc"
#       labels = {
#       "app" = "dsprest"
#       }
#     }
#     spec {
#       selector = {
#       "app" = "dsprest"
#       }
#       port {
#       port        = 80
#       target_port = 8443
#       }
#       type = "NodePort"
#       }
#       # depends_on = [ aws_eks_node_group.customer-eks-nodes ]
#       # timeouts {
#       # create = "15m"
#       # }
#       }

# resource "kubernetes_ingress_v1" "ingress-keycloak" {
#   # wait_for_load_balancer = true
#   metadata {
#     name = "ingress-keycloak"
#     annotations = {
#       "alb.ingress.kubernetes.io/certificate-arn": "arn:aws:acm:us-west-2:055638961298:certificate/0d5e5df9-3360-4081-9882-262de32c6f54"
#       "alb.ingress.kubernetes.io/scheme": "internet-facing"
#       # "alb.ingress.kubernetes.io/listen-ports": "[{HTTP: 80}, {HTTPS:443}]"
#       "alb.ingress.kubernetes.io/listen-ports": "[{\"HTTP\": 80}, {\"HTTPS\":443}]"
#       "alb.ingress.kubernetes.io/ssl-redirect": "443"
#       "alb.ingress.kubernetes.io/group.name": "ingress-rules"
#       "alb.ingress.kubernetes.io/group.order": "1"
#       # "alb.ingress.kubernetes.io/tags": "Environment=dev","Team=test"
#     }
#   }

#   spec {
#     ingress_class_name = "alb"
#     rule {
#       host = "keycloak-kube.stella-apps.com"
#       http {
#         path {
#           path = "/"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.keycloak-svc.metadata.0.name
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
    
#   }
# }


# resource "kubernetes_ingress_v1" "ingress-dspweb" {
#   # wait_for_load_balancer = true
#   metadata {
#     name = "ingress-dspweb"
#     annotations = {
#       "alb.ingress.kubernetes.io/certificate-arn": "arn:aws:acm:us-west-2:055638961298:certificate/0d5e5df9-3360-4081-9882-262de32c6f54"
#       "alb.ingress.kubernetes.io/scheme": "internet-facing"
#       # "alb.ingress.kubernetes.io/listen-ports": "[{HTTP: 80}, {HTTPS:443}]"
#       "alb.ingress.kubernetes.io/listen-ports": "[{\"HTTP\": 80}, {\"HTTPS\":443}]"
#       "alb.ingress.kubernetes.io/ssl-redirect": "443"
#       "alb.ingress.kubernetes.io/group.name": "ingress-rules"
#       "alb.ingress.kubernetes.io/group.order": "2"
#       # "alb.ingress.kubernetes.io/tags": "Environment=dev","Team=test"
#     }
#   }

#   spec {
#     ingress_class_name = "alb"
#     rule {
#       host = "web-kube.stella-apps.com"
#       http {
#         path {
#           path = "/"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.dspweb-svc.metadata.0.name
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
    
#   }
# }


# # Mirth Ingress
# resource "kubernetes_ingress_v1" "ingress-mirth" {
#   # wait_for_load_balancer = true
#   metadata {
#     name = "ingress-mirth"
#     annotations = {
#       "alb.ingress.kubernetes.io/certificate-arn": "arn:aws:acm:us-west-2:055638961298:certificate/0d5e5df9-3360-4081-9882-262de32c6f54"
#       "alb.ingress.kubernetes.io/scheme": "internet-facing"
#       # "alb.ingress.kubernetes.io/listen-ports": "[{HTTP: 80}, {HTTPS:443}]"
#       "alb.ingress.kubernetes.io/listen-ports": "[{\"HTTP\": 80}, {\"HTTPS\":443}]"
#       "alb.ingress.kubernetes.io/ssl-redirect": "443"
#       "alb.ingress.kubernetes.io/group.name": "ingress-rules"
#       "alb.ingress.kubernetes.io/group.order": "3"
#       # "alb.ingress.kubernetes.io/tags": "Environment=dev","Team=test"
#     }
#   }

#   spec {
#     ingress_class_name = "alb"
#     rule {
#       host = "mirth-kube.stella-apps.com"
#       http {
#         path {
#           path = "/"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.mirth-svc.metadata.0.name
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
    
#   }
# }


# # Ingress DSPRest
# resource "kubernetes_ingress_v1" "ingress-dsprest" {
#   # wait_for_load_balancer = true
#   metadata {
#     name = "ingress-dsprest"
#     annotations = {
#       "alb.ingress.kubernetes.io/certificate-arn": "arn:aws:acm:us-west-2:055638961298:certificate/0d5e5df9-3360-4081-9882-262de32c6f54"
#       "alb.ingress.kubernetes.io/scheme": "internet-facing"
#       # "alb.ingress.kubernetes.io/listen-ports": "[{HTTP: 80}, {HTTPS:443}]"
#       "alb.ingress.kubernetes.io/listen-ports": "[{\"HTTP\": 80}, {\"HTTPS\":443}]"
#       "alb.ingress.kubernetes.io/ssl-redirect": "443"
#       "alb.ingress.kubernetes.io/group.name": "ingress-rules"
#       "alb.ingress.kubernetes.io/group.order": "4"
#       # "alb.ingress.kubernetes.io/tags": "Environment=dev","Team=test"
#     }
#   }

#   spec {
#     ingress_class_name = "alb"
#     rule {
#       host = "dsprest-kube.stella-apps.com"
#       http {
#         path {
#           path = "/"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = kubernetes_service.dsprest-svc.metadata.0.name
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
    
#   }
# }


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