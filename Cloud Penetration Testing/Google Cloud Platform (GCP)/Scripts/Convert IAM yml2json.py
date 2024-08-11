import yaml
import json

with open('policy.yml', 'r') as file:
    configuration = yaml.safe_load(file)

with open('policy.json', 'w') as json_file:
    json.dump(configuration, json_file, indent=2)
