require 'aruba/cucumber'
require 'methadone/cucumber'
require 'fileutils'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')

Before do
  # Using "announce" causes massive warnings on 1.9.2
  @puts = true
  @original_rubylib = ENV['RUBYLIB']
  @original_home = ENV['HOME']
  FileUtils.rm_rf("/tmp/akaTest")
  FileUtils.mkdir("/tmp/akaTest")
  ENV['HOME'] = "/tmp/akaTest"
  File.open("#{ENV['HOME']}/.alias", "w") { |file|  file.puts 'alias test="echo this is a test"' }
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s
end

After do
  ENV['RUBYLIB'] = @original_rubylib
  ENV['HOME'] = @original_home
end
