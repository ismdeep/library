#!python3.8

import requests
from lxml import html


def main():
    req = requests.get(
        url='https://go.dev/dl/'
    )
    tree = html.fromstring(req.content)
    items = tree.xpath('''//a[@class="download"]/@href''')
    for item in items:
        item = item.strip()
        if ('/dl/' not in item) \
                or ('rc' in item) \
                or ('beta' in item) \
                or ('.pkg' in item) \
                or ('.msi' in item):
            continue
        print(item[4:])


if __name__ == '__main__':
    main()
