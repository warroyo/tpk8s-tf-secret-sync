
data "azurerm_key_vault" "space-secrets-vault" {
  name                =  var.key_vault_name
  resource_group_name = var.key_vault_rg_name
}

data "azurerm_key_vault_secrets" "space-secrets" {
  key_vault_id = data.azurerm_key_vault.space-secrets-vault.id
}

data "azurerm_key_vault_secret" "space-secret" {
  for_each     = toset(data.azurerm_key_vault_secrets.space-secrets.names)
  name         = each.key
  key_vault_id = data.azurerm_key_vault.space-secrets-vault.id
}




resource "kubectl_manifest" "passwords" {
    force_new = true # needed since secrets can't be merge patched
    for_each = data.azurerm_key_vault_secret.space-secret
    yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: ${each.value.name}
  namespace: default
  annotations:
    tf-automated: "true"
    test: "test"
data:
  value: ${base64encode(each.value.value)}

YAML
}