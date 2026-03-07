#!/usr/bin/env bash
set -euo pipefail
[[ -z "${DEBUG:-}" ]] || set -x

_tmux_flow_source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[[ -f "$_tmux_flow_source_dir/tmux_core.sh" ]] || {
	echo "tmux-flow: missing tmux_core.sh" >&2
	exit 1
}

# shellcheck source=tmux_core.sh
source "$_tmux_flow_source_dir/tmux_core.sh"

main() {
	local content
	local opt_break_icon
	local opt_session_icon

	opt_break_icon="$(_tmux_get_option "@flow-break-icon" "")"
	opt_session_icon="$(_tmux_get_option "@flow-focus-icon" "")"
	content="$("$(dirname "$_tmux_flow_source_dir")/macos/tmux-flow.scpt")"

	content="${content/Flow/$opt_session_icon}"
	content="${content/Break/$opt_break_icon}"

	echo "$content"
}

main
