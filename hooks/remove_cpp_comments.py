#!/tools/bin/python
import re
import sys
# import argparse

def fix_file(file_path):
    with open(file_path, 'r') as file:
        content = file.read()

    # Regex for removing C++ style comments
    content = re.sub(r'//.*?$', '', content, flags=re.MULTILINE)  # Single-line comments
    # content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)  # Multi-line comments

    with open(file_path, 'w') as file:
        file.write(content)

def main(argv):
    for file_path in sys.argv[1:]:
        print(f'Fixing {file_path}')
        fix_file(file_path)

if __name__ == "__main__":
   raise SystemExit(main())
