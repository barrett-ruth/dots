# type: ignore

import os

from qutebrowser.api import interceptor

c = c  # noqa: F821
config = config  # noqa: F821

config.load_autoconfig()

c.downloads.location.directory = os.getenv('XDG_DOWNLOAD_DIR')

c.statusbar.show = 'in-mode'
c.tabs.title.format = '{perc}{index}:{current_title}'
c.tabs.show = 'multiple'
c.tabs.favicons.show = 'never'

c.auto_save.session = True
c.input.insert_mode.auto_load = True
c.qt.highdpi = True
c.scrolling.smooth = True

c.url.default_page = c.url.start_pages = (
    os.getenv('XDG_CONFIG_HOME') + '/qutebrowser/index.html'
)


def filter_yt(info: interceptor.Request):
    url = info.request_url
    if (
        url.host() == 'www.youtube.com'
        and url.path() == '/get_video_info'
        and '&adformat=' in url.query()
    ):
        info.block()


interceptor.register(filter_yt)

# TODO: prefix
# config.bind('b', 'config-cycle statusbar.show in-mode always')
# config.bind('t', 'config-cycle tabs.show multiple always')
config.bind('<Ctrl-W>', 'tab-close', mode='insert')
config.bind('<Ctrl-P>', 'fake-key <Up>', mode='insert')
config.bind('<Ctrl-N>', 'fake-key <Down>', mode='insert')

# TODO: borrow theme from XRESOURCES
config.source('gruvbox.py')

c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://easylist.to/easylist/fanboy-annoyance.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
]

c.content.blocking.enabled = True
c.content.blocking.hosts.lists = [
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts'
]
c.content.blocking.method = 'both'
