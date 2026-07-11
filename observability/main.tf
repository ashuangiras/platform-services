module "prometheus" {
  source = "git::https://github.com/ashuangiras/platform-modules.git//modules/observability/prometheus?ref=v1.4.0"

  container_name = "platform-prometheus"
  config_path    = var.prometheus_config_path
  data_path      = var.prometheus_data_path
  http_port      = var.prometheus_port
  network_name   = var.network_name

  labels = {
    "platform.env" = var.environment
  }
}

module "grafana" {
  source = "git::https://github.com/ashuangiras/platform-modules.git//modules/observability/grafana?ref=v1.4.0"

  container_name = "platform-grafana"
  data_path      = var.grafana_data_path
  http_port      = var.grafana_port
  network_name   = var.network_name
  prometheus_url = module.prometheus.http_address_internal
  admin_password = var.grafana_admin_password

  # Authentik OIDC — RUN-009b requires all services use Authentik as IDP.
  # oidc_config is populated from Vault secret secret/platform/oidc/grafana
  # via platform-infrastructure integrations/. Pass null to disable OIDC (staging only).
  oidc_config = var.grafana_oidc_config

  labels = {
    "platform.env" = var.environment
  }

  depends_on = [module.prometheus]
}
