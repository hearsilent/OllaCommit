# --- 1. Environment Detection ---
PYTHON_CMD=$(which python3 || echo "/usr/bin/python3")

# --- 2. Input Handling ---
export RAW_INPUT="$1"

$PYTHON_CMD <<'EOF'
import json
import urllib.request
import os
import sys

def run():
    model = "qwen2.5:0.5b" 
    raw_input = os.environ.get('RAW_INPUT', '')
    
    if not raw_input.strip():
        return

    # Pure Instruction Prompt - No Examples to avoid overfitting
    prompt = (
        "Command: Convert the following user input into a professional Git Commit message.\n"
        "Strict Rules:\n"
        "1. Format: <type>: <description>\n"
        "2. Types: feat, fix, docs, style, refactor, perf, test, chore, revert.\n"
        "3. Language: Output MUST be in English.\n"
        "4. Tone: Use imperative mood, start with a lowercase letter, max 50 chars.\n"
        "5. Mapping: Use 'style' for any UI, layout, or visual adjustments.\n\n"
        f"User Input: {raw_input}\n"
        "Git Commit:"
    )

    data = json.dumps({
        "model": model,
        "prompt": prompt,
        "stream": False,
        "options": {
            "temperature": 0.3, # Slightly higher to encourage creative word choice
            "num_predict": 40,
            "stop": ["\n", "User Input:", "Git Commit:"]
        }
    }).encode('utf-8')

    try:
        api_url = "http://localhost:11434/api/generate"
        req = urllib.request.Request(api_url, data=data, headers={'Content-Type': 'application/json'})
        
        with urllib.request.urlopen(req, timeout=5) as f:
            resp = json.loads(f.read().decode('utf-8'))
            content = resp.get('response', '').strip()
            
            if content:
                # Basic cleaning
                clean_output = content.split('\n')[0].replace('"', '').replace("'", "")
                
                # Logic to strictly enforce <type>: <lowercase description>
                if ":" in clean_output:
                    parts = clean_output.split(":", 1)
                    prefix = parts[0].strip().lower()
                    description = parts[1].strip()
                    
                    if description:
                        # Ensure first letter is lowercase, preserve the rest
                        final_desc = description[0].lower() + description[1:]
                        print(f"{prefix}: {final_desc}", end='')
                    else:
                        print(f"{prefix}:", end='')
                else:
                    # Fallback if no colon is present
                    print(clean_output.lower(), end='')
                return
    except:
        pass
    
    # Return original input if anything goes wrong
    print(raw_input, end='')

if __name__ == "__main__":
    run()
EOF