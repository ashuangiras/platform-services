variable "network_name" { type = string }
variable "prometheus_data_path" { type = string }
variable "prometheus_config_path" { type = string }
variable "grafana_data_path" { type = string }
variable "prometheus_port" { type = number }
variable "grafana_port" { type = number }
variable "grafana_admin_password" {
  type      = string
  sensitive = true
  default   = ""
}
variable "environment" { type = string }

variable "grafana_oidc_config" {
  description = "Authentik OIDC config for Grafana. Passed to the grafana module."
  type = object({
    client_id     = string
    client_secret = string
    auth_url      = string
    token_url     = string
    api_url       = string
    name          = optional(string, "Authentik")
  })
  sensitive = true
  default   = null
}
