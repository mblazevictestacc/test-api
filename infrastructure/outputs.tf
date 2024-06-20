output "hello_app_url" {
  value = azurerm_container_app.hello_app.latest_revision_fqdn
}