resource "helm_release" "nginx_ingress" {
  name = "nginx-ingress-controller"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  depends_on = [module.eks]
  namespace  = "kube-system"
  version    = "4.0.13"

  wait = true

}