Gem::Specification.new do |s|
  
  s.name = %q{jruby-serialport}
  s.version = "0.0.1"
  s.authors = ["Pratik Mukerji"]
  s.email = ["pratik@electricfeel.com"]
  s.homepage = "https://github.com/pmukerji/jruby-serialport"
  s.summary = "JRuby Serial Port wrapper"
  s.description = <<-EOF
    JRuby wrapper for serial port communication mimicking the ruby-serialport gem.
  EOF
  s.platform = Gem::Platform::JAVA
  s.require_paths = ["lib"]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.add_development_dependency 'rspec', '~> 2.5'
  
end
