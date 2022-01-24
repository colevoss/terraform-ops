locals {
  subscriptions_data = jsondecode(file("../pubsub.json"))
  topics             = toset([for sub in local.subscriptions_data.subscriptions : sub.topic])
  subscriptions = {
    for sub in local.subscriptions_data.subscriptions : sub.name => {
      topic    = sub.topic
      endpoint = sub.endpoint
    }
  }
}

resource "google_pubsub_topic" "topics" {
  for_each = local.topics

  name = each.value

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_pubsub_subscription" "subscriptions" {
  for_each = local.subscriptions

  name  = each.key
  topic = each.value.topic

  push_config {
    push_endpoint = "${google_cloud_run_service.service.status[0].url}${each.value.endpoint}"
  }

  labels = {
    service = "my-service"
  }
}
