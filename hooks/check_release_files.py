#!/tools/bin/python
import sys

def check_file_exist(file_path, files_list):
    print(f'checking {file_path} in {files_list}')
    with open(files_list, "r") as file:
        paths = file.readlines()

    # Check if the target path exists in the file
    if file_path in [line.strip() for line in paths]:
        print(f"{file_path} exists in {files_list}")
        return 1
    else:
        print(f"{file_path} does not exist in {files_list}")
        return 0

def main():
    file_not_found = 0

    print(f'checking FILES.ltsw')
    for file_path in sys.argv[1:]:
        if not check_file_exist(file_path, "FILES.ltsw"):
            file_not_found = 1
            break

    if not file_not_found:
        return file_not_found

    file_not_found = 0
    print(f'checking FILES.esw')
    for file_path in sys.argv[1:]:
        if not check_file_exist(file_path, "FILES.esw"):
            file_not_found = 1
            break

    return file_not_found
