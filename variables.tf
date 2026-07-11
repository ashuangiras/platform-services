# ── Shared infrastructure ────────────────────────────────────────────────────
variable "platform_network_name" {
  description = "Name of the Docker network created by platform-infrastructure. All services attach here."
  type        = string
  default     = "platform-backend"
}

# ── Host paths ────────────────────────────────────────────────────────────────
variable "prometheus_data_path" {
  description = "Host path for Prometheus TSDB data. Writable by UID 65534."
  type        = string
  default     = "/srv/platform/prometheus/data"
}

variable "prometheus_config_path" {
  description = "Host path containing prometheus.yml. See observability/config/prometheus.yml.example."
  type        = string
  default     = "/srv/platform/prometheus/config"
}

variable "grafana_data_path" {
  description = "Host path for Grafana data. Writable by UID 472."
  type        = string
  default     = "/srv/platform/grafana/data"
}

# ── Ports ─────────────────────────────────────────────────────────────────────
variable "prometheus_port" {
  description = "Host port for Prometheus."
  type        = number
  default     = 9090
}

variable "grafana_port" {
  description = "Host port for Grafana UI."
  type        = number
  default     = 3000
}

# ── Credentials ───────────────────────────────────────────────────────────────
variable "grafana_admin_password" {
  description = "Grafana admin password (sensitive). Set via TF_VAR or inject from Vault."
  type        = string
  sensitive   = true
  default     = ""
}

# ── Environment ───────────────────────────────────────────────────────────────
variable "environment" {
  description = "Environment label applied to all containers."
  type        = string
  default     = "production"
}
