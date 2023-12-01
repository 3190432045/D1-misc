@REM
@REM BUILD FOR MINGW 20231201
@REM

@SETLOCAL enabledelayedexpansion

@REM -----------------------------------------------------------------------

@SET CONFIG_FILE_PATH=BUILD_OPTION.TXT
@REM SET DEFAULT_GCC_EXECUTABLE_DIR=.
@REM SET DEFAULT_C_COMPILER_OPTION=-Wall -g
@REM SET DEFAULT_CPP_COMPILER_OPTION=-Wall -g
@REM SET DEFAULT_LINKER_OPTION=
@REM SET DEFAULT_RC_OPTION=
@REM SET DEFAULT_BUILD_TARGET_NAME=prog.exe

@REM -----------------------------------------------------------------------

@ECHO OFF

@ECHO.
@ECHO                             BUILD FOR MINGW
@ECHO.
@ECHO  Reading config file...
@ECHO ===============================================================================
@ECHO.


@IF NOT EXIST %CONFIG_FILE_PATH% GOTO error_config_file
@FOR /F "tokens=1,* delims==" %%a IN (%CONFIG_FILE_PATH%) DO SET "%%a=%%b" || GOTO error_missing_config
@IF NOT DEFINED GCC_EXECUTABLE_DIR SET GCC_EXECUTABLE_DIR=gcc
@IF NOT EXIST %GCC_EXECUTABLE_DIR% GOTO error_executable_gcc
@IF NOT DEFINED GPP_EXECUTABLE_DIR SET GCC_EXECUTABLE_DIR=g++
@IF NOT EXIST %GPP_EXECUTABLE_DIR% GOTO error_executable_gpp
@IF NOT DEFINED PROJECT_FOLDER_NAME GOTO error_missing_config
@IF NOT DEFINED C_COMPILER_OPTION SET C_COMPILER_OPTION=-Wall -g
@IF NOT DEFINED CPP_COMPILER_OPTION SET CPP_COMPILER_OPTION=-Wall -g
@IF NOT DEFINED LINKER_OPTION SET LINKER_OPTION=
@IF NOT DEFINED RC_OPTION SET RC_OPTION=
@IF NOT DEFINED BUILD_TARGET_NAME SET BUILD_TARGET_NAME=%PROJECT_FOLDER_NAME%


@ECHO.
@ECHO                             BUILD FOR MINGW
@ECHO.
@ECHO  Cleaning up...
@ECHO ===============================================================================
@ECHO.


@IF EXIST %BUILD_TARGET_NAME%.exe DEL /F /Q %BUILD_TARGET_NAME%.exe || GOTO error_generic
@IF EXIST obj\*.o DEL /F /Q obj\*.o || GOTO error_generic


@ECHO.
@ECHO                             BUILD FOR MINGW
@ECHO.
@ECHO  Rebuilding project...
@ECHO ===============================================================================
@ECHO.


@FOR /F  "delims="  %%f IN ('DIR %PROJECT_FOLDER_NAME% /AD /S /B') DO SET INC_DIR_LIST=!INC_DIR_LIST! -I%%f || GOTO error_generic
@SET C_COMPILER_OPTION=!C_COMPILER_OPTION! %INC_DIR_LIST% || GOTO error_generic
@SET CPP_COMPILER_OPTION=!CPP_COMPILER_OPTION! %INC_DIR_LIST% || GOTO error_generic


@ECHO.
@ECHO                             BUILD FOR MINGW
@ECHO.
@ECHO  Compiling...
@ECHO ===============================================================================
@ECHO.


@IF NOT EXIST obj MD obj || GOTO error_generic
@FOR /F  "delims="  %%f IN ('DIR %PROJECT_FOLDER_NAME%\*.c /S /B') DO %GCC_EXECUTABLE_DIR% %C_COMPILER_OPTION% -c %%f -o obj\%%~nf.o || GOTO error_compile
@FOR /F  "delims="  %%f IN ('DIR %PROJECT_FOLDER_NAME%\*.cpp /S /B') DO %GPP_EXECUTABLE_DIR% %CPP_COMPILER_OPTION% -c %%f -o obj\%%~nf.o || GOTO error_compile
@FOR /F  "delims="  %%f IN ('DIR %PROJECT_FOLDER_NAME%\*.cc /S /B') DO %GPP_EXECUTABLE_DIR% %CPP_COMPILER_OPTION% -c %%f -o obj\%%~nf.o || GOTO error_compile
@FOR /F  "delims="  %%f IN ('DIR %PROJECT_FOLDER_NAME%\*.cxx /S /B') DO %GPP_EXECUTABLE_DIR% %CPP_COMPILER_OPTION% -c %%f -o obj\%%~nf.o || GOTO error_compile


@ECHO.
@ECHO                             BUILD FOR MINGW
@ECHO.
@ECHO  Linking...
@ECHO ===============================================================================
@ECHO.


@FOR /F  "delims="  %%f IN ('DIR obj\*.o /S /B') DO SET OBJ_FILE_LIST=!OBJ_FILE_LIST! %%f || GOTO error_generic
@%GPP_EXECUTABLE_DIR% -o %BUILD_TARGET_NAME%.exe %OBJ_FILE_LIST% %LINKER_OPTION% || GOTO error_link


@ECHO.
@ECHO                             BUILD FOR MINGW
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
@ECHO ERROR: Cannot find GCC.
@GOTO end

:error_executable_gpp
@ECHO ERROR: Cannot find G++.
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


:end
@ECHO Press any key to exit.
@ECHO.
@PAUSE> NUL
@ENDLOCAL

