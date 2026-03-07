#NoEnv
#SingleInstance Force

; ==============================================================================
; --- CONFIGURATION ---
; ==============================================================================

; [ TOGGLE SETTINGS ]
ActivationKey   := "z"          ; The key you press to Turn On/Off
Interval        := 500          ; Time between repeats (ms)
ClickDelay      := 50           ; How long the key is held down (ms)

; [ TARGET SETTINGS ]
TargetKey       := "1"          ; The actual key to press
TargetProcess   := "GeForceNOW.exe" ; Process name (e.g., Wow.exe, GeForceNOW.exe)
OnlyInTarget    := true         ; If true, script only spams when window is active

; [ SOUND SETTINGS ]
PlaySound       := true         ; Set to false to mute beeps
On_Pitch        := 750          ; Frequency of 'ON' beep (Hz)
On_Time         := 100          ; Duration of 'ON' beep (ms)
Off_Pitch       := 300          ; Frequency of 'OFF' beep (Hz)
Off_Time        := 100          ; Duration of 'OFF' beep (ms)

; [ VISUAL SETTINGS ]
ShowTooltip     := true         ; Set to false to hide on-screen text
Tooltip_Dur     := 1000         ; How long text stays on screen (ms)
TooltipX        := "Center"     ; Horizontal position (Center or pixel value)
TooltipY        := 280           ; Vertical position (pixels from top)
Color_On        := "Lime"       ; Text color when enabled
Color_Off       := "Red"        ; Text color when disabled

; ==============================================================================
; --- INTERNAL SETUP ---
; ==============================================================================
Toggled  := 0
TargetSC := GetKeySC(TargetKey) 
GameID   := "ahk_exe " . TargetProcess
Hotkey, ~%ActivationKey%, ToggleLabel 

if (ShowTooltip) {
    Gui, +AlwaysOnTop -Caption +ToolWindow +LastFound
    Gui, Color, ABCDEF 
    Gui, Font, s24 w700, Verdana
    Gui, Add, Text, vStatusText Center, --- READY ---
    WinSet, TransColor, ABCDEF 
}
return

; ==============================================================================
; --- LOGIC ---
; ==============================================================================

ToggleLabel:
    Toggled := !Toggled
    if (Toggled) {
        SetTimer, SendRaw, %Interval%
        if (ShowTooltip)
            UpdateOverlay(" ENABLED", Color_On)
        if (PlaySound)
            SoundBeep, %On_Pitch%, %On_Time%
    } else {
        SetTimer, SendRaw, Off
        if (ShowTooltip)
            UpdateOverlay(" DISABLED", Color_Off)
        if (PlaySound)
            SoundBeep, %Off_Pitch%, %Off_Time%
    }
    
    if (ShowTooltip)
        SetTimer, HideOverlay, % -Tooltip_Dur
return

SendRaw:
    ; Safety Check: Only send if the target window is active
    if (OnlyInTarget && !WinActive(GameID))
        return

    ; Hardware-level input injection
    keybd_event(0, TargetSC, 0, 0) ; Key Down
    Sleep, %ClickDelay%
    keybd_event(0, TargetSC, 2, 0) ; Key Up
return

UpdateOverlay(Text, Color) {
    global TooltipX, TooltipY
    Gui, Font, c%Color%
    GuiControl, Font, StatusText
    GuiControl,, StatusText, %Text%
    Gui, Show, NoActivate x%TooltipX% y%TooltipY%
}

HideOverlay:
    Gui, Hide
return

keybd_event(vk, sc, flags, info) {
    dllcall("keybd_event", "uchar", vk, "uchar", sc, "uint", flags, "ptr", info)
}
