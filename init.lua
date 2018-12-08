-- Settings
SOCKET=80
SSID="UglyChristmasSweater"
PWD=""
PINS = {2,3,4}

function boot()
  print("Booting...")
  math.randomseed(tmr.tick())
  setup_pins(PINS)
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
function setup_pins(pins)
  for _,v in ipairs(pins) do
    gpio.mode(v, gpio.OUTPUT)
  end
end

function led_on(pin)
  gpio.write(pin, gpio.HIGH)
end

function led_off(pin)
  gpio.write(pin, gpio.LOW)
end

function blink(pin, delay)
  led_on(pin)
  tmr.delayms(delay)
  led_off(pin)
end

function blink_pins(pins)
  rand_pins = shuffle(pins)
  for _,v in ipairs(rand_pins)  do
    d = math.random(30,300)
    blink(v, d)
  end
end

function blink_pattern(pins)
  for i=1,15 do
    blink_pins(pins)
  end
end

-- Misc Functions
function shuffle(array)
  -- fisher-yates
  local output = { }
  local random = math.random

  for index = 1, #array do
    local offset = index - 1
    local value = array[index]
    local randomIndex = offset*random()
    local flooredIndex = randomIndex - randomIndex%1

    if flooredIndex == offset then
      output[#output + 1] = value
    else
      output[#output + 1] = output[flooredIndex + 1]
      output[flooredIndex + 1] = value
    end
  end
  return output
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
    blink_pattern(PINS)
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
  page = [[<font size="10px;">🎄🎄</font> <a href="/xmas">MERRY CHRISTMAS</a> <font size="10px;">🎄🎄</font>]]
  return page
end

function xmas(conn)
  page = [[<font size="10px;">🎅🎅🎶🎶 Merry Christmas🎄🎄🌟🌟</font>]]
  return page
end


-- Boot
boot()
