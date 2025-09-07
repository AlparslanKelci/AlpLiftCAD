ECHO "BACKUP DATABASE FILE SCRIPT BY ALPROCK"
@ECHO OFF
PUSHD \\ALP\DATABASE
MKDIR %username%%date:~10,4%%date:~4,2%%date:~7,2%
COPY %APPDATA%\AlpLiftCAD\ASNData.db %username%%date:~10,4%%date:~4,2%%date:~7,2%\ASNData.db

POPD
COPY /Y "%APPDATA%\AlpLiftCAD\ASNData.db" "D:\CiritAsansör1992 (Cloud Backup)\ydk.db"
@ECHO DATABASE SUNUCUYA YEDEKLENDI
PAUSE
ECHO "END OF SCRIPT"
