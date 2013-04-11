# JRuby Serial Port Gem

JRuby wrapper for serial port communication mimicking the functionality of the ruby-serialport gem

Based off of [pragpub](https://github.com/undees/pragpub) and [jr_serial_port](https://github.com/dcrosby42/jr_serial_port) projects.

## Requirements

Must have the librxtxSerial libraries in your java paths.

An example of the files can be found at the this [RXTX wiki](http://rxtx.qbang.org/wiki/index.php/Download)

If you're having trouble on OSX, check out this site: [jlog.org](http://jlog.org/rxtx-mac.html)

## Usage

Include jruby-serial port in your Gemfile:

```ruby
#gem is not published yet
gem "jruby-serialport", :git => "git://github.com/pmukerji/ruby-serialport.git"
```

If you have an application you want to run with JRuby and Ruby then you can specify the platform. For example:

```ruby

platforms :jruby do
  gem "jruby-serialport", :git => "git://github.com/pmukerji/jruby-serialport.git"
end

platforms :ruby do
  gem "serialport", :git => "git://github.com/pmukerji/ruby-serialport.git"
end

```

Use jruby-serialport in your application:

```ruby

require "serialport"

serial_port = SerialPort.new "/dev/ttyUSB0", 38400 # optional data_bits=8, stop_bits=1, parity=GnuSerialPort::PARITY_NONE

serial_port.read_timeout = 1000 # Read Timeout in milliseconds

serial_port.write "output data" # returns length (in bytes) of the message written

num_bytes_to_read = 5

serial_port.read num_bytes # returns message or whatever could be read before timeout was reached

```

## Tests

There are currently no tests written for this library. Please add some!