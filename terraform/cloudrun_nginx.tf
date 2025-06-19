resource "google_cloud_run_service" "duc-bac-nginx-service" {
  name     = "duc-bac-nginx-service"
  project  = var.project_id
  location = var.region

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"        = 10
        "autoscaling.knative.dev/minScale"        = 0
        "run.googleapis.com/vpc-access-connector" = "${module.networks.serverless_vpc_connector_name}"
        "run.googleapis.com/vpc-access-egress"    = "all-traffic"
      }
    }
    spec {
      container_concurrency = 20
      containers {
        image = "nginx:latest"
        name  = "duc-bac-nginx-service"

        ports {
          container_port = 80
        }
        resources {
          limits = {
            cpu    = "1"
            memory = "512Mi"
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true

}

resource "google_cloud_run_service_iam_member" "duc-bac-nginx-service-invoker" {
  service  = google_cloud_run_service.duc-bac-nginx-service.name
  location = var.region
  project  = var.project_id
  role     = "roles/run.invoker"
  member   = "allUsers"
}
