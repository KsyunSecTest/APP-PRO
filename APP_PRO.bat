@echo off
setlocal

:: 获取当前屏幕大小
for /f "tokens=2 delims=: " %%a in ('powershell -command "(Get-WmiObject -Class Win32_VideoController).CurrentHorizontalResolution"') do set "width=%%a"
for /f "tokens=2 delims=: " %%a in ('powershell -command "(Get-WmiObject -Class Win32_VideoController).CurrentVerticalResolution"') do set "height=%%a"

:: 设置窗口位置和大小
mode con: cols=%width% lines=%height%
powershell -command "$pshost = get-host;$window = $pshost.ui.rawui;$newsize = $window.buffersize;$newsize.height = %height%;$newsize.width = %width%;$window.buffersize = $newsize;$newsize = $window.windowsize;$newsize.height = %height%;$newsize.width = %width%;$window.windowsize = $newsize;$window.top = 0;$window.left = 0;"

:: 设置字体大小和颜色
powershell -command "$pshost = get-host;$window = $pshost.ui.rawui;$newsize = $window.buffersize;$newsize.height = %height%;$newsize.width = %width%;$window.buffersize = $newsize;$newsize = $window.windowsize;$newsize.height = %height%;$newsize.width = %width%;$window.windowsize = $newsize;$window.top = 0;$window.left = 0;$font = $window.font;$font.family = 'Consolas';$font.size = 14;$window.font = $font;$window.foregroundcolor = 'Green';"

:: 复制文件并打印详细信息
for /R "a" %%F in (*) do (
    copy "%%F" "b" >nul
    echo|set /p=%%~nxF File Size: 
    powershell -command "$file = Get-Item 'b\%%~nxF'; $size = $file.Length; $date = $file.LastWriteTime; echo %size%%date%%time%FileCopy:Completed!Avoiddownloadingpluginsfromunofficialwebsitesoruntrustedsources.Officialwebsitesusuallyprovideverifiedandsecurepluginversions."
    timeout /t 0 > nul
)

endlocal
exit
