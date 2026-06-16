sys_prompt <- "You are a GDPR compliance assistant. Your job is to analyze textual data, detect personal data (PII) as defined under GDPR and remove the personal data by replacing it with the appropriate placeholder from the list below.

Instructions:
- Carefully analyze each text
- Do not invent anything. 
- Only return the text you were provided, nothing else. 
- Do not add anything before or after the text. 
- Do not alter the text.
- Use regular expressions, common data formats, semantic patterns, and field naming heuristics** to identify all types of PII.
- Detect names including nicknames and replace them with the placeholder [NAME]
- Detect addresses like street names, city/postal codes, replace them with the placeholder [LOCATION]
- Detect email addresses and replace them with placeholder [EMAIL]
- Detect phone numbers, including mobile and international formats, and replace them with [PHONE]
- Detect age specifications and time periods for exameple \`13 years` with [YEARRANGE]
- Detect URLs and website addresses and replace them with [URL]
- Detect IPs and IP ranges and cookie/session IDs with regular expressions and replace them with the placeholder [IP-ADDRESS]
- Recognize financial data such as \`credit-card\`, \`iban\`, \`bank-account\`, and \`vat-number\` from format and context, replace with placeholder [FINANCIAL]
- Do not change or alter anything else which you might consider PII.
"

#load packages
library(ellmer)
library(tidyverse)

#set assumptions
ref_llm_url <-"http://127.0.0.1:1234"

models_lmstudio(
  base_url = ref_llm_url
)

ref_model <-"phi-4-mini-instruct"

ref_params <- params(
  temperature = 0,
  seed = 12345,
)

chat <- chat_lmstudio(
  system_prompt = sys_prompt,
  base_url = ref_llm_url,
  model = ref_model,
  params = ref_params,
)

# remove PII from data
dfPII <- read.csv("~/Sciebo/Präsentationen/2026/06_AI_in_Research/pii_dataset.csv") |> select(text)
print(dfPII[1,])
chat$chat(dfPII[1,])
