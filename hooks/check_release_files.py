#!/tools/bin/python
import sys

def check_file_exist(file_path):
    print(f'{file_path}')
    return 0

def main():
    for file_path in sys.argv[1:]:
        check_file_exist(file_path)
