#!/usr/bin/env osascript

-- Get the current Flow app status.
--
-- Queries the Flow app (macOS pomodoro timer) for the current phase
-- and remaining time.
--
-- Returns:
--   A string in the format "Phase Time" (e.g., "Flow 24:35" or "Break 05:00")
--   - Phase is either "Flow" (focus session) or "Break"
--   - Time is the remaining time in the current phase
--
-- Usage:
--   ./tmux-flow.scpt
--   # Output: "Flow 24:35"
--
-- Dependencies:
--   - Flow app must be installed and running (https://flowapp.info/)

tell application "Flow"
	set flow_time to getTime as text
	set flow_phase to getPhase as text

	return flow_phase & " " & flow_time
end tell
