#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=1090
source "${CURRENT_DIR}/tmux-core.sh"

main() {
	local content
	local opt_break_icon
	local opt_session_icon

	opt_break_icon="$(tmux_get_option "@flow_break_icon" "")"
	opt_session_icon="$(tmux_get_option "@flow_session_icon" "")"
	content="$("${CURRENT_DIR}/tmux-flow.scpt")"

	content="${content/Flow/$opt_session_icon}"
	content="${content/Break/$opt_break_icon}"

	echo "$content"
}

main
