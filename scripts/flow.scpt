#!/usr/bin/env osascript

tell application "Flow"
	launch

	set flow_time to getTime as text
	set flow_phase to getPhase as text

	return flow_phase & " " & flow_time
end tell
