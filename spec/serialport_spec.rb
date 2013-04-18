require 'spec_helper'

PORTNAME = ENV["PORTNAME"] || ENV["PORT"]
BAUDRATE = (ENV["BAUDRATE"] || ENV["BAUD"]).to_i
DATA_BITS = (ENV["DATA_BITS"] || 8).to_i
STOP_BITS = (ENV["STOP_BITS"] || 1).to_i


describe SerialPort do
  
  describe "new" do
  
    it "should respond to a new method" do
      SerialPort.should respond_to :new
    end
    
    it "should throw ArgumentError if less than 2 arguments are passed" do
      lambda { SerialPort.new }.should raise_error ArgumentError
      lambda { SerialPort.new(1) }.should raise_error ArgumentError
    end
    
    it "should throw ArgumentError if more than 5 arguments are passed" do
      lambda { 
        SerialPort.new(1,2,3,4,5,6)
      }.should raise_error ArgumentError
    end
    
    # it "should successfully open a SerialPort with valid default inputs" do
    #   serial_port = SerialPort.new(PORTNAME,BAUDRATE)
    #   serial_port.close
    #   serial_port = SerialPort.new(PORTNAME, BAUDRATE, DATA_BITS, STOP_BITS, GnuSerialPort::PARITY_NONE)
    #   serial_port.close
    # end
  
  end
  
  
end