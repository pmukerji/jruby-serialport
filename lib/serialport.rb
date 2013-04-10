require 'java'
require 'RXTXcomm.jar'

java_import('gnu.io.CommPortIdentifier')
java_import('gnu.io.SerialPort') { 'GnuSerialPort' }

class SerialPort
  
  attr_accessor :baud, :data_bits, :stop_bits, :parity, :read_timeout

  def initialize name, baud, data_bits=8, stop_bits=1, parity=GnuSerialPort::PARITY_NONE
    
    @baud = baud
    @data_bits    = GnuSerialPort.const_get "DATABITS_#{data_bits}"
    @stop_bits    = GnuSerialPort.const_get "STOPBITS_#{stop_bits}"
    @parity = parity
    @port = CommPortIdentifier.get_port_identifier(name).open 'JRuby', 500
    
    # Sets the data_bits, stop_bits, parity
    update_serial_port_params

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
        sleep 0.01 until @in.available == num_bytes || Time.now > deadline
      end
      @in_io.read(num_bytes) || ''
    else
      if @read_timeout
        deadline = Time.now + @read_timeout / 1000.0
        sleep 0.01 until @in.available > 0 || Time.now > deadline
      end
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


end