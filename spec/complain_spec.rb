require 'spec_helper'

describe Complain do

  class Complain_TestLogger
    def self.error(message)
      puts "Complain_TestLogger: #{message}"
    end
  end

  class Complain_BadTestLogger
  end

  it { expect{ Complain.("test message") }.to output("test message\n").to_stderr }
  it { expect{ Complain.("test message", nil) }.to output("test message\n").to_stderr }
  it { expect{ Complain.("test message", :stderr) }.to output("test message\n").to_stderr }
  it { expect{ Complain.("test message", $stderr) }.to output("test message\n").to_stderr }
  it { expect{ Complain.("test message", :stdout) }.to output("test message\n").to_stdout }
  it { expect{ Complain.("test message", :exception) }.to raise_error(Exception, "test message") }
  it { expect{ Complain.("test message", Complain_BadTestLogger) }.to raise_error(Exception, /Can\'t write to logs/) }
  it { expect{ Complain.("test message", Complain_TestLogger) }.to output("Complain_TestLogger: test message\n").to_stdout }

end