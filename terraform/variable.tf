variable "region" {
  type    = string
  default = "asia-southeast1"
}
variable "project_id" {
  type    = string
  default = "infrateam-playground"
}

variable "jobs" {
  type = map(object({
    description = string
    schedule    = string
    uri         = string
    body        = string
    timezone    = string
    method      = string
    region      = string
  }))
  default = {
    "duc-bac-nginx-job" = {
      description = "Job to trigger the Nginx Cloud Run service"
      schedule    = "0 15 * * *"
      uri         = "https://duc-bac-nginx-service-1046428081626.asia-southeast1.run.app"
      body        = ""
      timezone    = "Asia/Singapore"
      method      = "GET"
      region      = "asia-southeast1"
    }
  }
}
