@REM
@REM BUILD FOR WINAVR 20231201
@REM

@SETLOCAL enabledelayedexpansion

@REM -----------------------------------------------------------------------

@SET CONFIG_FILE_PATH=AVRBUILD_OPTION.TXT
@REM SET DEFAULT_GCC_EXECUTABLE_DIR=.
@REM SET DEFAULT_C_COMPILER_OPTION=-Wall -g
@REM SET DEFAULT_CPP_COMPILER_OPTION=-Wall -g
@REM SET DEFAULT_LINKER_OPTION=
@REM SET DEFAULT_RC_OPTION=
@REM SET DEFAULT_BUILD_TARGET_NAME=prog.exe

@REM -----------------------------------------------------------------------

REM @ECHO OFF

@ECHO.
@ECHO                             BUILD FOR WINAVR
@ECHO.
@ECHO  Reading config file...
@ECHO ===============================================================================
@ECHO.


@IF NOT EXIST %CONFIG_FILE_PATH% GOTO error_config_file
@FOR /F "tokens=1,* delims==" %%a IN (%CONFIG_FILE_PATH%) DO SET "%%a=%%b"
@IF ERRORLEVEL 1 GOTO error_missing_config
@IF NOT DEFINED GCC_EXECUTABLE_DIR SET GCC_EXECUTABLE_DIR=avr-gcc
@IF NOT EXIST %GCC_EXECUTABLE_DIR% GOTO error_executable_gcc
@IF NOT DEFINED GPP_EXECUTABLE_DIR SET GCC_EXECUTABLE_DIR=avr-g++
@IF NOT EXIST %GPP_EXECUTABLE_DIR% GOTO error_executable_gpp
@IF NOT DEFINED OBJCOPY_EXECUTABLE_DIR SET OBJCOPY_EXECUTABLE_DIR=avr-objcopy
@IF NOT EXIST %OBJCOPY_EXECUTABLE_DIR% GOTO error_executable_objcopy
@IF NOT DEFINED PROJECT_FOLDER_NAME GOTO error_missing_config
@IF NOT DEFINED C_COMPILER_OPTION SET C_COMPILER_OPTION=-Wall -g -mmcu=atmega644p -DF_CPU=12000000
@IF NOT DEFINED CPP_COMPILER_OPTION SET CPP_COMPILER_OPTION=-Wall -g -mmcu=atmega644p -DF_CPU=12000000
@IF NOT DEFINED LINKER_OPTION SET LINKER_OPTION=-mmcu=atmega644p
@IF NOT DEFINED AVR_OBJCOPY_OPTION SET AVR_OBJCOPY_OPTION=-R .eeprom -R .fuse -R .lock -R .signature
@IF NOT DEFINED RC_OPTION SET RC_OPTION=
@IF NOT DEFINED BUILD_TARGET_NAME SET BUILD_TARGET_NAME=%PROJECT_FOLDER_NAME%


@ECHO.
@ECHO                             BUILD FOR WINAVR
@ECHO.
@ECHO  Cleaning up...
@ECHO ===============================================================================
@ECHO.


@IF EXIST %BUILD_TARGET_NAME%.elf DEL /F /Q %BUILD_TARGET_NAME%.elf
@IF ERRORLEVEL 1 GOTO error_generic
@IF EXIST %BUILD_TARGET_NAME%.hex DEL /F /Q %BUILD_TARGET_NAME%.hex
@IF ERRORLEVEL 1 GOTO error_generic
@IF EXIST obj\*.o DEL /F /Q obj\*.o
@IF ERRORLEVEL 1 GOTO error_generic


@ECHO.
@ECHO                             BUILD FOR WINAVR
@ECHO.
@ECHO  Rebuilding project...
@ECHO ===============================================================================
@ECHO.


@ECHO.
@ECHO                             BUILD FOR WINAVR
@ECHO.
@ECHO  Compiling...
@ECHO ===============================================================================
@ECHO.


@IF NOT EXIST obj MD obj
@IF ERRORLEVEL 1 GOTO error_generic
@FOR /F  "delims="  %%f IN ('DIR %PROJECT_FOLDER_NAME%\*.c /s /b') DO %GCC_EXECUTABLE_DIR% %C_COMPILER_OPTION% -c %%f -o obj\%%~nf.o
@IF ERRORLEVEL 1 GOTO error_compile
@FOR /F  "delims="  %%f IN ('DIR %PROJECT_FOLDER_NAME%\*.cpp /s /b') DO %GPP_EXECUTABLE_DIR% %CPP_COMPILER_OPTION% -c %%f -o obj\%%~nf.o
@IF ERRORLEVEL 1 GOTO error_compile
@FOR /F  "delims="  %%f IN ('DIR %PROJECT_FOLDER_NAME%\*.cc /s /b') DO %GPP_EXECUTABLE_DIR% %CPP_COMPILER_OPTION% -c %%f -o obj\%%~nf.o
@IF ERRORLEVEL 1 GOTO error_compile
@FOR /F  "delims="  %%f IN ('DIR %PROJECT_FOLDER_NAME%\*.cxx /s /b') DO %GPP_EXECUTABLE_DIR% %CPP_COMPILER_OPTION% -c %%f -o obj\%%~nf.o
@IF ERRORLEVEL 1 GOTO error_compile


@ECHO.
@ECHO                             BUILD FOR WINAVR
@ECHO.
@ECHO  Linking...
@ECHO ===============================================================================
@ECHO.


@FOR /F  "delims="  %%f IN ('DIR obj\*.o /s /b') DO SET OBJ_FILE_LIST=!OBJ_FILE_LIST! %%f
@%GPP_EXECUTABLE_DIR% -o %BUILD_TARGET_NAME%.elf %OBJ_FILE_LIST% %LINKER_OPTION%
@IF ERRORLEVEL 1 GOTO error_link


@ECHO.
@ECHO                             BUILD FOR WINAVR
@ECHO.
@ECHO  Transforming to hex...
@ECHO ===============================================================================
@ECHO.


@%OBJCOPY_EXECUTABLE_DIR% -O ihex %BUILD_TARGET_NAME%.elf %BUILD_TARGET_NAME%.hex
@IF ERRORLEVEL 1 GOTO error_hex


@ECHO.
@ECHO                             BUILD FOR WINAVR
@ECHO.
@ECHO  Done.
@ECHO ===============================================================================
@ECHO.
@GOTO :end


@REM -----------------------------------------------------------------------

:error_config_file
@ECHO ERROR: Cannot open BUILD_OPTION.TXT
@GOTO end

:error_missing_config
@ECHO ERROR: Missing configuration parameters.
@GOTO end

:error_executable_gcc
@ECHO ERROR: Cannot find avr-gcc.
@GOTO end

:error_executable_gpp
@ECHO ERROR: Cannot find avr-g++.
@GOTO end

:error_executable_objcopy
@ECHO ERROR: Cannot find avr-objcopy.
@GOTO end

:error_generic
@ECHO ERROR: Generic batch command error.
@GOTO end

:error_compile
@ECHO ERROR: Compiler error.
@GOTO end

:error_link
@ECHO ERROR: Linker error.
@GOTO end

:error_hex
@ECHO ERROR: avr-objcopy error.
@GOTO end


:end
@ECHO Press any key to exit.
@ECHO.
@PAUSE> NUL
@ENDLOCAL

