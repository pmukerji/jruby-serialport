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
    @out = @port.output_stream
    
  end

  def close
    @port.close
  end

  def write data
    @out.write data.to_java_bytes
    data.bytes.count
  end

  def read num_bytes
    buffer = Java::byte[num_bytes].new
    total = 0; read = 0
    total += read while (total < num_bytes && (read = @in.read(buffer, total, num_bytes-total)) > 0)
    String.from_java_bytes(buffer)
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
  
  def read_timeout= value
    @read_timeout = value
    @port.enable_receive_timeout @read_timeout
  end
  
  protected
  
  def update_serial_port_params
    @port.set_serial_port_params @baud, @data_bits, @stop_bits, @parity
  end  


end