import dracula.draw
import sys, os
from qutebrowser.api import interceptor

#Dracula theme
# Load existing settings made via :set
config.load_autoconfig()

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})

# ================== Youtube Add Blocking ======================= {{{
def filter_yt(info: interceptor.Request):
    """Block the given request if necessary."""
    url = info.request_url
    if (
        url.host() == "www.youtube.com"
        and url.path() == "/get_video_info"
        and "&adformat=" in url.query()
    ):
        info.block()


interceptor.register(filter_yt)


config.load_autoconfig(True)

c.auto_save.session = True

c.colors.webpage.preferred_color_scheme = 'dark'

c.downloads.location.directory = "/home/haiyang/Downloads"

c.editor.command = ['st','-e', 'nvim',  '{file}']

c.scrolling.smooth = True

c.spellcheck.languages = ["en-US"]

c.url.searchengines = {
        'DEFAULT': "https://www.google.com/search?&ie=UTF-8&q={}",
        'd': 'https://duckduckgo.com/?q={}',
        "a": "https://wiki.archlinux.org/?search={}"
}

#lazily restore tabs
c.session.lazy_restore=True
#Always show scrolling bar
#c.scrolling.bar="always"
#close the last tab
c.tabs.last_close="close"

c.content.pdfjs=True

c.content.autoplay = False

c.tabs.select_on_remove="last-used"


#Allow popup pages
c.content.javascript.can_open_tabs_automatically=True



#config.bind('D', 'tab-close -o')
config.bind('D', 'tab-close')
config.bind('d', 'scroll-page 0 0.5')
config.bind('u', 'scroll-page 0 -0.5')
config.bind('U', 'undo')
#config.bind('u', 'undo')
#config.bind('U', 'undo -w')


#config.bind('j', 'scroll down')
#config.bind('k', 'scroll up')
config.bind('j', 'scroll-page 0 0.05')
config.bind('k', 'scroll-page 0 -0.05')

# config.bind('<Ctrl-Shift-Tab>', 'completion-item-focus prev-category', mode='command')
# config.bind('<Ctrl-Tab>', 'completion-item-focus next-category', mode='command')
config.bind('<Ctrl-Shift-Tab>', 'tab-prev')
config.bind('<Ctrl-Tab>', 'tab-next')

config.bind('<Ctrl-t>', 'open -t -r')

#choose which window to give tab for 
config.bind('W', 'set-cmd-text -s :tab-give')
#spawn the link into chromium
config.bind("V", "hint links spawn " + "chromium" + ' "{hint-url}"')


config.bind(",m", "spawn mpv {url}")
config.bind(",M", "hint links spawn mpv {hint-url}")
 
 

# https://gist.github.com/Gavinok/f9c310a66576dc00329dd7bef2b122a1 has some good bindings
c.tabs.show = "multiple"
# change title format
c.tabs.title.format = "{audio}{current_title}"
# fonts
c.fonts.web.size.default = 17

#Emacs-like bindings for insert mode
config.bind("<Ctrl-h>", "fake-key <Backspace>", "insert")
config.bind("<Ctrl-a>", "fake-key <Home>", "insert")
config.bind("<Ctrl-e>", "fake-key <End>", "insert")
config.bind("<Ctrl-b>", "fake-key <Left>", "insert")
config.bind("<Mod1-b>", "fake-key <Ctrl-Left>", "insert")
config.bind("<Ctrl-f>", "fake-key <Right>", "insert")
config.bind("<Mod1-f>", "fake-key <Ctrl-Right>", "insert")
config.bind("<Ctrl-p>", "fake-key <Up>", "insert")
config.bind("<Ctrl-n>", "fake-key <Down>", "insert")
config.bind("<Mod1-d>", "fake-key <Ctrl-Delete>", "insert")
config.bind("<Ctrl-d>", "fake-key <Delete>", "insert")
config.bind("<Ctrl-w>", "fake-key <Ctrl-Backspace>", "insert")
config.bind("<Ctrl-u>", "fake-key <Shift-Home><Delete>", "insert")
config.bind("<Ctrl-k>", "fake-key <Shift-End><Delete>", "insert")
config.bind("<Ctrl-x><Ctrl-e>", "open-editor", "insert")

