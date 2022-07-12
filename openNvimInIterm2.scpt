on run {input, parameters}
	
	# seem to need the full path at least in some cases
	# -p opens files in separate tabs
	set nvimCommand to "nvim -p "
	
	set filepaths to ""
	if input is not {} then
		repeat with currentFile in input
			set filepaths to filepaths & quoted form of POSIX path of currentFile & " "
		end repeat
	end if
	
	if application "iTerm" is running then
		tell application "iTerm"
			try
				activate
				tell current window
					create tab with default profile
					tell current session
						write text nvimCommand & filepaths
					end tell
				end tell
			on error errText
				set newWindow to (create window with default profile)
				tell newWindow
					tell current session
						write text nvimCommand & filepaths
					end tell
				end tell
			end try	
		end tell
	else
		tell application "iTerm"
			--set newWindow to (create window with default profile)
			activate
			delay 1
			tell current window
				tell current session
					write text nvimCommand & filepaths
				end tell
			end tell
		end tell
	end if
end run
