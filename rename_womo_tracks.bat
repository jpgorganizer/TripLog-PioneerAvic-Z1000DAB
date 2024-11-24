@echo off
rem rename_womo_tracks.bat
rem renames gpx files from Pioneer AVIC Z1000-DAB so that the
rem filename starts with "Fahrt_YYYYMMDD" 
rem
rem SVN:      $Revision: 3296 $
rem           $Date: 2024-11-23 16:19:13 +0100 (Sa, 23 Nov 2024) $
rem ==============================================================
rem USAGE: rename_womo_tracks.bat <directory>

rem --------------------------------------------------------
rem set your own values here
set OLDFILENAMEPREFIX=Fahrt
set NEWFILENAMEPREFIX=Fahrt_

rem --------------------------------------------------------
rem please don't change from here
set trackdir=%1
echo trackdir=%trackdir%
if "%trackdir%"=="" goto :ERROR

set startdir=%cd%
echo startdir=%startdir%

for  %%a in (".\%trackdir%\%OLDFILENAMEPREFIX%*") do (call :renametrack "%%a" )

goto :ENDOFFILE


rem xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
:renametrack
set trackfile=%1
echo trackfile=%trackfile%
set  x=%trackfile:~2%
rem echo x=%x%
call set "_result=%%x:%trackdir%\=%%"
set N=%_result%
rem echo N=%N%
set mydir="%startdir%\%trackdir%"
rem echo mydir=%mydir%

rem remove quotation marks
set mydir1=%mydir:~1,-1%
rem echo mydir1=%mydir1%

set newfilename=%NEWFILENAMEPREFIX%%N:~19,4%-%N:~16,2%-%N:~13,2%_%N:~24,12%
rem echo newfilename=%newfilename%
set old_with_dir=%mydir1%\%N:~1,-1% 
rem echo old_with_dir=%old_with_dir%

set command=rename "%old_with_dir%" "%newfilename%"		 
echo %command%
     %command%  
	 
echo ========
exit /b   


rem xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
:ERROR
echo given parameter:
echo directory=%trackdir%
echo.
echo.echo USAGE: %~nx0  directory
echo.
echo directory: directory containing the gpx files to be renamed

goto :ENDOFFILE


:ENDOFFILE
