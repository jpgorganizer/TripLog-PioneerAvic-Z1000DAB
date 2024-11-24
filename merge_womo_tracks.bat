@echo off
rem merge_womo_tracks.bat
rem merge all tracks from one day into a single track within one gpx file
rem
rem SVN:      $Revision: 3297 $
rem           $Date: 2024-11-23 17:13:47 +0100 (Sa, 23 Nov 2024) $
rem ==============================================================
rem USAGE: merge_womo_tracks.bat <joinedgpxfile> <mergedgpxfile>

rem --------------------------------------------------------
rem set your own values here
set GPXSCRIPT="C:\Program Files\GPSBabel\gpsbabel.exe"
set TRACKNAMEPART=_Womo

rem --------------------------------------------------------
rem please don't change from here
set joinedgpxfile=%1
set mergedgpxfile=%2
if "%joinedgpxfile%"=="" goto :ERROR
if "%mergedgpxfile%"=="" goto :ERROR

echo GPXSCRIPT=%GPXSCRIPT%
echo TRACKNAMEPART=%TRACKNAMEPART%
echo joinedgpxfile=%joinedgpxfile%
echo mergedgpxfile=%mergedgpxfile%

set command=%GPXSCRIPT% -t -i gpx -f %joinedgpxfile% ^
     -x track,merge,split,title=%%Y%%m%%d%TRACKNAMEPART% ^
	 -o gpx -F %mergedgpxfile%

echo %command%
     %command%
	 
goto :ENDOFFILE


rem xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
:ERROR
echo given parameter:
echo joinedgpxfile=%joinedgpxfile%
echo mergedgpxfile=%mergedgpxfile%
echo.
echo USAGE: %~nx0  joinedgpxfile mergedgpxfile
echo.
echo joinedgpxfile: path and file name with the joined tracks
echo mergedgpxfile: path and file name for the merged tracks
echo.

goto :ENDOFFILE

   
rem xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
:ENDOFFILE


