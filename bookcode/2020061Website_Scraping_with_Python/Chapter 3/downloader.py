import requests
from bs4 import BeautifulSoup, SoupStrainer

from chapter_3.file_cache import FileCache


class Downloader:
    def __init__(self, cache=None, parser='html.parser', hard_cache=True):
        if not cache:
            self.cache = FileCache('sainsbury_compressed', compressed=True)
        else:
            self.cache = cache
        self.parser = parser
        self.hard_cache = hard_cache

    def get_contents(self, url, use_cache=True):
        if not use_cache:
            return get_site(url)
        content = self.cache.get_content(url)
        if content:
            return content
        if self.hard_cache:
            return None
        print("cache missed")
        content = get_site(url)
        self.cache.save_content(url, content)
        return content

    def get_soup(self, url, use_cache=True, tag=None, attributes={}):
        c = self.get_contents(url, use_cache)
        strainer = SoupStrainer(name=tag, attrs=attributes)
        if c:
            return BeautifulSoup(c, self.parser, parse_only=strainer)


def get_site(url):
    try:
        r = requests.get(url)
        if r.status_code == 200:
            return r.content
    except Exception as e:
        # logging.exception("Exception while accessing URL '{}'".format(url))
        pass
    return None
