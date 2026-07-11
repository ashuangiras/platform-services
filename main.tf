# Root orchestration — calls each service component.

module "observability" {
  source = "./observability"

  network_name           = var.platform_network_name
  prometheus_data_path   = var.prometheus_data_path
  prometheus_config_path = var.prometheus_config_path
  grafana_data_path      = var.grafana_data_path
  prometheus_port        = var.prometheus_port
  grafana_port           = var.grafana_port
  grafana_admin_password = var.grafana_admin_password
  grafana_oidc_config    = var.grafana_oidc_config
  environment            = var.environment
}
