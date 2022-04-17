{

  Project: EE-14 Assignment
  Platform: Parallax Project USB Board
  Revision: 1.0
  Author: Teo Xin Yi
  Date: 24th Feb 2022
  Log:
        Date: Desc
        24/2/2022: Include checksum
}


CON

  commRxPin     = 19 'DOUT
  commTxPin     = 18 'DIN
  commBaud      = 9600

  'Comm Hex Keys
  commStart     = $7A
  commRight     = $01
  commLeft      = $02
  commForward   = $03
  commReverse   = $04
  commDiagNE    = $05
  commDiagSW    = $06
  commDiagNW    = $07
  commDiagSE    = $08
  commSideLeft  = $09
  commSideRight = $10
  commStopAll   = $AA
  commErr       = $EE
  commAck       = $AC

  encryptkey    = $7F

VAR

  long  cogIDNum, cogStack[64], _Ms_001, rxHeader, rxDir, rxSpd, rxChecksum

OBJ
  Comm2      : "FullDuplexSerial.spin"                   'UART communication for Control

PUB Start(msVal, dirVal, speed)       'Core 3

   _Ms_001 := MSVal   'stores number of milliseconds which will be used by Pause function

  StopCore      'stops cog

  cogIDNum := cognew(commCore(dirVal, speed),@cogStack)   'cog that runs the ValueGiven function

  return

PUB StopCore       'Stops cog if cog3ID is called

  if cogIDNum
    cogstop(cogIDNum)

PUB commCore(dirVal, speed) | CKC, DS

  Comm2.Start(commTxPin,commRxPin,0,commBaud)
  Pause(3000)

  ' Run & get readings
  repeat
    rxHeader := Comm2.Rx  '<- Wait at this statement for a byte
    if (rxHeader == CommStart)
      repeat
        rxDir := Comm2.Rx
        rxSpd := Comm2.Rx
        rxChecksum := Comm2.Rx
        CKC := rxChecksum ^ encryptkey
        DS := rxDir ^ rxSpd
        if (DS == CKC)
          Comm2.Tx(commAck)
          case rxDir
            commRight:
              long[dirVal] := 0
              long[speed] := rxSpd
            commLeft:
              long[dirVal] := 1
              long[speed] := rxSpd
            commForward:
              long[dirVal] := 2
              long[speed] := rxSpd
            commReverse:
              long[dirVal] := 3
              long[speed] := rxSpd
            commDiagNE:
              long[dirVal] := 4
              long[speed] := rxSpd
            commDiagSW:
              long[dirVal] := 5
              long[speed] := rxSpd
            commDiagNW:
              long[dirVal] := 6
              long[speed] := rxSpd
            commDiagSE:
              long[dirVal] := 7
              long[speed] := rxSpd
            commSideLeft:
              long[dirVal] := 8
              long[speed] := rxSpd
            commSideRight:
              long[dirVal] := 9
              long[speed] := rxSpd
            commStopAll:
              long[dirVal] := 10
        else
          Comm2.Tx(commErr)

PRI Pause(ms) | t    'Pause Function

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return