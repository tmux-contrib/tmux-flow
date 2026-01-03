#!/usr/bin/env bash

# Get the current Flow app status with customizable icons.
#
# Retrieves the current phase and time from the Flow app (macOS pomodoro timer)
# and replaces the default phase names with configured icons.
#
# Configuration Options:
#   @flow_break_icon   - Icon to display during break phase (default: "")
#   @flow_session_icon - Icon to display during focus session (default: "")
#
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   The Flow status with phase and time to stdout
# Returns:
#   0 on success
# Dependencies:
#   - macos/tmux-flow.scpt: AppleScript to query Flow app

_tmux_source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
_tmux_plugin_dir="$(dirname "$_tmux_source_dir")"

# shellcheck source=tmux_core.sh
source "$_tmux_source_dir/tmux_core.sh"

# Main entry point for the Flow status script.
#
# Retrieves Flow app status via AppleScript and substitutes phase names
# with configured icons.
#
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   Flow status string (e.g., " 24:35" for a focus session)
# Returns:
#   0 on success
main() {
	local content
	local opt_break_icon
	local opt_session_icon

	opt_break_icon="$(tmux_get_option "@flow_break_icon" "")"
	opt_session_icon="$(tmux_get_option "@flow_session_icon" "")"
	content="$("$_tmux_plugin_dir/macos/tmux-flow.scpt")"

	content="${content/Flow/$opt_session_icon}"
	content="${content/Break/$opt_break_icon}"

	echo "$content"
}

main
