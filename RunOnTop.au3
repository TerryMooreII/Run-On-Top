#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\icons\app.ico
#AutoIt3Wrapper_outfile=RunOnTop.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;************************************
;Written by: Terry Moore (motersho)
;Date: 11/23/2009
;Desc: Displays a dropdown of running GUI applications and
;		and lets the user run the application on top of the other windows
;License: GPL v3


#include <GUIConstants.au3>
#include <ComboConstants.au3>
#include <ButtonConstants.au3>


global $cmbAppList	;Create the global varible which is used to create the drop down list of open applications


;Define the GIU
GUICreate("Run On Top", 310, 125, 100, 200)
GUICtrlCreateLabel("Select the application to run on top:", 10, 15)

;Call function to display the window list drop down
GetWinList()

;create a refresh button that when pressed calls the GetWinList() function
$btnRefresh = GUICtrlCreateButton("", 280, 40, 20, 20, $BS_ICON)
GUICtrlSetImage(-1, "C:\Users\tmoore\Desktop\AutoIT\icons\refresh_small.ico");

;Define the buttons
$btnRun = GUICtrlCreateButton("Run On Top", 15, 75, 125, 20)
$btnRemove = GUICtrlCreateButton("Remove Run On Top", 160, 75, 125, 20)

;Start the GUI
GUISetState()
Do
	;wait for a user action
	$n = GUIGetMsg()
	If $n = $btnRun Then
		call("RunOnTop", GUICtrlRead($cmbAppList))
	elseIf $n = $btnRemove Then
		call("RemoveRunOnTop", GUICtrlRead($cmbAppList))
	elseif $n = $btnRefresh then
		call("GetWinList")
	EndIf
Until $n = $GUI_EVENT_CLOSE

;Delete the Combo button and recalls it to display the windows list
Func GetWinList()
	 GUICtrlDelete($cmbAppList)
	$winlist = WinList()
	$cmbAppList = GUICtrlCreateCombo("", 10, 40, 265,"", $CBS_DROPDOWNLIST)

	For $i = 1 to $winlist[0][0]
	  ; Only display visble windows that have a title
	  If $winlist[$i][0] <> "" AND IsVisible($winlist[$i][1]) Then
		 GUICtrlSetData(-1, $winlist[$i][0])

	  EndIf
	Next

EndFunc

;Sets a User selected windows as active and then makes it run on top of the other windows
Func RunOnTop($title)
	WinActivate($title)
	WinSetOnTop($title, "", 1)
EndFunc

;Sets a user selected windows as active and remove the run on top property
Func RemoveRunOnTop($title)
	WinActivate($title)
	WinSetOnTop($title, "", 0)
EndFunc

;Function to get only the visable running application that have a GUI
Func IsVisible($handle)
  If BitAnd( WinGetState($handle), 2 ) Then
    Return 1
  Else
    Return 0
  EndIf
EndFunc

