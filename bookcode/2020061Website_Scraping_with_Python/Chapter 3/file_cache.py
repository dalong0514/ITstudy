"""
Tihs file implements a file-based cache.

This approach is very pragmatic and it can be improved in many ways. But for now it is enough.
"""

import glob
import os
from hashlib import blake2b
import zlib


class FileCache:
    def __init__(self, path_to_cache="filecache", compressed=True):
        """
        This function initializes the cache -  it loads the files from the designated folder.
        :return:
        """
        self.__site_cache = {}
        self.__cache_path = path_to_cache
        self.compressed = compressed
        print('loading cache...')
        for file in glob.glob(path_to_cache + '/*', recursive=False):
            with open(file, 'rb') as infile:
                if compressed:
                    self.__site_cache[os.path.basename(file)] = zlib.decompress(infile.read())
                else:
                    self.__site_cache[os.path.basename(file)] = infile.read()
        print('cache initialized')

    def get_content(self, url):
        """
        This function retrieves the content based on the URL.
        :param url: the URL to get the file.
        :return: the retrieved content or None if the site is not in the cache
        """
        filename = self.__get_file_name(url)
        if filename not in self.__site_cache:
            return None
        return self.__site_cache[filename]

    def save_content(self, url, content):
        if not os.path.exists(self.__cache_path):
            os.makedirs(self.__cache_path)
        if not content:
            return
        filename = self.__get_file_name(url)
        with open(self.__cache_path + '/' + filename, 'wb') as outfile:
            if self.compressed:
                outfile.write(zlib.compress(content))
            else:
                outfile.write(content)

    @staticmethod
    def __get_file_name(url):
        return blake2b(url.encode()).hexdigest()


if __name__ == '__main__':
    for file in glob.glob('sainsbury_cache' + '/*', recursive=False):
        filename = os.path.basename(file)
        with open(file) as infile, open('sainsbury_compressed/' + filename, 'wb') as outfile:
            outfile.write(zlib.compress(infile.read().encode()))
