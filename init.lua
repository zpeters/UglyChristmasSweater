STA_SSID="ubnt"
STA_PASS="monkey33082"
AP_SSID="UglySweater"
AP_PASS="1234"
LED_PIN=17
DELAY=100

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
  setup_sta()
  setup_ap()
end


function setup_sta()
  cfg={}
  cfg.ssid=STA_SSID
  cfg.pwd=STA_PASS
  wifi.startsta(cfg, sta_callback)
end

function setup_ap()
  cfg={}
  cfg.ssid=AP_SSID
  cfg.pwd=AP_PASS
  wifi.startap(cfg, ap_callback)
end

function ap_callback(info)
  blink(LED_PIN)
  blink(LED_PIN)
  blink(LED_PIN)
  blink(LED_PIN)
  blink(LED_PIN)
  blink(LED_PIN)
  blink(LED_PIN)
  blink(LED_PIN)
end

function sta_callback(info)
  blink(LED_PIN)
  blink(LED_PIN)
  blink(LED_PIN)
  blink(LED_PIN)
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
