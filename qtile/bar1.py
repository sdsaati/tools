from libqtile.bar import Bar
from libqtile.widget.battery import Battery
from libqtile.widget.clock import Clock
from libqtile.widget.cpu import CPU
from libqtile.widget.currentlayout import CurrentLayout
from libqtile.widget.groupbox import GroupBox
from libqtile.widget.memory import Memory
from libqtile.widget.net import Net
from libqtile.widget.spacer import Spacer
from libqtile.widget.systray import Systray
from libqtile.widget.window_count import WindowCount
from libqtile.widget.windowname import WindowName
from libqtile.widget.textbox import TextBox

from unicodes import left_half_circle, right_arrow, left_arrow, right_half_circle
from colors import *
import jdatetime

BAR_HEIGHT = 28
BAR_MARGIN = 0

bar = Bar(
    [
        GroupBox(
            disable_drag=True,
            active=nord_fox["pink"],
            inactive=nord_fox["black"],
            highlight_method="block",
            highlight_color=nord_fox["blue"],
            block_highlight_text_color=nord_fox["blue"],
            this_current_screen_border=nord_fox["black"],
            borderwidth=0,
            background=nord_fox["bg"],
            spacing=2,
            rounded=True,
        ),
        left_half_circle(nord_fox["red"], nord_fox["bg"]),
        CurrentLayout(
            background=nord_fox["red"],
            foreground=nord_fox["white"],
            margin=10,
        ),
        right_arrow(nord_fox["fg_gutter"], nord_fox["red"]),
        WindowCount(
            text_format="#{num}",
            background=nord_fox["fg_gutter"],
            foreground=nord_fox["white"],
            show_zero=True,
        ),
        right_half_circle(nord_fox["fg_gutter"], nord_fox["bg"]),
        WindowName(background=nord_fox["bg"], foreground=nord_fox["fg"]),
        left_half_circle(nord_fox["black"], nord_fox["bg"]),
        CPU(
            format=" {freq_current}GHz {load_percent}%",
            background=nord_fox["black"],
            foreground=nord_fox["pink"],
        ),
        Memory(
            format=" {MemUsed: .0f}{mm}/{MemTotal: .0f}{mm}",
            background=nord_fox["black"],
            foreground=nord_fox["cyan"],
        ),
        Net(background=nord_fox["black"], foreground=nord_fox["green"]),
        # # Battery(
        # #     background=gruvbox['fg3'],
        # #     format='{char} {percent:2.0%} {hour:d}:{min:02d}'
        # # ),
        left_half_circle(nord_fox["fg_gutter"], nord_fox["black"]),
        Systray(background=nord_fox["fg_gutter"]),
        right_half_circle(nord_fox["fg_gutter"], nord_fox["black"]),
        TextBox(
            " " + jdatetime.date.today().strftime("%Y/%m/%d"),
            background=nord_fox["black"],
            foreground=nord_fox["yellow"],
        ),
        Clock(
            background=nord_fox["black"],
            foreground=nord_fox["white"],
            format="%Y-%m-%d %a %I:%M %p",
        ),
    ],
    # background=nord_fox['bg'],
    size=BAR_HEIGHT,
    margin=BAR_MARGIN,
)
