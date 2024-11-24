@echo off
rem export_womo_tracks.bat
rem export all tracks from gpx-file to a new gpx-file
rem
rem SVN:      $Revision: 3294 $
rem           $Date: 2024-11-23 13:35:27 +0100 (Sa, 23 Nov 2024) $
rem ==============================================================
rem USAGE: export_womo_tracks.bat <mergedgpxfile> 

rem --------------------------------------------------------
rem set your own values here
set GPXSCRIPT="C:\Program Files\GPSBabel\gpsbabel.exe"

rem --------------------------------------------------------
rem please don't change from here
set mergedgpxfile=%1
if "%mergedgpxfile%"=="" goto :ERROR

echo GPXSCRIPT=%GPXSCRIPT%
echo mergedgpxfile=%mergedgpxfile%

For %%A in ("%mergedgpxfile%") do (
    Set folder=%%~dpA
    rem Set filename=%%~nxA
)
echo folder=%folder%
rem echo filename is: %filename%

set tempfile=%mergedgpxfile%.tmp
rem echo tempfile=%tempfile%

findstr /i "<name>" %mergedgpxfile% | findstr -i "</name>" >%tempfile%

for /F "tokens=1,2,3,4 delims==<>" %%i in (%tempfile%) do (
    echo write track=%%k 
	%GPXSCRIPT% -t -r -w -i gpx -f %mergedgpxfile% -x track,name="%%k" -o gpx -F "%folder%\%%k.gpx"
)

goto :ENDOFFILE
  

rem xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
:ERROR
echo given parameter:
echo mergedgpxfile=%mergedgpxfile%
echo.
echo USAGE: %~nx0  mergedgpxfile
echo.
echo mergedgpxfile: gpx file with the (merged) tracks

goto :ENDOFFILE


rem xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx	   
:ENDOFFILE
if not "%tempfile%"=="" if exist "%tempfile%" del "%tempfile%" >nul