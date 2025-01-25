# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from decimal import Rounded
import os
import subprocess
from libqtile import layout, qtile, widget, hook

# from libqtile import bar
from libqtile.config import (
    Click,
    Drag,
    Group,
    ScratchPad,
    DropDown,
    Key,
    Match,
    Screen,
    KeyChord,
)
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal, send_notification
from colors import nord_fox
from bar1 import bar
import jdatetime

mod = "mod4"
modifier_keys = {
    "M": "mod4",
    "A": "mod1",
    "S": "shift",
    "C": "control",
}
h = "/home/sdsaati/.config/qtile"
terminal = "xfce4-terminal"  # guess_terminal()
home_folder = os.path.expanduser("~")
ranger = os.path.join(home_folder, "bin", "ranger")
qtile_script_folder = os.path.join(home_folder, "bin", "qtile", "saati")
fileManager = f"{terminal} -e {ranger}"
rofi = h + "/saati/rofi.sh combi"
rofi_web_search = h + "/../rofi/web-search.sh"
rofi_monitor_layout = h + "/../rofi/monitor_layout.sh"
logseq = f"{home_folder}/Downloads/Logseq-linux-x64-0.10.9.AppImage --no-sandbox"
nemo = "nemo"

opacity = "FF"
fonts = {
    # "general": "Comic Helvetic Heavy",
    # "general": "MonaSpiceNe Nerd Font Bold",
    "general": "CaskaydiaCove Nerd Font",
    "generalSize": 15,  # was 16
    "delimiter": "CaskaydiaCove Nerd Font",
    "delimiterSize": 18,
    "group": "CaskaydiaCove Nerd Font",  # MonaSpiceNe Nerd Font
    "groupSize": 15,
}

colors = {
    "transparent": "#00000000",
    "Rosewater": "#dc8a78" + opacity,
    "Flamingo": "#dd7878" + opacity,
    "Pink": "#ea76cb" + opacity,
    "Mauve": "#8839ef" + opacity,
    "Red": "#d20f39" + opacity,
    "Maroon": "#e64553" + opacity,
    "Peach": "#fe640b" + opacity,
    "Yellow": "#df8e1d" + opacity,
    "Green": "#40a02b" + opacity,
    "Teal": "#179299" + opacity,
    "Sky": "#04a5e5",
    "Sapphire": "#209fb5",
    "Blue": "#1e66f5",
    "Lavender": "#7287fd",
    "Text": "#4c4f69",
    "Subtext1": "#5c5f77",
    "Subtext0": "#6c6f85",
    "Overlay2": "#7c7f93",
    "Overlay1": "#8c8fa1",
    "Overlay0": "#9ca0b0",
    "Surface2": "#acb0be",
    "Surface1": "#bcc0cc",
    "Surface0": "#ccd0da",
    "Base": "#eff1f5",
    "Mantle": "#e6e9ef",
    "Crust": "#dce0e8",
    "Black": "#000000",
}
# qcolor = {
#    "windowBorderActive": colors["Mauve"],
#    "windowBorderInactive": colors["Crust"],
#    "barBg" : [ colors["Base"], colors["Mantle"],colors["Subtext1"]],
#    "delimiterFg": colors["Blue"],
#    "widgetFg": colors["Text"],
#    "groupFg": colors["Text"],
#    "groupBg": [colors["Mantle"], colors["Text"], colors["Lavender"]],
#    "groupInactive": colors["Subtext0"],
#    "groupActive": colors["Base"],
#    "groupHighLight": colors["Base"],
#    "groupHightlightBg": colors["Blue"],
# }
qcolor = {
    "windowBorderActive": colors["Peach"],
    "windowBorderInactive": colors["transparent"],
    "barBg": [colors["Black"], colors["Black"], colors["Black"]],
    "delimiterFg": colors["Lavender"],
    "widgetFg": colors["Base"],
    "groupFg": colors["Base"],
    "groupBg": [colors["Black"], colors["Black"], colors["transparent"]],
    "groupInactive": colors["Subtext0"],
    "groupActive": colors["Red"],
    "groupHighLight": colors["Base"],
    "groupHightlightBg": colors["Blue"],
}

# #######################
# ALL the key shortcuts:
#########################
keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    # Key([Keycode.CAPSLOCK], "Print", lazy.spawn("flameshot gui"), desc="Launch Flameshot GUI"),
    Key([], "Print", lazy.spawn("flameshot gui"), desc="Launch Flameshot GUI"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key(["mod1"], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key(["mod4"], "Return", lazy.spawn(fileManager), desc="Launch File Manager"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "d", lazy.spawn(rofi), desc="Runs rofi"),
    Key(
        [mod],
        "c",
        lazy.spawn(qtile_script_folder + "/calc.sh"),
        desc="Run Rofi Calculator",
    ),
    Key([mod], "s", lazy.spawn(rofi_web_search), desc="Runs rofi web searcher"),
    Key(
        [mod],
        "p",
        lazy.spawn(rofi_monitor_layout),
        desc="Runs rofi monitor layout picker",
    ),
    Key([mod], "e", lazy.spawn(nemo), desc="Runs nemo file manager"),
    Key([mod], "Pause", lazy.spawn("prop"), desc="Runs xprop"),
    Key(
        [mod],
        "backslash",
        lazy.widget["keyboardlayout"].next_keyboard(),
        desc="Change Keyboard Layout",
    ),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # C U S T O M
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume 0 +5%"),
        desc="Volume Up",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume 0 -5%"),
        desc="volume down",
    ),
    Key(
        [], "XF86AudioMute", lazy.spawn("pulsemixer --toggle-mute"), desc="Volume Mute"
    ),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="playerctl"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="playerctl"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="playerctl"),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl s 10%+"),
        desc="brightness UP",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl s 10%-"),
        desc="brightness Down",
    ),
    # Key([mod], "h", lazy.spawn("roficlip"), desc='clipboard'),
    # Key([mod], "s", lazy.spawn("flameshot gui"), desc='Screenshot'),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
# for vt in range(1, 8):
#    keys.append(
#        Key(
#            ["control", "mod1"],
#            f"f{vt}",
#            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
#            desc=f"Switch to VT{vt}",
#        )
#    )


groups = [
    Group("1", matches=[Match(wm_class="firefox")], layout="columns"),
    Group("2", layout="columns"),
    Group("3", matches=[Match(wm_class="logseq")], layout="columns"),
    Group("4"),
    Group("5", matches=[Match(wm_class="edge")], layout="columns"),
    Group("6"),
    Group("7"),
    Group("8", matches=[Match(wm_class="steam"), Match(wm_class="Telegram")]),
    Group("9", matches=[Match(wm_class="discord")], layout="columns"),
]


for i in groups:

    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

#  ____   ____ ____      _  _____ ____ _   _ ____   _    ____  ____
# / ___| / ___|  _ \    / \|_   _/ ___| | | |  _ \ / \  |  _ \/ ___|
# \___ \| |   | |_) |  / _ \ | || |   | |_| | |_) / _ \ | | | \___ \
#  ___) | |___|  _ <  / ___ \| || |___|  _  |  __/ ___ \| |_| |___) |
# |____/ \____|_| \_\/_/   \_\_| \____|_| |_|_| /_/   \_\____/|____/


groups.append(
    ScratchPad(
        "scratchpad",
        [
            DropDown(
                "term",
                f"{fileManager}",
                width=0.95,
                height=0.95,
                x=0.025,
                y=0.025,
                opacity=1,
            ),
            DropDown(
                "mixer", "pavucontrol", width=0.4, height=0.6, x=0.3, y=0.1, opacity=1
            ),
            DropDown(
                "logseq",
                logseq,
                width=0.9,
                height=0.9,
                x=0.05,
                y=0.05,
                opacity=1,
            ),
            DropDown(
                "blueman",
                "blueman-manager",
                width=0.05,
                height=0.6,
                x=0.35,
                y=0.1,
                opacity=1,
            ),
        ],
    )
)

keys.extend(
    [
        Key([mod], "F1", lazy.group["scratchpad"].dropdown_toggle("term")),
        Key([mod], "F2", lazy.group["scratchpad"].dropdown_toggle("mixer")),
        Key([mod], "F3", lazy.group["scratchpad"].dropdown_toggle("logseq")),
        Key([mod], "F4", lazy.group["scratchpad"].dropdown_toggle("blueman")),
    ]
)
layout_theme = {
    "margin": [0, -3, 0, 0],
    "border_width": 2,
    "border_focus_stack": [
        colors["Green"],
        colors["transparent"],
    ],
    "border_focus": colors["Green"],
    "border_normal": colors["transparent"],
}

layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Columns(**layout_theme),
    # layout.MonadTall(
    #     border_width=3,
    #     border_focus=colors["Green"],
    #     border_normal=colors["transparent"],
    # ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.MonadWide(**layout_theme),
    # layout.RatioTile(),
    # layout.Tile(**layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


def separator():
    return widget.Sep(
        linewidth=0,
        padding=0,
        foreground=qcolor["barBg"],
        background=qcolor["barBg"],
    )


def delimiter(c=None):
    # ༆,𓄻,,,,,🥀,,
    if c is None:
        c = "༆"
    return widget.TextBox(
        text=f"{c}",
        font=fonts["delimiter"],
        foreground=colors["Green"],
        background=qcolor["barBg"],
        padding=0,
        fontsize=fonts["delimiterSize"],
    )


widget_defaults = dict(
    font=fonts["general"],
    fontsize=fonts["generalSize"],
    padding=5,
    foreground=qcolor["widgetFg"],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar,
        # top=bar.Bar(
        #     [
        #         # delimiter(),
        #         # widget.CurrentLayout(fmt="{:^13}"),
        #         widget.CurrentLayoutIcon(),
        #         # delimiter(),
        #         widget.GroupBox(
        #             Rounded=True,
        #             font=fonts["group"],
        #             fontsize=fonts["groupSize"],
        #             disable_drag=True,
        #             padding=2,
        #             highlight_method="block",
        #             block_highlight_text_color=qcolor["groupHighLight"],
        #             this_current_screen_border=qcolor["groupHightlightBg"],
        #             active=qcolor["groupActive"],
        #             inactive=qcolor["groupInactive"],
        #             foreground=qcolor["groupFg"],
        #             background=qcolor["groupBg"],
        #         ),
        #         delimiter("🪶"),
        #         widget.Prompt(),
        #         widget.WindowName(),
        #         widget.Chord(
        #             chords_colors={
        #                 "launch": ("#ff0000", "#ffffff"),
        #             },
        #             name_transform=lambda name: name.upper(),
        #         ),
        #         delimiter(""),
        #         widget.Net(
        #             format="{down:.0f}{down_suffix} ↓↑ {up:.0f}{up_suffix}",
        #             foreground=colors["Yellow"],
        #         ),
        #         # widget.TextBox("default config", name="default"),
        #         # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
        #         # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
        #         # widget.StatusNotifier(),
        #         # widget.NetGraph(),
        #         delimiter(),
        #         widget.NvidiaSensors(
        #             fmt="GPU:{}",
        #             threshold=80,
        #             foreground=qcolor["widgetFg"].replace("#", ""),
        #             foreground_alert="ff6000",
        #         ),
        #         delimiter("💻"),
        #         widget.CPU(foreground=colors["Mauve"]),
        #         delimiter("⌨"),
        #         widget.KeyboardLayout(configured_keyboards=["us", "ir"]),
        #         delimiter(""),
        #         widget.Systray(background=colors["Black"], icon_size=24),
        #         delimiter(" 🔊"),
        #         widget.Volume(foreground=colors["Blue"]),
        #         delimiter(" ⏳"),
        #         widget.Clock(
        #             format="%I:%M%p ⫷ %a ⫸ %Y-%m-%d", foreground=colors["Pink"]
        #         ),
        #         delimiter(" 📅"),
        #         widget.TextBox(
        #             jdatetime.date.today().strftime("%Y/%m/%d"),
        #             foreground=colors["Green"],
        #         ),
        #         delimiter(""),
        #         widget.QuickExit(default_text="🔐"),
        #     ],
        #     fonts["generalSize"] + 14,
        #     background=qcolor["barBg"],
        #     margin=[0, 0, 0, 0],
        #     opacity=0.6,
        #     name="qitle",
        #     border_width=[6, 1, 3, 1],  # Draw top and bottom borders
        #     border_color=[
        #         colors["transparent"],
        #         colors["transparent"],
        #         colors["transparent"],
        #         colors["transparent"],
        #     ],  # Borders are magenta
        # ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        x11_drag_polling_rate=120,
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = True
floats_kept_above = True
cursor_warp = (
    False  # this makes each time a dialog is opened, your cursor goes to center of it
)
floating_layout = layout.Floating(
    border_normal=nord_fox["bg"],
    border_focus=nord_fox["blue"],
    border_width=2,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="steam"),  # steam
        Match(wm_class="dota2"),  # Dota2 game
        Match(wm_class="cs2"),  # Counter Strike 2 game
        # Match(wm_class="mpv"),  # mpv media player
    ],
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False  # True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


# Hook Section:
@hook.subscribe.startup_once
async def autostart_once():
    home = os.path.expanduser("~/.config/qtile/saati/startup_once")
    subprocess.Popen([home])


@hook.subscribe.startup
async def run_every_startup():
    home = os.path.expanduser("~/.config/qtile/saati/startup")
    subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])
    subprocess.Popen([home])
    send_notification("qtile", "Startup")


def float_to_front(qtile):
    for group in qtile.groups:
        for window in group.windows:
            if window.floating:
                window.bring_to_front()


@hook.subscribe.client_focus
def client_focus(client):
    # send_notification("qtile", f"{client.name} has been focused")
    float_to_front(qtile)
