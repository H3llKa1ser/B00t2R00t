# Static Heuristic Rules

Some AVs implement heuristic rules for anomaly detection, but:

1) Rules are often rigid, with high false-positive risk.

2) They focus on superficial indicators like suspicious filenames, uncommon API use, or abnormal file sizes.

## Drawbacks:

1) Attackers can bypass heuristics by mimicking benign behavior.

2) AVs rarely correlate multiple actions over time.

### Evasion Tip: Wrap malicious code inside clean-looking wrappers or templates to avoid heuristics (e.g., signed installers, clean icons).
