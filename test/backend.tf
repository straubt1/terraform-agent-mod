terraform {
  cloud {
    hostname     = "tfe.hc-6be5777e989c4fab8c400322fcb.gcp.sbx.hashicorpdemo.com"
    organization = "terraform-tom"

    workspaces {
      name = "agent-workspace"
    }
  }
}
