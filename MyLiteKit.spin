{

  Project: EE-14 Assignment
  Platform: Parallax Project USB Board
  Revision: 1.0
  Author: Teo Xin Yi
  Date: 24th Feb 2022
  Log:
        Date: Desc
        24/2/2022: Connect & Control Lite Kit using Mecanum wheels

}

CON
        _clkmode                = xtal1 + pll16x                                               'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq                = 5_000_000
        _ConClkFreq             = ((_clkmode - xtal1) >> 6) + _xinfreq
        _Ms_001                 = _ConClkFreq / 1_000

VAR    'Global Variables
  long  Mainmeca, speed

OBJ
  'Term          : "FullDuplexSerial.spin"   'UART communication for debugging
  Meca          : "MecanumControl.spin"      '<-- Object / Blackbox
  Comm2         : "Comm2Control.spin"

PUB Main | dirVal

  Meca.Start(_Ms_001, @Mainmeca, @speed)

  repeat dirVal from 0 to 9
    Mainmeca := dirVal
    speed:= 40
    Pause(26000)

  repeat dirVal from 10 to 12
    Mainmeca := dirVal
    speed := 50
    Pause(30000)

PRI Pause(ms) | t    'Pause Function

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return