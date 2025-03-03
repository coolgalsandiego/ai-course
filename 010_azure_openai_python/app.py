# Install the following dependencies: azure.identity and azure-ai-inference
import os
from azure.ai.inference import ChatCompletionsClient
from azure.ai.inference.models import SystemMessage, UserMessage
from azure.core.credentials import AzureKeyCredential

endpoint = os.getenv("AZURE_INFERENCE_SDK_ENDPOINT", "https://ai-services-0013-prod.services.ai.azure.com/models")
model_name = os.getenv("DEPLOYMENT_NAME", "gpt-4o")
key = os.getenv("AZURE_INFERENCE_SDK_KEY", "67a4b1bc5885405c92e17b3ff938929a")

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