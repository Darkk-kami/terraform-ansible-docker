resource "local_file" "nginx_config" {
  filename = "${path.module}/../../dependencies/nginx/nginx-test.conf"
  content  = templatefile("${path.module}/../../templates/nginx.conf.tpl", {
    domain = var.domain
  })
}
