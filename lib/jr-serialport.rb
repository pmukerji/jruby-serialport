require 'java'
require 'RXTXcomm.jar'

java_import('gnu.io.CommPortIdentifier')
java_import('gnu.io.SerialPort') { 'GnuSerialPort' }

class SerialPort
  
  attr_accessor :read_timeout

  NONE = GnuSerialPort::PARITY_NONE

  def initialize name, baud, data=8, stop=1, parity=NONE
    
    port_id = CommPortIdentifier.get_port_identifier name
    data    = GnuSerialPort.const_get "DATABITS_#{data}"
    stop    = GnuSerialPort.const_get "STOPBITS_#{stop}"

    @port = port_id.open 'JRuby', 500
    @port.set_serial_port_params baud, data, stop, parity

    @in  = @port.input_stream
    @in_io = @in.to_io
    @out = @port.output_stream
    
  end

  def close
    @port.close
  end

  def write bytes
    @out.write bytes.to_java_bytes
  end

  def read num_bytes=nil
    
    if num_bytes
      if @read_timeout
        deadline = Time.now + @read_timeout / 1000.0
        sleep 0.1 until @in.available == num_bytes || Time.now > deadline
      end
      @in_io.read(num_bytes) || ''
    else
      if @read_timeout
        deadline = Time.now + @read_timeout / 1000.0
        sleep 0.1 until @in.available > 0 || Time.now > deadline
      end
      @in_io.read(@in.available) || ''
    end
    
  end

end