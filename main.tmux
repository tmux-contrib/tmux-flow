#!/usr/bin/env bash

# tmux-flow plugin entry point.
#
# This plugin provides a #{flow_status} format string that displays
# the current status of the Flow app (macOS pomodoro timer) in the
# tmux status bar.
#
# Usage:
#   Add #{flow_status} to your status-left or status-right option.
#
# Example:
#   set -g status-right "#{flow_status} | %H:%M"
#
# Configuration:
#   @flow_break_icon   - Icon for break phase (default: "")
#   @flow_session_icon - Icon for focus session (default: "")

_tmux_flow_root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/tmux_flow_core.sh
source "$_tmux_flow_root_dir/scripts/tmux_flow_core.sh"

flow_status="#($_tmux_flow_root_dir/scripts/tmux_flow.sh)"
flow_status_pattern="\#{flow_status}"

# Interpolate the flow status pattern in content.
#
# Replaces #{flow_status} pattern in the given content string with the
# actual tmux command string to retrieve Flow app status.
#
# Globals:
#   flow_status - The tmux command string to get Flow status
#   flow_status_pattern - The pattern to replace (#{flow_status})
# Arguments:
#   $1 - The content string containing the pattern
# Outputs:
#   The content with pattern replaced by tmux command string
# Returns:
#   0 on success
_tmux_interpolate() {
	local content=$1

	content=${content/$flow_status_pattern/$flow_status}

	echo "$content"
}

# Update a tmux option by interpolating the flow status pattern.
#
# Retrieves the current value of the specified tmux option, replaces any
# occurrences of #{flow_status} with the actual command string, and sets
# the option to the new value.
#
# Globals:
#   None
# Arguments:
#   $1 - The name of the tmux option to update (e.g., "status-right")
# Returns:
#   0 on success
_tmux_update_option() {
	local option="$1"
	local option_value

	option_value="$(_tmux_get_option "$option")"
	option_value="$(tmux_interpolate "$option_value")"

	_tmux_set_option "$option" "$option_value"
}

# Main entry point for the plugin.
#
# Initializes the Flow plugin by updating the status-right and status-left
# options to interpolate the flow_status pattern.
#
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   0 on success
main() {
	tmux_update_option "status-right"
	tmux_update_option "status-left"
}

main
