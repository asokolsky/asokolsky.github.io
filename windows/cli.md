# Windows Power Shell Commands

## Merge MP3 files

In Power Shell

```cmd
get-content 06* -Enc Byte -Read 512 | set-content -Encoding Byte 06.mp3
```

## Display/Uninstall Apps

As admin, to display apps:

```cmd
DISM /Online /Get-ProvisionedAppxPackages | select-string Packagename
```

Uninstall:
```cmd
DISM.exe /Online /Remove-ProvisionedAppxPackage \
    /PackageName:Microsoft.Xbox.TCUI_1.23.28002.0_neutral_~_8wekyb3d8bbwe
```
