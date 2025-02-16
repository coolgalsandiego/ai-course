// See https://aka.ms/new-console-template for more information
// Console.WriteLine("Hello, World!");


// Install the .NET library via NuGet: dotnet add package Azure.AI.OpenAI --prerelease
using System.Text.Json;
using Azure;
using Azure.AI.OpenAI;
using Azure.Identity;
using OpenAI.Chat;

using static System.Environment;

async Task RunAsync()
{
    // Retrieve the OpenAI endpoint from environment variables
    var endpoint = "https://hubhd1353090411.openai.azure.com/";
    // var endpoint = GetEnvironmentVariable("AZURE_OPENAI_ENDPOINT");
    if (string.IsNullOrEmpty(endpoint))
    {
        Console.WriteLine("Please set the AZURE_OPENAI_ENDPOINT environment variable.");
        return;
    }

    var key = "CU2G5v03iAwa8qLcj1zfExwmolky573r8rYYW0qimE3Gqzt7WmqBJQQJ99BBAC5T7U2XJ3w3AAAAACOG8QT6";
    // var key = GetEnvironmentVariable("AZURE_OPENAI_KEY");
    if (string.IsNullOrEmpty(key))
    {
        Console.WriteLine("Please set the AZURE_OPENAI_KEY environment variable.");
        return;
    }

    AzureKeyCredential credential = new AzureKeyCredential(key);

    // Initialize the AzureOpenAIClient
    AzureOpenAIClient azureClient = new(new Uri(endpoint), credential);

    // Initialize the ChatClient with the specified deployment name
    ChatClient chatClient = azureClient.GetChatClient("gpt-4o");

    // Create a list of chat messages
    var messages = new List<ChatMessage>
          {
              new SystemChatMessage("You are an AI assistant that helps people find information."),
              new UserChatMessage("What are 3 things to visit in Seattle?")
          };

    // Create chat completion options
    var options = new ChatCompletionOptions
    {
        Temperature = (float)0.7,
        MaxOutputTokenCount = 800,

        FrequencyPenalty = 0,
        PresencePenalty = 0,
    };

    try
    {
        // Create the chat completion request
        ChatCompletion completion = await chatClient.CompleteChatAsync(messages, options);

        // Print the response
        if (completion.Content != null && completion.Content.Count > 0)
        {
            Console.WriteLine($"{completion.Content[0].Kind}: {completion.Content[0].Text}");

            Console.WriteLine("-------------------------");

            Console.WriteLine(JsonSerializer.Serialize(completion.Usage));
        }
        else
        {
            Console.WriteLine("No response received.");
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine($"An error occurred: {ex.Message}");
    }
}

await RunAsync();