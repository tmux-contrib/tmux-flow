#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=1090
source "${CURRENT_DIR}/helpers.sh"

main() {
	local content
	local opt_break_icon
	local opt_session_icon

	opt_break_icon="$(get_tmux_option "@flow_break_icon" " ")"
	opt_session_icon="$(get_tmux_option "@flow_session_icon" " ")"
	content="$("${CURRENT_DIR}/flow.scpt")"

	content="${content/Flow/$opt_session_icon}"
	content="${content/Break/$opt_break_icon}"

	echo "$content"
}

main
