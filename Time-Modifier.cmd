@REM Copyright (c) [2025] [anjisuan608]
@REM [Sky-Time-Modify-Tool] is licensed under Mulan PubL v2.
@REM You can use this software according to the terms and conditions of the Mulan PubL v2.
@REM You may obtain a copy of Mulan PubL v2 at:
@REM          http://license.coscl.org.cn/MulanPubL-2.0
@REM THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
@REM EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
@REM MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
@REM See the Mulan PubL v2 for more details.
@echo off
title Sky-Time-Modify-Tool
@REM 管理员身份检查
net session >nul 2>&1
if %errorlevel% neq 0 (
    color 04
    echo ======================
    echo 请以管理员身份运行此工具！
    echo ======================
    echo.
    pause
    exit /b
)

:menu
@REM 主菜单
echo 键入 h 脚本以遇境时间模式工作
echo 键入 a 脚本以云巢时间模式工作
echo 键入 r 恢复当前时区的时间
echo 键入 x 退出批处理
echo 请选择要进行的操作:
choice /C harx /CS
if %errorlevel%==1 goto home
if %errorlevel%==2 goto av
if %errorlevel%==3 goto reset
if %errorlevel%==4 goto x
@REM 异常回收
echo.
echo 发生异常,返回菜单
goto menu

:home
@REM 遇境时间控制
echo 请确保您已经进入游戏后继续
pause
goto homeTimeShell

:homeTimeShell
setlocal enabledelayedexpansion
set times=05:00:00 09:00:00 10:00:00 16:00:00 17:00:00 21:00:00
for %%t in (%times%) do (
    echo 正在设置系统时间为 %%t
    time %%t
    timeout /t 4 >nul
)
goto menu

:av
@REM 云巢时间控制
echo 请确保您已经进入游戏后继续
pause
goto avTimeShell

:avTimeShell
setlocal enabledelayedexpansion
set mins=00 10 15 40 50
for %%m in (%mins%) do (
    set newtime=!time:~0,3!%%m:00
    echo 正在设置系统时间为 !newtime!
    time !newtime!
    timeout /t 4 >nul
)
goto menu

:reset
echo 正在重置时间……

:TimeReset
@REM 使用NTP服务器(ntp.ntsc.ac.cn)进行时间校准
echo 正在与NTP服务器(ntp.ntsc.ac.cn)同步时间...
w32tm /config /manualpeerlist:"ntp.ntsc.ac.cn" /syncfromflags:manual /update
w32tm /resync >nul 2>&1 && (
    echo 时间同步成功！
) || (
    echo 时间同步失败，请检查网络连接或管理员权限。
)
goto menu

:x
@REM 退出
exit /b