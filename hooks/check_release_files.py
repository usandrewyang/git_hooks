#!/tools/bin/python
def check_file_exist(file_path):
    print(f'{file_path}')
    return retval

def main():
    for file_path in sys.argv[1:]:
        check_file_exist(file_path)
