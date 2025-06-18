resource "google_cloud_run_service" "nginx-service" {
  name     = "nginx-service"
  project  = var.project_id
  location = var.region

  template {
    spec {
        container_concurrency = 10
      containers {
        image = "nginx:latest"
        name = "nginx-service"

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

resource "google_cloud_run_service_iam_member" "nginx_service_all_users" {
  location = var.region
  project  = var.project_id
  service  = google_cloud_run_service.nginx-service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}