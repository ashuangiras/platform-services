output "prometheus_url" {
  value = module.prometheus.http_address
}

output "prometheus_health" {
  value = module.prometheus.health_endpoint
}

output "grafana_url" {
  value = module.grafana.http_address
}

output "grafana_health" {
  value = module.grafana.health_endpoint
}
