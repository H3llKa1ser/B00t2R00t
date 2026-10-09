# Garak

### 1) Installation

    pip install garak

### 2) Run a jailbreak probe sweep against an LLM running on the machine

    python3 -m garak --model_type ollama --model_name llama3:8b --probes dan.DAN_Jailbreak

### 3) Run all DAN variants at once

    python3 -m garak --model_type ollama --model_name llama3:8b --probes dan

