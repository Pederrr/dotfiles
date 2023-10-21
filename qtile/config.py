from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

import subprocess
import os

# tokyonight
colors = {
        "black": "#1a1b26",
        "gray": "#4e5173",
        "red": "#F7768E",
        "green": "#9ECE6A",
        "yellow": "#e5af6a",
        "blue": "#7AA2F7",
        "magenta": "#9a7ecc",
        "cyan": "#9ecbd5",
        "white": "#acb0d0"
        }

mod = "mod4"
terminal = "kitty"
web_browser = "firefox"
wallpaper = "~/.config/qtile/Wallpapers/zoro_wp.png"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

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

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Turn the screen off
    Key([mod, "control"], "Home", lazy.spawn("xset s activate && sleep 0.2 && xset dpms force suspend", shell=True)),

    # Launching applications
    Key([mod], "r", lazy.spawn("rofi -show drun -show-icons")),
    Key([mod], "d", lazy.spawn("rofi -show run")),
    Key([mod], "b", lazy.spawn(web_browser)),

    Key([mod], "f", lazy.window.toggle_floating()),

    # Sound control provided by audioicon tray app
    # Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    # Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 sset Master 5- unmute")),
    # Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 sset Master 5+ unmute"))

    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 10")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 10")),
    Key([mod], "space", lazy.widget["keyboardlayout"].next_keyboard(), desc="Next keyboard layout."),
]

groups = [Group(i) for i in "123456"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )


layout_theme = {
        "border_width": 2,
        "margin": 4,
        "border_focus": colors["cyan"],
        "border_normal": colors["gray"]
        }

layouts = [
    layout.Columns(**layout_theme),
    layout.MonadTall(**layout_theme),
    # layout.Stack(**layout_theme),
    layout.Max(),
    # layout.Bsp(**layout_theme),
    # layout.Matrix(),
    # layout.MonadWide(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Tile(**layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Zoomy(**layout_theme),
]


widget_defaults = dict(
    font="Hack",
    fontsize=12,
    padding=5,
)
extension_defaults = widget_defaults.copy()


def widget_sep(bg: str, fg: str):
    return widget.Sep(
                padding=10,
                foreground=fg,
                background=bg,
            )


def arrow_sep(bg: str, fg: str):
    return widget.TextBox(
                text="",
                background=bg,
                foreground=fg,
                padding=0,
                fontsize=22,
            )

def arrow_sep_right(bg: str, fg: str):
    return widget.TextBox(
                text="",
                background=bg,
                foreground=fg,
                padding=0,
                fontsize=22,
            )


def init_widgets(sys_tray=False):
    return [
            widget.CurrentLayout(
                background=colors["gray"],
            ),
            arrow_sep_right(colors["black"], colors["gray"]),
            widget.Spacer(length=5),
            widget.GroupBox(
                this_current_screen_border=colors["blue"],
                this_screen_border=colors["blue"],
                other_current_screen_border=colors["gray"],
                other_screen_border=colors["gray"],
                urgent_border=colors["red"],
                padding=3,
            ),
            widget.TaskList(
                border=colors["blue"],
                urgent_border=colors["red"],
            ),
            arrow_sep(colors["black"], colors["gray"]),
            widget.Systray(background=colors["gray"]) if sys_tray else widget.Spacer(length=0, background=colors["gray"]),
            widget.Spacer(length=5, background=colors["gray"]),
            arrow_sep(colors["gray"], colors["blue"]),
            widget.KeyboardLayout(
                configured_keyboards=['us', 'sk qwerty'],
                foreground=colors["black"],
                background=colors["blue"],
            ),
            arrow_sep(colors["blue"], colors["green"]),
            widget.Battery(
                charge_char='',
                discharge_char='',
                format='{char} {percent:2.0%}',
                update_interval=10,
                foreground=colors["black"],
                background=colors["green"],
            ),
            arrow_sep(colors["green"], colors["red"]),
            widget.Clock(
                format="%d-%m-%Y %a %H:%M",
                foreground=colors["black"],
                background=colors["red"],
            ),
        ]


screens = [
    Screen(
        top=bar.Bar(
            init_widgets(True),
            25,
            background=colors["black"],
            # opacity = 0.5,
        ),
        wallpaper=wallpaper,
        wallpaper_mode="fill"
    ),
    Screen(
        top=bar.Bar(
            init_widgets(),
            25,
            background=colors["black"],
        ),
        wallpaper=wallpaper,
        wallpaper_mode="fill"
    ),
    Screen(
        top=bar.Bar(
            init_widgets(),
            25,
            background=colors["black"],
        ),
        wallpaper=wallpaper,
        wallpaper_mode="fill"
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
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_width=2,
    border_focus=colors["cyan"],
    border_normal=colors["gray"],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="Volume Control"),  # pavucontrol
        Match(title="Bluetooth Devices"),  # blueman
        Match(title="Proton VPN"),  # protonvpn
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])
    subprocess.call([home + '/Scripts/monitor-home-setup.sh'])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
# wmname = "Qtile"
