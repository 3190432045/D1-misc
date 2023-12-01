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
START /wait /b %AVR_EXECUTABLE_DIR%avrdude -c usbasp -p m644p -U flash:w:prog.hex
@echo.
@echo.
@echo.******************End  Process*********************
@echo.
@echo.





pause