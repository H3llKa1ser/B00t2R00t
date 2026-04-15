# Prompt Engineering

## Effective ways to write prompts

### 1) Instruction (task)

Some commands to be used:

    Write
    Summarize
    Compare
    Analyse

Set clear instructions to have a more accurate result.

### 2) Context (background)

Example:

    You are an experienced security engineer specializing in AWS cloud security
    Based on the attached report (Use attached files)

Use context to drastically reduce margin of error

### 3) Output format (structure)

Example:

    Summarise these 3 log samples each in a bullet point, all under 50 words

If you need a summary, specify its length, if you need code, specify language.

### 4) Constraints (boundaries)

Example:

    Write an academic report on IoT devices, provide citations in MLA format, and include a bullet-pointed summary section at the end (do NOT exceed 5 bullets)

Guide the model to follow specific boundaries like forbidding certain topics, enforcing a style guide, mandating a tone.

## Example of a proper prompt that is not too verbose, nor to vague

    Write a JavaScript function that: (1) takes a user object with name, email, and age; (2) validates that email is properly formatted; and (3) returns the validated object or throws an error listing the validation failures.

## Advanced Prompting

### 1) The Shot Spectrum

Zero-shot example (0 examples, LLM relies only on its pre-trained data)

    Classify this log entry as INFO, WARN, or ERROR:
    "2025-02-17 14:23:11 Failed to connect to database after 3 retries"
    
One-shot example (User gives an example to the LLM to improve accuracy of output)

    Extract vulnerability info as JSON:
    Example: "SQL injection in login.php line 47" → {"type": "SQL injection", "file": "login.php", "line": 47}
    Now extract: "XSS vulnerability in search.js line 203"

Few-shot example (Use multiple examples covering various scenarios to dramatically improve performance on complex tasks)

    Classify these authentication events:
    - "User admin logged in from 192.168.1.100" → NORMAL
    - "Failed login attempt for root from 203.0.113.42" → SUSPICIOUS
    - "5 failed logins for user bob in 10 seconds" → ATTACK
    Now classify: "User guest logged in from 10.0.0.5 at 3:47 AM"

Best practice: use 2-3 diverse examples that cover edge cases, and maintain identical structure across examples to avoid ambiguity.

### 2) Chain-of-Thought (CoT)

Ask an LLM to break down complex tasks into intermediate steps (just like a human!). Useful for arithmetic, logic, puzzles and anything that has to do with multi-hop reasoning.

Example:

    Q: A user downloaded "invoice.pdf.exe" from an email. Should this be flagged?
    A: Let me analyse this: First, the file has a double extension (.pdf.exe), which is a common technique to disguise executables. Second, it came from email, a frequent malware delivery vector. Third, legitimate PDFs don't have .exe extensions. This exhibits two red flags: masquerading and suspicious origin. Answer: Yes, flag as high-priority threat.
    Q: A user accessed the admin panel from 192.168.1.50 at 2 AM. Suspicious?

#### Use LLMs with 100B parameters to utilize this well.

Zero-shot CoT example:

    Analyse this security incident and explain your reasoning step by step:
    "User downloaded ransomware.exe, antivirus quarantined it, but 3 hours later 50 files were encrypted."

### 3) Prompt Templates

Example:

    Review this [LANGUAGE] code for [VULNERABILITY_TYPES]:
    Context: [PURPOSE]
    Code: [CODE_BLOCK]
    Output format:
    1. Vulnerabilities found (severity: critical/high/medium/low)
    2. Affected lines
    3. Remediation steps
    4. Example secure code

## Use cases

1) Zero-shot: Simple, well-defined tasks where instructions are clear

2) One-shot: Format clarification or style guidance needed

3) Few-shot: Complex patterns, domain-specific outputs, multiple edge cases

4) Chain-of-Thought: Multi-step reasoning, security analysis requiring justification, debugging complex logic

5) Templates: Repeatable tasks, team standardisation, quality control
