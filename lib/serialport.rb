require 'java'
require 'RXTXcomm.jar'

java_import('gnu.io.CommPortIdentifier')
java_import('gnu.io.SerialPort') { 'GnuSerialPort' }

class SerialPort
  
  attr_accessor :baud, :data_bits, :stop_bits, :parity, :read_timeout

  def initialize name, baud, data_bits=8, stop_bits=1, parity=GnuSerialPort::PARITY_NONE
    
    @baud = baud
    @data_bits = GnuSerialPort.const_get "DATABITS_#{data_bits}"
    @stop_bits = GnuSerialPort.const_get "STOPBITS_#{stop_bits}"
    @parity = parity
    @port = CommPortIdentifier.get_port_identifier(name).open 'JRuby', 500
    
    # Sets the data_bits, stop_bits, parity
    update_serial_port_params

    @in  = @port.input_stream
    @in_io = @in.to_io
    @out = @port.output_stream
    
    # Clear anything on the port
    @in_io.read(@in.available)
    
  end

  def close
    @port.close
  end

  def write data
    @out.write data.to_java_bytes
  end

  def read num_bytes=nil
    if num_bytes
      wait_for_data num_bytes
      @in_io.read(num_bytes) || ''
    else
      @in_io.read(@in.available) || ''
    end
  end
  
  def data_bits= value
    @data_bits = value
    update_serial_port_params
  end
  
  def stop_bits= value
    @stop_bits = value
    update_serial_port_params
  end
  
  def parity= value
    @parity = value
    update_serial_port_params
  end
  
  protected
  
  def update_serial_port_params
    @port.set_serial_port_params @baud, @data_bits, @stop_bits, @parity
  end  

  def wait_for_data num_bytes
    timeout = Time.now + Float(@read_timeout)/1000.0
    while Time.now < timeout || @in.available < num_bytes
      sleep 0.1
    end
  end
  
end