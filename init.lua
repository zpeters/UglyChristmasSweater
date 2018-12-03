LED_PIN=17
DELAY=100
SOCKET=80

function startup()
	print("MCU Info")
	print("Version: " .. mcu.info())
	print("Mem: " .. mcu.mem())
	print("Chip ID: " .. mcu.chipid())
	print("Boot reason: " .. mcu.bootreason())
	print("")
  print("Setting up local AP")
  gpio.mode(LED_PIN, gpio.OUTPUT)
  led_off(LED_PIN)
  blink(LED_PIN)
  setup_ap()
  start_server()
end

function setup_ap()
  cfg={ssid='WiFiMCU_SoftAP',pwd=''}
  wifi.startap(cfg, function(info) ap_callback(info); end)
  cfg=nil
  blink(LED_PIN)
  blink(LED_PIN)
end

function start_server()
  skt=net.new(net.TCP,net.SERVER)
  net.on(skt,'receive', function(c,d) receive(c,d); end)
  net.start(skt,SOCKET)
  blink(LED_PIN)
  blink(LED_PIN)
end

function receive(c, d)
  net.send(c, [[HTTP/1.1 200 OK\r\nServer: UglyChristmasSweater\r\nContent-Type: text/html\r\n\r\n]])
  if string.find(d, "/xmas") then
    net.send(c, [[You Found it]])
  else
    net.send(c, [[<h1>HELLO WORLD</h1><a href="/xmas">xmas lights</a>]])
  end


  net.close(c)
end

function ap_callback(info)
  if info == 'AP_UP' then
    led_on(LED_PIN)
  else
    blink(LED_PIN)
  end
end

function led_on(pin)
  gpio.write(pin, gpio.LOW)
end

function led_off(pin)
  gpio.write(pin, gpio.HIGH)
end

function blink(pin)
  tmr.delayms(DELAY)
  led_on(pin)
  tmr.delayms(DELAY)
  led_off(pin)
end

startup()
