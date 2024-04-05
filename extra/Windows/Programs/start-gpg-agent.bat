@ECHO OFF
ECHO Starting GnuPG Agent...
"%ProgramFiles(x86)%\gnupg\bin\gpg-connect-agent.exe" killagent /bye 2>NUL
"%ProgramFiles(x86)%\gnupg\bin\gpg-connect-agent.exe" /bye
TIMEOUT /T 5 /NOBREAK >NUL
"%ProgramFiles(x86)%\gnupg\bin\gpg.exe" --card-status
TIMEOUT /T 1 /NOBREAK >NUL
IF %ERRORLEVEL% NEQ 0 PAUSE
