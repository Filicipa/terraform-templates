resource "digitalocean_app" "frontend" {
  spec {
    name   = "frontend"
    region = "fra"
    # domain {
    #   name = "pepestein.io"
    # }
    alert {
      disabled = false
      rule     = "DEPLOYMENT_FAILED"
    }
    alert {
      disabled = false
      rule     = "DOMAIN_FAILED"
    }
    ingress {
      rule {
        component {
          name                 = "frontend"
          preserve_path_prefix = false
          rewrite              = null
        }
        match {
          path {
            prefix = "/"
          }
        }
      }
    }
    static_site {
      name             = "landing"
      build_command    = "npm run build"
      environment_slug = "node-js"
      output_dir       = "dist"
      source_dir       = "/"
      github {
        branch         = "stage"
        deploy_on_push = true
        repo           = "org/landing"
      }
      env {
        key   = "EXAMPLE"
        value = "example"
        type  = "GENERAL"
      }
    }
  }
  lifecycle {
    ignore_changes = [
      spec[0].static_site[0].env
    ]
  }
}

