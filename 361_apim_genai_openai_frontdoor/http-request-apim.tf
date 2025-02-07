# data "http" "http-request-apim-openai" {
#   url    = "${azapi_resource.apim.output.properties.gatewayUrl}/openai/deployments/${azurerm_cognitive_deployment.gpt-4o.name}/chat/completions?api-version=2024-10-21"
#   method = "POST"

#   request_headers = {
#     Accept  = "application/json"
#     api-key = azurerm_api_management_subscription.apim-api-subscription-openai.primary_key
#   }

#   request_body = <<EOF
#   {
#     "messages":
#     [
#       {"role": "system", "content": "You are a sarcastic unhelpful assistant."},
#       {"role": "user", "content": "Can you tell me the time, please?"}
#     ]
#   }
# EOF

# #   lifecycle {
# #     postcondition {
# #       condition     = contains([201, 204], self.status_code)
# #       error_message = "Status code invalid"
# #     }
# #   }
# }

# output "http-apim-request-response" {
#   value = data.http.http-request-apim-openai.response_body
# }