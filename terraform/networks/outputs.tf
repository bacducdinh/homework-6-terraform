output "serverless_vpc_connector_name" {
  description = "The name of the serverless VPC connector"
  value       = google_vpc_access_connector.duc_bac_serverless_vpc_connector.name
}

output "serverless_vpc_connector_id" {
  description = "The full ID of the serverless VPC connector"
  value       = google_vpc_access_connector.duc_bac_serverless_vpc_connector.id
}
