{

  Project: EE-14 Assignment
  Platform: Parallax Project USB Board
  Revision: 1.0
  Author: Teo Xin Yi
  Date: 18th Feb 2022
  Log:
        Date: Desc
        18/02/2022: Connect & Control Lite Kit using Mecanum wheels
}


CON
  ' RoboClaw 1 - Back
  R1S1 = 3
  R1S2 = 2

  ' RoboClaw 2 - Front
  R2S1 = 5
  R2S2 = 4

  ' Simple Serial
  SSBaud = 57_600

  ' Channel Stops
  Ch1Stop = 64
  Ch2Stop = 192

VAR
  long cogStack[64], cogIDNum, _Ms_001

OBJ
  MD[2]        : "FullDuplexSerial.spin"

PUB Start(msVal, direction, speed)

  _Ms_001 := msVal
  StopCore
  cogIDNum := cognew(mecCore(direction, speed),@cogStack)

PUB mecCore(direction, speed)

  MecInit

  repeat
    case long[direction]
      0:
        TurnRight(long[speed])
        Stop
      1:
        TurnLeft(long[speed])
        Stop
      2:
        Forward(long[speed])
        Stop
      3:
        Reverse(long[speed])
        Stop
      4:
        DiagNE(long[speed])
        Stop
      5:
        DiagSW(long[speed])
        Stop
      6:
        DiagNW(long[speed])
        Stop
      7:
        DiagSE(long[speed])
        Stop
      8:
        SideLeft(long[speed])
        Stop
      9:
        SideRight(long[speed])
        Stop
      10:
        SideRight(long[speed])
        Stop
      11:
        SideLeft(long[speed])
        Stop
      12:
        StopAll

PUB Forward(speed) | i

  repeat i from 0 to speed step (speed/6)
    MD[0].Tx(Ch1Stop + i)                                                       'Back right wheel
    MD[0].Tx(Ch2Stop + i)                                                       'Back left wheel
    MD[1].Tx(Ch1Stop + i)                                                       'Front right wheel
    MD[1].Tx(Ch2Stop + i)                                                       'Front left wheel
    Pause(2000)

  repeat i from speed to 0 step (speed/6)
    MD[0].Tx(Ch1Stop + i)
    MD[0].Tx(Ch2Stop + i)
    MD[1].Tx(Ch1Stop + i)
    MD[1].Tx(Ch2Stop + i)
    Pause(2000)

PUB Reverse(speed) | i

  repeat i from 0 to speed step (speed/6)
    MD[0].Tx(Ch1Stop - i)                                                       'Back right wheel
    MD[0].Tx(Ch2Stop - i)                                                       'Back left wheel
    MD[1].Tx(Ch1Stop - i)                                                       'Front right wheel
    MD[1].Tx(Ch2Stop - i)                                                       'Front left wheel
    Pause(2000)

  repeat i from speed to 0 step (speed/6)
    MD[0].Tx(Ch1Stop - i)
    MD[0].Tx(Ch2Stop - i)
    MD[1].Tx(Ch1Stop - i)
    MD[1].Tx(Ch2Stop - i)
    Pause(2000)

PUB TurnLeft(speed) | i

  repeat i from 0 to speed step (speed/6)
    MD[0].Tx(Ch1Stop + i)                                                       'Back right wheel
    MD[0].Tx(Ch2Stop - i)                                                       'Back left wheel
    MD[1].Tx(Ch1Stop + i)                                                       'Front right wheel
    MD[1].Tx(Ch2Stop - i)                                                       'Front left wheel
    Pause(2000)

  repeat i from speed to 0 step (speed/6)
    MD[0].Tx(Ch1Stop + i)
    MD[0].Tx(Ch2Stop - i)
    MD[1].Tx(Ch1Stop + i)
    MD[1].Tx(Ch2Stop - i)
    Pause(2000)

PUB TurnRight(speed) | i

  repeat i from 0 to speed step (speed/6)
    MD[0].Tx(Ch1Stop - i)                                                       'Back right wheel
    MD[0].Tx(Ch2Stop + i)                                                       'Back left wheel
    MD[1].Tx(Ch1Stop - i)                                                       'Front right wheel
    MD[1].Tx(Ch2Stop + i)                                                       'Front left wheel
    Pause(2000)

  repeat i from speed to 0 step (speed/6)
    MD[0].Tx(Ch1Stop - i)
    MD[0].Tx(Ch2Stop + i)
    MD[1].Tx(Ch1Stop - i)
    MD[1].Tx(Ch2Stop + i)
    Pause(2000)

  StopAll

PUB SideLeft(speed) | i

  repeat i from 0 to speed step (speed/6)
    MD[0].Tx(Ch1Stop - i)                                                       'Back right wheel
    MD[0].Tx(Ch2Stop + i)                                                       'Back left wheel
    MD[1].Tx(Ch1Stop + i)                                                       'Front right wheel
    MD[1].Tx(Ch2Stop - i)                                                       'Front left wheel
    Pause(2000)

  repeat i from speed to 0 step (speed/6)
    MD[0].Tx(Ch1Stop - i)
    MD[0].Tx(Ch2Stop + i)
    MD[1].Tx(Ch1Stop + i)
    MD[1].Tx(Ch2Stop - i)
    Pause(2000)

PUB SideRight(speed) | i

  repeat i from 0 to speed step (speed/6)
    MD[0].Tx(Ch1Stop + i)                                                       'Back right wheel
    MD[0].Tx(Ch2Stop - i)                                                       'Back left wheel
    MD[1].Tx(Ch1Stop - i)                                                       'Front right wheel
    MD[1].Tx(Ch2Stop + i)                                                       'Front left wheel
    Pause(2000)

  repeat i from speed to 0 step (speed/6)
    MD[0].Tx(Ch1Stop + i)
    MD[0].Tx(Ch2Stop - i)
    MD[1].Tx(Ch1Stop - i)
    MD[1].Tx(Ch2Stop + i)
    Pause(2000)

PUB DiagNE(speed) | i

  repeat i from 0 to speed step (speed/6)
    MD[0].Tx(Ch1Stop + i)                                                       'Back right wheel
    MD[1].Tx(Ch2Stop + i)                                                       'Front left wheel
    Pause(2000)

  repeat i from speed to 0 step (speed/6)
    MD[0].Tx(Ch1Stop + i)
    MD[1].Tx(Ch2Stop + i)
    Pause(2000)

PUB DiagNW(speed) | i

  repeat i from 0 to speed step (speed/6)
    MD[0].Tx(Ch2Stop + i)                                                       'Back left wheel
    MD[1].Tx(Ch1Stop + i)                                                       'Front right wheel
    Pause(2000)

  repeat i from speed to 0 step (speed/6)
    MD[0].Tx(Ch2Stop + i)
    MD[1].Tx(Ch1Stop + i)
    Pause(2000)

PUB DiagSE(speed) | i

  repeat i from 0 to speed step (speed/6)
    MD[0].Tx(Ch2Stop - i)                                                       'Back left wheel
    MD[1].Tx(Ch1Stop - i)                                                       'Front right wheel
    Pause(2000)

  repeat i from speed to 0 step (speed/6)
    MD[0].Tx(Ch2Stop - i)
    MD[1].Tx(Ch1Stop - i)
    Pause(2000)

PUB DiagSW(speed) | i

  repeat i from 0 to speed step (speed/6)
    MD[0].Tx(Ch1Stop - i)                                                       'Back right wheel
    MD[1].Tx(Ch2Stop - i)                                                       'Front left wheel
    Pause(2000)

  repeat i from speed to 0 step (speed/6)
    MD[0].Tx(Ch1Stop - i)
    MD[1].Tx(Ch2Stop - i)
    Pause(2000)

PUB Stop | i

  'Indivudual Channel Stop
  MD[0].Tx(Ch1Stop)
  MD[0].Tx(Ch2Stop)
  MD[1].Tx(Ch1Stop)
  MD[1].Tx(Ch2Stop)
  Pause(300)

PUB StopAll

  'Shut Down Transmission to Channel
  MD[0].Tx(0)
  MD[1].Tx(0)
  Pause(100)

PRI MecInit

  MD[0].Start(R1S2, R1S1, 0, SSBaud)
  MD[1].Start(R2S2, R2S1, 0, SSBaud)

  Stop

PRI StopCore                    'To stop the code in the core/cog and release the core/cog

  if cogIDNum
   cogstop(cogIDNum~)

PRI Pause(ms) | t    'Pause Function

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return