= Ugly Christmas Sweater
The Ugly Chrismas Sweater is my attempt to win the 2018 Ugly Chrismas Sweater contest at [work](http://bcianswers.com)

UCS is based on a WifiMCU (EMW3165) board. WifiMCU is a fun platform that runs [eLua](https://github.com/elua/elua)!!

UCS has it's own access point.  When you connect to the AP you are presented with a "login" page.  Instead of a login prompt, you have a simple link that will trigger the lights and song.

= Construction

![Construction](/media/IMG_20181208_150545.jpg)

This is very basic as you can see from the photo.  The WifiMCU is connected to five (or more if you want) leds.  These are connected directly to the gpio pins, no resistor was necessary.

Additionally, there is a musical song that plays.  This was *extracted* from a battery operated christmas card.  Conveniently it had an on/off button, so that is no controlled by a 5v relay (see below)

== Relay
http://www.circuitbasics.com/setting-up-a-5v-relay-on-the-arduino/

= Installation 
The `init.lua` can be loaded with [WifiMCU Studio](https://github.com/SmartArduino/WiFiMCU-STUDIO) (windows based software) or my [wmc](https://github.com/zpeters/wmc) console based software (Mac, Linux, Windows)

= Operation
When you plug the sweater into a power source it will briefly display a "power up" animation.  After that it will boot up the Access Point and web server. 

When someone connects to the "UglyChristmasSweater" access point they are able to click on a link and start the fun.

![Ugly Christmas Sweater](media/ucs.webp)
