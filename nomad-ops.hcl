job "nomad-gitops" {
  namespace = "tools"
  datacenters = ["dc1"]
  group "nomad-gitops-group" {
    count = 1
    network {
      mode = "host"
      port "http" {
        static = 3112
      }
    }
    service {
      name = "nomad-gitops"
      tags = ["http","view",
              "urlprefix-/nomad-gitops strip=/nomad-gitops",
               "traefik.enable=true",
               "traefik.http.routers.nomad-gitops.rule=Path(`/nomad-gitops`)"]
      port = "http"
      provider = "consul"

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }
    task "webapp" {
      driver = "docker"

      env {
        NOMAD_ADDR = "http://192.168.122.25:4646"
        CONSUL_ADDR = "http://192.168.122.25:8500"
      }
      config {
        image = "mauu/gitops-main:v2"
        ports = [
          "http",
        ]

      }
      resources {
        cpu    = 200 # MHz
        memory = 500 # MB
      }
    }
  }
}
