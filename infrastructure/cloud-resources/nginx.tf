resource "helm_release" "nginx_ingress" {
  name = "nginx-ingress-controller"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  depends_on = [azurerm_kubernetes_cluster.aks]
  namespace  = "kube-system"
  version    = "4.0.13"

  wait = true

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path"
    value = "/healthz"
  }

}