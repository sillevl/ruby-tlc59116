require "tlc59116/version"
require "i2c"

module Tlc59116
  class Tlc59116
    I2C_ADDRESS = 0x68

    module Registers
      MODE1 = 0x00
      MODE2 = 0x01
      PWM = 0x02
      GROUPBRIGHTNESS = 0x12
      LED_OUT_0 = 0x14
      ERROR_FLAGS1 = 0x1D
      ERROR_FLAGS2 = 0x1E
    end

    AUTO_INCREMENT = 0x80;

    def initialize i2c
  	@i2c = i2c
    end

    def mode1 value
      write Registers::MODE1, value
    end

    def mode2 value
      write Registers::MODE2, value
    end

    def enable
	value = read_byte Registers::MODE1
	write Registers::MODE1, value & 0xEF
	sleep 0.001
    end

    def disable
	value = read_byte Registers::MODE1
	write Registers::MODE1, value | 0x10
    end

    def pwm_control *value
      write Registers::LED_OUT_0 | AUTO_INCREMENT, *value
    end

    def pwm *value, offset: offset = 0
	raise "Offset must be smaller than 16" if offset >= 16
      write (Registers::PWM + offset) | AUTO_INCREMENT, *value
    end

    def group_brightness value
      write Registers::GROUPBRIGHTNESS, value
    end

    private
    def read register, read_bytes = 1
      @i2c.read I2C_ADDRESS , read_bytes , register
    end

    def read_byte register
      data = read register
      data.unpack("C").first
    end

    def read_short register
      data = read register, 2
      data.unpack("S_").first
    end

    def write register, *values
      @i2c.write I2C_ADDRESS, register, *values
    end

  end
end


# sends every param, begining with +params[0]+
# If the current param is a Fixnum, it is treated as one byte.
# If the param is a String, this string will be send byte by byte.
# You can use Array#pack to create a string from an array
# For Fixnum there is a convinient function to_short which transforms
# the number to a string this way: 12345.to_short == [12345].pack("s")
