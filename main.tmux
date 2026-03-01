#!/usr/bin/env bash
set -euo pipefail
[[ -z "${DEBUG:-}" ]] || set -x

_tmux_flow_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[[ -f "$_tmux_flow_root/scripts/tmux_core.sh" ]] || {
	echo "tmux-flow: missing tmux_core.sh" >&2
	exit 1
}

# shellcheck source=scripts/tmux_core.sh
source "$_tmux_flow_root/scripts/tmux_core.sh"

flow_status="#($_tmux_flow_root/scripts/tmux_flow.sh)"
flow_status_pattern="\#{flow_status}"

_tmux_interpolate() {
	local content=$1
	local pattern=$2
	local value=$3

	echo "${content/$pattern/$value}"
}

_tmux_update_option() {
	local option="$1"
	local option_value
	local new_option_value

	option_value="$(_tmux_get_option "$option")"
	new_option_value="$(_tmux_interpolate "$option_value" "$flow_status_pattern" "$flow_status")"

	_tmux_set_option "$option" "$new_option_value"
}

main() {
	_tmux_update_option "status-right"
	_tmux_update_option "status-left"
}

main
