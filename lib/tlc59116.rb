require "tlc59116/version"
require "i2c"

module Tlc59116
  class Tlc59116
    I2C_ADDRESS = 0x1B

    module Register
      MODE1 = 0x00,
      MODE2 = 0x01,
      PWM = 0x02,
      LED_OUT_0 = 0x14,
      ERROR_FLAGS1 = 0x1D,
      ERROR_FLAGS2 = 0x1E
    end

    AUTO_INCREMENT = 0x80;

  	def initialize port
  		@i2c = I2C.create port
   	end

    def enable
      write Register::MODE1, 0x00;
    end

    def disable
      write Register::MODE1, 0x10;
    end

    def pwm_control value
      write Register::LED_OUT_0 | AUTO_INCREMENT, *value
    end

    def pwm address, value
      write Register::PWM | AUTO_INCREMENT, *value
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

    def write register, value
      @i2c.write I2C_ADDRESS, *value
    end

  end
end


# sends every param, begining with +params[0]+
# If the current param is a Fixnum, it is treated as one byte.
# If the param is a String, this string will be send byte by byte.
# You can use Array#pack to create a string from an array
# For Fixnum there is a convinient function to_short which transforms
# the number to a string this way: 12345.to_short == [12345].pack("s")
