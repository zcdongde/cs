@echo off
setlocal enabledelayedexpansion
:: 设置窗口标题
title dongde系统维护工具箱 v5.0 (修复闪退版)
color 0b

:menu
cls
echo =================================================================
echo             dongde 系统维护工具箱 v5.0 (极速稳定版)
echo =================================================================
echo  [系统/激活] (独立窗口)
echo   [1] MediaCreationTool (系统下载)
echo   [4] MAS (Windows/Office 激活)
echo   [5] Office Tool Plus (Office 安装)
echo   [6] 搜狗输入法 (Winget 安装)
echo.
echo  [装机工具] (浏览器直达)
echo   [2] Rufus (官网)             [3] Flyby11 (GitHub)
echo   [7] HiBit Uninstaller (OSS)  [8] Bandizip 6.0 (OSS无广)
echo.
echo  [常用软件] (浏览器直达/OSS)
echo   [9]  WPS Office (官网)       [10] 火绒安全 (官网)
echo   [11] CherryStudio (官网)     [12] Clash Verge (OSS直链)
echo   [13] KeePass (官网)          [14] Snipaste (官网直链)
echo   [15] QQ (官网)               [16] 微信 (官网直链)
echo   [17] 企业微信 (官网直链)
echo.
echo  [0] 退出
echo =================================================================
echo  示例: "1,12,15" 或 "1-17" (全选并发)
echo =================================================================
set /p user_input=请输入选项: 

if "%user_input%"=="" goto menu
if "%user_input%"=="0" exit

echo.
echo [正在分发任务...]

:: --- 解析多选逻辑 ---
set "work_list=%user_input:,= %"

for %%i in (%work_list%) do (
    set "item=%%i"
    :: 检查是否为范围 (例如 1-17)
    if "!item:-=!" neq "!item!" (
        for /f "tokens=1,2 delims=-" %%a in ("!item!") do (
            set "start_num=%%a"
            set "end_num=%%b"
            if "!start_num!"=="" set start_num=1
            if "!end_num!"=="" set end_num=1
            for /L %%k in (!start_num!, 1, !end_num!) do (
                call :launch_task %%k
            )
        )
    ) else (
        call :launch_task !item!
    )
)

echo.
echo ============================================
echo  所有任务已启动。
echo  请检查浏览器下载列表或新弹出的窗口。
echo ============================================
pause
goto menu

:: --- 任务分发 (使用单行逻辑防止语法崩溃) ---
:launch_task
set "idx=%~1"
if "%idx%"=="" goto :eof

:: [1] MCT
if "%idx%"=="1" start "MCT" powershell -NoProfile -Command "$u='https://github.com/AveYo/MediaCreationTool.bat/raw/main/MediaCreationTool.bat'; $f=\"$env:USERPROFILE\Desktop\MediaCreationTool.bat\"; try{ irm $u -OutFile $f; & $f }catch{ Start-Process 'https://github.com/AveYo/MediaCreationTool.bat' }" & goto :eof

:: [2] Rufus (官网)
if "%idx%"=="2" start "" "https://rufus.ie/zh/" & goto :eof

:: [3] Flyby11 (GitHub)
if "%idx%"=="3" start "" "https://github.com/builtbybel/Flyby11/releases" & goto :eof

:: [4] MAS 激活
if "%idx%"=="4" start "MAS" powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex" & goto :eof

:: [5] OTP
if "%idx%"=="5" start "OTP" powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://officetool.plus | iex" & goto :eof

:: [6] 搜狗输入法
if "%idx%"=="6" start "Sogou" cmd /c "winget install --id Sogou.SogouInput --source winget --accept-package-agreements --accept-source-agreements & pause" & goto :eof

:: [7] HiBit (OSS - 注意链接中的 % 已转义为 %%)
if "%idx%"=="7" start "" "https://dongdepicturesbed.oss-cn-wuhan-lr.aliyuncs.com/2601-%%E5%%8D%%B8%%E8%%BD%%BD%%E5%%B7%%A5%%E5%%85%%B7HiBitUninstaller-Portable3.2.55-54.exe" & goto :eof

:: [8] Bandizip (OSS - 注意链接中的 % 已转义为 %%)
if "%idx%"=="8" start "" "https://dongdepicturesbed.oss-cn-wuhan-lr.aliyuncs.com/2601-A%%E8%%A3%%85%%E6%%9C%%BA%%E5%%BF%%85%%E5%%A4%%87-%%E5%%8E%%8B%%E7%%BC%%A9%%E6%%97%%A0%%E5%%B9%%BF%%E5%%91%%8A%%E7%%89%%88BANDIZIP6-SETUP%%EF%%BC%%88%%E8%%A3%%85%%E5%%90%%8E%%E5%%8F%%96%%E6%%B6%%88%%E6%%9B%%B4%%E6%%96%%B0%%EF%%BC%%89-03.EXE" & goto :eof

:: [9] WPS (官网)
if "%idx%"=="9" start "" "https://www.wps.cn/" & goto :eof

:: [10] 火绒 (官网个人版)
if "%idx%"=="10" start "" "https://www.huorong.cn/person" & goto :eof

:: [11] CherryStudio (官网)
if "%idx%"=="11" start "" "https://www.cherry-ai.com/download" & goto :eof

:: [12] Clash Verge (OSS直链)
if "%idx%"=="12" start "" "https://dongdepicturesbed.oss-cn-wuhan-lr.aliyuncs.com/2602-Clash.Verge_2.4.5_x64-setup-09.exe" & goto :eof

:: [13] KeePass (官网下载页)
if "%idx%"=="13" start "" "https://keepass.info/download.html" & goto :eof

:: [14] Snipaste (官网直链)
if "%idx%"=="14" start "" "https://dl.snipaste.com/win-x64" & goto :eof

:: [15] QQ (官网 - 修复了 # 导致的崩溃)
if "%idx%"=="15" start "" "https://im.qq.com/index/#/" & goto :eof

:: [16] 微信 (直链)
if "%idx%"=="16" start "" "https://dldir1.qq.com/weixin/Windows/WeChatSetup.exe" & goto :eof

:: [17] 企业微信 (直链)
if "%idx%"=="17" start "" "https://work.weixin.qq.com/wework_admin/commdownload?platform=win" & goto :eof

goto :eof
