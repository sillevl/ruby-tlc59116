
#:require './test/test_helper'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'tlc59116'
include Tlc59116

i2c = I2C.create '/dev/i2c-1'


leds = Tlc59116::Tlc59116.new i2c

leds.enable
leds.pwm_control 0xFF, 0xFF, 0xFF, 0xFF
leds.group_brightness 0x10

#leds.pwm 0x00, 0xFF, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0xFF

leds.pwm 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 

16.times do |offset|
	leds.pwm 0xFF, offset: offset
	sleep 1
end

sleep 2.0

leds.pwm 0x00, 0x00, 0x00, offset: 3
leds.pwm 0xFF, 0xFF, 0xFF, offset: 6
#leds.demo

puts "hello"


