@REM
@REM Download hex file to flash via ISP 20231201
@REM

@SETLOCAL

@REM -----------------------------------------------------------------------

@SET CONFIG_FILE_PATH=AVRDUDE_OPTION.TXT
@SET SECOND_PARAMETER=%1

@REM -----------------------------------------------------------------------

@ECHO OFF

@ECHO.
@ECHO                      Download hex file to flash via ISP
@ECHO.
@ECHO  Reading config file.
@ECHO ===============================================================================
@ECHO.


@IF NOT EXIST %CONFIG_FILE_PATH% GOTO error_config_file
@FOR /F "tokens=1,* delims==" %%a IN (%CONFIG_FILE_PATH%) DO SET "%%a=%%b"
@IF ERRORLEVEL 1 GOTO error_missing_config
@IF NOT DEFINED AVR_EXECUTABLE_DIR SET AVR_EXECUTABLE_DIR=.
@IF NOT EXIST %AVR_EXECUTABLE_DIR%\avrdude.exe GOTO error_executable
@IF NOT DEFINED SECOND_PARAMETER GOTO error_missing_arguments


@ECHO.
@ECHO                      Download hex file to flash via ISP
@ECHO.
@ECHO  File specified: %SECOND_PARAMETER%
@ECHO.
@ECHO  Do you wish to continue?
@ECHO ===============================================================================
@ECHO Enter y/n or press ENTER to abort
@ECHO.

@SET VAR=
@SET /P VAR="Enter: "

@IF NOT DEFINED VAR GOTO act_aborted
@IF "%VAR%"=="n" GOTO act_aborted
@IF "%VAR%"=="N" GOTO act_aborted
@IF "%VAR%"=="no" GOTO act_aborted
@IF "%VAR%"=="NO" GOTO act_aborted
@IF "%VAR%"=="y" GOTO act_download
@IF "%VAR%"=="Y" GOTO act_download
@IF "%VAR%"=="yes" GOTO act_download
@IF "%VAR%"=="YES" GOTO act_download
@GOTO act_aborted


:act_download
@ECHO.
@ECHO                      Download hex file to flash via ISP
@ECHO.
@ECHO  Starting avrdude...
@ECHO ===============================================================================
@ECHO.


%AVR_EXECUTABLE_DIR%\avrdude -c c232hm -p m644p
@IF ERRORLEVEL 1 GOTO error_isp


@ECHO.
@ECHO                      Download hex file to flash via ISP
@ECHO.
@ECHO  Downloading...
@ECHO ===============================================================================
@ECHO.


@IF NOT EXIST %SECOND_PARAMETER% GOTO error_hex_file
%AVR_EXECUTABLE_DIR%\avrdude -c c232hm -p m644p -U flash:w:%SECOND_PARAMETER%
@IF ERRORLEVEL 1 GOTO error_download


@ECHO.
@ECHO                      Download hex file to flash via ISP
@ECHO.
@ECHO  Done.
@ECHO ===============================================================================
@ECHO.
@GOTO :end


:act_aborted
@ECHO.
@ECHO                      Download hex file to flash via ISP
@ECHO.
@ECHO  Action aborted.
@ECHO ===============================================================================
@ECHO.
@GOTO end


@REM -----------------------------------------------------------------------

:error_config_file
@ECHO ERROR: Cannot open AVRDUDE_OPTION.TXT
@GOTO end

:error_missing_config
@ECHO ERROR: Missing configuration parameters.
@GOTO end

:error_executable
@ECHO ERROR: Cannot find avrdude.
@GOTO end

:error_missing_arguments
@ECHO ERROR: No hex file specified, nothing to be done.
@ECHO Usage: DOWNLOADISP ^<hexfile^>
@GOTO end

:error_isp
@ECHO ERROR: Test ISP interface failed.
@GOTO end

:error_hex_file
@ECHO ERROR: Cannot find hex file %SECOND_PARAMETER%
@GOTO end

:error_download
@ECHO ERROR: Failed to download.
@GOTO end


:end
@ECHO Press any key to exit.
@ECHO.
@PAUSE> NUL
@ENDLOCAL
