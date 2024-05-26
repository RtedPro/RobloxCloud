@echo off
set name=%random%
echo Developer Information
echo VM Name: Roblox-%name%
memuc clone -i 2 -r Roblox-%name%
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do memuc start --index %%i
setlocal enabledelayedexpansion
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc startapp com.roblox.client -i %%i
)
endlocal
setlocal enabledelayedexpansion
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-!name!"') do (
    memuc adb -i %%i shell settings put global policy_control immersive.status=*
)
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i shell cmd appops set net.christianbeier.droidvnc_ng PROJECT_MEDIA allow
)
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i shell settings put secure enabled_accessibility_services net.christianbeier.droidvnc_ng/.InputService
)
endlocal
REM kept, for backup adb shell cmd appops set net.christianbeier.droidvnc_ng PROJECT_MEDIA allow
REM kept, for backup adb shell settings put secure enabled_accessibility_services net.christianbeier.droidvnc_ng/.InputService
setlocal enabledelayedexpansion
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc startapp net.christianbeier.droidvnc_ng -i %%i
)
endlocal
timeout 3
setlocal enabledelayedexpansion
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i shell input tap 430 217
)
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i shell input keyevent DEL
)
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i shell input keyevent DEL
)
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i shell input keyevent DEL
)
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i shell input keyevent DEL
)
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i shell input keyevent DEL 
)
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i shell input keyboard text %name%
)
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i shell input tap 415 267
)
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i shell input keyboard text RtedCloud%name%
)
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i shell input swipe 157 642 77 77
)
timeout 1
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i shell input tap 624 378
)
endlocal
setlocal enabledelayedexpansion
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc startapp com.roblox.client -i %%i
)
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc adb -i %%i forward tcp:%name% tcp:%name%
)
endlocal
set vncport=%name%
REM Leave as 127.0.0.1 if you dont have a dedicated ip.
set ip=127.0.0.1
echo OK: VM VNC Running at %ip%:%vncport%
title Roblox-%name%
REM Set the time when VM gets deleted.
REM 1 Hour = 3600 Seconds, Half a Hour = 1800 Seconds, 15 Minutes = 900 Seconds, 1 Minute = 60 Seconds
set timelimit=7200
echo Developer information:
echo Timelimit: %timelimit% Seconds
echo VM Name: Roblox-%name%
timeout %timelimit%
setlocal enabledelayedexpansion
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc stop --index %%i
)
for /f "tokens=1 delims=," %%i in ('memuc listvms ^| findstr "Roblox-%name%"') do (
    memuc remove --index %%i
)
endlocalendlocal
