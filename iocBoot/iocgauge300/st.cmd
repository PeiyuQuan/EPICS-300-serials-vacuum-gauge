#!../../bin/linux-x86_64/gauge300

#- You may have to change gauge300 to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/gauge300.dbd"
gauge300_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", "$(IP)/db")
epicsEnvSet("PREFIX", "SLAC:Gauge300s:")
epicsEnvSet("PORT", "serial1")
epicsEnvSet("M","kjlc:")

## Load record instances
#drvAsynSerialPortConfigure("portName","ttyName",priority,noAutoConnect,noProcessEosIn)
#asynSetOption("portName",addr,"Key","value")

drvAsynSerialPortConfigure("serial1", "/dev/ttyUSB0", 0, 0, 0)
asynOctetSetInputEos("serial1",0,"\r")
asynOctetSetOutputEos("serial1",0,"\r")
asynSetOption("serial1",0,"baud","19200")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
asynSetOption("serial1",0,"clocal","Y")
asynSetOption("serial1",0,"crtscts","N")

dbLoadRecords("${TOP}/gauge300App/gauge300s.db","P=$(PREFIX),M=$(M),PORT=serial1")
#- Set this to see messages from mySub
#var mySubDebug 1

#- Run this to trace the stages of iocInit
#traceIocInit

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncExample, "user=quan"
