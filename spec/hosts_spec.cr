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
  hosts_file.unlink

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

  it "#name?" do
    hosts.name?("host1").should eq("host1")
    hosts.name?("xxxxx").should eq(nil)
    hosts.name?("192.168.0.1").should eq("host1")
    hosts.name?("192.168.1.1").should eq(nil)
  end

  it "#addr?" do
    hosts.addr?("host1").should eq("192.168.0.1")
    hosts.addr?("xxxxx").should eq(nil)
    hosts.addr?("192.168.0.1").should eq("192.168.0.1")
    hosts.addr?("192.168.1.1").should eq(nil)
  end
end
