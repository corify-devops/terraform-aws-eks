resource "aws_eks_addon" "this" {
  cluster_name             = var.cluster_name
  addon_name               = "adot"
  addon_version            = var.adot_version
  service_account_role_arn = aws_iam_role.adot_collector.arn
  resolve_conflicts_on_update = "OVERWRITE"
  depends_on = [
    kubectl_manifest.this
  ]
}

resource "kubernetes_namespace" "this" {
  count = var.create_namespace ? 1 : 0
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_service_account_v1" "adot-collector" {
  metadata {
    name      = local.service_account_name
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.adot_collector.arn
    }
  }
}
