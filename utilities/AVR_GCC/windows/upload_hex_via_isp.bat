@echo.
@rem ************************************************************************************************************

@set AVR_EXECUTABLE_DIR=D:\CodeBlocks\WinAVR\bin\

set FIRST_PARAMETER=%0
set SECOND_PARAMETER=%1

@rem ************************************************************************************************************



@echo.
@echo.
@echo.******************Begine  Process******************
@echo.
@echo.
@rem START /wait /b %AVR_EXECUTABLE_DIR%\avr_gcc --help
START /wait /b %AVR_EXECUTABLE_DIR%avrdude -c c232hm -p m644p -U flash:r:upload.hex
@echo.
@echo.
@echo.******************End  Process*********************
@echo.
@echo.





pause