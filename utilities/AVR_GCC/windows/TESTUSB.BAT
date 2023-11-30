@REM
@REM Test USB interface 20231129
@REM

@SETLOCAL

@REM -----------------------------------------------------------------------

@SET CONFIG_FILE_PATH=AVRDUDE_OPTION.TXT

@REM -----------------------------------------------------------------------

@ECHO OFF

@ECHO.
@ECHO                              Test USB
@ECHO.
@ECHO  Reading config file.
@ECHO ===============================================================================
@ECHO.


@IF NOT EXIST %CONFIG_FILE_PATH% GOTO error_config_file
@FOR /F "tokens=1,* delims==" %%a IN (%CONFIG_FILE_PATH%) DO SET "%%a=%%b"
@IF ERRORLEVEL 1 GOTO error_missing_config
@IF NOT DEFINED AVR_EXECUTABLE_DIR SET AVR_EXECUTABLE_DIR=.
@IF NOT EXIST %AVR_EXECUTABLE_DIR%\avrdude.exe GOTO error_executable


@ECHO.
@ECHO                              Test USB
@ECHO.
@ECHO  Starting avrdude...
@ECHO ===============================================================================
@ECHO.


%AVR_EXECUTABLE_DIR%\avrdude -c usbasp -p m644p
@IF ERRORLEVEL 1 GOTO error_usb


@ECHO.
@ECHO                              Test USB
@ECHO.
@ECHO  Done.
@ECHO ===============================================================================
@ECHO.


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

:error_usb
@ECHO ERROR: Test USB interface failed.
@GOTO end


:end
@ECHO Press any key to exit.
@ECHO.
@PAUSE> NUL
@ENDLOCAL

