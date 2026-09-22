library(mall)
library(ellmer)
library(dplyr)

# 1. Configure an OpenAI-compatible chat connection pointing to LiteLLM
chat <- chat_openai(
  model = "dynamic-router",
  base_url = "http://localhost:4000/v1",
  # Pass a zero-argument function returning your placeholder string
  credentials = function() "any-string" 
)

# 2. Tell mall to use this custom client
llm_use(chat)

# 3. Create sample data
df <- tibble(
  prompts = c(
    #"Fix this bug: def test(): print('hi'", 
    "What is the capital of France?",
    "Why did Alan do this?",
    "What is Ceda?",
    "Email Alan at jane.doe@example.com about the results.",
    "Alan credit card number is 4111 1111 1111 1111, please verify it.",
    "Call Alan on +31 6 12345678 tomorrow.",
    "Alan Smith needs the report by Friday."
  )
)

# 4. Run predictions
results <- df %>% 
  llm_custom(
    col = prompts, 
    prompt = "Answer the user question concisely."
  )

print(results)

