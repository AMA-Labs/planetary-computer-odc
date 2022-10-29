module "resources" {
  source      = "../resources"
  environment = "staging"
  region      = "West Europe"
  # subscription = "Planetary Computer"

  # AKS ----------------------------------------------------------------------
  kubernetes_version = "1.22.11"
  # 2GiB of RAM, 1 CPU core
  core_vm_size              = "Standard_A2_v2"
  user_pool_min_count       = 1
  cpu_worker_pool_min_count = 0

  # Logs ---------------------------------------------------------------------
  workspace_id = "83dcaf36e047a90f"

  # DaskHub ------------------------------------------------------------------
  dns_label                 = "pcc-staging"
  oauth_host                = "login.microsoftonline.com/71f3a1e4-414e-49b2-904b-2b5faf35ec34"
  jupyterhub_host           = "hub.earthanalyticslab.com"
  user_placeholder_replicas = 0
  stac_url                  = "https://planetarycomputer-staging.microsoft.com/api/stac/v1/"

  jupyterhub_singleuser_image_name = "mcr.microsoft.com/planetary-computer/python" # "pcccr.azurecr.io/public/planetary-computer/python"
  jupyterhub_singleuser_image_tag  = "latest"
  python_image                     = "mcr.microsoft.com/planetary-computer/python:latest" # "pcccr.azurecr.io/public/planetary-computer/python:2022.05.11.0"
  odc_image                        = "brianbterry/odc-planetary-computer:pg12"
  r_image                          = "mcr.microsoft.com/planetary-computer/r:2022.01.17.0"
  gpu_pytorch_image                = "mcr.microsoft.com/public/planetary-computer/gpu-pytorch:2022.05.2.0"
  gpu_tensorflow_image             = "mcr.microsoft.com/public/planetary-computer/gpu-tensorflow:2022.02.14.0"
  qgis_image                       = "mcr.microsoft.com/planetary-computer/qgis:3.18.0.1"

  kbatch_proxy_url = "http://dhub-staging-kbatch-proxy.staging.svc.cluster.local"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "pc-manual-resources"
    storage_account_name = "odcstagingtfstate"
    container_name       = "pcc"
    key                  = "staging.tfstate"
  }
}

output "resources" {
  value     = module.resources
  sensitive = true
}
