# tmux-flow

A tmux plugin that displays the [Flow](https://flowapp.info/) pomodoro timer status in the status bar.

## Features

- Display current Flow session phase (Focus or Break)
- Display remaining time in the current phase
- Customizable icons for each phase

## Requirements

- macOS
- [Flow](https://flowapp.info/) app installed and running

## Installation

### Using TPM

Add the following line to your `~/.tmux.conf`:

```tmux
set -g @plugin 'tmux-contrib/tmux-flow'
```

Then press `prefix` + <kbd>I</kbd> to install.

### Manual

Clone the repository:

```bash
git clone https://github.com/tmux-contrib/tmux-flow ~/.tmux/plugins/tmux-flow
```

Add to your `~/.tmux.conf`:

```tmux
run-shell ~/.tmux/plugins/tmux-flow/main.tmux
```

## Usage

Add the `#{flow_status}` format string to your status bar:

```tmux
set -g status-right "#{flow_status} | %H:%M"
```

### Format Strings

| Format String    | Description                           |
|------------------|---------------------------------------|
| `#{flow_status}` | Current Flow phase and remaining time |

### Configuration

Customize the icons for each phase:

```tmux
# Icon for focus sessions (default: "")
set -g @flow_session_icon ""

# Icon for break periods (default: "")
set -g @flow_break_icon ""
```

### Example Output

- Focus session: ` 24:35`
- Break period: ` 05:00`

## Documentation

See [docs/API.md](docs/API.md) for the full API documentation.

## License

[MIT](LICENSE)
