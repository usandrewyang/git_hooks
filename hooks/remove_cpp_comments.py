#!/tools/bin/python
import re
import sys

def remove_cpp_comments(file_path):
    with open(file_path, 'r') as file:
        content = file.read()

    # Regex for removing C++ style single-line comments
    content = re.sub(r'//.*?$', '', content, flags=re.MULTILINE)

    # Regex for removing C++ style multi-line comments
    # content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)

    # Write the cleaned content back to the file
    with open(file_path, 'w') as file:
        file.write(content)

if __name__ == "__main__":
    for file_path in sys.argv[1:]:
        remove_cpp_comments(file_path)
