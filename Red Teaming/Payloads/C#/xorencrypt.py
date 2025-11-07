# Github repo: https://github.com/caueb/PayloadInResources/tree/main
import sys

def xor_file(input_file, output_file, key):
    try:
        with open(input_file, "rb") as f:
            data = f.read()
    except FileNotFoundError:
        print("File not found:", input_file)
        sys.exit(1)

    key = key.encode("utf-8")
    key_len = len(key)
    encrypted_data = bytearray()

    for i in range(len(data)):
        current = data[i]
        current_key = key[i % key_len]
        encrypted_data.append(current ^ current_key)

    with open(output_file, "wb") as f:
        f.write(bytes(encrypted_data))

    print("File encrypted and saved as", output_file)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python xor_encrypt.py <input_file> <output_file> <key>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]
    key = sys.argv[3]

    xor_file(input_file, output_file, key)
