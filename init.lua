--- Settings
LED_PIN=17
DELAY=100
SOCKET=80
SSID="WiFiMCU_SoftAP"
PWD=""

function boot()
	print("MCU Info")
	print("Version: " .. mcu.info())
	print("Mem: " .. mcu.mem())
	print("Chip ID: " .. mcu.chipid())
	print("Boot reason: " .. mcu.bootreason())
	print("")
  gpio.mode(LED_PIN, gpio.OUTPUT)
  led_off(LED_PIN)
  blink(LED_PIN)
  print("Setting up local AP '" .. SSID .. "'")
  print("Password '" .. PWD .. "'")
  setup_ap(SSID,PWD)
  print("Starting server: " .. wifi.ap.getip() .. ":" .. SOCKET)
  print(wifi.ap.getipadv())
  start_server()
end

-- AP Functions --
function setup_ap(ssid, pwd)
  -- Config
  cfg={}
  cfg.ssid=ssid
  cfg.pwd=pwd
  cfg.retry_interval=2000

  -- Setup
  wifi.startap(cfg, function(info) ap_callback(info); end)
  blink(LED_PIN)
  blink(LED_PIN)
end

function ap_callback(info)
  if info == 'AP_UP' then
    led_on(LED_PIN)
  else
    blink(LED_PIN)
  end
end
-- LED Functions --
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
-- Server Functions --
function start_server()
  skt=net.new(net.TCP,net.SERVER)
  net.on(skt,'receive', function(c,d) receive(c,d); end)
  net.start(skt,SOCKET)
  blink(LED_PIN)
  blink(LED_PIN)
end

function header(conn)
  net.send(conn, [[HTTP/1.1 200 OK\r\nServer: UglyChristmasSweater\r\nContent-Type: text/html\r\n\r\n]])
end

-- Pages
function index()
  page = [[<html> <head><title>Ugly Christmas Shirt</title</head> <body> <h1>HELLO WORLD</h1> <a href="/xmas">xmas lights</a> </body> </html>]]
  return page
end

function xmas()
  page = [[
    You found it
    ]]
  return page
end

-- "Router"
function receive(c, d)
  header()
  if string.find(d, "/xmas") then
    net.send(c, xmas())
  else
    net.send(c, index())
  end

  net.close(c)
end

--- Boot
boot()
