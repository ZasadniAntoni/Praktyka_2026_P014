@echo off
title Remote Desktop SSH Tunnel
setlocal enabledelayedexpansion

:: =========================================================
:: CONFIGURATION VARIABLES
:: =========================================================
set "REMOTE_USER=[login]"
set "PORT=[port_number]"
set "SERVER_IP=149.156.107.197"
set "KILL_SSH_TUNNEL=True"
set "OPENVPN_GUI=C:\Program Files\OpenVPN\bin\openvpn-gui.exe"
set "OPENVPN_CONFIG=VPN-AGH.2026.ovpn"
:: =========================================================

title RDP: %REMOTE_USER%

:: 0. Check and Launch OpenVPN
echo [VPN] Checking if OpenVPN is currently active...
tasklist /FI "IMAGENAME eq openvpn.exe" 2>nul | findstr /I "openvpn.exe" >nul
if %errorlevel% equ 0 (
    echo [VPN] OpenVPN is already running. Skipping connection step.
) else (
    echo [VPN] OpenVPN is not active. Attempting to connect...
    
    :: Check if the GUI executable exists at the specified path
    if not exist "%OPENVPN_GUI%" (
        echo [ERROR] OpenVPN GUI was not found at: "%OPENVPN_GUI%"
        echo Please update the path in the script configuration.
        pause
        exit /b
    )
    :: Start OpenVPN GUI and trigger the specific profile connection
    start "" "%OPENVPN_GUI%" --connect "%OPENVPN_CONFIG%"
    set "WAIT_S=5"
    echo [VPN] Sent connect signal. Waiting !WAIT_S! seconds for VPN tunnel to establish...
    timeout /t !WAIT_S! >nul
)
echo.

:: 1. Start the SSH tunnel with an interactive shell in a new Windows Terminal tab
echo [SSH] Starting Interactive SSH Tunnel for %REMOTE_USER%...
echo.
:: Open new tab for SSH port, then exit automatically when done (and flag==TRUE).
wt -w 0 new-tab --title "SSH: %REMOTE_USER%" cmd /c "ssh -L 3389:127.0.0.1:3389 %REMOTE_USER%@%SERVER_IP% -p %PORT% & exit"

:: 2. Dynamic Port Checking Loop
echo [SSH] Waiting for you to enter password and port 3389 to open...
:CHECK_PORT
timeout /t 1 >nul
netstat -ano | findstr "LISTENING" | findstr ":3389" >nul
if %errorlevel% equ 0 (
    echo [SSH] SSH Tunnel is established!
    goto LAUNCH_RDP
) else (
    goto CHECK_PORT
)

:: 3. Launch Remote Desktop
:LAUNCH_RDP
echo [RDP] Setting temporary credentials for %REMOTE_USER%...
cmdkey /generic:127.0.0.1 /user:%REMOTE_USER%
:: Launch with Default.rdp config
echo [RDP] Launching Remote Desktop...
mstsc /v:127.0.0.1:3389

:: 4. CLEANUP & CONDITIONAL TERMINATION
echo.
echo [CLEANUP] Removing temporary local RDP credentials...
cmdkey /delete:127.0.0.1 >nul 2>&1

if /i "%KILL_SSH_TUNNEL%"=="TRUE" (
    :: This targets the SSH process PID
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr "LISTENING" ^| findstr ":3389"') do (
        taskkill /PID %%a /F >nul 2>&1
    )
) else (
    echo [INFO] SSH tunnel is still active for your use.
)

exit