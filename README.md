# Ugly Christmas Sweater
<a href="https://www.gnu.org/licenses/gpl-3.0.en.html"><img src="https://www.gnu.org/graphics/gplv3-127x51.png"></a>

The Ugly Chrismas Sweater is my attempt to win the 2018 Ugly Chrismas Sweater contest at [work](http://bcianswers.com)

UCS is based on a WifiMCU (EMW3165) board. WifiMCU is a fun platform that runs [eLua](https://github.com/elua/elua)!!
* Cortex-M4 microcotroller
  * STM32F411CE
  * 100MHz,Cortex-M4 core
  * 2M bytes of SPI flash and 512K bytes of on-chip flash
  * 128K bytes of RAM
* Interfaces
  * 17 GPIO Pin
  * 3 UARTs
  * ADC(5)/SPI(1)/I2C(1)/USB(1)
  * SWD debug interface
  * 11 PWM
* Broadcom IEEE 802.11 b/g/n RF Chip
  * Supports 802.11 b/g/n
  * WEP,WPA/WPA2,PSK/Enterprise
  * 16.5dBm@11b,14.5dBm@11g,13.5dBm@11n
  * Receiver sensitivity：-87 dBm
  * Station,Soft AP and Station+Soft AP
  * CE,  FCC  suitable

UCS has it's own access point.  When you connect to the AP you are presented with a "login" page.  Instead of a login prompt, you have a simple link that will trigger the lights and song.

# Construction

<img src="/media/IMG_20181208_150545.jpg" width=600>

This is very basic as you can see from the photo.  The WifiMCU is connected to five (or more if you want) leds.  These are connected directly to the gpio pins, no resistor was necessary.

Additionally, there is a musical song that plays.  This was *extracted* from a battery operated christmas card.  Conveniently it had an on/off button, so that is no controlled by a 5v relay (see below)

This is a super basic circuit, basically just connect all the components directly to the board.  Please [add an issue](https://github.com/zpeters/UglyChristmasSweater/issues) if you want a proper schematic

## Materials
* WifiMCU board - https://www.banggood.com/EMW3165-WiFiMCU-Wireless-WiFi-Development-Board-Using-Lua-p-1007187.html?cur_warehouse=CN
* Assorted LEDs - https://www.amazon.com/CO-RODE-Emitting-Assorted-300-Pack/dp/B00UWBJM0Q
* Relay (controlling the music) *search around you can find it cheaper* - https://www.jameco.com/z/VMA406-Velleman-Arduino-Compatible-5V-Relay-Module_2255306.html?CID=GOOG&gclid=Cj0KCQiA3b3gBRDAARIsAL6D-N9IcueX3lxBgmxwu-tJX6X8pQ4PQMKhEb3y59M-ZX1Sv_UYJ2Np-zMaAtcvEALw_wcB
* Protoboard - https://www.sparkfun.com/categories/301
* Jumper wires *search around you can find a better deal* - https://www.amazon.com/Aketek-Jumper-Wires-Premium-Female/dp/B008MRZSH8

# Installation 
The `init.lua` can be loaded with [WifiMCU Studio](https://github.com/SmartArduino/WiFiMCU-STUDIO) (windows based software) or my [wmc](https://github.com/zpeters/wmc) console based software (Mac, Linux, Windows)

*wmc example*
```
wmc put init.lua
wmc reboot
```

# Operation
When you plug the sweater into a power source it will briefly display a "power up" animation.  After that it will boot up the Access Point and web server. 

When someone connects to the "UglyChristmasSweater" access point they are able to click on a link and start the fun.

<img src="media/ucs.webp" height="200">

<a href="media/2018-12-11 19.26.59.mp4">Video with sound</a>
