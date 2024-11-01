#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=1090
source "${CURRENT_DIR}/scripts/helpers.sh"

flow_status="#(${CURRENT_DIR}/scripts/flow.sh)"
flow_status_pattern="\#{flow_status}"

tmux_interpolate() {
	local content=$1

	content=${content/$flow_status_pattern/$flow_status}

	echo "$content"
}

tmux_update_option() {
	local option="$1"
	local option_value

	option_value="$(tmux_get_option "$option")"
	option_value="$(tmux_interpolate "$option_value")"

	tmux_set_option "$option" "$option_value"
}

main() {
	tmux_update_option "status-right"
	tmux_update_option "status-left"
}

main
