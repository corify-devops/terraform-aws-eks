module "olm" {
  source = "./modules/olm"

  count = var.create && var.enable_olm ? 1 : 0
}
