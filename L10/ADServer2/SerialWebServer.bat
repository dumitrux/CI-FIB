:: **************************************************************************
::  DESCIPTION: Windows Shell Script to execute A/D Serial-WebServer App
::  AUTHOR:     Manuel Vinagre Ruiz
::  DATE:       24 April 2016 
:: **************************************************************************
@ECHO OFF


IF "%1"=="" ( 
ECHO Empty argument error, -h for further information
) ELSE ( 
IF "%1"=="-h" (
ECHO Type "SerialWebServer ARG1", where ARG1 can be:
ECHO.
ECHO -h , for help information.
ECHO -l, for port listing.
ECHO PORT, to start connected to specific Serial Port. 
) ELSE (
node.exe server.js %1
)
)