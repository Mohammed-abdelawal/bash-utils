#!/bin/bash

# Load environment variables
if [ -f .env ]; then
    source .env
elif [ -f .env.example ]; then
    source .env.example
fi

# Number of lines to read from system logs
LINES=${LOG_LINES:-100}

# Collect latest logs using journalctl if available, otherwise fallback to syslog
if command -v journalctl >/dev/null 2>&1; then
    LOG_CONTENT=$(journalctl -n "$LINES")
else
    LOG_CONTENT=$(tail -n "$LINES" /var/log/syslog 2>/dev/null)
fi

# Export logs for Python script
export LOG_CONTENT

python3 <<'PYTHON'
import os
import openai

api_key = os.getenv('DEEPSEEK_API_KEY')
model = os.getenv('DEEPSEEK_MODEL', 'deepseek-chat')
base_url = os.getenv('DEEPSEEK_BASE_URL', 'https://api.deepseek.com')
logs = os.getenv('LOG_CONTENT', '')

if not api_key:
    raise SystemExit('DEEPSEEK_API_KEY is not set')

openai.api_key = api_key
openai.base_url = base_url + '/v1'

prompt = f"Analyze the following system logs and provide a summary of any issues or notable events:\n{logs}"

response = openai.ChatCompletion.create(
    model=model,
    messages=[{"role": "user", "content": prompt}]
)

print(response.choices[0].message['content'])
PYTHON
