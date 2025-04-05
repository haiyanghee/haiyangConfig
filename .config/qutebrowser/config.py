import dracula.draw
import sys, os
from qutebrowser.api import interceptor

#Dracula theme
# Load existing settings made via :set
config.load_autoconfig()


dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 6
    }
})

#Color of the progress loading bar
c.colors.statusbar.progress.bg = "white"

# ================== Youtube Add Blocking ======================= {{{
def filter_yt(info: interceptor.Request):
    #Block the given request if necessary.
    url = info.request_url
    if (
        url.host() == "www.youtube.com"
        and url.path() == "/get_video_info"
        and "&adformat=" in url.query()
    ):
        info.block()

interceptor.register(filter_yt)


"""
#disable host blocking for jblock
c.content.blocking.enabled=False

sys.path.append(os.path.join(sys.path[0], 'jblock'))
config.source("jblock/jblock/integrations/qutebrowser.py")
"""


config.load_autoconfig(True)

# this setting might save you some memory.. 
# more discussion on https://github.com/qutebrowser/qutebrowser/issues/1476
c.qt.force_software_rendering = "qt-quick"

c.auto_save.session = True

c.colors.webpage.preferred_color_scheme = 'dark'

c.downloads.location.directory = "/home/haiyang/Downloads"

c.editor.command = ['alacritty','-e', 'nvim',  '{file}']

c.scrolling.smooth = True

c.spellcheck.languages = ["en-US"]

c.content.headers.accept_language="en-US,en;q=0.9,zh-cn;q=1"

c.url.searchengines = {
        'DEFAULT': "https://www.google.ca/search?&ie=UTF-8&q={}",
        'd': 'https://duckduckgo.com/?q={}',
        "a": "https://wiki.archlinux.org/?search={}"
}

c.statusbar.widgets=["keypress", "history", "url", "scroll", "progress"]

#close download finished tab after 30 seconds
c.downloads.remove_finished=30000


# ":open" start page
c.url.default_page="https://www.google.ca"


#lazily restore tabs
c.session.lazy_restore=True
#Always show scrolling bar
c.scrolling.bar="always"
#close the last tab
c.tabs.last_close="close"

#c.content.pdfjs=True

c.content.autoplay = False

c.tabs.select_on_remove="last-used"

#Allow popup pages
c.content.javascript.can_open_tabs_automatically=True


#hopefully fix most of the escape from input issue?
config.bind('<Escape>', 'mode-leave ;; jseval -q document.activeElement.blur()', mode='insert')




#config.bind('D', 'tab-close -o')
config.bind('D', 'tab-close')
config.bind('d', 'scroll-page 0 0.5')
config.bind('u', 'scroll-page 0 -0.5')
config.bind('U', 'undo')
#config.bind('u', 'undo')
#config.bind('U', 'undo -w')


#config.bind('j', ':run-with-count 2 scroll down')
#config.bind('k', ':run-with-count 2 scroll up')

#config.bind('j', 'scroll-page 0 0.05')
#config.bind('k', 'scroll-page 0 -0.05')

config.bind('h', 'scroll-px -58 0')
config.bind('j', 'scroll-px 0 58 ')
config.bind('k', 'scroll-px 0 -58')
config.bind('l', 'scroll-px 58 0 ')
config.bind('<Ctrl-j>', 'scroll down')
config.bind('<Ctrl-k>', 'scroll up')
config.bind('<Ctrl-h>', 'scroll left')
config.bind('<Ctrl-l>', 'scroll right')


# config.bind('<Ctrl-Shift-Tab>', 'completion-item-focus prev-category', mode='command')
# config.bind('<Ctrl-Tab>', 'completion-item-focus next-category', mode='command')
config.bind('<Ctrl-Shift-Tab>', 'tab-prev')
config.bind('<Ctrl-Tab>', 'tab-next')

config.bind('<Ctrl-t>', 'open -t')
#config.bind('tt', 'open -t -r')
#config.bind('tT', 'set-cmd-text -s :open -t')
config.bind('tt', 'set-cmd-text -s :open -t')

config.bind('O', 'set-cmd-text -s :open -t -r')


config.bind('Pp', "open -t -r -- {clipboard}")
config.bind('PP', "open -t -r -- {primary}")


#choose which window to give tab for 
config.bind('W', 'set-cmd-text -s :tab-give')
#spawn the link into chromium
config.bind("V", "hint links spawn " + "chromium" + ' "{hint-url}"')


config.bind(",m", "spawn mpv {url}")
config.bind(",M", "hint links spawn mpv {hint-url}")
 
 

# https://gist.github.com/Gavinok/f9c310a66576dc00329dd7bef2b122a1 has some good bindings
# change title format
c.tabs.title.format = "{private}{perc}{audio}{current_title}"
c.tabs.title.format_pinned="{private}{perc}{title_sep}"
# fonts
#c.fonts.web.size.default = 17

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
#config.bind("<Ctrl-x><Ctrl-e>", "open-editor", "insert")
config.bind("<Ctrl-x><Ctrl-e>", 'edit-text', "insert")

config.unbind("<Ctrl-q>")
config.unbind("ZQ")
