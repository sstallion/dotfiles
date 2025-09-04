@ECHO OFF
SET COLUMNS=108
SET LINES=65
wt.exe --size %COLUMNS%,%LINES% --window Neovim nvim.exe %*