#NoEnv
#SingleInstance Force
SetBatchLines, -1

; ==============================================================================
; --- CONFIGURATION ---
; ==============================================================================
ActivationKey   := "z"          
Interval        := 500          

TargetKey       := "1"          
TargetProcesses := ["WoW.exe", "GeForceNOW.exe", "WowClassic.exe"] 
OnlyInTarget    := true         

PlaySound       := false        
On_Pitch        := 750          
Off_Pitch       := 300          

; [ VISUAL SETTINGS ]
ShowTooltip     := true         
Tooltip_Dur     := 1000         
TooltipX        := "Center"     
TooltipY        := 280          

Color_On        := "00FF00"     ; Lime Green
Color_Off       := "FF0000"     ; Bright Red
CustomTrans     := "123456"     

; --- ICON SETTINGS ---
Icon_On         := "⚔ ⚔ ⚔"      
Icon_Off        := "× × ×"      

; ==============================================================================
; --- INTERNAL SETUP ---
; ==============================================================================
Toggled   := 0
GroupAdd, GameGroup, ahk_exe WoW.exe
GroupAdd, GameGroup, ahk_exe GeForceNOW.exe
GroupAdd, GameGroup, ahk_exe WowClassic.exe

; Setup the Overlay if enabled
if (ShowTooltip) {
    Gui, +AlwaysOnTop -Caption +ToolWindow +LastFound
    Gui, Color, %CustomTrans%
    WinSet, TransColor, %CustomTrans%
    Gui, Font, s40 w700, Segoe UI Symbol 
    Gui, Add, Text, vStatusIcon Center w600, %Icon_Off%
}
return ; End of Auto-Execute Section

; ==============================================================================
; --- LOGIC ---
; ==============================================================================

; This directive ensures the hotkey ONLY works when one of your games is active
#IfWinActive ahk_group GameGroup

$~z:: ; Using the tilde (~) allows the 'z' to still reach the game if needed
    Toggled := !Toggled
    
    if (Toggled) {
        SetTimer, SendRaw, %Interval%
        CurrentColor := Color_On
        CurrentIcon  := Icon_On
    } else {
        SetTimer, SendRaw, Off
        CurrentColor := Color_Off
        CurrentIcon  := Icon_Off
    }
    
    if (ShowTooltip) {
        UpdateOverlay(CurrentIcon, CurrentColor)
        SetTimer, HideOverlay, % -Tooltip_Dur
    }

    if (PlaySound) {
        Pitch := Toggled ? On_Pitch : Off_Pitch
        SoundBeep, %Pitch%, 100
    }
return

#IfWinActive ; Reset the directive so subsequent hotkeys (if any) are global

SendRaw:
    ; Double check to ensure we don't spam if you Alt-Tab while it's ON
    if (!WinActive("ahk_group GameGroup"))
        return
    Send, %TargetKey%
return

UpdateOverlay(Symbol, Color) {
    global TooltipX, TooltipY
    Gui, Font, c%Color%
    GuiControl, Font, StatusIcon
    GuiControl,, StatusIcon, %Symbol%
    
    ShowArgs := (TooltipX = "Center") ? "xCenter" : "x" . TooltipX
    Gui, Show, NoActivate %ShowArgs% y%TooltipY% w600
}

HideOverlay:
    Gui, Hide
return
