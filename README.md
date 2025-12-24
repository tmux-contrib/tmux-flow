# tmux-flow

A tmux plugin that displays the [Flow](https://flowapp.info/) pomodoro timer status in the status bar.

## Installation

```tmux
# configure the tmux plugins manager
set -g @plugin "tmux-plugins/tpm"

# official plugins
set -g @plugin 'tmux-contrib/tmux-flow'
```

## Usage

Add the `#{flow_status}` format string to your status bar:

```tmux
set -g status-right "#{flow_status} | %H:%M"
```

### Options

| Option                | Default | Description                   |
|-----------------------|---------|-------------------------------|
| `@flow_session_icon`  | `""`    | Icon for focus sessions       |
| `@flow_break_icon`    | `""`    | Icon for break periods        |

### Format Strings

| Format String    | Description                           |
|------------------|---------------------------------------|
| `#{flow_status}` | Current Flow phase and remaining time |
