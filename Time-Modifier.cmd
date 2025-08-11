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
    echo ==============================
    echo 请以管理员身份运行此工具！
    echo ==============================
    echo.
    pause
    exit /b
)

@REM 初始化间隔时长变量
set "homeSwitchTimeInterval=4"
set "avSwitchTimeInterval=4"

:menu
cls
@REM 主菜单
echo ================================================
echo 键入 h 遇境时间切换模式
echo 键入 a 云巢时间切换模式
echo 键入 r 联机恢复正确时间(实验性)
echo 键入 t 进入时间设置
echo 键入 c 清屏
echo 键入 x 退出批处理
echo ================================================
echo.
echo 请选择要进行的操作:
choice /C hartcx /CS
if %errorlevel%==1 goto home
if %errorlevel%==2 goto av
if %errorlevel%==3 goto reset
if %errorlevel%==4 goto t
if %errorlevel%==5 goto c
if %errorlevel%==6 goto x
@REM 异常回收
echo.
echo 发生异常,返回菜单
goto menu

:home
cls
@REM 遇境时间控制
echo.
echo 请确保您已经进入游戏后继续进行操作!
echo.
echo ===============================================
echo 键入 o 开始运行
echo 键入 s 配置切换
echo ++++++++++++++++++++++++++++++++++++++++++++++
echo 键入 r 联机恢复正确时间(实验性)
echo ++++++++++++++++++++++++++++++++++++++++++++++
echo 键入 b 返回主菜单
echo 键入 c 清屏
echo 键入 x 退出
echo ===============================================
echo.
echo 请选择要进行的操作:
choice /C osrbcx /CS
if %errorlevel%==1 goto homeTimeShell
if %errorlevel%==2 goto homeTimeSwitchSetting
if %errorlevel%==3 goto reset
if %errorlevel%==4 goto menu
if %errorlevel%==5 goto c
if %errorlevel%==6 goto x
@REM 异常回收
goto home

goto homeTimeShell

:homeTimeShell
@REM 遇境时间切换执行模块
echo 当前切换间隔时间为: %homeSwitchTimeInterval% 秒
setlocal enabledelayedexpansion
set times=05:00:00 09:00:00 10:00:00 16:00:00 17:00:00 21:00:00
for %%t in (%times%) do (
    echo 正在设置系统时间为 %%t
    time %%t
    timeout /t %homeSwitchTimeInterval% >nul
)
goto home

:homeTimeSwitchSetting
@REM 时间切换设置模块
echo.
echo 当前遇境时间切换间隔为: %homeSwitchTimeInterval% 秒
echo.
echo 请输入新的切换间隔时间（0-99999秒）:
set /p "inputTime="

@REM 验证输入是否为纯数字且在有效范围内
set "validInput=1"
if not defined inputTime set "validInput=0"
for /f "delims=0123456789" %%i in ("%inputTime%") do set "validInput=0"
if %validInput%==1 (
    if %inputTime% geq 0 (
        if %inputTime% leq 99999 (
            set "homeSwitchTimeInterval=%inputTime%"
            echo.
            echo 设置成功！新的切换间隔时间: %homeSwitchTimeInterval% 秒
        ) else set "validInput=0"
    ) else set "validInput=0"
) else (
    echo.
    echo 错误：请输入0-99999之间的整数。
)

if %validInput%==0 (
    echo.
    echo 输入无效，请重新输入。
    timeout /t 2 >nul
)
goto home

:av
@REM 云巢时间控制
cls
echo.
echo 请确保您已经进入游戏后继续进行操作!
echo.
echo ===============================================
echo 键入 o 开始运行
echo 键入 s 配置切换
echo ++++++++++++++++++++++++++++++++++++++++++++++
echo 键入 r 联机恢复正确时间(实验性)
echo ++++++++++++++++++++++++++++++++++++++++++++++
echo 键入 b 返回主菜单
echo 键入 c 清屏
echo 键入 x 退出
echo ===============================================
echo.
echo 请选择要进行的操作:
choice /C osrbcx /CS
if %errorlevel%==1 goto avTimeShell
if %errorlevel%==2 goto avTimeSwitchSetting
if %errorlevel%==3 goto reset
if %errorlevel%==4 goto menu
if %errorlevel%==5 goto c
if %errorlevel%==6 goto x
@REM 异常回收
goto av

:avTimeShell
@REM 云巢时间切换执行模块
echo 当前切换间隔时间为: %avSwitchTimeInterval% 秒
setlocal enabledelayedexpansion
set mins=00 10 15 40 50
for %%m in (%mins%) do (
    set newtime=!time:~0,3!%%m:00
    echo 正在设置系统时间为 !newtime!
    time !newtime!
    timeout /t %avSwitchTimeInterval% >nul
)
goto av

:avTimeSwitchSetting
@REM 云巢时间切换设置模块
echo.
echo 当前云巢时间切换间隔为: %avSwitchTimeInterval% 秒
echo.
echo 请输入新的切换间隔时间（0-99999秒）:
set /p "inputTime="

@REM 验证输入是否为纯数字且在有效范围内
set "validInput=1"
if not defined inputTime set "validInput=0"
for /f "delims=0123456789" %%i in ("%inputTime%") do set "validInput=0"
if %validInput%==1 (
    if %inputTime% geq 0 (
        if %inputTime% leq 99999 (
            set "avSwitchTimeInterval=%inputTime%"
            echo.
            echo 设置成功！新的切换间隔时间: %avSwitchTimeInterval% 秒
        ) else set "validInput=0"
    ) else set "validInput=0"
) else (
    echo.
    echo 错误：请输入0-99999之间的整数。
)

if %validInput%==0 (
    echo.
    echo 输入无效，请重新输入。
    timeout /t 2 >nul
)
goto av

:reset
:TimeResetShell
@REM 使用NTP服务器进行时间校准
echo 正在与NTP服务器(ntp.ntsc.ac.cn)同步时间...
w32tm /config /manualpeerlist:"ntp.ntsc.ac.cn" /syncfromflags:manual /update
w32tm /resync >nul 2>&1 && (
    echo 时间同步成功！
) || (
    echo 时间同步失败，请检查网络连接或管理员权限。
)
goto menu

:t
@REM 时间配置菜单
cls

:c
@REM 清屏
cls
goto menu

:x
@REM 退出
exit /b