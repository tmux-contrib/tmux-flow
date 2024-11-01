# tmux-flow

This plugin displays the [Flow Application](https://flowapp.info/) status.

## Installation

This is a plugin for [tmux plugin
manager](https://github.com/tmux-plugins/tpm). You can install it by adding the
following line in your tmux config.

```shell
set -g @plugin 'tmux-conrib/tmux-flow'
```

## Getting Started

You can use the `#{flow_status}` variable in your existing status line.

```shell
set-option -g status-right '#{flow_status}'
```
