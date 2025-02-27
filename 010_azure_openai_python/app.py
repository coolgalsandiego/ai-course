# Install the following dependencies: azure.identity and azure-ai-inference
import os
from azure.ai.inference import ChatCompletionsClient
from azure.ai.inference.models import SystemMessage, UserMessage
from azure.core.credentials import AzureKeyCredential

endpoint = os.getenv("AZURE_INFERENCE_SDK_ENDPOINT", "https://hubhoussem1968977252.services.ai.azure.com/models")
model_name = os.getenv("DEPLOYMENT_NAME", "gpt-4o")
key = os.getenv("AZURE_INFERENCE_SDK_KEY", "7bsvbdOFsxHIiTYGlltHec9piPWD1TXt3ebOJGMkpV0gpe9RpljCJQQJ99BBAC5T7U2XJ3w3AAAAACOGxPuA")

client = ChatCompletionsClient(endpoint=endpoint, credential=AzureKeyCredential(key))

response = client.complete(
  messages=[
    SystemMessage(content="You are a helpful assistant."),
    UserMessage(content="What are 3 things to visit in Seattle?")
  ],
  model = model_name,
  max_tokens=1000
)

print(response)