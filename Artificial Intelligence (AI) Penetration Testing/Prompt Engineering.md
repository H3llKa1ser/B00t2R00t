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
