# Win32MenuIconsPreview

AutoHotkey script to preview and browse icons embedded in built-in Windows DLLs via native Win32 menus. Supports dark mode for modern systems.

![Win32MenuIconsPreview](https://github.com/user-attachments/assets/0c0c6788-a659-45e9-95a9-42d2f8e09f7f)


## Features

- Dark mode enabled Win32 menu
- Browse icons from common system DLLs
- Categorized submenus with live icon previews

## Included Icon Sources

Icons are pulled from a curated list of 30+ Windows system DLLs, including:

- `imageres.dll`
- `shell32.dll`
- `explorer.exe`
- `moricons.dll`
- `netshell.dll`
- ... and more!

See `Win32MenuIconsPreview()` in the script for the full list.

## Usage

1. Make sure you have [AutoHotkey v2](https://www.autohotkey.com/) installed.
2. Download or clone this repo.
3. Run `Win32MenuIcons.ahk`.
4. Press `F1` to open the icon menu.
5. Press `Ctrl + Esc` to exit the script.

## Credit

- DLL icon list inspiration: [cyqsimon/W10-Ico-Ref](https://github.com/cyqsimon/W10-Ico-Ref)
- Dark mode Win32 menu: [lexikos](https://www.autohotkey.com/boards/viewtopic.php?t=94661)

## License

This project is not affiliated with Microsoft. It is an independent script created to enhance user experience.

[MIT](LICENSE)
