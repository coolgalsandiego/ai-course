resource "azurerm_role_assignment" "ai-services" {
  scope                = azurerm_ai_services.ai-services.id
  role_definition_name = "Cognitive Services OpenAI Contributor" # "Cognitive Services OpenAI User"
  principal_id         = data.azurerm_client_config.current.object_id
}

# Your project, "ai-project" does not have permission to access the connected Azure OpenAI resource because its connection is set to use role-based authentication. To resolve this issue, you can either assign the role of Azure AI Developer to your project for the resource, or change the connection's authentication method to use an API key and try again. If you recently added the role, it could take up to 15 minutes for the roles to update.
resource "azurerm_role_assignment" "azure-ai-developer-project-on-ai-services" {
  scope                = azurerm_ai_services.ai-services.id
  role_definition_name = "Azure AI Developer"
  principal_id         = azurerm_ai_foundry_project.project.identity.0.principal_id # azapi_resource.project.identity.0.principal_id
}

# # Your project, "ai-project" does not have permission to access the connected Azure OpenAI resource because its connection is set to use role-based authentication. To resolve this issue, you can either assign the role of Azure AI Developer to your project for the resource, or change the connection's authentication method to use an API key and try again. If you recently added the role, it could take up to 15 minutes for the roles to update.
# resource "azurerm_role_assignment" "azure-ai-developer" {
#   scope                = azapi_resource.project.output.id
#   role_definition_name = "Azure AI Developer"
#   principal_id         = data.azurerm_client_config.current.object_id
# }