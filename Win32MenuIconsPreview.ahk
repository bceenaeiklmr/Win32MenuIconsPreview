; Script     Win32MenuIconsPreview.ahk
; License:   MIT License
; Author:    Bence Markiel (bceenaeiklmr)
; Github:    https://github.com/bceenaeiklmr/Win32MenuIconsPreview
; Date       07.04.2025
; Version    1.0.0

#SingleInstance force
#Warn

; Enable dark mode for Win32 menu.
Win32MenuDarkMode(darkMode := true)

; Create menu.
Win32MenuIconsPreview()

; Show menu.
F1::icons.Show()

; Exit script.
^Esc::ExitApp

; Create a menu with icons from a list of files.
Win32MenuIconsPreview() {

    global icons

    ; credit: cyqsimon,
    ; https://github.com/cyqsimon/W10-Ico-Ref
    files := [
        "shell32.dll",          ; Another collection of miscellaneous icons, including icons for internet, devices, networks, peripherals, folders, etc.
        "imageres.dll",         ; Miscellaneous icons used almost everywhere, including different types of folders, hardware devices, peripherals, actions, etc.
        "pifmgr.dll",           ; Legacy and exotic (i.e. not very useful) icons used in Windows 95 and 98.
        "explorer.exe",         ; A few icons used by Explorer and its older versions.
        "accessibilitycpl.dll", ; Icons used for accessibility.
        "ddores.dll",           ; Icons used for hardware devices and resources.
        "moricons.dll",         ; Another set of legacy icons used in pre-2000 Windows versions, mainly including icons for old applications and programming languages.
        "mmcndmgr.dll",         ; Yet another set of legacy icons, mainly including icons related to computer management, such as networks, folders, authentication, time, computers, and servers.
        "mmres.dll",            ; Icons related to audio hardware.
        "netcenter.dll",        ; A few icons related to networking.
        "netshell.dll",         ; More icons related to networking, including icons for Bluetooth, wireless routers, and network connections.
        "networkexplorer.dll",  ; A few more icons related to networking, mostly peripheral hardware related.
        "sensorscpl.dll",       ; Icons for various sensors, which mostly look the same unfortunately.
        "setupapi.dll",         ; Icons used by hardware setup wizards, including icons for various peripheral hardware.
        "wmploc.dll",           ; Icons related to multimedia, including hardware icons, MIME type icons, status icons, etc.
        "wpdshext.dll",         ; A few icons related to portable devices and portability.
        "compstui.dll",         ; Legacy icons mostly related to printing.
        "ieframe.dll",          ; All kinds of icons used by IE.
        "dmdskres.dll",         ; A few icons used for disk management.
        "dsuiext.dll",          ; Icons related to network locations and services.
        "mstscax.dll",          ; Icons used for remote desktop connection.
        "wiashext.dll",         ; Icons used for imaging hardware.
        "comres.dll",           ; Some general status icons.
        "mstsc.exe",            ; A few icons used for system monitoring and configuration.
        "actioncentercpl.dll",  ; Icons used in action center, notably including red, yellow, and green traffic lights.
        "aclui.dll",            ; A few checks, crosses, and i-in-circles.
        "autoplay.dll",         ; One autoplay icon.
        "xwizards.dll",         ; One software install icon.
        "ncpa.cpl",             ; One network folder icon.
        "url.dll"               ; A few random network related icons.
        ; Deprecated, no icons in Windows 11.
        ;"comctl32.dll",        ; Legacy info, warning, and error icons.
        ;"pnidui.dll",          ; Modern style white icons related to network status.
    ]

    ; Create a new menu for icons.
    icons := Menu()

    ; Add a sub menu for each file.
    for f in files {

        iconSub := Menu()
        icons.Add(f, iconSub)

        ; Detect the number of icons in the file.
        i := 0
        loop {
            try {
                icons.SetIcon(f, f, A_Index - 1)
            }
            catch {
                break
            }
            i += 1
        }
        ; Set first icon to sub menu.
        icons.SetIcon(f, f, 0)

        ; Element per sub menu.
        n := 32
        subMenu := Ceil(i / n)

        ; Crete sub menus and add icons.
        loop subMenu {
            i := A_Index
            subMenu := Menu()
            strMenu := Format("{:03}", (i - 1) * n) " - " Format("{:03}", A_Index * n)
            iconSub.Add(strMenu, subMenu)
            loop n {
                try {
                    j := A_Index + n * (i - 1)
                    subMenu.Add(j, (*) => "")
                    subMenu.SetIcon(j, f, j)
                }
                catch {
                    subMenu.Delete(j)
                    break
                }
            }
        }
        Tooltip("Loading icon files, please wait: " AsciiProgressbarHorizontal(A_Index, files.Length))
    }
    icons.SetIcon("imageres.dll", "imageres.dll", 3)
    icons.Show()
    Tooltip()
    return
}

; Generate a horizontal ASCII progress bar
AsciiProgressbarHorizontal(current, goal := 100, char := ['◼', '◻'], scale := 1) {
    progress := Round(current / goal * 10)
    loop progress * scale
        str .= char[1]
    loop (10 - progress) * scale
        str .= char[2]
    return str
}

; Enable or disable dark mode on Win32 menu.
Win32MenuDarkMode(dark := true) {
    ; Credit: lexikos
    ; https://www.autohotkey.com/boards/viewtopic.php?t=94661
    if (VerCompare(A_OSVersion, "10.0.18362") < 0)
        return
    uxtheme := DllCall("GetModuleHandle", "str", "uxtheme", "ptr")
    SetPreferredAppMode := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 135, "ptr")
    FlushMenuThemes := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 136, "ptr")
    DllCall(SetPreferredAppMode, "int", dark) ; *** 0 for NOT Dark
    DllCall(FlushMenuThemes)
    return
}
