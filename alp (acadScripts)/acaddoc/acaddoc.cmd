@echo off
xcopy "acaddoc.lsp" "%ProgramFiles%\Autodesk\AutoCAD 2018\Support\" /K /D /H /Y
xcopy "burst&purge.lsp" "%ProgramFiles%\Autodesk\AutoCAD 2018\Support\" /K /D /H /Y

xcopy "acaddoc.lsp" "%ProgramFiles%\Autodesk\AutoCAD 2019\Support\" /K /D /H /Y
xcopy "burst&purge.lsp" "%ProgramFiles%\Autodesk\AutoCAD 2019\Support\" /K /D /H /Y

xcopy "acaddoc.lsp" "%ProgramFiles%\Autodesk\AutoCAD 2020\Support\" /K /D /H /Y
xcopy "burst&purge.lsp" "%ProgramFiles%\Autodesk\AutoCAD 2020\Support\" /K /D /H /Y

xcopy "acaddoc.lsp" "%ProgramFiles%\Autodesk\AutoCAD 2021\Support\" /K /D /H /Y
xcopy "burst&purge.lsp" "%ProgramFiles%\Autodesk\AutoCAD 2021\Support\" /K /D /H /Y
exit