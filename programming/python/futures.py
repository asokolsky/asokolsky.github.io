import concurrent.futures
from os import walk
import os.path
import yaml


def process_file(path: str) -> None:
    print("    file:", os.path.basename(path))
    with open(path) as fh:
        for obj in yaml.safe_load_all(fh):
            # do something with the file content
            print(obj)
    return


def process_dir(path: str) -> None:
    '''
    # namespace_map = collections.defaultdict(set)
    # global_map = collections.defaultdict(set)
    '''
    print("Dir:", path)

    yaml_files = []
    for (dirpath, _, filenames) in walk(path):
        for filename in filenames:
            if filename.endswith('.yaml'):
                yaml_files.append(os.path.join(dirpath, filename))

    with concurrent.futures.ProcessPoolExecutor() as executor:
        futures = [executor.submit(process_file, filepath) for filepath in yaml_files]
        concurrent.futures.wait(futures)

    return


def main(root: str) -> None:
    '''
    For all the subdirs of release: test the dir
    '''
    for item in os.listdir(root):
        path = os.path.join(root, item)
        if os.path.isdir(path):
            process_dir(path)
    return


if __name__ == '__main__':
    main('./foobar')
