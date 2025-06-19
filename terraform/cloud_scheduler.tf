resource "google_cloud_scheduler_job" "jobs" {
  for_each         = var.jobs
  name             = each.key
  description      = each.value.description
  schedule         = each.value.schedule
  time_zone        = each.value.timezone
  attempt_deadline = "320s"
  region           = each.value.region

  retry_config {
    retry_count = 1
  }

  http_target {
    http_method = each.value.method
    uri         = each.value.uri
    body        = each.value.body != "" ? base64encode(each.value.body) : null
    headers = each.value.body != "" ? {
      "Content-Type" = "application/json"
    } : {}
  }
}
