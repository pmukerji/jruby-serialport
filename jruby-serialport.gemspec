Gem::Specification.new do |s|
  
  s.name = %q{jr-serialport}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pratik Mukerji"]
  s.date = %q{2013-04-10}
  s.summary = "JRuby Serial Port wrapper"
  s.email = %q{pratik@electricfeel.com}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.description = %q{JRuby wrapper for serial port communication mimicking the ruby-serialport gem}
  s.files = Dir["lib/**/*.rb"]
  
end
