# SimpleKeySpammer 🛡️

A simple, robust AutoHotkey (v1.1) script designed for World of Warcraft players to automate repetitive key presses. It features a custom Big-Text HUD and audio cues so you never have to guess if your rotation is active.

## ✨ Features
* **Visual HUD:** A large Green/Red overlay in the center of your screen.
* **Audio Cues:** High/Low pitch beeps when toggling.
* **Smart Toggling:** Uses the `~z` key so the original key function isn't blocked.
* **Performance:** Minimal CPU usage with `#NoEnv`.

## 🚀 Installation
1. Install [AutoHotkey v1.1](https://www.autohotkey.com/).
2. Download `SimpleKeySpammer.ahk` from this repo.
3. Right-click the file and select **Run Script**.

## 🕹️ How to Use
* **Toggle:** Press `Z` to start/stop the loop.
* **Action:** While active, the script sends `1` every 500ms.
* **Exit:** Right-click the Green 'H' icon in your system tray and select **Exit**.

## ⚠️ Important Notes
* **Window Mode:** For the Big Text overlay to appear, run WoW in **Windowed** or **Windowed Borderless** mode.
* **Permissions:** If the script doesn't work inside the game, try running the script as **Administrator**.
* **TOS:** Use responsibly. Be aware of Blizzard's "one keypress per one action" stance; using automated loops is at your own risk.


## ⚙️ Configuration Guide

The script's behavior is managed entirely within the `; --- CONFIGURATION ---` section. Below is a breakdown of what each setting does and how to adjust them for your needs.

---

### 1. Toggle Settings
These define the core behavior of the automation.
* **`ActivationKey`**: The physical key on your keyboard used to turn the spamming ON or OFF (e.g., `"z"`, `"F1"`, or `"Capslock"`).
* **`Interval`**: The delay in milliseconds ($ms$) between each key press. 
    * *Example: `1000` = 1 press per second; `100` = 10 presses per second.*

### 2. Target Settings
Determines what key is pressed and where it is sent.
* **`TargetKey`**: The key you want the script to spam (e.g., `"1"`, `"e"`, or `"Space"`).
* **`TargetProcess`**: The executable name of the application (e.g., `GeForceNOW.exe` or `Wow.exe`). 
* **`OnlyInTarget`**: 
    * `true`: The script will only spam if the target window is currently active (focused). **Highly recommended.**
    * `false`: The script will spam regardless of what window you are in.

### 3. Sound Settings
Audio feedback so you know the script state without looking at the screen.
* **`PlaySound`**: Set to `true` to enable beeps; `false` to mute.
* **`On_Pitch` / `Off_Pitch`**: The frequency of the beep in Hertz. Higher numbers = higher pitch.
* **`On_Time` / `Off_Time`**: Duration of the beep in milliseconds.

### 4. Visual Settings (Overlay)
Configures the on-screen display (OSD) that appears when you toggle the script.
* **`ShowTooltip`**: Enables or disables the large text overlay.
* **`Tooltip_Dur`**: How long the "ENABLED" or "DISABLED" text stays on screen before disappearing.
* **`TooltipX` / `TooltipY`**: The screen coordinates for the text. Use `"Center"` for horizontal alignment.
* **`Color_On` / `Color_Off`**: The color of the text (standard HTML color names like `"Lime"`, `"Red"`, `"Cyan"`).

---

## ⌨️ Configuration Quick Reference

| Variable | Default | Purpose |
| :--- | :--- | :--- |
| `Interval` | `500` | Speed of spam (Lower = Faster) |
| `TargetProcess` | `GeForceNOW.exe` | The specific app the script monitors |
| `OnlyInTarget` | `true` | Prevents accidental typing in other apps |
