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
from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod1"
modifier_keys = {
   'M': 'mod4',
   'A': 'mod1',
   'S': 'shift',
   'C': 'control',
}
h = '/home/sdsaati/.config/qtile'
terminal = 'xfce4-terminal' #guess_terminal()
fileManager = "xfce4-terminal -e ranger"
rofi = h + '/saati/rofi.sh'


opacity = "AA"
colors = {"transparent": "#00000000",
          "Rosewater": "#f5e0dc"+opacity,
          "Flamingo": "#f2cdcd"+opacity,
          "Pink": "#f5c2e7"+opacity,
          "Mauve": "#cba6f7"+opacity,
          "Red": "#f38ba8"+opacity,
          "Maroon": "#eba0ac"+opacity,
          "Peach": "#fab387"+opacity,
          "Yellow": "#f9e2af"+opacity,
          "Green": "#a6e3a1"+opacity,
          "Teal": "#94e2d5"+opacity,
          "Sky": "#89dceb",
          "Sapphire": "#74c7ec",
          "Blue": "#89b4fa",
          "Lavender": "#b4befe",
          "Text": "#cdd6f4",
          "Subtext1": "#bac2de",
          "Subtext0": "#a6adc8",
          "Overlay2": "#9399b2",
          "Overlay1": "#7f849c",
          "Overlay0": "#6c7086",
          "Surface2": "#585b70",
          "Surface1": "#45475a",
          "Surface0": "#313244",
          "Base": "#1e1e2e",
          "Mantle": "#181825",
          "Crust": "#11111b",          
}
qcolor = {
    "windowBorderActive": colors["Green"],
    "windowBorderInactive": colors["transparent"],
    "barBg" : [ colors["Overlay1"], colors["Base"],colors["Base"]],
    "delimiterFg": colors["Blue"],
    "groupFg": colors["Text"],
    "groupBg": [colors["Green"], colors["Surface1"], colors["Base"]],
    "groupInactive": colors["Surface2"],
    "groupActive": colors["Green"],
    "groupHighLight": colors["Base"],
    "groupHightlightBg": colors["Green"],
}


# #######################
# ALL the key shortcuts:
#########################
keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
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
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
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
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "d", lazy.spawn(rofi), desc="Runs rofi"),
    Key([mod], "Pause", lazy.spawn('prop'), desc="Runs xprop"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # C U S T O M
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +5%"), desc='Volume Up'),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -5%"), desc='volume down'),
    Key([], "XF86AudioMute", lazy.spawn("pulsemixer --toggle-mute"), desc='Volume Mute'),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc='playerctl'),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc='playerctl'),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc='playerctl'),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s 10%+"), desc='brightness UP'),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 10%-"), desc='brightness Down'),
	#Key([mod], "h", lazy.spawn("roficlip"), desc='clipboard'),
    #Key([mod], "s", lazy.spawn("flameshot gui"), desc='Screenshot'),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
#for vt in range(1, 8):
#    keys.append(
#        Key(
#            ["control", "mod1"],
#            f"f{vt}",
#            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
#            desc=f"Switch to VT{vt}",
#        )
#    )


groups = [
    Group("1", matches=[Match(wm_class="Firefox")], layout="max"),
    Group("2"),
    Group("3"),
    Group("4"),
    Group("5"),
    Group("6"),
    Group("7"),
    Group("8", matches=[Match(wm_class="steam")]),
    Group("9", matches=[Match(wm_class="discord")], layout="max"),
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

layout_theme = {
    "margin": [15,15,15,15],
    "border_width": 4,
    "border_focus": qcolor["windowBorderActive"],
    "border_normal": qcolor["windowBorderInactive"],
}

layouts = [
    #layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Columns(**layout_theme),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    #layout.MonadTall(**layout_theme),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

def separator():
    return widget.Sep(linewidth = 0,
                    padding = 0,
                    foreground = qcolor["barBg"],
                    background = qcolor["barBg"],
                    )
def delimiter():
    return widget.TextBox(text = ':',
                    font="ComicShannsMono Nerd Font Regular",
                    foreground = qcolor["delimiterFg"],
                    background = qcolor["barBg"],
                    padding = 0,
                    fontsize = 24 
                    )
    

widget_defaults = dict(
    font="ComicShannsMono Nerd Font Bold",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                separator(),
                widget.CurrentLayout(),
                separator(),
                delimiter(),
                widget.GroupBox(Rounded=True,font="ComicShannsMono Nerd Font Regular",
                                 disable_drag=True,
                                 highlight_method='block',
                                 block_highlight_text_color=qcolor["groupHighLight"],
                                 this_current_screen_border=qcolor["groupHightlightBg"],
                                 active=qcolor["groupActive"],
                                 inactive=qcolor["groupInactive"],
                                 foreground=qcolor["groupFg"],
                                 background=qcolor["groupBg"]),
                delimiter(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Net(format='{down:.0f}{down_suffix} ↓↑ {up:.0f}{up_suffix}'),
                #widget.TextBox("default config", name="default"),
                #widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                #widget.StatusNotifier(),
                widget.NetGraph(),
                delimiter(),
                widget.NvidiaSensors(fmt='GPU:{}',threshold=80, foreground_alert='ff6000'),
                delimiter(),
                widget.CPU(),
                delimiter(),
                widget.KeyboardLayout(configured_keyboards=["us", "ir"]),
                delimiter(),
                widget.Systray(background=colors["Base"], icon_size=24),
                delimiter(),
                widget.Volume(),
                delimiter(),
                #widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.QuickExit(),
            ],
            24,
            background= qcolor["barBg"],
            margin = [0,0,0,0],
            #opacity = 0.4,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = True
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
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
        #Match(wm_class="mpv"),  # mpv media player
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False #True

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
async def autostart():
    home = os.path.expanduser('~/.config/qtile/saati/startup_once')
    subprocess.Popen([home])