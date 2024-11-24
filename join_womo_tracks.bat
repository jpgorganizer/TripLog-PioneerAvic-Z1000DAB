@echo off
rem join_womo_tracks.bat
rem join all gpx-files from Pioneer  AVIC Z1000-DAB to a single gpx-file
rem
rem SVN:      $Revision: 3297 $
rem           $Date: 2024-11-23 17:13:47 +0100 (Sa, 23 Nov 2024) $
rem ==============================================================
rem USAGE: join_womo_tracks.bat <directory> <joinedgpxfile>

rem --------------------------------------------------------
rem set your own values here
set GPXSCRIPT="C:\Program Files\GPSBabel\gpsbabel.exe"
set NEWFILENAMEPREFIX=Fahrt_



rem --------------------------------------------------------
rem please don't change from here
set trackdir=%1
set joinedgpxfile=%2
if "%trackdir%"=="" goto :ERROR
if "%joinedgpxfile%"=="" goto :ERROR

echo GPXSCRIPT=%GPXSCRIPT%
echo NEWFILENAMEPREFIX=%NEWFILENAMEPREFIX%
echo trackdir=%trackdir%
echo joinedgpxfile=%joinedgpxfile%

set inputfilelist=%trackdir%\inputfilelist.tmp
echo inputfilelist=%inputfilelist%

echo -i gpx >%inputfilelist%
for  %%a in ("%trackdir%\%NEWFILENAMEPREFIX%*") do ( 
	echo join file: "%%a"
	echo -f "%%a" >>%inputfilelist%
)

set command=%GPXSCRIPT% -t -b %inputfilelist%  -o gpx -F %joinedgpxfile%
echo %command%
     %command%  
	 
goto :ENDOFFILE


rem xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
:ERROR
echo given parameter:
echo trackdir=%trackdir%
echo joinedgpxfile=%joinedgpxfile%
echo.
echo USAGE: %~nx0  directory joinedgpxfile
echo.
echo directory: directory with the track files to be joined
echo joinedgpxfile: path and file name for the joined tracks
echo.

goto :ENDOFFILE


rem xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
:ENDOFFILE
if exist %inputfilelist% del %inputfilelist% 


