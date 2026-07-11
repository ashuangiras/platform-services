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
