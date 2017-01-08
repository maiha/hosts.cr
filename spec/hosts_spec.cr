require "./spec_helper"

require "tempfile"

describe Hosts do
  hosts_file = Tempfile.open("hosts") { |file|
    file.print <<-EOF
      # comment
      127.0.0.1      ubuntu localhost
      
      192.168.0.1    host1
      192.168.0.2    host2
      192.168.0.253  host253 gateway1
      EOF
  }
  hosts = Hosts.new(hosts_file.path)

  it "#[addr]" do
    hosts["192.168.0.1"].addr.should eq("192.168.0.1")
    hosts["192.168.0.1"].names.should eq(Set{"host1"})
    expect_raises(KeyError) { hosts["127.0.0.2"] }
  end

  it "#[addr]?" do
    hosts["192.168.0.1"]?.try(&.addr).should eq("192.168.0.1")
    hosts["192.168.1.1"]?.should eq(nil)
  end

  it "#[name]" do
    hosts["host1"].addr.should eq("192.168.0.1")
    expect_raises(KeyError) { hosts["xxx"] }
  end

  it "#[name]?" do
    hosts["host1"]?.try(&.addr).should eq("192.168.0.1")
    hosts["xxx"]?.should eq(nil)
  end
end
