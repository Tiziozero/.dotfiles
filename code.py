import sys
import os
import base64

def encode_dir(directory):
    for filename in os.listdir(directory):
        file_path = os.path.join(directory, filename)
        if os.path.isfile(file_path) and not filename.endswith('.b64'):
            with open(file_path, 'rb') as f:
                encoded = base64.b64encode(f.read())
            out_path = file_path + '.b64'
            with open(out_path, 'wb') as f:
                f.write(encoded)
            print(f"Encoded {filename} -> {filename}.b64")

def decode_dir(directory):
    for filename in os.listdir(directory):
        if filename.endswith('.b64'):
            b64_path = os.path.join(directory, filename)
            with open(b64_path, 'rb') as f:
                decoded = base64.b64decode(f.read())
            orig_name = filename[:-4]  # remove '.b64'
            out_path = os.path.join(directory, orig_name)
            with open(out_path, 'wb') as f:
                f.write(decoded)
            print(f"Decoded {filename} -> {orig_name}")

def main():
    if len(sys.argv) != 3:
        print("Usage: python script.py encode <dir> OR python script.py decode <dir>")
        sys.exit(1)

    cmd, directory = sys.argv[1], sys.argv[2]

    if not os.path.isdir(directory):
        print(f"Error: {directory} is not a directory or doesn't exist.")
        sys.exit(1)

    if cmd == 'encode':
        encode_dir(directory)
    elif cmd == 'decode':
        decode_dir(directory)
    else:
        print("Unknown command. Use 'encode' or 'decode'.")
        sys.exit(1)

if __name__ == '__main__':
    main()

