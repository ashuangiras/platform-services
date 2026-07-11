output "prometheus_url" {
  description = "Prometheus HTTP address from the host."
  value       = module.observability.prometheus_url
}

output "grafana_url" {
  description = "Grafana UI address from the host."
  value       = module.observability.grafana_url
}

output "prometheus_health" {
  description = "Prometheus health endpoint (OBS-001)."
  value       = module.observability.prometheus_health
}

output "grafana_health" {
  description = "Grafana health endpoint (OBS-001)."
  value       = module.observability.grafana_health
}
