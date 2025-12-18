# tmux-flow API Documentation

This document describes the public API for the tmux-flow plugin.

## Table of Contents

- [Overview](#overview)
- [Format Strings](#format-strings)
- [Configuration](#configuration)
- [Core Functions](#core-functions)
  - [tmux_get_option](#tmux_get_option)
  - [tmux_set_option](#tmux_set_option)
- [Plugin Functions](#plugin-functions)
  - [main (tmux-flow.sh)](#main-tmux-flowsh)
  - [tmux_interpolate](#tmux_interpolate)
  - [tmux_update_option](#tmux_update_option)
- [macOS Integration](#macos-integration)
  - [tmux-flow.scpt](#tmux-flowscpt)

---

## Overview

The tmux-flow plugin displays the current status of the Flow app (a macOS
pomodoro timer) in the tmux status bar. It shows the current phase (focus
or break) and the remaining time.

## Format Strings

| Format String   | Description                              |
|-----------------|------------------------------------------|
| `#{flow_status}`| Current Flow app phase and time          |

**Usage Example:**
```tmux
set -g status-right "#{flow_status} | %H:%M"
```

## Configuration

| Option              | Description                    | Default |
|---------------------|--------------------------------|---------|
| `@flow_break_icon`  | Icon for break phase           | `""`    |
| `@flow_session_icon`| Icon for focus session         | `""`    |

**Example:**
```tmux
set -g @flow_break_icon ""
set -g @flow_session_icon ""
```

---

## Core Functions

Located in `scripts/core.sh`.

### tmux_get_option

Get a tmux option value.

Retrieves the value of a global tmux option. If the option is not set,
returns the provided default value.

```bash
tmux_get_option "option_name" "default_value"
```

**Arguments:**
- `$1` - The name of the tmux option to retrieve
- `$2` - The default value to return if the option is not set

**Outputs:**
- The option value or default value to stdout

**Returns:**
- `0` on success

---

### tmux_set_option

Set a tmux option value.

Sets a global tmux option to the specified value.

```bash
tmux_set_option "option_name" "value"
```

**Arguments:**
- `$1` - The name of the tmux option to set
- `$2` - The value to set the option to

**Returns:**
- `0` on success, non-zero on failure

---

## Plugin Functions

### main (tmux-flow.sh)

Located in `scripts/tmux-flow.sh`.

Get the current Flow app status with customizable icons.

Retrieves the current phase and time from the Flow app and replaces the
default phase names with configured icons.

```bash
./scripts/tmux-flow.sh
# Output: " 24:35" (with configured icon)
```

**Arguments:**
- None

**Outputs:**
- The Flow status with phase and time to stdout

**Returns:**
- `0` on success

**Dependencies:**
- `macos/tmux-flow.scpt`: AppleScript to query Flow app

---

### tmux_interpolate

Located in `main.tmux`.

Interpolate the flow status pattern in content.

Replaces `#{flow_status}` pattern in the given content string with the
actual tmux command string to retrieve Flow app status.

```bash
tmux_interpolate "Status: #{flow_status}"
# Output: "Status: #(/path/to/scripts/tmux-flow.sh)"
```

**Arguments:**
- `$1` - The content string containing the pattern

**Outputs:**
- The content with pattern replaced by tmux command string

**Returns:**
- `0` on success

---

### tmux_update_option

Located in `main.tmux`.

Update a tmux option by interpolating the flow status pattern.

Retrieves the current value of the specified tmux option, replaces any
occurrences of `#{flow_status}` with the actual command string, and sets
the option to the new value.

```bash
tmux_update_option "status-right"
```

**Arguments:**
- `$1` - The name of the tmux option to update (e.g., "status-right")

**Returns:**
- `0` on success

---

## macOS Integration

Located in `macos/` directory.

### tmux-flow.scpt

AppleScript to get the current Flow app status.

Queries the Flow app (macOS pomodoro timer) for the current phase and
remaining time.

```bash
./macos/tmux-flow.scpt
# Output: "Flow 24:35" or "Break 05:00"
```

**Returns:**
- A string in the format "Phase Time"
  - Phase: `"Flow"` (focus session) or `"Break"`
  - Time: remaining time in the current phase

**Dependencies:**
- [Flow app](https://flowapp.info/) must be installed and running
