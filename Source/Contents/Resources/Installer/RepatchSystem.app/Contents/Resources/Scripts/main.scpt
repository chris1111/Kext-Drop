# Applescript create by chris1111
# PatchedSystem.app Copyright (c) 2025 chris1111 All rights reserved.
# Vars
set theAction to button returned of (display dialog "
Welcome Patched-System
This will restore the system on 
the Last-Patched-System.
Repatch System work from BigSur 11 to Tahoe 26 if you have an existing KDK installed from Kext Drop earlier.
" with icon note buttons {"Quit", "Patched-System"} cancel button "Quit" default button {"Patched-System"})

if theAction = "Patched-System" then
	display dialog "Patched-System
To using this program! 
Gatekeeper must be disable
SIP security must be disable
==================
config.plist: NVRAM ⬇︎ 
7C436110-AB2A-4BBB-A880-FE41995C9F82: csr-active-config ➤ 03080000

" with icon note
	
	activate me
	set Volumepath to paragraphs of (do shell script "ls /Volumes")
	set Diskpath to choose from list Volumepath with prompt "
To be able to continue, select the volume
that you want to restore the system on on Last-Patched-System.
Then press the OK button" OK button name "OK" with multiple selections allowed
	if Diskpath is false then
		display dialog "Quit Installer " with icon 0 buttons {"EXIT"} default button {"EXIT"}
		return
		
		return (POSIX path of Diskpath)
	end if
	try
		
		--If Continue
		display dialog "Select the APFS Volume " & Diskpath & " on the list to mount the drive as RW" with icon note
		set alldisks to paragraphs of (do shell script "diskutil list")
		set nonbootnumber to (count of alldisks)
		try
			# Credit: Portion Base on jackluke work
			set alldisks to items 2 thru nonbootnumber of alldisks
			activate
			set your_selected_device_id to (choose from list alldisks with prompt "Choose APFS Volume " & Diskpath & " then click OK to proceed")
			repeat with the_Item in your_selected_device_id
				set the_ID to (do shell script "diskutil list | grep -m 1" & space & quoted form of the_Item & space & "| grep -o 'disk[0-9][a-z][0-9]*'")
				set Check to false
				set tName to your_selected_device_id as text
				if (tName contains "10:" or tName contains "9:" or tName contains "8:" or tName contains "7:" or tName contains "6:" or tName contains "5:" or tName contains "4:" or tName contains "3:" or tName contains "2:" or tName contains "1:" or tName contains "0:") and tName contains "APFS" and (tName does not contain "VM" and tName does not contain "- D" and tName does not contain "Update" and tName does not contain "Preboot" and tName does not contain "Recovery" and tName does not contain "Container" and tName does not contain "Snapshot") then
					set Check to true
				end if
				if Check is true then
					set progress total steps to 6
					set progress additional description to "Analyse Progression"
					delay 2
					set progress completed steps to 1
					
					set progress additional description to "Analyse Progression"
					delay 2
					set progress completed steps to 2
					
					set progress additional description to "Analyse " & Diskpath & ""
					delay 2
					set progress completed steps to 3
					
					try
						do shell script "mount -o nobrowse -t apfs /dev/" & the_ID & " /System/Volumes/Update/mnt1" with administrator privileges
						delay 2
						tell application "RepatchSystem"
							activate
						end tell
						
						set progress additional description to "Patched-System"
						delay 2
						set progress completed steps to 4
						
						set progress additional description to "Patched-System"
						delay 1
						set progress completed steps to 5
						set progress additional description to "
Patched-System
There are about two minutes left.
Wait for it to be completed. . ."
						
						
					end try
					display dialog "Final step for the Snapshot " & Diskpath & "" buttons {"OK"} default button 1 with icon note giving up after 1
					delay 1
					set the_command to quoted form of POSIX path of (path to resource "Patched-System" in directory "Scripts")
					delay 2
					do shell script the_command with administrator privileges
					
					tell application "RepatchSystem"
						activate
					end tell
					set progress completed steps to 5
					set progress additional description to "Unmount the root volume, from" & Diskpath & "
Operation complete Done!"
					delay 2
				else
					display dialog "You haven't selected any " & Diskpath & "" buttons {"Exit"} with icon note giving up after 5
				end if
				
			end repeat
		on error the error_message number the error_number
			if the error_number is -128 or the error_number is -1708 then
			else
				display dialog "There are no selected " & Diskpath & " snapshots." buttons {"OK"} default button 1 with icon note giving up after 5
			end if
		end try
	end try
	
end if
