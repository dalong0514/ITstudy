import requests
from bs4 import BeautifulSoup

bs_parser = 'html.parser'


def get_page(url):
    try:
        r = requests.get(url)
        if r.status_code == 200:
            return BeautifulSoup(r.content, bs_parser)
    except Exception as e:
        pass
    return None


def get_sights():
    soup = get_page('https://www.berlin.de/en/attractions-and-sights/')
    if not soup:
        return

    for sight in soup.select('div[class*="teaser"]'):
        h3 = sight.find('h3')
        if not h3:
            continue
        a = h3.find('a')
        if not a:
            continue
        name = a.text
        if not name:
            continue

        description = ''
        div = sight.find('div', class_='inner')
        if div:
            p = div.find('p')
            if p:
                description = p.text
        if not description:
            continue
        yield (name, description)


if __name__ == '__main__':
    with open('berlin_sights.jl', 'w') as outfile:
        for sight in get_sights():
            outfile.write('{' + '"name": "{}", "description": "{}"'.format(sight[0], sight[1]) + '}\n')
