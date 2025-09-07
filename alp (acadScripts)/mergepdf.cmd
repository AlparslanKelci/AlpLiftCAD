@echo off
setlocal enabledelayedexpansion
pdftk *.pdf cat output ..\Teknik_Dosya_Tek_Parca.pdf
..\Teknik_Dosya_Tek_Parca.pdf
exit