terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "cana_brava" {
   name   = var.cluster_name 
   #"canabrava-devops"
   region = var.region
   #"nyc1"
   version = "1.23.9-do.0"

  node_pool {
    name       = "default"
    size       = "s-2vcpu-4gb"
    node_count = 3
  }
}

variable "do_token" {}
variable "cluster_name" {}
variable "region" {}

output "kube_endpoint" {
    value = digitalocean_kubernetes_cluster.cana_brava.endpoint
}

resource "local_file" "kube_config" {
    content = digitalocean_kubernetes_cluster.cana_brava.kube_config.0.raw_config
    filename = "kube_config.yaml"  
}
