### Link to code: https://raw.githubusercontent.com/hac01/iam-policy-visualize/main/main.py

import json
import graphviz
import re
import sys
import os
import hashlib

def clean_node_name(name):
    """Remove special characters from node name."""
    return re.sub(r"[^a-zA-Z0-9_]+", "_", name)

def get_unique_color(name):
    """Generate a light color based on the hash of the name."""
    hash_object = hashlib.sha256(name.encode())
    hash_hex = hash_object.hexdigest()
    # Use the last 6 characters of the hash to ensure lighter colors
    return '#' + hash_hex[-6:]

def add_node(dot, node_name, shape='box', color='#E1F5FE', fontcolor='#000000'):
    """Add a node with specified attributes to the graph."""
    dot.node(node_name, shape=shape, style='filled', color=color, fontcolor=fontcolor, height='0.6')

def add_edge(dot, source, target, color='#81D4FA'):
    """Add an edge with specified attributes to the graph."""
    dot.edge(source, target, color=color, style='dashed', penwidth='1.2')

def visualize_iam_policy(iam_policy, output_file='iam_policy_graph'):
    try:
        iam_policy = json.loads(iam_policy)
    except json.JSONDecodeError as e:
        print(f"Error parsing JSON data: {e}")
        return

    dot = graphviz.Digraph(comment='IAM Policy Graph', format='png', graph_attr={'bgcolor': '#F2F2F2', 'rankdir': 'LR'})

    for binding in iam_policy.get('bindings', []):
        role = binding.get('role', 'unknown_role')
        for member in binding.get('members', []):
            member_node = clean_node_name(member)

            if member.startswith('serviceAccount:'):
                service_account_color = get_unique_color(member)
                add_node(dot, member_node, shape='box', color=service_account_color, fontcolor='#000000')
            elif member.startswith('user:'):
                add_node(dot, member_node, shape='ellipse', color='#FFF9C4', fontcolor='#000000')
            else:
                add_node(dot, member_node, color='#E1F5FE')

            add_edge(dot, member_node, clean_node_name(role), color='#81D4FA')

        add_node(dot, clean_node_name(role), color='#E1F5FE')

    output_path = os.path.join(os.path.dirname(__file__), f"{output_file}.png")
    dot.render(output_path, cleanup=True)

    print(f"IAM Policy visualization saved as {output_path}")

def main(file_path):
    try:
        with open(file_path, 'r') as file:
            iam_policy_json = file.read()
    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found.")
        return
    except Exception as e:
        print(f"Error reading file: {e}")
        return

    visualize_iam_policy(iam_policy_json, output_file='iam_policy_graph')

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 code.py /path/to/iam.json")
    else:
        main(sys.argv[1])
