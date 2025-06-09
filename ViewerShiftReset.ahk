#Requires AutoHotkey v2.0

/*------------------------------------------------------------------------------------------

    ViewerShiftReset.ahk

    Version: 1.0.0
    Author:  tsukasa.rexen
    Repository: https://github.com/bullllet/ViewerShiftReset/

    This AutoHotkey v2 script fixes the "stuck Shift key" bug in some Second Life viewers that can make chat input difficult or unintentionally trigger whisper mode.

    - Automatically releases Shift after short idle time
    - Resets Shift before Enter key is sent
    - Only active when a supported viewer app is in focus
    - Lightweight and efficient (uses InputHook and timers)

    Tested with: Firestorm, Alchemy, Black Dragon, and Second Life official viewers.

-------------------------------------------------------------------------------------------*/

; ===== Settings =====
targetApps := [
    "SecondLifeViewer.exe",
    "AlchemyBeta.exe",
    "Black Dragon.exe",
    "Firestorm-Releasex64.exe",
    "ApertureOS-Release.exe"
]
showPopup       := false ; Display popup when key is detected or Shift Up is sent (for debugging)
typingThreshold := 200   ; Inactivity period (ms) after which Shift Up is triggered
checkActiveTime := 500   ; Interval (ms) for checking if target app is active
checkKeyTime    := 10    ; Interval (ms) for checking idle state after key press

global lastKeyTime := A_TickCount
global shiftSent := false
global isMonitoring := false
global ih := InputHook("L0 V")
ih.KeyOpt("{All}", "N")
ih.OnKeyDown := (*) => OnKeyPressed()

; ===== Always-on timer to monitor active window state =====
SetTimer(CheckWindowActive, checkActiveTime)

; ===== Key detection inside target applications =====
OnKeyPressed() {
    global lastKeyTime, shiftSent, showPopup
    lastKeyTime := A_TickCount
    shiftSent := false

    if showPopup {
        keyGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
        keyGui.BackColor := 0xADD8E6
        keyGui.SetFont("s10 Bold cBlack")
        keyGui.Add("Text", , "KEY PRESS DETECTED")
        keyGui.Show("x10 y10 NoActivate AutoSize")
        SetTimer(() => keyGui.Destroy(), -500)
    }
}

; ===== Starts/stops InputHook & Enter handler based on active window =====
CheckWindowActive(*) {
    global isMonitoring, targetApps, ih

    isTargetActive := false
    for app in targetApps {
        if WinActive("ahk_exe " app) {
            isTargetActive := true
            break
        }
    }

    if isTargetActive && !isMonitoring {
        ih.Start()
        SetTimer(CheckIdleAndFire, checkKeyTime)
         Hotkey("*Enter", EnterHandler.Bind(), "On")
        isMonitoring := true
    } else if !isTargetActive && isMonitoring {
        ih.Stop()
        SetTimer(CheckIdleAndFire, 0)
        Hotkey("*Enter", EnterHandler.Bind(), "Off")
        isMonitoring := false
    }
}

; ===== Sends Shift Up if idle time exceeds threshold =====
CheckIdleAndFire(*) {
    global lastKeyTime, typingThreshold, shiftSent, showPopup

    timeSinceKey := A_TickCount - lastKeyTime

    if (!shiftSent && timeSinceKey >= typingThreshold) {
        Send("{Shift up}")
        shiftSent := true

        if showPopup {
            shiftGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
            shiftGui.BackColor := "Yellow"
            shiftGui.SetFont("s10 Bold cBlack")
            shiftGui.Add("Text", , "SHIFT UP")
            shiftGui.Show("x10 y60 NoActivate AutoSize")
            SetTimer(() => shiftGui.Destroy(), -500)
        }
    }
}

; ===== Intercept Enter key: release Shift if no modifiers are held =====
EnterHandler(*) {
    global targetApps, showPopup

    isTargetActive := false
    for app in targetApps {
        if WinActive("ahk_exe " app) {
            isTargetActive := true
            break
        }
    }

    if isTargetActive {
        shift := GetKeyState("Shift", "P")
        ctrl  := GetKeyState("Ctrl", "P")
        alt   := GetKeyState("Alt", "P")
        winL  := GetKeyState("LWin", "P")
        winR  := GetKeyState("RWin", "P")

        Send("{Shift up}")
        Sleep(30)

        combo := ""
        if shift
            combo .= "{Shift down}"
        if ctrl
            combo .= "{Ctrl down}"
        if alt
            combo .= "{Alt down}"
        if winL
            combo .= "{LWin down}"
        if winR
            combo .= "{RWin down}"

        Send(combo . "{Enter}")

        if shift
            Send("{Shift up}")
        if ctrl
            Send("{Ctrl up}")
        if alt
            Send("{Alt up}")
        if winL
            Send("{LWin up}")
        if winR
            Send("{RWin up}")

        if showPopup {
            enterGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
            enterGui.BackColor := "Green"
            enterGui.SetFont("s10 Bold cBlack")
            enterGui.Add("Text", , "SHIFT RESET → ENTER")
            enterGui.Show("x10 y120 NoActivate AutoSize")
            SetTimer(() => enterGui.Destroy(), -500)
        }
    } else {
        Send("{Enter}")
    }
}
