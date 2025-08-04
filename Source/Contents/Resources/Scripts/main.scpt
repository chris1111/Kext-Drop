# Applescript create by chris1111
# Kext Drop.app Copyright (c) 2025 chris1111 All rights reserved.
set theAction to button returned of (display dialog "
Welcome Kext Drop
Use Kext Drop  or Revert Snapshot
" with icon note buttons {"Quit", "Revert Snapshot", "Kext Drop"} cancel button "Quit" default button {"Kext Drop"})
set source to path to me as string
set source to POSIX path of source & "Contents/Resources/Installer/RevertSnapshot.app"
set source to quoted form of source
if theAction = "Revert Snapshot" then do shell script "open " & source & "/"
set source to path to me as string

if theAction = "Kext Drop" then
	set theAction to button returned of (display dialog "
Install Kexts with Kext Drop.  
Kext Drop work from Catalina 10.15 to Tahoe 26.
===============================
Or Repatch the System after macOS Update if you have an existing KDK. 
Repatch System work from BigSur 11 to Tahoe 26.
===============================
" with icon note buttons {"Quit", "Repatch System", "Kext Drop"} cancel button "Quit" default button {"Kext Drop"})
	
	set source to path to me as string
	set source to POSIX path of source & "Contents/Resources/Installer/RepatchSystem.app"
	set source to quoted form of source
	if theAction = "Repatch System" then do shell script "open " & source & "/"
	set source to path to me as string
	
	set source to path to me as string
	set source to POSIX path of source & "Contents/Resources/Installer/Kext-Drop.app"
	set source to quoted form of source
	if theAction = "Kext Drop" then do shell script "open " & source & "/"
	set source to path to me as string
	
end if
