-- Settings
SOCKET=80
SSID="Nerd Sweater"
PWD=""


function boot()
	print("MCU Info")
	print("Version: " .. mcu.info())
	print("Mem: " .. mcu.mem())
	print("Chip ID: " .. mcu.chipid())
	print("Boot reason: " .. mcu.bootreason())
  print("SSID: '" .. SSID .. "'")
  print("Password: '" .. PWD .. "'")
	print("")
  gpio.mode(2, gpio.OUTPUT)
  gpio.mode(3, gpio.OUTPUT)
  gpio.mode(4, gpio.OUTPUT)
  setup_ap(SSID,PWD)
  print("Starting server: " .. wifi.ap.getip() .. ":" .. SOCKET)
  print(wifi.ap.getipadv())
  start_server()
end

-- AP Functions
function setup_ap(ssid, pwd)
  print("Setting up AP...")
  -- Config
  cfg={}
  cfg.ssid=ssid
  cfg.pwd=pwd
  cfg.retry_interval=2000
  -- Setup
  wifi.startap(cfg, function(info) ap_callback(info); end)
end

function ap_callback(info)
  print("AP Callback: " .. info)
end

-- LED functions
function led_on(pin)
  gpio.write(pin, gpio.HIGH)
end

function led_off(pin)
  gpio.write(pin, gpio.LOW)
end

function blink(pin)
  tmr.delayms(100)
  led_on(pin)
  tmr.delayms(100)
  led_off(pin)
end

-- Sever Functions
function start_server()
  skt=net.new(net.TCP,net.SERVER)
  net.on(skt, 'receive', function(c,d) receive(c,d); end)
  net.start(skt,SOCKET)
end

function receive(c,d)
  h = header()

  if string.find(d, "/xmas") then
    page = xmas()
    blink(2)
    blink(2)
    blink(2)
    blink(3)
    blink(3)
    blink(3)
    blink(4)
    blink(4)
    blink(4)
    blink(4)
  else
    page = index()
  end

  resp = h .. page
  print("Response " .. resp)
  net.send(c, resp)
  net.close(c)
end

function header(conn)
  hdr = [[HTTP/1.1 200 OK\r\n\Server: UglyChristmasSweater\r\nContent-Type: text/html\r\n\r\n]]
  return hdr
end

function index(conn)
  page = [[<h1>Click Me</h1><a href="/xmas">XMAS</a>]]
  return page
end

function xmas(conn)
  page = [[<h1>XMAS</h1>]]
  return page
end


-- Boot
boot()
