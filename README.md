# tmux-flow

> Display [Flow](https://flowapp.info/) pomodoro timer status in your tmux status bar.

[![CI](https://github.com/tmux-contrib/tmux-flow/actions/workflows/ci.yml/badge.svg)](https://github.com/tmux-contrib/tmux-flow/actions/workflows/ci.yml) [![Release](https://img.shields.io/github/v/release/tmux-contrib/tmux-flow)](https://github.com/tmux-contrib/tmux-flow/releases) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Dependencies

- macOS with [Flow](https://flowapp.info/) installed

## Installation

Add this plugin to your `~/.tmux.conf`:

```tmux
set -g @plugin 'tmux-contrib/tmux-flow'
```

And install it by running `<prefix> + I`.

## Usage

Add the `#{flow}` format string to your status bar:

```tmux
set -g status-right "#{flow} | %H:%M"
```

## Configuration

| Option              | Default | Description                   |
|---------------------|---------|-------------------------------|
| `@flow-focus-icon`  | `""`    | Icon for focus sessions       |
| `@flow-break-icon`  | `""`    | Icon for break periods        |

### Format Strings

| Format String | Description                           |
|---------------|---------------------------------------|
| `#{flow}`     | Current Flow phase and remaining time |

## Development

### Prerequisites

Install dependencies using [Nix](https://nixos.org/):

```sh
nix develop
```

Or install manually: `bash`, `tmux`, `bats`

### Running Tests

```sh
bats tests/
```

### Debugging

Enable trace output with the `DEBUG` environment variable:

```sh
DEBUG=1 /path/to/tmux-flow/scripts/tmux_flow.sh
```

## License

MIT
