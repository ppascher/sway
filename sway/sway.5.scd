sway(5)

# NAME

sway - configuration file and commands

# DESCRIPTION

A sway configuration file is a list of sway commands that are executed by sway
on startup.  These commands usually consist of setting your preferences and
setting key bindings. An example config is likely present in /etc/sway/config
for you to check out.

Lines in the configuration file might be extended through multiple lines by
adding a '\\' character at the end of line. e.g.:

```
bindsym Shift+XF86AudioRaiseVolume exec \\
	pactl set-sink-volume @DEFAULT_SINK@ -1%
```

Commands can also be given as a block in the form *command { <subcommands...>
}*. Anything before the opening *{* will be prepended to the lines inside the
block. For example:

```
output eDP-1 {
	background ~/wallpaper.png
	resolution 1920x1080
}
```

is identical to

```
output eDP-1 background ~/wallpaper.png
output eDP-1 resolution 1920x1080
```

These commands can be executed in your config file, via *swaymsg*(1), or via
the bindsym command.

# COMMAND CONVENTIONS

Commands are split into several arguments using spaces. You can enclose
arguments with quotation marks (*"..."* or *'...'*) to add spaces to a single
argument. You may also run several commands in order by separating each with
*,* or *;*.

Throughout the documentation, *|* is used to distinguish between arguments for
which you may only select one. *[...]* is used for optional arguments, and
*<...>* for arguments where you are expected to supply some value.

# COMMANDS

The following commands may only be used in the configuration file.

*bar* [<bar-id>] <bar-subcommands...>
	For details on bar subcommands, see *sway-bar*(5).

*default\_orientation* horizontal|vertical|auto
	Sets the default container layout for tiled containers.

*include* <path>
	Includes another file from _path_. _path_ can be either a full path or a
	path relative to the parent config, and expands shell syntax (see
	*wordexp*(3) for details). The same include file can only be included once;
	subsequent attempts will be ignored.

*swaybg\_command* <command>
	Executes custom background _command_. Default is _swaybg_. Refer to
	*sway-output*(5) for more information.

	It can be disabled by setting the command to a single dash:
	_swaybg\_command -_

*swaynag\_command* <command>
	Executes custom command for _swaynag_. Default is _swaynag_. Additional
	arguments may be appended to the end. This should only be used to either
	direct sway to call swaynag from a custom path or to provide additional
	arguments. This should be placed at the top of the config for the best
	results.

	It can be disabled by setting the command to a single dash:
	_swaynag\_command -_

The following commands cannot be used directly in the configuration file.
They are expected to be used with *bindsym* or at runtime through *swaymsg*(1).

*border* none|normal|csd|pixel [<n>]
	Set border style for focused window. _normal_ includes a border of
	thickness _n_ and a title bar. _pixel_ is a border without title bar _n_
	pixels thick. Default is _normal_ with border thickness 2. _csd_ is short
	for client-side-decorations, which allows the client to draw its own
	decorations.

*border* toggle
	Cycles through the available border styles.

*exit*
	Exit sway and end your Wayland session.

*floating* enable|disable|toggle
	Make focused view floating, non-floating, or the opposite of what it is now.

<criteria> *focus*
	Moves focus to the container that matches the specified criteria.

*focus* up|right|down|left
	Moves focus to the next container in the specified direction.

*focus* child
	Moves focus to the last-focused child of the focused container.

*focus* parent
	Moves focus to the parent of the focused container.

*focus* output up|right|down|left
	Moves focus to the next output in the specified direction.

*focus* output <name>
	Moves focus to the named output.

*focus tiling*
	Sets focus to the last focused tiling container.

*focus floating*
	Sets focus to the last focused floating container.

*focus* mode\_toggle
	Moves focus between the floating and tiled layers.

*fullscreen*
	Toggles fullscreen for the focused view.

*layout* default|splith|splitv|stacking|tabbed
	Sets the layout mode of the focused container.

*layout* toggle [split|all]
	Cycles the layout mode of the focused container though a preset list of
	layouts. If no argument is given, then it cycles through stacking, tabbed
	and the last split layout. If "split" is given, then it cycles through
	splith and splitv. If "all" is given, then it cycles through every layout.

*layout* toggle [split|tabbed|stacking|splitv|splith] [split|tabbed|stacking|splitv|splith]...
	Cycles the layout mode of the focused container through a list of layouts.

*move* left|right|up|down [<px> px]
	Moves the focused container in the direction specified. If the container,
	the optional _px_ argument specifies how many pixels to move the container.
	If unspecified, the default is 10 pixels. Pixels are ignored when moving
	tiled containers.

*move* [absolute] position <pos\_x> [px] <pos\_y> [px]
	Moves the focused container to the specified position in the workspace. If
	_absolute_ is used, the position is relative to all outputs.

*move* [absolute] position center
	Moves the focused container to be centered on the workspace. If _absolute_
	is used, it is moved to the center of all outputs.

*move* position cursor|mouse|pointer
	Moves the focused container to be centered on the cursor.

*move* container|window [to] mark <mark>
	Moves the focused container to the specified mark.

*move* [--no-auto-back-and-forth] container|window [to] workspace [number] <name>
	Moves the focused container to the specified workspace. The string "number"
	is optional and is used to match a workspace with the same number, even if
	it has a different name.

*move* container|window [to] workspace prev|next|current
	Moves the focused container to the previous, next or current workspace on
	this output, or if no workspaces remain, the previous or next output.

*move* container|window [to] workspace prev\_on\_output|next\_on\_output
	Moves the focused container to the previous or next workspace on this
	output, wrapping around if already at the first or last workspace.

*move* container|window [to] workspace back\_and\_forth
	Moves the focused container to previously focused workspace.

*move* container|window|workspace [to] output <name>
	Moves the focused container or workspace to the specified output.

*move* container|window|workspace [to] output up|right|down|left
	Moves the focused container or workspace to next output in the specified
	direction.

*move* [to] scratchpad
	Moves the focused window to the scratchpad.

*nop* <comment>
	A no operation command that can be used to override default behaviour. The
	optional comment argument is ignored, but logged for debugging purposes.

*reload*
	Reloads the sway config file and applies any changes.

*resize* shrink|grow width|height [<amount> [px|ppt]]
	Resizes the currently focused container by _amount_, specified in pixels or
	percentage points. If the units are omitted, floating containers are resized
	in px and tiled containers by ppt. _amount_ will default to 10 if omitted.

*resize set* <width> [px|ppt] <height> [px|ppt]
	Sets the width and height of the currently focused container to _width_ and
	_height_, specified in pixels or percentage points. If the units are
	omitted, floating containers are resized in px and tiled containers by ppt.
	If _width_ or _height_ is 0, no resize is done on that axis.

*scratchpad show*
	Shows a window from the scratchpad. Repeatedly using this command will
	cycle through the windows in the scratchpad.

*split* vertical|v|horizontal|h|toggle|t
	Splits the current container, vertically or horizontally. When _toggle_ is
	specified, the current container is split opposite to the parent
	container's layout.

*splith*
	Equivalent to *split horizontal*

*splitv*
	Equivalent to *split vertical*

*splitt*
	Equivalent to *split toggle*

*sticky* enable|disable|toggle
	"Sticks" a floating window to the current output so that it shows up on all
	workspaces.

*swap* container with id|con\_id|mark <arg>
	Swaps the position, geometry, and fullscreen status of two containers. The
	first container can be selected either by criteria or focus. The second
	container can be selected by _id_, _con\_id_, or _mark_. _id_ can only be
	used with xwayland views. If the first container has focus, it will retain
	focus unless it is moved to a different workspace or the second container
	becomes fullscreen on the same workspace as the first container. In either
	of those cases, the second container will gain focus.

The following commands may be used either in the configuration file or at
runtime.

*assign* <criteria> [→] [workspace] [number] <workspace>
	Assigns views matching _criteria_ (see *CRITERIA* for details) to
	_workspace_. The → (U+2192) is optional and cosmetic. This command is
	equivalent to:

		for\_window <criteria> move container to workspace <workspace>

*assign* <criteria> [→] output left|right|up|down|<name>
	Assigns views matching _criteria_ (see *CRITERIA* for details) to the
	specified output. The → (U+2192) is optional and cosmetic. This command is
	equivalent to:

		for\_window <criteria> move container to output <output>

*bindsym* [--release|--locked] [--input-device=<device>] <key combo> <command>
	Binds _key combo_ to execute the sway command _command_ when pressed. You
	may use XKB key names here (*xev*(1) is a good tool for discovering these).
	With the flag _--release_, the command is executed when the key combo is
	released. Unless the flag _--locked_ is set, the command will not be run
	when a screen locking program is active. If _input-device_ is given, the
	binding will only be executed for that input device and will be executed
	instead of any binding that is generic to all devices.

	Example:

		# Execute firefox when alt, shift, and f are pressed together
		bindsym Mod1+Shift+f exec firefox

	*bindcode* [--release|--locked] [--input-device=<device>] <code> <command>
	is also available for binding with key codes instead of key names.

*client.<class>* <border> <background> <text> <indicator> <child\_border>
	Configures the color of window borders and title bars. All 5 colors are
	required, with the exception of *client.background*, which requires exactly
	one. Colors may be specified in hex, either as _#RRGGBB_ or _#RRGGBBAA_.

	The available classes are:

	*client.background*
		Ignored (present for i3 compatibility).

	*client.focused*
		The window that has focus.

	*client.focused\_inactive*
		The most recently focused view within a container which is not focused.

	*client.placeholder*
		Ignored (present for i3 compatibility).

	*client.unfocused*
		A view that does not have focus.

	*client.urgent*
		A view with an urgency hint. *Note*: This is not currently implemented.

	The meaning of each color is:

	_border_
		The border around the title bar.

	_background_
		The background of the title bar.

	_text_
		The text color of the title bar.

	_indicator_
		The color used to indicate where a new view will open. In a tiled
		container, this would paint the right border of the current view if a
		new view would be opened to the right.

	_child\_border_
		The border around the view itself.

The default colors are:

[- *class*
:[ _border_
:[ _background_
:[ _text_
:[ _indicator_
:[ _child\_border_
|[ *background*
:  n/a
:  #ffffff
:  n/a
:  n/a
:  n/a
|  *focused*
:  #4c7899
:  #285577
:  #ffffff
:  #2e9ef4
:  #285577
|  *focused\_inactive*
:  #333333
:  #5f676a
:  #ffffff
:  #484e50
:  #5f676a
|  *unfocused*
:  #333333
:  #222222
:  #888888
:  #292d2e
:  #222222
|  *urgent*
:  #2f343a
:  #900000
:  #ffffff
:  #900000
:  #900000
|  *placeholder*
:  #000000
:  #0c0c0c
:  #ffffff
:  #000000
:  #0c0c0c

*debuglog* on|off|toggle
	Enables, disables or toggles debug logging. _toggle_ cannot be used in the
	configuration file.

*default\_border* normal|none|pixel [<n>]
	Set default border style for new tiled windows.

*default\_floating\_border* normal|none|pixel [<n>]
	Set default border style for new floating windows. This only applies to
	windows that are spawned in floating mode, not windows that become floating
	afterwards.

*exec* <shell command>
	Executes _shell command_ with sh.

*exec\_always* <shell command>
	Like *exec*, but the shell command will be executed _again_ after *reload*.

*floating\_maximum\_size* <width> x <height>
	Specifies the maximum size of floating windows. -1 x -1 removes the upper
	limit.

*floating\_minimum\_size* <width> x <height>
	Specifies the minimum size of floating windows. The default is 75 x 50.

*floating\_modifier* <modifier> [normal|inverse]
	When the _modifier_ key is held down, you may hold left click to move
	windows, and right click to resize them. If _inverse_ is specified, left
	click is used for resizing and right click for moving.

*floating\_scroll* up|right|down|left [command]
	Sets a command to be executed when the mouse wheel is scrolled in the
	specified direction while holding the floating modifier. Resets the
	command, when given no arguments.

*focus\_follows\_mouse* yes|no
	If set to _yes_, moving your mouse over a window will focus that window.

*focus\_wrapping* yes|no|force
	This option determines what to do when attempting to focus over the edge
	of a container. If set to _no_, the focused container will retain focus,
	if there are no other containers in the direction. If set to _yes_, focus
	will be wrapped to the opposite edge of the container, if there are no
	other containers in the direction. If set to _force_, focus will be wrapped
	to the opposite edge of the container, even if there are other containers
	in the direction. Default is _yes_.

*font* <font>
	Sets font for use in title bars in Pango format.

*for\_window* <criteria> <command>
	Whenever a window that matches _criteria_ appears, run list of commands.
	See *CRITERIA* for more details.

*force\_focus\_wrapping* yes|no
	This option is a wrapper to support i3's legacy syntax. _no_ is equivalent
	to _focus\_wrapping yes_ and _yes_ is equivalent to
	_focus\_wrapping force_. This is only available for convenience. Please
	use _focus\_wrapping_ instead when possible.

*gaps* inner|outer <amount>
	Sets default _amount_ pixels of _inner_ or _outer_ gap, where the inner
	affects spacing around each view and outer affects the spacing around each
	workspace. Outer gaps are in addition to inner gaps. To reduce or remove
	outer gaps, outer gaps can be set to a negative value.

	This affects new workspaces only, and is used when the workspace doesn't
	have its own gaps settings (see: workspace <ws> gaps inner|outer <amount>).

*gaps* inner|outer all|current set|plus|minus <amount>
	Changes the _inner_ or _outer_ gaps for either _all_ workspaces or the
	_current_ workspace.

*hide\_edge\_borders* none|vertical|horizontal|both|smart|smart\_no\_gaps
	Hides window borders adjacent to the screen edges. Default is _none_.

*input* <input\_device> <input-subcommands...>
	For details on input subcommands, see *sway-input*(5).

	\* may be used in lieu of a specific device name to configure all input
	devices. A list of input device names may be obtained via *swaymsg -t
	get\_inputs*.

*seat* <seat> <seat-subcommands...>
	For details on seat subcommands, see *sway-input*(5).

*seat* <seat> cursor move|set <x> <y>
	Move specified seat's cursor relative to current position or wrap to
	absolute coordinates (with respect to the global coordinate space).
	Specifying either value as 0 will not update that coordinate.

*seat* <seat> cursor press|release left|right|1|2|3...
	Simulate pressing (or releasing) the specified mouse button on the
	specified seat.

*kill*
	Kills (closes) the currently focused container and all of its children.

*smart\_borders* on|no\_gaps|off
	If smart\_borders are _on_, borders will only be enabled if the workspace
	only has one visible child (identical to _hide\_edge\_borders_ smart). If
	smart\_borders is set to _no\_gaps_, borders will only be enabled if the
	workspace only has one visible child and gaps greater than zero.

*smart\_gaps* on|off
	If smart\_gaps are _on_ gaps will only be enabled if a workspace has more
	than one child.

*mark* --add|--replace [--toggle] <identifier>
	Marks are arbitrary labels that can be used to identify certain windows and
	then jump to them at a later time. By default, *mark* sets _identifier_ as
	the only mark on a window. _--add_ will instead add _identifier_ to the
	list of current marks. If _--toggle_ is specified mark will remove
	_identifier_ if it is already marked.

*mode* <mode>
	Switches to the specified mode. The default mode _default_.

*mode* [--pango\_markup] <mode> <mode-subcommands...>
	The only two valid _mode-subcommands..._ are *bindsym* and *bindcode*.
	If _--pango\_markup_ is given, then _mode_ will be interpreted as pango
	markup.

*mouse\_warping* output|container|none
	If _output_ is specified, the mouse will be moved to new outputs as you
	move focus between them. If _container_ is specified, the mouse will be
	moved to the middle of the container on switch. Default is _output_.

*no\_focus* <criteria>
	Prevents windows matching <criteria> from being focused automatically when
	they're created. This has no effect on the first window in a workspace.

*output* <output\_name> <output-subcommands...>
	For details on output subcommands, see *sway-output*(5).

	\* may be used in lieu of a specific output name to configure all outputs.
	A list of output names may be obtained via *swaymsg -t get\_outputs*.

*popup\_during\_fullscreen* smart|ignore|leave\_fullscreen
	Determines what to do when a fullscreen view opens a dialog.
	If _smart_ (the default), the dialog will be displayed. If _ignore_, the
	dialog will not be rendered. If _leave\_fullscreen_, the view will exit
	fullscreen mode and the dialog will be rendered.

*set* $<name> <value>
	Sets variable $_name_ to _value_. You can use the new variable in the
	arguments of future commands. When the variable is used, it can be escaped
	with an additional $ (ie $$_name_) to have the replacement happen at run
	time instead of when reading the config. However, it does not always make
	sense for the variable to be replaced at run time since some arguments do
	need to be known at config time.

*show\_marks* yes|no
	If *show\_marks* is yes, marks will be displayed in the window borders.
	Any mark that starts with an underscore will not be drawn even if
	*show\_marks* is yes. The default is _yes_.

*opacity* <value>
	Set the opacity of the window between 0 (completely transparent) and 1
	(completely opaque).

*unmark* [<identifier>]
	*unmark* will remove _identifier_ from the list of current marks on a
	window. If _identifier_ is omitted, all marks are removed.

*urgent* enable|disable|allow|deny
	Using _enable_ or _disable_ manually sets or unsets the window's urgent
	state. Using _allow_ or _deny_ controls the window's ability to set itself
	as urgent. By default, windows are allowed to set their own urgency.

*workspace* [--no-auto-back-and-forth] [number] <name>
	Switches to the specified workspace. The string "number" is optional and is
	used to sort workspaces.

*workspace* prev|next
	Switches to the next workspace on the current output or on the next output
	if currently on the last workspace.

*workspace* prev\_on\_output|next\_on\_output
	Switches to the next workspace on the current output.

*workspace* back\_and\_forth
	Switches to the previously focused workspace.

*workspace* <name> gaps inner|outer <amount>
	Specifies that workspace _name_ should have the given gaps settings when it
	is created.

*workspace* <name> output <output>
	Specifies that workspace _name_ should be shown on the specified _output_.

*workspace\_auto\_back\_and\_forth* yes|no
	When _yes_, repeating a workspace switch command will switch back to the
	prior workspace. For example, if you are currently on workspace 1,
	switch to workspace 2, then invoke the "workspace 2" command again, you
	will be returned to workspace 1. Default is _no_.

*workspace\_layout* default|stacking|tabbed
	Specifies the initial layout for new workspaces.

# BAR CONTROL

*bar hidden\_state* hide|show|toggle [<bar\_id>]
	Sets the hidden state of the bar (see *sway-bar*(5)), either individually,
	by specifying a bar id, or if none is given, for all bar instances.
	_toggle_ switches between _hide_ and _show_.

*bar mode* dock|hide|invisible|toggle [<bar\_id>]
	Sets the mode of the bar (see *sway-bar*(5)), either individually,
	by specifying a bar id, or if none is given, for all bar instances.
	_toggle_ switches between _dock_ and _hide_.

# CRITERIA

A criteria is a string in the form of, for example:

```
[class="[Rr]egex.*" title="some title"]
```

The string contains one or more (space separated) attribute/value pairs. They
are used by some commands to choose which views to execute actions on. All
attributes must match for the criteria to match.

Criteria may be used with either the *for\_window* or *assign* commands to
specify operations to perform on new views. A criteria may also be used to
perform specific commands (ones that normally act upon one window) on all views
that match that criteria. For example:

Focus on a window with the mark "IRC":

```
[con_mark="IRC"] focus
```

Kill all windows with the title "Emacs":

```
[class="Emacs"] kill
```

Mark all Firefox windows with "Browser":

```
[class="Firefox"] mark Browser
```

The following attributes may be matched with:

*app\_id*
	Compare value against the app id. Can be a regular expression. If value is
	\_\_focused\_\_, then the app id must be the same as that of the currently
	focused window.

*class*
	Compare value against the window class. Can be a regular expression. If
	value is \_\_focused\_\_, then the window class must be the same as that of
	the currently focused window.

*con\_id*
	Compare against the internal container ID, which you can find via IPC. If
	value is \_\_focused\_\_, then the id must be the same as that of the
	currently focused window.

*con\_mark*
	Compare against the window marks. Can be a regular expression.

*floating*
	Matches floating windows.

*id*
	Compare value against the X11 window ID. Must be numeric.

*instance*
	Compare value against the window instance. Can be a regular expression. If
	value is \_\_focused\_\_, then the window instance must be the same as that
	of the currently focused window.

*shell*
	Compare value against the window shell, such as "xdg\_shell" or "xwayland".
	Can be a regular expression. If value is \_\_focused\_\_, then the shell
	must be the same as that of the currently focused window.

*tiling*
	Matches tiling windows.

*title*
	Compare against the window title. Can be a regular expression. If value is
	\_\_focused\_\_, then the window title must be the same as that of the
	currently focused window.

*urgent*
	Compares the urgent state of the window. Can be "first", "last", "latest",
	"newest", "oldest" or "recent".

*window\_role*
	Compare against the window role (WM\_WINDOW\_ROLE). Can be a regular
	expression. If value is \_\_focused\_\_, then the window role must be the
	same as that of the currently focused window.

*window\_type*
	Compare against the window type (\_NET\_WM\_WINDOW\_TYPE). Possible values
	are normal, dialog, utility, toolbar, splash, menu, dropdown\_menu,
	popup\_menu, tooltip and notification.

*workspace*
	Compare against the workspace name for this view. Can be a regular
	expression. If the value is \_\_focused\_\_, then all the views on the
	currently focused workspace matches.

# SEE ALSO

*sway*(1) *sway-input*(5) *sway-output*(5) *sway-bar*(5)
